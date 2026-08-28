
--region global define
local require   = require
local import    = import
local isNull    = isNull
local isNotNull = isNotNull
--endregion

--region import
local util             = require 'XLua.util'
local CoWait           = CS.Engine.Lib.CoWait

---@type CardComponent
local cardComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardComponent)
--endregion

--region define

local ActionRecommendPopupTipsDesc = "Game.UI.ActionRecommend.ActionRecommendPopupTipsDesc"
local CardHeadNode = "Game.Behaviours.CardHeadNode"

--endregion

--- from: Assets/BundleResources/Prefabs/Action/ActionRecommendPopup.prefab > name: ActionRecommendPopup
---@class ActionRecommendPopup
---@field Env                           	ActionRecommendPopup                    
---@field controller                    	Engine.UI.UILuaDialog                   
---@field TxtTitle                      	UnityEngine.UI.Text                     	@ 0    
---@field TxtTime                       	UnityEngine.UI.Text                     	@ 1    
---@field BtnClose1                     	UnityEngine.RectTransform               	@ 2    
---@field TaskSwitch                    	UnityEngine.RectTransform               	@ 3    
---@field TitleDesc                     	UnityEngine.RectTransform               	@ 4    
---@field RoleDesc                      	UnityEngine.RectTransform               	@ 5    
---@field RecommendRole                 	UnityEngine.RectTransform               	@ 6    
---@field RoleNode                      	UnityEngine.RectTransform               	@ 7    
---@field HeadNode                      	UnityEngine.RectTransform               	@ 8    
local ActionRecommendPopup = Class('ActionRecommendPopup')


function ActionRecommendPopup:__init()
end


function ActionRecommendPopup:__delete()
    self.controller = nil
end


function ActionRecommendPopup:Awake()

end


function ActionRecommendPopup:OnFocus(focus)
    if focus then
        CfUtils.SetTopCommonCb(function() 
            self:OnClickCloseBtnAction()
        end)
    else
        CfUtils.ResetNavigatorCustomBackAction()
    end
end


function ActionRecommendPopup:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:OnInit()
        self:FreshUI()

        self:StartCountDown()

        local isExits = UICommonUtils.CheckIsExistsBlackOverLay()
        if isExits then
            self._overlayCo = CoStart(function() 
                while UICommonUtils.CheckIsExistsBlackOverLay() do
                    CoYield()
                end
                self.ImgBlack:Capture()
                self._overlayCo = nil
            end)
        else
            self.ImgBlack:Capture()
        end
    end))
    return coWait
end


-- function ActionRecommendPopup:OnShow()
--     ---@type Engine.Lib.CoWait
--     local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        
--     end))
--     return coWait
-- end


function ActionRecommendPopup:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:StopCountDown()
        if isNotNull(self._overlayCo) then
            CoStop(self._overlayCo)
        end
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
        self = nil
    end))
    return coWait
end


--region init 

function ActionRecommendPopup:OnInit()
    self:InitData()
    self:InitAction()
end

function ActionRecommendPopup:InitData()
    local parameters = self.controller.Argument.parameters
    local tipsId     = parameters.tipsId
    local isAuto     = parameters.isAuto
    parameters.isAuto = nil

    ---@type ActionRecommendVo
    local vo = CfUtils.GetCfVo(AutoIds.IdSetting5000, "ActionRecommendVo", tipsId)
    self._vo = vo

    self._isAuto = isAuto

end

function ActionRecommendPopup:InitAction()
    SetButtonAction(self.BtnClose1, Bind(self, self.OnClickCloseBtnAction))
    SetButtonAction(self.BtnClose, Bind(self, self.OnClickCloseBtnAction))
end

--endregion 


--region logic 

function ActionRecommendPopup:FreshUI()
    ---大标题
    ---@type ActionRecommendVo
    local vo = self._vo
    self.TxtTitle.text = vo.title

    ---小标题
    self:FreshSubTitles(vo)

    ---推荐角色文本介绍
    self:FreshTipsDesc(self.RoleDesc, vo.desc3)
    ---移动到父节点最下面
    self.RoleDesc:SetAsLastSibling()

    self:FreshRecommendRole(vo:GetRoles())

end

---FreshSubTitles
---@param vo ActionRecommendVo
function ActionRecommendPopup:FreshSubTitles(vo)
    local subTitleList = self:GetSubTitleList(vo)
    local isShow = #subTitleList > 0
    CfUtils.SetActive(self.TitleDesc, isShow)
    if not isShow then return end

    for index, value in ipairs(subTitleList) do
        local desc, title = SafeUnpack(subTitleList[index])
        local node
        if index == 1 then
            node = self.TitleDesc
        else
            node = self.TaskSwitch.gameObject:AddChild(self.TitleDesc.gameObject)
        end
        self:FreshTipsDesc(node, desc, title)
    end
        
end

function ActionRecommendPopup:FreshTipsDesc(node, desc, title)
    ---@type ActionRecommendPopupTipsDesc
    local env = CfUtils.GetLuaScr(node, ActionRecommendPopupTipsDesc)
    if isNotNull(env) then
        env:FreshUI(desc, title)
    end
end

function ActionRecommendPopup:FreshRecommendRole(cardIds)
    local isShow = #cardIds > 0
    CfUtils.SetActive(self.RecommendRole, isShow)
    if not isShow then
        return
    end
    GameUtils.ResizeContent(self.RoleNode, self.HeadNode, #cardIds, function(luaIndex, childNode) 
        CfUtils.GetLuaScr(childNode, ActionRecommendPopup)
        local cardId = cardIds[luaIndex]

        local viewType
        ---@type CardDojo
        local dojo
        local id = cardComponent:GetIdByCardId(cardId)
        print(id, "iiiiii")
        if id ~= nil then
            viewType = 1
            dojo = cardComponent:GetCardById(id)
            UICommonUtils.FillCardHeadNode(childNode, viewType, function ()
                ---@type CardProgressionUtils
                local CardProgressionUtils = import("Game.CardProgression.CardProgressionUtils")
                CardProgressionUtils.OpenDialog(Constants.UITypeIds.CultivateMain, {playerCardId = id}, UICommonUtils.GetShowDialogArguments())
            end, dojo, true)
        else
            viewType = 2
            UICommonUtils.FillCardHeadNode(childNode, viewType, function ()
                ---@type GachaponUtils
                local gachaponUtils = import('Game.Gachapon.GachaponUtils')
                gachaponUtils.OpenDetail(cardId, UICommonUtils.GetShowDialogArguments())
            end, cardId)
        end

    end)
end

function ActionRecommendPopup:StartCountDown()
    if not self._isAuto then
        CfUtils.SetActive(self.TxtTime, false)
        return
    end
    self._isDisableClose = true
    local closeTime = self._vo.closeTime
    local seconds   = os.time()
    self.TxtTime.text = localize("_num_秒 关闭", {_num_ = closeTime})
    self._co = CoStart(function() 
        local passageSeconds = os.time() - seconds
        while passageSeconds < closeTime do
            CoYield(1)
            passageSeconds = os.time() - seconds
            self.TxtTime.text = localize("_num_秒 关闭", {_num_ = math.max(closeTime - passageSeconds, 0)})
        end
        CfUtils.SetActive(self.TxtTime, false)
        self._isDisableClose = false
        self._co = nil
    end)
end

function ActionRecommendPopup:StopCountDown()
    if not self._isAuto then
        return
    end
    CoStop(self._co)
end

function ActionRecommendPopup:FreshSeconds(seconds)
    CfUtils.SetActive(self.tex)
end

--endregion 


--region get/set 

---GetSubTitleList
---@param vo ActionRecommendVo
function ActionRecommendPopup:GetSubTitleList(vo)
    local subTitleList = {}
    if not string.isEmpty(vo.head1) and not string.isEmpty(vo.desc1) then
        table.insert(subTitleList, {vo.desc1, vo.head1})
    end

    if not string.isEmpty(vo.head2) and not string.isEmpty(vo.desc2) then
        table.insert(subTitleList, {vo.desc2, vo.head2})
    end

    return subTitleList

end

---endregion 


--region handler 

function ActionRecommendPopup:OnClickCloseBtnAction()
    if self._isDisableClose then
        return
    end
    self.controller:Close()
end


---endregion 


return ActionRecommendPopup
