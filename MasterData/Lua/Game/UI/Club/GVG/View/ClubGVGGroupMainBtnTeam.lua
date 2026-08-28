
--region global define
local isNull    = isNull
local isNotNull = isNotNull
local CfUtils = CfUtils
--endregion

--region import
---@type ClubGVGUtils
local ClubGVGUtils     = import('Game.UI.Club.GVG.ClubGVGUtils')
local GVGConstants     = ClubGVGUtils.Constants

local StageStatus = GVGConstants.StageStatus
--endregion

--region define

local SetActive = CfUtils.SetActive
--endregion

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubGvgGroupMainDialog.prefab > name: BtnTeam
---@class ClubGVGGroupMainBtnTeam
---@field Env                           	ClubGVGGroupMainBtnTeam                 
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field UIFX_Team_Entrance            	UnityEngine.RectTransform               	@ 0    
---@field UIFX_Team_Rebirth             	UnityEngine.RectTransform               	@ 1    
---@field Slider                        	UnityEngine.RectTransform               	@ 2    
---@field SliderImgFill                 	UnityEngine.UI.Image                    	@ 3    
---@field ImgIcon                       	Game.Native.Common.UISwitchImage        	@ 4    
---@field StatusMarching                	UnityEngine.RectTransform               	@ 5    
---@field StatusSuspend                 	UnityEngine.RectTransform               	@ 6    
---@field TextDesc                      	Game.Native.Common.UISwitchText         	@ 7    
---@field Vitality                      	UnityEngine.RectTransform               	@ 8    
---@field BtnExplain                    	UnityEngine.RectTransform               	@ 9    
---@field ImgGoodsIcon                  	Engine.UI.ImageAlterable                	@ 10   
---@field TextNumber                    	TMPro.TextMeshProUGUI                   	@ 11   
local ClubGVGGroupMainBtnTeam = Class('ClubGVGGroupMainBtnTeam')

function ClubGVGGroupMainBtnTeam:__init()

end


function ClubGVGGroupMainBtnTeam:__delete()

end


function ClubGVGGroupMainBtnTeam:Awake()
    SetActive(self.UIFX_Team_Entrance, false)
    SetActive(self.UIFX_Team_Rebirth,  false)
    SetActive(self.Slider,             false)
    SetActive(self.StatusMarching,     false)
    SetActive(self.StatusSuspend,      false)
    SetActive(self.Vitality,           false)
    SetActive(self.TextDesc,           false)

    local hpGoodsId        = ClubGVGUtils.GetParamValue(GVGConstants.ParamsId.HPGoodsId)
    local vo               = GoodsConfMgr:GetInstance():GetGoodsVoById(hpGoodsId)
    self.ImgGoodsIcon:LoadSprite(vo.photoPath)
end


function ClubGVGGroupMainBtnTeam:Start()
    SetButtonAction(self.BtnExplain, Bind(self, self.OnClickBtnExplainAction))
end


function ClubGVGGroupMainBtnTeam:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

---FreshUI
function ClubGVGGroupMainBtnTeam:FreshUI()
    ---@type ClubGVGMgr
    local mgr          = ClubGVGUtils.GetMgr()
    local stageStatus = mgr:GetStageStatus()
    local dojo = mgr:GetHomeDojo()
    -- print("stageStatus--->>>", stageStatus)
    local isHide = stageStatus == StageStatus.PrepareComplete or dojo.clubIsDie == 1
    SetActive(self.controller,        not isHide)
    if isHide then
        return stageStatus
    end

    self.ImgIcon.Status = CfUtils.IsWoman() and 1 or 2

    local isBattleStageAndUneditedTeam = stageStatus == StageStatus.BattleStageAndUneditedTeam
    if  stageStatus == StageStatus.PrepareAndUneditedTeam or isBattleStageAndUneditedTeam then
        SetActive(self.TextDesc,           true)
        self.TextDesc.Status = 1
        SetActive(self.UIFX_Team_Entrance, false)
        SetActive(self.Vitality, false)
        SetActive(self.Slider, false)

    elseif stageStatus == StageStatus.BattleStageAndNonAcceded then
        SetActive(self.TextDesc,           true)
        self.TextDesc.Status = 2
        SetActive(self.UIFX_Team_Entrance, not mgr:GetResurrecting())
        SetActive(self.Vitality, false)
        SetActive(self.Slider, false)
        self:FreshMarchStatus(false)
        
    elseif stageStatus == StageStatus.InBattle then
        SetActive(self.TextDesc,           false)
        self.TextDesc.Status = 2

        ---@type ClubGVGHomeDojo
        local dojo         = mgr:GetComp():GetDojo()
        local hp           = dojo.hp
        local maxHp        = ClubGVGUtils.GetParamValue(GVGConstants.ParamsId.PlayerInitHP)
        local sliderVal    = math.min(1, hp / maxHp)

        SetActive(self.UIFX_Team_Entrance, hp == maxHp and dojo.playerPlace == dojo.clubPlace)

        SetActive(self.Vitality, true)
        self.TextNumber.text = hp

        SetActive(self.Slider, true)
        self.SliderImgFill.fillAmount = sliderVal
        self:FreshMarchStatus(mgr:GetMarchSeconds() ~= nil)

    end
    

    return stageStatus
end

function ClubGVGGroupMainBtnTeam:FreshMarchStatus(isShow)
    SetActive(self.StatusMarching, isShow)
end

function ClubGVGGroupMainBtnTeam:FreshRebirthEffectShowStatus(isShow)
    SetActive(self.UIFX_Team_Rebirth, isShow)
end

function ClubGVGGroupMainBtnTeam:FreshTeamEntranceShowStatus(isShow)
    SetActive(self.UIFX_Team_Entrance, isShow)
end

--endregion 


--region get/set 


---endregion 


--region handler 

function ClubGVGGroupMainBtnTeam:OnClickBtnExplainAction()
    
end

---endregion 


return ClubGVGGroupMainBtnTeam
