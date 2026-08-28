
--region global define
local CS        = CS
local require   = require
local import    = import
local isNull    = isNull
local isNotNull = isNotNull
local isSet     = isSet
local checkNumber     = checkNumber
local typeof     = typeof
--endregion

--region import
local CoWait           = CS.Engine.Lib.CoWait
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
local util             = require 'XLua.util'
---@type CatBallUtils
local CatBallUtils     = import("Game.CatBall.CatBallUtils")
---@type GachaponUtils
local GachaponUtils = import('Game.Gachapon.GachaponUtils')
local GameObject       = CS.UnityEngine.GameObject
--endregion

--region define
local RectTransformType   = typeof(CS.UnityEngine.RectTransform)
local TextType            = typeof(CS.UnityEngine.Text)
local UISwitchTextType    = typeof(CS.Game.Native.Common.UISwitchText)
local UISwitchImageType   = typeof(CS.Game.Native.Common.UISwitchImage)
local UISwitchTextMeshProType   = typeof(CS.Game.Native.Common.UISwitchTextMeshPro)
local TextMeshProUGUIType   = typeof(CS.TMPro.TextMeshProUGUI)


--endregion

--- from: Assets/BundleResources/Prefabs/OverseaManage/OverseaManageCatballDrawMember.prefab
---@class CatBallDrawMember
---@field Env                           	CatBallDrawMember                       
---@field controller                    	Engine.UI.UILuaDialog                   
---@field RoleCell                      	UnityEngine.RectTransform               
---@field ButtonClose                   	UnityEngine.UI.Button                   
---@field ScrollBar                     	UnityEngine.RectTransform               
---@field EnsuranceTitle                	UnityEngine.UI.Text                     
---@field MemberGroup                   	UnityEngine.RectTransform               
---@field CommonSmallHeadNode           	UnityEngine.RectTransform               
---@field EnsuranceMain                 	UnityEngine.UI.Text                     
---@field Ensurance                     	UnityEngine.RectTransform               
---@field block                         	UnityEngine.UI.Button                   
---@field VertContent                   	UnityEngine.RectTransform               
---@field MemberBlock                   	UnityEngine.RectTransform               
local CatBallDrawMember = Class('CatBallDrawMember')


function CatBallDrawMember:__init()
end


function CatBallDrawMember:__delete()
    self.controller = nil
end


function CatBallDrawMember:Awake()
    self.EmptyClose = self.controller.transform:Find("EmptyClose")
end


function CatBallDrawMember:OnFocus(focus)

end


function CatBallDrawMember:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:OnInit()
    end))
    return coWait
end


function CatBallDrawMember:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        GameUtils.HidePreviousDialogs(self.controller)
    end))
    return coWait
end

function CatBallDrawMember:OnHide()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        GameUtils.ShowPreviousDialogs()
    end))
    return coWait
end


function CatBallDrawMember:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
        self = nil
    end))
    return coWait
end


--region init 

function CatBallDrawMember:OnInit()
    self:InitData()
    self:InitAction()
    self:InitMember()
end

function CatBallDrawMember:InitData()
    local function unique(t)
        local check = {}
        local n = {}
        local idx = 1
        for k, v in pairs(t) do
            if not check[v.itemId] then
                n[idx] = v
                idx = idx + 1
                check[v.itemId] = true
            end
        end
        return n
    end
    local parameters  = self.controller.Argument.parameters
    local pool        = clone(parameters.pool)

    local members = unique(pool.preview)
    print(table.toString(members))
    ---@type table<Constants.RareType, CatBallEntity[]>
    local filter = {}
    local UpFilter = {}
    local memberMap = {}
    for i = 1, #members do
        ---@type CatBallEntity
        local memberData = self:GetMembersData(members[i].itemId)
        local rare = checkNumber(members[i].rareGroup)
        -- filter
        filter[rare] = filter[rare] or {}
        table.insert(filter[rare], memberData)
        -- UpFilter
        UpFilter[rare] = UpFilter[rare] or {}
        if members[i].isUp == 1 then
            table.insert(UpFilter[rare], memberData)
        end
        -- memberMap
        local displayNum = checkNumber(members[i].displayNum)
        displayNum = checkInt(displayNum * 10000) / 100 
        members[i].displayNum = displayNum
        memberMap[memberData.goodsId] = members[i]
    end

    -- print(table.toString(pool.rates))
    local poolRates = {}
    local ratesIndex = {}
    for rare, value in pairs(pool.rates) do
        rare = checkNumber(rare)
        poolRates[rare] = checkNumber(value) * 100
        table.insert(ratesIndex, rare)
    end
    table.sort(ratesIndex, function (a, b) return a > b end)

    self._ratesIndex = ratesIndex
    self._filter = filter
    self._memberMap = memberMap
    self._poolRates = poolRates
    
    self._poolDesc = pool.poolDesc
end

function CatBallDrawMember:InitAction()
    SetButtonAction(self.ButtonClose, function()
        CfUtils.DialogBack()
        -- self.controller:Close()
    end)
    if self.EmptyClose then
        SetButtonAction(self.EmptyClose, function()
            CfUtils.DialogBack()
            -- self.controller:Close()
        end)
    end
end

function CatBallDrawMember:InitMember()
    --- Fresh UI
    self.EnsuranceMain.text = self._poolDesc

    KTool.SetActive(self.ScrollBar.gameObject, true)
 
    local MemberGroup = self.MemberGroup    
    for _, rare in ipairs(self._ratesIndex) do
        local members = self._filter[rare]
        if members then
            local rectTrans = GameObject.Instantiate(self.MemberBlock.gameObject, MemberGroup):GetComponent(RectTransformType)
            KTool.SetActive(rectTrans.gameObject, true)
            self:UpdateMemberBlock(rectTrans, members, self._memberMap, rare, self._poolRates[rare])
        end
    end
    CfUtils.SetCanvasGroupAlpha(self.ScrollBar.gameObject , 1)
end

---UpdateMemberBlock
---@param memberBlockTrans UnityEngine.RectTransform @ 头像节点
---@param members CatBallEntity[] @ 猫球列表
---@param previewMap table<integer, GachaponPreviewDojo> @ up的卡牌id
---@param rareId integer @ 品质id
---@param rateValue number @ 品质概率值
function CatBallDrawMember:UpdateMemberBlock(memberBlockTrans, members, previewMap, rareId, rateValue)
    local memberChildrenPath = {
        rare       = { path = "TittleGroup/rare",            componentName = UISwitchTextType },
        bg         = { path = "TittleGroup/bg",              componentName = UISwitchImageType },
        value      = { path = "TittleGroup/TextProbability", componentName = UISwitchTextMeshProType },
        Content    = { path = "Content",                     componentName = RectTransformType },
        introTitle = { path = "Image/introTitle",            componentName = TextType },  -- intro child
        introMain  = { path = "introMain",                   componentName = TextType },  -- intro child
    }

    -- 品质标题字
    local component = self:GetComponent(memberBlockTrans, memberChildrenPath.rare)
    if component then
        component.text = CfUtils.GetRareText(rareId)
        component.Status = rareId
    end

    -- 品质概率值
    ---@type Game.Native.Common.UISwitchTextMeshPro
    local value = self:GetComponent(memberBlockTrans, memberChildrenPath.value)
    if value then
        value.text = string.format('%s%%', tostring(rateValue))
        value.Status = rareId
    end

    -- 品质标题背景条
    ---@type Game.Native.Common.UISwitchImage
    local bg = self:GetComponent(memberBlockTrans, memberChildrenPath.bg)
    if bg then
        bg.Status = rareId
    end

    local Content = self:GetComponent(memberBlockTrans, memberChildrenPath.Content)
    if members then
        local memberCount = #members
        if memberCount > 0 then
            CoYield()
            CfUtils.SetActive(Content, true)
            GachaponUtils.ResizeContent(Content, memberCount, self.RoleCell.gameObject)
            table.sort(members, function(aEntity, bEntity)
                local aPreviewDojo = previewMap[aEntity.goodsId]
                local bPreviewDojo = previewMap[bEntity.goodsId]

                local upA    = aPreviewDojo.isUp and 1 or 0
                local upB    = bPreviewDojo.isUp and 1 or 0
                if upA ~= upB then
                    return upA > upB
                end
                if aEntity.vo.rare ~= bEntity.vo.rare then
                    return aEntity.vo.rare > bEntity.vo.rare
                end
                return aEntity.goodsId > bEntity.goodsId
                
            end)
            for i = 1, memberCount do
                ---@type CatBallEntity
                local entity = members[i]
                local memberIns = Content:GetChild(i - 1)
                self:UpdateMemberCell(memberIns, entity, previewMap[entity.goodsId])
            end
        else
            CfUtils.SetActive(Content, false)
        end
    else
        CfUtils.SetActive(Content, false)
    end
end

---UpdateMemberCell
---@param trans UnityEngine.Transform
---@param entity CatBallEntity
---@param previewDojo GachaponPreviewDojo
function CatBallDrawMember:UpdateMemberCell(trans, entity, previewDojo)
    -- up状态标识
    local isCardUp  = previewDojo.isUp == 1
    local imgUpNode = self:GetComponent(trans, {path = "ImgUp" , componentName = RectTransformType} )
    local rateImgBg = self:GetComponent(trans, {path = "Probability/ImgBg" , componentName = UISwitchImageType} )
    CfUtils.SetActive(imgUpNode, isCardUp == true)
    if rateImgBg then
        rateImgBg.Status = isCardUp and 2 or 1
    end

    -- 概率文本
    local rateValue = self:GetComponent(trans, {path = "Probability/TextNumber" , componentName = TextMeshProUGUIType} )
    if rateValue then
        rateValue.text  = string.format('%s%%', tostring(previewDojo.displayNum))
    end

    local headNode = self:GetComponent(trans ,{path = "CommonSmallCatballNode" , componentName = RectTransformType} )
    if headNode then
        KTool.SetActive(headNode, true)
        CatBallUtils.FreshCommonSmallCatBallNode(headNode, entity, function ()
            self.controller:Close()
            CatBallUtils.PreviewCatBall(entity.goodsId, {UIArgs(Constants.UITypeIds.CatBallDrawEntryDialog)})
        end)
    end
end


--endregion 


--region logic 


--endregion 


--region get/set 

function CatBallDrawMember:GetMembersData(goodsId)
    ---@type CatEggDojo
    local catEggDojo    = CatBallUtils.GeneratedVirtualCatEggDojo(goodsId)
    ---@type CatBallEntity
    local catBallEntity = CatBallUtils.GeneratedCatBallEntity(catEggDojo)
    return catBallEntity, catBallEntity.vo.rare
end

---@param trans UnityEngine.Transform
---@param compTable table 类型
---@return UnityEngine.Component | nil
function CatBallDrawMember:GetComponent(trans ,  compTable)
    local object = trans:Find(compTable.path)
    if isNull(object)  then
        return
    end
    return object.gameObject:GetComponent(compTable.componentName)
end

---endregion 


--region handler 


---endregion 


return CatBallDrawMember
