-------------------------------------------------------------------------------
-- 卡牌养成 - 收集奖励弹窗
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-04-28 16:51:46
-------------------------------------------------------------------------------

---@type CardConfMgr
local cardConfMgr = CardConfMgr:GetInstance()
---@type IllustratedHandbookComponent
local illustratedHandbookComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.IllustratedHandbookComponent)

local CollectionTypeDefines = {
    [Constants.CardCollectionType.STAR] = {
        redCheckFunc = Bind(illustratedHandbookComp, illustratedHandbookComp.CheckAdditionStarRedPoint),
    },
    [Constants.CardCollectionType.UR_NUM] = {
        redCheckFunc = Bind(illustratedHandbookComp, illustratedHandbookComp.CheckAdditionUrNumRedPoint),
    },
    [Constants.CardCollectionType.SKILL] = {
        redCheckFunc = Bind(illustratedHandbookComp, illustratedHandbookComp.CheckAdditionSkillRedPoint),
    },
    [Constants.CardCollectionType.SKIN_LV] = {
        redCheckFunc = Bind(illustratedHandbookComp, illustratedHandbookComp.CheckAdditionSkinLevelRedPoint),
    },
}

local TypeListCellName = 'Cell'

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaCollectRewardPopup.prefab
---@class CardProgressionCollectRewardsDialog
---@field Env                           	CardProgressionCollectRewardsDialog     
---@field controller                    	Engine.UI.UILuaDialog                   
---@field ScrollView                    	SuperScrollView.LoopListView2           @ 滚动列表
---@field BtnClose                      	UnityEngine.RectTransform               @ 关闭按钮
---@field block                         	UnityEngine.RectTransform               @ 半透明底背
---@field RootNode                      	UnityEngine.RectTransform               @ 根节点
local CardProgressionCollectRewardsDialog = Class('CardProgressionCollectRewardsDialog')


function CardProgressionCollectRewardsDialog:__init()
end


function CardProgressionCollectRewardsDialog:__delete()
end


function CardProgressionCollectRewardsDialog:Awake()
    SetButtonAction(self.block, Bind(self, self.OnClickCloseButtonHandler_))
    SetButtonAction(self.BtnClose, Bind(self, self.OnClickCloseButtonHandler_))
    SetListViewAction(self.ScrollView, Bind(self, self.OnUpdateTypeListCellHandler_))
end


function CardProgressionCollectRewardsDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}

        -- init typeList
        local collectTypeList = illustratedHandbookComp:GetCardCollectionTypeList()
        self:SetCollectTypeList(collectTypeList)
    end)
end


function CardProgressionCollectRewardsDialog:OnFinalize()
    return CoWaitDo(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


-------------------------------------------------
-- get / set

---@return Constants.CardCollectionType[]
function CardProgressionCollectRewardsDialog:GetCollectTypeList()
    return checkTable(self.collectTypeList_)
end
function CardProgressionCollectRewardsDialog:SetCollectTypeList(typeList)
    self.collectTypeList_ = checkTable(typeList)
    self:UpdateCollectListView_()
end


-------------------------------------------------
-- public

function CardProgressionCollectRewardsDialog:Close()
    CfUtils.DialogClose(self.controller)
end


-------------------------------------------------
-- private

function CardProgressionCollectRewardsDialog:UpdateCollectListView_()
    local listDataLength = #self:GetCollectTypeList()
    GameUtils.ReloadData(self.ScrollView, listDataLength)
end


---@param luaIndex integer @ start at 1
---@param cellNode SuperScrollView.LoopListViewItem2
function CardProgressionCollectRewardsDialog:UpdateTypeListCellInfo_(luaIndex, cellNode, isPlayLevelUpAnim)
    cellNode = cellNode or self.ScrollView:GetShownItemByItemIndex(luaIndex - 1)
    if isNull(cellNode) then return end

    local cellCollectType   = self:GetCollectTypeList()[luaIndex]
    local progressRewardsVo = illustratedHandbookComp:GetAdditionProgressVo(cellCollectType)

    -------------------------------------------------
    -- update background
    CfUtils.SetUISwitchImage(cellNode.transform:Find('ImgBackground'), cellCollectType)
    
    -- update typeIcon
    CfUtils.SetUISwitchImage(cellNode.transform:Find('ImgSymbol'), cellCollectType)

    -- update type descr
    CfUtils.FillText(cellNode.transform:Find('Progress/TextDesc'), tostring(progressRewardsVo.collectDescr))
    

    -------------------------------------------------
    -- update progress txt
    local currentCollectNum  = illustratedHandbookComp:GetAdditionCollectNum(cellCollectType)
    local targetCollectNum   = checkInt(progressRewardsVo.collectTarget)
    local collectProgressStr = string.format('<size=60>%d</size>/%d', currentCollectNum, targetCollectNum)
    CfUtils.FillText(cellNode.transform:Find('Progress/TextNumber'), collectProgressStr)

    -- update progress num
    local collectProgressNum = currentCollectNum / targetCollectNum
    CfUtils.SetSliderPercent(cellNode.transform:Find('Progress/Sider'), collectProgressNum)


    -------------------------------------------------
    local typeActivateNum   = illustratedHandbookComp:GetAdditionActivateNum(cellCollectType)
    local activateRewardsVo = checkTable(illustratedHandbookComp:GetAdditionRewardsVoAt(cellCollectType, typeActivateNum))
    local isTypeActivateAll = typeActivateNum >= targetCollectNum
    
    -- update addition attr name
    ---@type BasicAttrAdditionVo
    local attrAdditionVo = cardConfMgr:GetBasicAttrAdditionById(progressRewardsVo.attTypeId)
    CfUtils.FillText(cellNode.transform:Find('Attribute/TextDesc'), tostring(attrAdditionVo.attrAdditionName))

    -- update addition attr num
    local attrCurtText   = cellNode.transform:Find('Attribute/Number/TextNumber')
    local attrTargetNode = cellNode.transform:Find('Attribute/Number/Target')
    local attrTargetText = cellNode.transform:Find('Attribute/Number/Target/TextNumber')
    if typeActivateNum == 0 or isTypeActivateAll then -- 从未激活 / 激活全部
        CfUtils.SetActive(attrTargetNode, false)
        CfUtils.FillText(attrCurtText, checkInt(progressRewardsVo.attAddNum))
    else
        CfUtils.SetActive(attrTargetNode, true)
        CfUtils.FillText(attrCurtText, checkInt(activateRewardsVo.attAddNum))
        CfUtils.FillText(attrTargetText, checkInt(progressRewardsVo.attAddNum))
        local isCanUnlock = currentCollectNum >= targetCollectNum
        CfUtils.SetUISwitchText(attrTargetText, isCanUnlock and 2 or 1)
    end


    -------------------------------------------------
    -- update status
    local maxImgNode  = cellNode.transform:Find('BtnStatus/ImgMax')
    local arrowNoNode = cellNode.transform:Find('BtnStatus/ArrowNode')
    local arrowUpNode = cellNode.transform:Find('BtnStatus/ArrowUpGrade')
    local textTitle   = cellNode.transform:Find('BtnStatus/TextTitle')
    if isTypeActivateAll then
        CfUtils.SetActive(maxImgNode, true)
        CfUtils.SetActive(arrowNoNode, false)
        CfUtils.SetActive(arrowUpNode, false)
        CfUtils.SetActive(textTitle, false)
    else
        local isCanUnlock = currentCollectNum >= targetCollectNum
        CfUtils.SetActive(maxImgNode, false)
        CfUtils.SetActive(arrowNoNode, not isCanUnlock)
        CfUtils.SetActive(arrowUpNode, isCanUnlock)
        CfUtils.SetActive(textTitle, true)
        CfUtils.SetUISwitchText(textTitle, isCanUnlock and 2 or 1)
    end

    -------------------------------------------------
    -- play level up anim 
    if isPlayLevelUpAnim then
        CfUtils.PlayAnimation(cellNode, "CultivateOverseaCollectRewardPopup_LevelUP")
    else
        CfUtils.StopAnimation(cellNode)
    end

    -------------------------------------------------
    -- bind handler
    SetButtonAction(cellNode.transform:Find('BtnStatus/Area'), Bind(self, self.OnClickTypeListCellHandler_, luaIndex))
end


-------------------------------------------------
-- handler

function CardProgressionCollectRewardsDialog:OnClickCloseButtonHandler_()
    self:Close()
end


---@param listView SuperScrollView.LoopListView2
---@param luaIndex integer @ start at 1
---@return SuperScrollView.LoopListViewItem2
function CardProgressionCollectRewardsDialog:OnUpdateTypeListCellHandler_(listView, luaIndex)
    local cellNode = listView:NewListViewItem(TypeListCellName)
    self:UpdateTypeListCellInfo_(luaIndex, cellNode)
    return cellNode
end


---@param luaIndex integer
function CardProgressionCollectRewardsDialog:OnClickTypeListCellHandler_(luaIndex)
    local cellCollectType   = self:GetCollectTypeList()[luaIndex]
    local currentCollectNum = illustratedHandbookComp:GetAdditionCollectNum(cellCollectType)
    local progressRewardsVo = illustratedHandbookComp:GetAdditionProgressVo(cellCollectType)
    local typeActivateNum   = illustratedHandbookComp:GetAdditionActivateNum(cellCollectType)
    local targetCollectNum  = checkInt(progressRewardsVo.collectTarget)
    local isTypeActivateAll = typeActivateNum >= targetCollectNum

    if isTypeActivateAll then
        GameUtils.Toast(localize('已升至最高级'))
    else
        local isCanUnlock = currentCollectNum >= targetCollectNum
        if isCanUnlock then
            local requestData = {type = cellCollectType, target = targetCollectNum}
            GameUtils.Request(Interfaces.OverseaCardAdditionUnlock, requestData, function(request, response)
                if checkInt(response.errCode) == 0 then

                    -- update activate cache
                    illustratedHandbookComp:SetAdditionActivateNum(cellCollectType, targetCollectNum)

                    -- update progress cache
                    illustratedHandbookComp:UpdateAdditionProgressVo(cellCollectType)

                    -- check redPoint
                    local typeDefine = CollectionTypeDefines[cellCollectType]
                    typeDefine.redCheckFunc()

                    -- update cell view
                    self:UpdateTypeListCellInfo_(luaIndex, nil, true)

                    GameUtils.Toast(localize('升级成功，全局属性已提升'))
                end
            end)
        else
            GameUtils.Toast(localize('未达到升级条件'))
        end
    end
end


return CardProgressionCollectRewardsDialog
