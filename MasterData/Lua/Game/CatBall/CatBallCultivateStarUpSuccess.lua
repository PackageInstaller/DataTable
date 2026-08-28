
--region global define

--endregion

--region import
local util            = require 'XLua.util'
local CoWait          = CS.Engine.Lib.CoWait
---@type CatBallUtils
local CatBallUtils    = import("Game.CatBall.CatBallUtils")
local CriWareUtils    = import('Game.Entry.CriWareUtilsFix')
---@type ActionUtils
local ActionUtils     = import('Game.UI.FightReady.UIMainChapter.ActionUtils')
--endregion

--region define

--endregion

--- from: Assets/BundleResources/Prefabs/OverseaManage/OverseaManageCatballStarupSuccess.prefab
---@class CatBallCultivateStarUpSuccess
---@field Env                           	CatBallCultivateStarUpSuccess           
---@field controller                    	Engine.UI.UILuaDialog                   
---@field Success                       	UnityEngine.Animation                   
---@field FontStyleButton               	UnityEngine.RectTransform               
---@field ItemAttribute                 	UnityEngine.RectTransform               
---@field StarLevelNode                 	UnityEngine.RectTransform               
local CatBallCultivateStarUpSuccess = Class('CatBallCultivateStarUpSuccess')


function CatBallCultivateStarUpSuccess:__init()
end


function CatBallCultivateStarUpSuccess:__delete()
    self.controller = nil
end


-- function CatBallCultivateStarUpSuccess:Awake()
-- end


function CatBallCultivateStarUpSuccess:OnFocus(focus)

end


function CatBallCultivateStarUpSuccess:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

        self:OnInit()
        CriWareUtils.PlaySe(UISheets.SFX_UI_CAT.path, UISheets.SFX_UI_CAT.sfx_ui_cat_starup)
    end))
    return coWait
end


function CatBallCultivateStarUpSuccess:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        ActionUtils.ShowTaskTipsNodeByDialog(self.controller, Constants.UITypeIds.CatBallCultivateDialog)
        self:FreshUI()
    end))
    return coWait
end


function CatBallCultivateStarUpSuccess:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
        self = nil
    end))
    return coWait
end


--region init 

function CatBallCultivateStarUpSuccess:OnInit()
    self:InitData()
    self:InitAction()
end

function CatBallCultivateStarUpSuccess:InitData()
    local parameters = self.controller.Argument.parameters
    ---@type CatEggDojo
    local dojo       = parameters.dojo
    local star       = checkNumber(dojo.star)
    self._oldStar    = star - 1
    self._star       = star
    self._dojo       = dojo

    local attrDefineInfo = CatBallUtils.CompareCatBallStarAttrDefineInfo(dojo.catId, self._oldStar, star)
    self._attrDefineInfo = attrDefineInfo

    self.controller:SetExtraArgument(tostring(dojo.id))
end

function CatBallCultivateStarUpSuccess:InitAction()
    SetButtonAction(self.FontStyleButton, function() 
        self.controller:Close()
    end)
end

--endregion 


--region logic 

function CatBallCultivateStarUpSuccess:FreshUI()
    self:FreshStarNodes()
    self:FreshSkillAndAttribute()
end

function CatBallCultivateStarUpSuccess:FreshStarNodes()
    ---@type CardProgressionStarGroupNode
    local env = CfUtils.GetLuaScr(self.StarLevelNode, "Game.CardProgression.Common.CardProgressionStarGroupNode")
    if isNull(env) then return end
    env:FreshUI(self._oldStar, self._star, nil, nil, true)
end

function CatBallCultivateStarUpSuccess:FreshSkillAndAttribute()
    ---@type CatBallChooseCardsSkillAndAttributeNode
    local env = CfUtils.GetLuaScr(self.ItemAttribute.gameObject, "Game.CatBall.CatBallChooseCardsSkillAndAttributeNode")
    if isNull(env) then return end
    env:FreshUI(self._dojo, self._star)
end

--endregion 


--region get/set 


---endregion 


--region handler 


---endregion 


return CatBallCultivateStarUpSuccess
