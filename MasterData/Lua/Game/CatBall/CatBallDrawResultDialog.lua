
--region global define
local require   = require
local import    = import
local isNull    = isNull
local isNotNull = isNotNull
--endregion

--region import
local util             = require 'XLua.util'
local CoWait           = CS.Engine.Lib.CoWait
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
--endregion

--region define
local EnvPath = "Game.CatBall.CatBallDrawResultCell"
--endregion

--- from: Assets/BundleResources/Prefabs/OverseaManage/OverseaManageCatballDrawResultDialog.prefab
---@class CatBallDrawResultDialog
---@field Env                           	CatBallDrawResultDialog                 
---@field controller                    	Engine.UI.UILuaDialog                   
---@field DrawContentMultiNode          	UnityEngine.RectTransform               
---@field DrawContentOneNode            	UnityEngine.RectTransform               
---@field ClickClose                    	UnityEngine.RectTransform               
local CatBallDrawResultDialog = Class('CatBallDrawResultDialog')


function CatBallDrawResultDialog:__init()
end


function CatBallDrawResultDialog:__delete()
    self.controller = nil
end


function CatBallDrawResultDialog:Awake()
end


function CatBallDrawResultDialog:OnFocus(focus)

end


function CatBallDrawResultDialog:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:OnInit()
        self:FreshUI()
    end))
    return coWait
end


function CatBallDrawResultDialog:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        if not self._isDisableEnter then
            local animTrans = self.controller.transform:Find("Root")
            CfUtils.PlayAnimation(animTrans, "OverseaManageCatballDrawResultDialog_Entry")
        end

    end))
    return coWait
end


function CatBallDrawResultDialog:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
        self = nil
    end))
    return coWait
end


--region init 

function CatBallDrawResultDialog:OnInit()
    self:InitData()
    self:InitAction()
end

function CatBallDrawResultDialog:InitData()
    local parameters = self.controller.Argument.parameters
    local rewards    = parameters.rewards
    ---@type CatBallEntity[]
    self._rewards    = rewards
    self._isDisableEnter = parameters.isDisableEnter

end

function CatBallDrawResultDialog:InitAction()
    SetButtonAction(self.ClickClose, Bind(self, self.OnClickEmptyAreaAction))
end

--endregion 


--region logic 

function CatBallDrawResultDialog:FreshUI()
    local isMulti = #self._rewards > 1
    KTool.SetActive(self.DrawContentOneNode,   not isMulti)
    KTool.SetActive(self.DrawContentMultiNode, isMulti)
  
    local parent     = isMulti and self.DrawContentMultiNode or self.DrawContentOneNode
    local childCount = parent.childCount
    for i = 1, childCount do
        local child = parent:GetChild(i - 1)
        local entity = self._rewards[i]
        local isShowChild = entity ~= nil
        KTool.SetActive(child.gameObject, isShowChild)
        self:FreshCell(child, entity)
    end

end

function CatBallDrawResultDialog:FreshCell(cell, entity)
    ---@type CatBallDrawResultCell
    local env = CfUtils.GetLuaScr(cell, EnvPath)
    if isNull(env) then return end
    env:FreshUI(entity, self._isDisableEnter)
    env:SetCallback(Bind(self, self.OnClickCellAction))
    
end


--endregion 


--region get/set 


---endregion 


--region handler 

function CatBallDrawResultDialog:OnClickEmptyAreaAction()
    self.controller:Close()
    self.controller.Argument.parameters.isDisableConversionYield = true
    CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop, self.controller.Argument.parameters, nil, true)
end

function CatBallDrawResultDialog:OnClickCellAction(catBallEntity)
    self.controller.Argument.parameters.isDisableEnter = true
    ---@type CatBallUtils
    local CatBallUtils              = import("Game.CatBall.CatBallUtils")
    CatBallUtils.PreviewCatBall(catBallEntity.goodsId)

end

---endregion 


return CatBallDrawResultDialog
