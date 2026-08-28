
--- lua:
local CoWait = CS.Engine.Lib.CoWait
local util = require 'XLua.util'
local cs_coroutine = require 'XLua.cs_coroutine' -- 协程
local Yielders = CS.Engine.Lib.Yielders -- 协程
local UIModule = CS.Engine.UI.UIModule

local GameUtils = import('Game.Utils.GameUtils')
local Object = CS.UnityEngine.Object
local GameObject = CS.UnityEngine.GameObject
local Vector2 = CS.UnityEngine.Vector2
local Vector3 = CS.UnityEngine.Vector3
local Mathf = CS.UnityEngine.Mathf
local Random = CS.UnityEngine.Random
local Canvas = CS.UnityEngine.Canvas
local Physics = CS.UnityEngine.Physics
local KTool = CS.Engine.Lib.KTool
local KCookie = CS.Engine.Lib.KCookie
local BehaviourAction = CS.Engine.Lib.BehaviourAction

---@type TimeLimitedMgr
local Mgr = import("Game.Activity.TimeLimitedRecruit.TimeLimitedMgr"):GetInstance()

---@type TimeLimitedRecruitUtil
local TimeLimitedRecruitUtil = import("Game.Activity.TimeLimitedRecruit.TimeLimitedRecruitUtil")

---@type ActivityMgr
local ActivityMgr = import('Game.Activity.ActivityMgr'):GetInstance()

--[[
        概率详情面板
]]


--- from: Assets/BundleResources/Prefabs/ActivityDK12003501/ActivityDKMemberPopUp.prefab > name: ActivityDKMemberPopUp
---@class UIActivityTimeLimitedProbabilityPanel
---@field Env                           	UIActivityTimeLimitedProbabilityPanel   
---@field controller                    	Engine.UI.UILuaDialog                   
---@field CloseEmpty                    	UnityEngine.RectTransform               	@ 0    
---@field ButtonClose                   	UnityEngine.RectTransform               	@ 1    
---@field ScrollBar                     	UnityEngine.RectTransform               	@ 2    
---@field EnsuranceMain                 	UnityEngine.RectTransform               	@ 3    
---@field MemberGroup                   	UnityEngine.RectTransform               	@ 4    
---@field Ensurance                     	UnityEngine.RectTransform               	@ 5    
local UIActivityTimeLimitedProbabilityPanel = Class("UIActivityTimeLimitedProbabilityPanel")
---------------------------------------------


---------------------------------------------
function UIActivityTimeLimitedProbabilityPanel:__init()
end


function UIActivityTimeLimitedProbabilityPanel:__delete()
end


function UIActivityTimeLimitedProbabilityPanel:Awake()

    local txtImgTitle = self.Ensurance:Find("ImgTitle")
    CfUtils.SetActive(txtImgTitle, false) -- 程菲: 不用显示了
    
    self.EnsuranceMain = self.Ensurance:Find("EnsuranceMain") -- 概率说明文本
    --
    self.appears = 
    {
        CelParent = self.MemberGroup:Find("Content"),
        BaseCell = self.MemberGroup:Find("Content/RoleCell"),
        EnsuranceTitle = self.MemberGroup:Find("ImgTitle/EnsuranceTitle") -- "出现概率"
    }

    self.gains = 
    {
        CelParent = self.MemberGroup:Find("Content_2"),
        BaseCell = self.MemberGroup:Find("Content_2/RoleCell"),
        EnsuranceTitle = self.MemberGroup:Find("ImgTitel_2/EnsuranceTitle") -- "出现概率"
    }

    CfUtils.SetActive(self.appears.BaseCell, false)
    CfUtils.SetActive(self.gains.BaseCell, false)

    SetButtonAction(self.CloseEmpty, function()
        UIModule.CloseDialog(self.controller)
    end)
    SetButtonAction(self.ButtonClose, function()
        UIModule.CloseDialog(self.controller)
    end)


end


function UIActivityTimeLimitedProbabilityPanel:OnInitialize()

    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        local parameters = checkTable(self.controller.Argument.parameters)
        self.recruitmentDojo = parameters.recruitmentDojo

        ---
        CfUtils.FillText( self.appears.EnsuranceTitle, localize("出现概率") ) 
        CfUtils.FillText( self.gains.EnsuranceTitle,   localize("获得概率") ) 

        for i=1, #self.recruitmentDojo.preview do 
            local cellDojo = self.recruitmentDojo.preview[i]
            self:_AddNewCell(cellDojo, self.appears.BaseCell, self.appears.CelParent, true)
            self:_AddNewCell(cellDojo, self.gains.BaseCell,   self.gains.CelParent,   false)
        end 


        local timeLimitedRecruitActivityScheduleVO = TimeLimitedRecruitUtil.GetTimeLimitedRecruitActivityScheduleVO( checkInt(Mgr.activityData.activityContentId) )

        ---
        local cardId = Mgr:GetCardId()
        --local sameCardDustGoodsVO = TimeLimitedRecruitUtil.GetSameCardDustGoodsVO(cardId)
        ---@type CardVo
        local cardVo = CfUtils.GetCfVo(AutoIds.IdSetting28, 'CardVo' , cardId)

        local desc = timeLimitedRecruitActivityScheduleVO.desc
        desc = string.gsub( desc, "_role_card_", tostring(cardVo.name) )
        desc = string.gsub( desc, "\\n", "\n" ) -- 将回车符 生效

        CfUtils.FillText( self.EnsuranceMain, desc )

            
    end))
    return coWait
end


function UIActivityTimeLimitedProbabilityPanel:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
    end))
    return coWait
end



function UIActivityTimeLimitedProbabilityPanel:_AddNewCell( cellDojo_, baseCell_, parent_, isAppear_ )

    local newCell = CfUtils.InstantiateGo( baseCell_, parent_ )
    CfUtils.SetActive(newCell, true)

    local goodNodeTF = newCell.transform:Find("GoodNode")
    local textNumberTF = newCell.transform:Find("Probability/TextNumber")

    ---@type GoodNodeMB
    local goodNodeMB = CfUtils.GetLuaScr(goodNodeTF, "Game.Behaviours.GoodNodeMB")

    goodNodeMB:Reload({ isShowNo = true , goodsId = cellDojo_.itemId, num = cellDojo_.itemNum, text = "x"..cellDojo_.itemNum})

    goodNodeMB:SetClickCallback(function()
        local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(cellDojo_.itemId)
        if isTable(vo) then
            GameUtils.ShowCommonTipsBoard(goodNodeTF, vo.name, vo.desc, vo.quality, vo.id)
        end
    end)

    local ProbabilityTxt = isAppear_==true and cellDojo_.appearProbability or cellDojo_.getProbability
    CfUtils.FillText( textNumberTF, tostring(ProbabilityTxt)    )
end


return UIActivityTimeLimitedProbabilityPanel
