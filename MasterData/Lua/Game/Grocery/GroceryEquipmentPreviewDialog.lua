-------------------------------------------------------------------------------
-- 杂货铺 - 装备抽取 - 预览弹窗
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-03-21 14:40:09
-------------------------------------------------------------------------------

local GameObject    = CS.UnityEngine.GameObject
local RectTransform = CS.UnityEngine.RectTransform
local goodsConfMgr  = GoodsConfMgr:GetInstance()

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/OverseaStore/OverseaStoreEquipDrawMember.prefab
---@class GroceryEquipmentPreviewDialog
---@field Env                           	GroceryEquipmentPreviewDialog           
---@field controller                    	Engine.UI.UILuaDialog                   
---@field MemberRoleCell                	UnityEngine.RectTransform               @ 成员组装备单元
---@field MemberRoleContent             	UnityEngine.RectTransform               @ 成员组列表容器
---@field MemberTittleGroup             	UnityEngine.RectTransform               @ 成员组概率节点
---@field MemberTitle                   	UnityEngine.RectTransform               @ 成员组标题
---@field MemberParentNode              	UnityEngine.RectTransform               @ 成员组父容器
---@field MemberGroup                   	UnityEngine.RectTransform               @ 成员组节点
---@field EnsuranceMain                 	UnityEngine.RectTransform               @ 说明正文文本
---@field EnsuranceTitle                	UnityEngine.RectTransform               @ 说明标题文本
---@field EnsuranceNode                 	UnityEngine.RectTransform               @ 说明节点
---@field BtnClose                      	UnityEngine.RectTransform               @ 关闭按钮
---@field TitleNode                     	UnityEngine.RectTransform               @ 标题节点
---@field PopupBoard                    	UnityEngine.RectTransform               @ 背景板节点
---@field Root                          	UnityEngine.RectTransform               @ UI根节点
---@field block                         	UnityEngine.RectTransform               @ 半透明底背
local GroceryEquipmentPreviewDialog = Class('GroceryEquipmentPreviewDialog')


function GroceryEquipmentPreviewDialog:__init()
    ---@type table 装备卡池数据
    self.equipGroceryData_ = nil
end


function GroceryEquipmentPreviewDialog:__delete()
    self.equipGroceryData_ = nil
    self.controller        = nil
end


function GroceryEquipmentPreviewDialog:Awake()
    SetButtonAction(self.block, Bind(self, self.OnClickCloseButtonHandler_))
    SetButtonAction(self.BtnClose, Bind(self, self.OnClickCloseButtonHandler_))
end


function GroceryEquipmentPreviewDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}
        self.equipGroceryData_ = checkTable(initParams.equipGroceryData)
    end)
end


function GroceryEquipmentPreviewDialog:OnFinalize()
    return CoWaitDo(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


function GroceryEquipmentPreviewDialog:OnShow()
    return CoWaitDo(function()
        self:UpdateDescrInfo_()
        self:UpdatePreviewItemList_()
    end)
end


-------------------------------------------------
-- public

function GroceryEquipmentPreviewDialog:Close()
    CfUtils.DialogClose(self.controller)
end


-------------------------------------------------
-- private

function GroceryEquipmentPreviewDialog:UpdateDescrInfo_()
    CfUtils.FillText(self.EnsuranceTitle, localize('重要说明'))

    local descrText = tostring(self.equipGroceryData_.poolDesc)
    CfUtils.FillText(self.EnsuranceMain, descrText)
end


function GroceryEquipmentPreviewDialog:UpdatePreviewItemList_()
    local rareGroupList = checkTable(self.equipGroceryData_.ratesIndex)

    -- to rareGroup map
    ---@type table<string, table[]>
    local goodsDataMap = {}
    for index, itemData in ipairs(self.equipGroceryData_.preview or {}) do
        local goodsId   = checkInt(itemData.itemId)
        local goodsVo   = goodsConfMgr:GetGoodsVoById(goodsId)
        local rareGroup = tostring(itemData.rareGroup)
        if not goodsDataMap[rareGroup] then
            goodsDataMap[rareGroup] = {}
        end
        table.insert(goodsDataMap[rareGroup], {
            -- equipVo  = CfUtils.GetCfVo(AutoIds.IdSetting34, 'EquipVo', goodsId),
            pIndex   = index,
            goodsVo  = goodsVo,
            goodsId  = goodsId,
            isUpping = itemData.isUp == 1,
            rareNum  = checkNumber(itemData.displayNum),
        })
    end
    for _, goodsDataList in pairs(goodsDataMap) do
        table.sort(goodsDataList, function(aGoodsData, bGoodsData)
            local isAItemUpping = checkBool(aGoodsData.isUpping)
            local isBItemUpping = checkBool(bGoodsData.isUpping)
            if isAItemUpping == isBItemUpping then
                return aGoodsData.pIndex < bGoodsData.pIndex
            else
                return isAItemUpping
            end
        end)
    end

    -- clean old items
    local originChildNum = 3  -- [ ImgTitle | TitleGroup | Content ]
    for childIndex = self.MemberParentNode.childCount - 1, originChildNum, -1 do
        CfUtils.SafeDelete(self.MemberParentNode:GetChild(childIndex).gameObject)
    end
    CfUtils.SetActive(self.MemberTittleGroup, false)
    CfUtils.SetActive(self.MemberRoleContent, false)

    -- update item list
    CoYield(0.1)  -- 由于是非共享元素列表，一口气全部初始化会造成阻塞，所以先延迟0.2秒先播放弹窗淡入动画
    local rectTransformType = typeof(RectTransform)
    for rareIndex, goodsRare in ipairs(rareGroupList) do
        local goodsDataList  = goodsDataMap[checkInt(goodsRare)] or goodsDataMap[tostring(goodsRare)]
        local itemTitleTrans = GameObject.Instantiate(self.MemberTittleGroup, self.MemberParentNode):GetComponent(rectTransformType)
        local itemListTrans  = GameObject.Instantiate(self.MemberRoleContent, self.MemberParentNode):GetComponent(rectTransformType)
        self:UpdatePreviewItemTitleNode_(itemTitleTrans, goodsRare)
        self:UpdatePreviewItemListNode_(itemListTrans, goodsRare, goodsDataList)
        -- CoYield(0.1)  -- 每创建一批品质列表后，延迟0.1秒，避免界面阻塞
    end
end


---@param itemTitleTrans UnityEngine.RectTransform
---@param goodsRare string
function GroceryEquipmentPreviewDialog:UpdatePreviewItemTitleNode_(itemTitleTrans, goodsRare)
    if isNull(itemTitleTrans) then return end
    CfUtils.SetActive(itemTitleTrans, true)

    -- update rare image
    CfUtils.SetUISwitchImage(itemTitleTrans:Find('ImgBg'), checkInt(goodsRare))
   
    -- update rare value
    local rareValueMap  = checkTable(self.equipGroceryData_.rates)
    local itemRareValue = checkNumber(rareValueMap[tostring(goodsRare)]) * 100
    CfUtils.FillText(itemTitleTrans:Find('TextProbability'), string.format('%s%%', itemRareValue))
end


---@param itemListTrans UnityEngine.RectTransform
---@param goodsRare string
---@param goodsDataList table[]
function GroceryEquipmentPreviewDialog:UpdatePreviewItemListNode_(itemListTrans, goodsRare, goodsDataList)
    if isNull(itemListTrans) then return end
    CfUtils.SetActive(itemListTrans, true)

    -- clean cache cell
    for childIndex = itemListTrans.childCount - 1, 0, -1 do
        CfUtils.SafeDelete(itemListTrans:GetChild(childIndex).gameObject)
    end

    -- update each cell
    local rectTransformType = typeof(RectTransform)
    for goodsIndex, goodsData in ipairs(goodsDataList) do
        ---@type UnityEngine.RectTransform
        local itemCellTrans = GameObject.Instantiate(self.MemberRoleCell, itemListTrans):GetComponent(rectTransformType)
        CfUtils.SetActive(itemCellTrans, true)
        
        ---@type GoodsVo
        local goodsVo = checkTable(goodsData.goodsVo)
        -- CfUtils.FillText(itemCellTrans:Find('TextName'), tostring(goodsVo.name))

        local goodNode = itemCellTrans:Find('GoodNode')
        ---@type GoodNodeMB
        local goodsNodeEnv = CfUtils.GetLuaScr(goodNode, Constants.UILuaTablePath.GoodNodeMB)
        if not isNull(goodsNodeEnv) then
            goodsNodeEnv:Reload({goodsId = goodsVo.refId, text = "x"..1})
            goodsNodeEnv:SetClickButtonAction(function(goodsId)
                local goodsVo = goodsConfMgr:GetGoodsVoById(goodsId)
                if isTable(goodsVo) then
                    GameUtils.ShowCommonTipsBoard(goodNode, goodsVo.name, goodsVo.desc, goodsVo.quality, goodsVo.id)
                end
            end)
        end

        -- update rare image
        local isItemUpping = checkBool(goodsData.isUpping)
        CfUtils.SetActive(itemCellTrans:Find('ImgUp'), isItemUpping)
        -- CfUtils.SetUISwitchImage(itemCellTrans:Find('Probability/ImgBg'), isItemUpping and 2 or 1)
        -- CfUtils.SetUISwitchText(itemCellTrans:Find('Probability/TextNumber'), isItemUpping and 2 or 1)

        -- update rare value
        local itemRareValue = checkNumber(goodsData.rareNum) * 100
        CfUtils.FillText(itemCellTrans:Find('Probability/TextNumber'), string.format('%s%%', itemRareValue))

        if goodsIndex < 12 then
            CoYield()
        end
    end
end


-------------------------------------------------
-- handler

function GroceryEquipmentPreviewDialog:OnClickCloseButtonHandler_()
    self:Close()
end


return GroceryEquipmentPreviewDialog
