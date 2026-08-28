
--region global define
local CfUtils   = CfUtils
local isNull    = isNull
local Bind      = Bind
local isNotNull = isNotNull
local SetButtonAction = SetButtonAction

--endregion

--region import
---@type ClubGVGUtils
local ClubGVGUtils     = import('Game.UI.Club.GVG.ClubGVGUtils')

--endregion

--region define
local SetActive        = CfUtils.SetActive
local GetTimeHMS2      = CfUtils.GetTimeHMS2
local GVGConstants     = ClubGVGUtils.Constants
--endregion

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubGvgGroupBaseDetailsPopup.prefab > name: OverseaClubGvgGroupBaseDetailsPopup
---@class ClubGVGGroupBuildingDetails
---@field Env                           	ClubGVGGroupBuildingDetails             
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ClickClose                    	UnityEngine.RectTransform               	@ 0    
---@field Root                          	UnityEngine.Animation                   	@ 1    
---@field BtnShare                      	UnityEngine.RectTransform               	@ 2    
---@field TextName                      	CustomText                              	@ 3    
---@field ImgBg                         	Game.Native.Common.UISwitchImage        	@ 4    
---@field Slider                        	UnityEngine.UI.Slider                   	@ 5    
---@field SliderImgFill                 	Game.Native.Common.UISwitchImage        	@ 6    
---@field SliderTextNumber              	TMPro.TextMeshProUGUI                   	@ 7    
---@field ImgSymbol                     	Game.Native.Common.UISwitchImage        	@ 8    
---@field BuildScoreTextNumber          	Game.Native.Common.UISwitchTextMeshPro  	@ 9    
---@field RaidTeam                      	UnityEngine.RectTransform               	@ 10   
---@field DefendTeam                    	UnityEngine.RectTransform               	@ 11   
---@field BattleTeam                    	UnityEngine.RectTransform               	@ 12   
---@field Button                        	UnityEngine.RectTransform               	@ 13   
---@field ForwardBase                   	UnityEngine.RectTransform               	@ 14   
---@field FontStyleButton               	Game.Native.Common.FontStyleButton      	@ 15   
---@field CommonBtnConsumePop           	UnityEngine.RectTransform               	@ 16   
---@field TimeBeforeAccelerate          	UnityEngine.RectTransform               	@ 17   
---@field BeforeAccelerateTextNumber    	TMPro.TextMeshProUGUI                   	@ 18   
---@field TimeAfterAccelerate           	UnityEngine.RectTransform               	@ 19   
---@field TimeAfterAccelerateTextDesc1  	CustomText                              	@ 20   
---@field AttackBase                    	UnityEngine.RectTransform               	@ 21   
---@field Remind                        	UnityEngine.RectTransform               	@ 22   
---@field AttackBaseTextDesc1           	CustomText                              	@ 23   
---@field ImgGoodsIcon                  	Engine.UI.ImageAlterable                	@ 24   
---@field BtnAuto                       	UnityEngine.RectTransform               	@ 25   
---@field BtnAutoAnimRoot               	UnityEngine.Animation                   	@ 26   
---@field AttackBtn                     	Game.Native.Common.FontStyleButton      	@ 27   
local ClubGVGGroupBuildingDetails = Class('ClubGVGGroupBuildingDetails')

function ClubGVGGroupBuildingDetails:__init()
    self._isInitial = false
    ---@type ClubGVGMgr
    self._mgr = ClubGVGUtils.GetMgr()
    self._isClose = true

    self._attackBuildingConsume = ClubGVGUtils.GetParamValue(GVGConstants.ParamsId.AttackBuildingConsume)
    self._attackPlayerConsume = ClubGVGUtils.GetParamValue(GVGConstants.ParamsId.AttackPlayerConsume)
    self._accelerateLimitSeconds = ClubGVGUtils.GetParamValue(GVGConstants.ParamsId.AccelerateLimitSeconds)
    self._accelerateConsumes = {
        {
            goodsId = ClubGVGUtils.GetParamValue(GVGConstants.ParamsId.AccelerateCurrency),
            num = ClubGVGUtils.GetParamValue(GVGConstants.ParamsId.AccelerateCurrencyNum),
        }
    }
end


function ClubGVGGroupBuildingDetails:__delete()

end


function ClubGVGGroupBuildingDetails:Awake()
    local hpGoodsId = ClubGVGUtils.GetParamValue(GVGConstants.ParamsId.HPGoodsId)
    ---@type GoodsVo
    local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(hpGoodsId)
    self.ImgGoodsIcon:LoadSprite(vo.photoPath)

    self._hpName = vo.name
end


function ClubGVGGroupBuildingDetails:Start()
    SetButtonAction(self.ClickClose, Bind(self, self.OnClickCloseAction))
    SetButtonAction(self.BtnShare,   Bind(self, self.OnBtnShareAction))
    SetButtonAction(self.BtnAuto,    Bind(self, self.OnBtnAutoAction))
    SetButtonAction(self.AttackBtn,  Bind(self, self.OnAttackBtnAction))
    SetButtonAction(self.FontStyleButton,  Bind(self, self.OnFontStyleButtonAction))

    SetActive(self.BtnShare, false)
end


function ClubGVGGroupBuildingDetails:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end

function ClubGVGGroupBuildingDetails:OnEnable()
    self._enable = true
end

function ClubGVGGroupBuildingDetails:OnDisable()
    self._enable = false
end


--region init 


--endregion 


--region logic 

function ClubGVGGroupBuildingDetails:FreshUI(buildingId)
    self:PlayRootAni(false)
    -- if self._buildingId == buildingId then 
    --     return 
    -- end
    self._buildingId = buildingId
    self:ReloadUI(buildingId)
   
end

function ClubGVGGroupBuildingDetails:ReloadUI(buildingId)
    ---走重载的的话 必须id相同
    if buildingId ~= self._buildingId then
        return
    end
    
    local buildingId = self._buildingId
    SetActive(self.controller, true)
    
    --- 建筑物名称
    local buildInfo = self._mgr:GetBuildInfo(buildingId)
    local buildType = buildInfo.type
    ---@type ClubGVGBuildingVo
    local vo        = ClubGVGUtils.GetBuildingVoById(buildType)
    local clubId    = checkNumber(buildInfo.clubId)
    local isSelfClubBuilding = self._mgr:GetClubId() == clubId

    self:FreshBuildBaseInfo(buildInfo, vo, isSelfClubBuilding)
    
    self:FreshBuildTeamDetails(buildInfo)

    self:FreshBottomNode(buildInfo, isSelfClubBuilding)

    self._isInitial = true
end

--region base info

---@param buildInfo table
---@param vo ClubGVGBuildingVo
---@param isSelfClubBuilding boolean 是否是自己工会建筑
function ClubGVGGroupBuildingDetails:FreshBuildBaseInfo(buildInfo, vo, isSelfClubBuilding)
    self.TextName.text = ClubGVGUtils.GetBuildingName(vo, buildInfo.buildingId)

    self:FreshSlider(isSelfClubBuilding, buildInfo.leftHp, vo.life)

    local isMainBuild  = vo.isMainBuild
    local symbolStatus
    if isMainBuild then
        symbolStatus = isSelfClubBuilding and 3 or 4
    else
        symbolStatus = isSelfClubBuilding and 1 or 2
    end

    self.ImgSymbol.Status = symbolStatus

    self.BuildScoreTextNumber.text = vo.score

end

function ClubGVGGroupBuildingDetails:FreshSlider(isSelfClub, leftHp, maxHp)
    local status = isSelfClub and 1 or 2
    self.ImgBg.Status = status
    self.SliderImgFill.Status = status
    self.Slider.value = math.min(leftHp / maxHp, 1)
    self.SliderTextNumber.text = string.format("%s/%s", leftHp, maxHp)

end

--endregion

---@param buildingInfo {buildingId:number, type:number, clubId:number, attackPlayerIds:table, defensePlayerIds:table, fightingInfo:table}
function ClubGVGGroupBuildingDetails:FreshBuildTeamDetails(buildingInfo)
    local buildingType   = buildingInfo.type
    local fightingInfo  = buildingInfo.fightingInfo
    local buildingFightingInfo, battingPlayerIdMap = ClubGVGUtils.GetBuildingFightingInfo(fightingInfo)
    self:FreshBattlingTeam(buildingFightingInfo, buildingType)

    local attackPlayerIds     = buildingInfo.attackPlayerIds
    self:FreshRaidTeam(attackPlayerIds, battingPlayerIdMap)

    local defendPlayerInfo = buildingInfo.defensePlayerIds
    self:FreshDefendTeam(defendPlayerInfo, battingPlayerIdMap)

end

---FreshRaidTeam
---刷新在进攻列的玩家
---@param playerIds table 进攻玩家id列表
function ClubGVGGroupBuildingDetails:FreshRaidTeam(playerIds, battingPlayerIdMap)
    ---@type ClubGVGGroupBuildingDetailsTeamInfo
    local env = self:GetRaidTeamInfoEnv(self.RaidTeam)
    if isNotNull(env) then
        env:FreshUI(playerIds, battingPlayerIdMap, GVGConstants.BuildingStatusLabelType.Attack)
        if not self._isInitial then
            env:SetCallback(Bind(self, self.OnShowBuildingTeamStatusPopupAction))
        end
    end
end

---FreshDefendTeam
---刷新在驻守列的玩家
function ClubGVGGroupBuildingDetails:FreshDefendTeam(playerIds, battingPlayerIdMap)
    ---@type ClubGVGGroupBuildingDetailsTeamInfo
    local env = self:GetDefendTeamInfoEnv(self.DefendTeam)
    if isNotNull(env) then
        env:FreshUI(playerIds, battingPlayerIdMap, GVGConstants.BuildingStatusLabelType.Defense)
        if not self._isInitial then
            env:SetCallback(Bind(self, self.OnShowBuildingTeamStatusPopupAction))
        end
    end
end

---FreshBattlingTeam
---刷新在对战列的玩家
function ClubGVGGroupBuildingDetails:FreshBattlingTeam(buildingFightingInfo, buildingType)
    ---@type ClubGVGGroupBuildingDetailsBattleTeam
    local env = self:GetBattleTeamInfoEnv(self.BattleTeam)
    if isNotNull(env) then
        env:FreshUI(buildingFightingInfo, buildingType, GVGConstants.BuildingStatusLabelType.Battling)
        if not self._isInitial then
            env:SetCallback(Bind(self, self.OnShowBuildingTeamStatusPopupAction))
        end
    end
end

---@param buildingInfo {buildingId:number, clubId:number, attackPlayerIds:table}
function ClubGVGGroupBuildingDetails:FreshBottomNode(buildingInfo, isSelfClubBuilding)
    local buildingState, data = ClubGVGUtils.AnalyzeBuildingState(buildingInfo, isSelfClubBuilding)
    self._isInCoolDown = nil
    self._isCanAutoAttack = false
    -- self._autoAttackSeconds = nil
    self._buildingState, self._buildingStateData = buildingState, data
    SetActive(self.Button, buildingState ~= GVGConstants.BuildingStatus.Non)
    if buildingState == nil then
        printError("未知建筑物状态", buildingState)
        return
    end
    SetActive(self.ForwardBase, buildingState ~= GVGConstants.BuildingStatus.AttackBuildingOrPlayer)
    SetActive(self.AttackBase,  buildingState == GVGConstants.BuildingStatus.AttackBuildingOrPlayer)

    if buildingState == GVGConstants.BuildingStatus.CanMarch then
        SetActive(self.TimeBeforeAccelerate, true)
        SetActive(self.TimeAfterAccelerate, false)
        SetActive(self.CommonBtnConsumePop, false)
        -- print("data", table.toString(data))
        local buildingCount = data.buildingCount
        -- print("buildingCount", buildingCount)
        self.FontStyleButton:ResetFontStyle(buildingCount > 0 and "B3" or "B17", localize("行军"))  
        if buildingCount > 0 then
            self.BeforeAccelerateTextNumber.text = GetTimeHMS2(ClubGVGUtils.CalcMarchSeconds(buildingCount))
        end

    elseif buildingState == GVGConstants.BuildingStatus.Marching then
        SetActive(self.TimeBeforeAccelerate, false)
        SetActive(self.TimeAfterAccelerate, true)
        SetActive(self.CommonBtnConsumePop, true)

        local consume = table.takeFirst(self._accelerateConsumes)
        UICommonUtils.FillCommonBtnConsumePop(self.CommonBtnConsumePop, consume.goodsId, consume.num)
        self:FreshTimeAfterAccelerate()

    elseif buildingState == GVGConstants.BuildingStatus.AttackBuildingOrPlayer then
        SetActive(self.CommonBtnConsumePop, false)

        ---@type ClubGVGHomeDojo
        local dojo           = ClubGVGUtils.GetComp():GetDojo()
        local hp             = dojo.hp
        local autoAttack     = dojo.autoAttack
        local isCanAttackBuilding = data
        -- local isAttackPlayer = next(attackPlayerIds) ~= nil
        local consumeNum     = self._attackBuildingConsume
        self.AttackBaseTextDesc1.text = localize("要消耗_goodsName_: _num_", {_goodsName_ = self._hpName, _num_ = consumeNum})

        local isShowBtnAuto = isCanAttackBuilding and hp > consumeNum
        SetActive(self.BtnAuto, isShowBtnAuto)
        if isShowBtnAuto then
            self.BtnAutoAnimRoot:Play(autoAttack and GVGConstants.AniName.OverseaClubGvgBtnAuto_OnDefault or GVGConstants.AniName.OverseaClubGvgBtnAuto_OffDefault)
        end

        local isInCD = dojo.attackCDEndTime > 0 and GameUtils.GetServerTime() < dojo.attackCDEndTime
        self.AttackBtn:ResetFontStyle((not isCanAttackBuilding or isInCD) and "B18" or "B6", localize("攻城"))  

     
    end

end

---刷新剩余到达时间
function ClubGVGGroupBuildingDetails:FreshTimeAfterAccelerate(curSeconds)
    if self._buildingState ~= GVGConstants.BuildingStatus.Marching then
        return
    end
    local marchInfo = self._buildingStateData
    ---@type ClubGVGHomeDojo
    local dojo        = self._mgr:GetHomeDojo()
    local isInCoolDown = dojo.accelerateCDEndTime > 0 and GameUtils.GetServerTime() < dojo.accelerateCDEndTime
    if self._isInCoolDown ~= isInCoolDown then
        self._isInCoolDown = isInCoolDown
        SetActive(self.CommonBtnConsumePop, not isInCoolDown)
        self.FontStyleButton:ResetFontStyle( isInCoolDown and "B17" or "B3", isInCoolDown and localize("冷却中") or localize("加速"))  
    end

    curSeconds = curSeconds or GameUtils.GetServerTime()
    local seconds = marchInfo.endTime - curSeconds
    
    if seconds > 0 then
        self.TimeAfterAccelerateTextDesc1.text = localize("还剩_num_到达", {_num_ = GetTimeHMS2(seconds)})
    else
        self._isInCoolDown = nil
        self:ReloadUI(self._buildingId)
    end

end

function ClubGVGGroupBuildingDetails:UpdateCountDown(curSeconds)
    if self._isClose then return end
    ---@type ClubGVGGroupBuildingDetailsBattleTeam
    local env = self:GetBattleTeamInfoEnv(self.BattleTeam)
    if isNotNull(env) then
        env:UpdateCountDown(curSeconds)
    end

    self:FreshTimeAfterAccelerate(curSeconds)

    -- if self._isCanAutoAttack then
    --     self._mgr:RequestAtBuilding()
    --     self._isCanAutoAttack = false
    -- end

end

function ClubGVGGroupBuildingDetails:CheckAtkBuildingCondition()
    ---@type ClubGVGHomeDojo
    local dojo        = self._mgr:GetHomeDojo()

    if dojo.clubIsDie == 1 then
        GameUtils.Toast(localize("您的社团主基地已被占领，淘汰出局"))
        return false
    end

    if dojo.attackCDEndTime > 0 and GameUtils.GetServerTime() < dojo.attackCDEndTime then
        GameUtils.Toast(localize("正在战斗中，请稍后"))
        return false
    end
    
    --- 建筑物名称
    -- local buildingInfo   = self._mgr:GetBuildInfo(self._buildingId)
    local isCanAttackBuilding = self._buildingStateData
    if not isCanAttackBuilding then
        GameUtils.Toast(localize("请先击败建筑内其他社团成员"))
        return false
    end

    local hp          = dojo.hp
    local consumeNum  = self._attackBuildingConsume
    if hp < consumeNum then
        GameUtils.Toast(localize("_name_不足", {_name_ = self._hpName}))
        return false
    end
    
    return true
end


function ClubGVGGroupBuildingDetails:PlayRootAni(isClose)
    self._isClose = isClose
    self.Root:Play(isClose and GVGConstants.AniName.HomelandTalentDetailsPopup_Cancel or GVGConstants.AniName.HomelandTalentDetailsPopup_Choose)

    Events.Broadcast(GVGConstants.EventNames.ChangeBuildingDetailsShowState, isClose)
end
--endregion 


--region get/set 

---@return ClubGVGGroupBuildingDetailsTeamInfo
function ClubGVGGroupBuildingDetails:GetRaidTeamInfoEnv(node)
    if isNull(self._raidTeamInfoEnv) then
        self._raidTeamInfoEnv = CfUtils.GetLuaScr(node, GVGConstants.LuaPath.ClubGVGGroupBuildingDetailsTeamInfo)
    end
    return self._raidTeamInfoEnv
end

---@return ClubGVGGroupBuildingDetailsTeamInfo
function ClubGVGGroupBuildingDetails:GetDefendTeamInfoEnv(node)
    if isNull(self._defendTeamInfoEnv) then
        self._defendTeamInfoEnv = CfUtils.GetLuaScr(node, GVGConstants.LuaPath.ClubGVGGroupBuildingDetailsTeamInfo)
    end
    return self._defendTeamInfoEnv
end

---@return ClubGVGGroupBuildingDetailsBattleTeam
function ClubGVGGroupBuildingDetails:GetBattleTeamInfoEnv(node)
    if isNull(self._battleTeamInfoEnv) then
        self._battleTeamInfoEnv = CfUtils.GetLuaScr(node, GVGConstants.LuaPath.ClubGVGGroupBuildingDetailsBattleTeam)
    end
    return self._battleTeamInfoEnv
end

function ClubGVGGroupBuildingDetails:GetBuildingId()
    return self._buildingId
end

---endregion 


--region handler 

function ClubGVGGroupBuildingDetails:OnClickCloseAction()
    self:PlayRootAni(true)
    -- Eve
end

function ClubGVGGroupBuildingDetails:OnBtnShareAction()
    
end

function ClubGVGGroupBuildingDetails:OnBtnAutoAction()
    ---@type ClubGVGHomeDojo
    local dojo        = self._mgr:GetHomeDojo()
    if dojo.autoAttack == false then
        self:OnAttackBtnAction()
    end
    local isAuto = ClubGVGUtils.GetMgr():ReverseAutoAttack()
    self.BtnAutoAnimRoot:Play(isAuto and GVGConstants.AniName.OverseaClubGvgBtnAuto_On or GVGConstants.AniName.OverseaClubGvgBtnAuto_Off)
end

function ClubGVGGroupBuildingDetails:OnAttackBtnAction()
    if not self:CheckAtkBuildingCondition() then
        return
    end

    self._mgr:RequestAtBuilding()
end

function ClubGVGGroupBuildingDetails:OnFontStyleButtonAction()
    local buildingState     = self._buildingState
    local buildingStateData = self._buildingStateData
    if buildingState == GVGConstants.BuildingStatus.CanMarch then
        local buildingCount = buildingStateData.buildingCount
        if buildingCount <= 0 then
            GameUtils.Toast(localize("所选地点无法到达"))
            return
        end
        self._mgr:RequestMarch({path = table.concat(buildingStateData.path, ",")})

    elseif buildingState == GVGConstants.BuildingStatus.Marching then
        if self._isInCoolDown then
            GameUtils.Toast(localize("加速冷却中，稍后再试"))
            return
        end

        ---@type ClubGVGHomeDojo
        local dojo           = ClubGVGUtils.GetComp():GetDojo()
        local serverTime = GameUtils.GetServerTime()
        if dojo.attackCDEndTime > 0 and serverTime < dojo.attackCDEndTime then
            GameUtils.Toast(localize("正在战斗中，请稍后"))
            return
        end

        local consumes, errText = GoodsUtils.CheckGoodConsume(self._accelerateConsumes)
        if errText then
            GameUtils.Toast(errText)
            return
        end

        local CheckAccelerateSeconds = function()
            local seconds = buildingStateData.endTime - serverTime
            if seconds <= self._accelerateLimitSeconds then
                GameUtils.Toast(localize("时间小于_num_秒，无法加速", {_num_ = self._accelerateLimitSeconds}))
                return false
            end

            return true
        end
        if not CheckAccelerateSeconds() then
            return
        end
        if self._mgr:GetAccelerationConfirmTick() then
            self._mgr:RequestMarchAccelerate(consumes)
            return
        end

        local consume = table.takeFirst(self._accelerateConsumes)
        local goodsId, num = consume.goodsId, consume.num
        ---@type GoodsVo
        local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(goodsId)
        GameUtils.SecondConfirm(localize("是否消耗_num__name_加速", {_num_ = num, _name_ = goodsVo.name}), function()
            if not CheckAccelerateSeconds() then
                return
            end
            self._mgr:RequestMarchAccelerate(consumes)

        end, nil, nil, nil, vo, nil, nil, function (isConfirmTick)
            self._mgr:SetAccelerationConfirmTick(isConfirmTick)
        end)


    end
end

function ClubGVGGroupBuildingDetails:OnShowBuildingTeamStatusPopupAction(labelType)
    CfUtils.DialogOpen(Constants.UITypeIds.ClubGVGGroupBaseBuildingTeamStatusPopup, {labelType = labelType, buildingId = self._buildingId})
end

---endregion 


return ClubGVGGroupBuildingDetails
