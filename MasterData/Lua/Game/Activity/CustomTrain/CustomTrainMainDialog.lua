--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/CustomTrain/CustomTrainMainDialog.prefab > name: CustomTrainMainDialog
---@class CustomTrainMainDialog
---@field Env                           	CustomTrainMainDialog                   
---@field controller                    	Engine.UI.UILuaDialog                   
---@field CustomTrainMainDialog_State_1 	UnityEngine.RectTransform               	@ 0    
---@field CustomTrainMainDialog_State_2 	UnityEngine.RectTransform               	@ 1    
---@field CustomTrainMainDialog_State_3 	UnityEngine.RectTransform               	@ 2    
---@field MaxBattleTxtDesc_1            	UnityEngine.RectTransform               	@ 3    
---@field MaxBattleTxtDesc_2            	UnityEngine.RectTransform               	@ 4    
---@field LeftTxtTime                   	UnityEngine.RectTransform               	@ 5    
---@field TxtDesc                       	UnityEngine.RectTransform               	@ 6    
---@field CurrentTxtDesc_2              	UnityEngine.RectTransform               	@ 7    
---@field Empty                         	UnityEngine.RectTransform               	@ 8    
---@field CommonGoodsListLight          	UnityEngine.RectTransform               	@ 9    
---@field redPoint                      	UnityEngine.RectTransform               	@ 10   
---@field CommRoleBonusLayoutGroup      	UnityEngine.RectTransform               	@ 11   
---@field BossNameText                  	UnityEngine.RectTransform               	@ 12   
---@field ImgBossIcon                   	UnityEngine.RectTransform               	@ 13   
---@field TeamFontStyleButton           	UnityEngine.RectTransform               	@ 14   
---@field BtnCheck                      	UnityEngine.RectTransform               	@ 15   
---@field Button                        	UnityEngine.RectTransform               	@ 16   
---@field BtnReward                     	UnityEngine.RectTransform               	@ 17   
---@field Reward                        	UnityEngine.RectTransform               	@ 18   
---@field DrawRewardBtn                 	UnityEngine.RectTransform               	@ 19   
---@field RestTxtTime                   	UnityEngine.RectTransform               	@ 20   
---@field RuleTxtDesc                   	UnityEngine.RectTransform               	@ 21   
local CustomTrainMainDialog = Class('CustomTrainMainDialog')
local UIModule = CS.Engine.UI.UIModule
local CDTimerModule = CS.Engine.Modules.CDTimerModule
local KCookie = CS.Engine.Lib.KCookie
---@type CustomTrainComponent 
local CustomTrainComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CustomTrainComponent)
function CustomTrainMainDialog:__init()
    self.selectIndex = checkInt(KCookie.Get("Custom_Index")) > 0  and checkInt(KCookie.Get("Custom_Index"))  or checkInt(CfUtils.GetLocalData("Custom_Index" , 1)) 
    KCookie.Set("Custom_Index" , self.selectIndex)
    local customTrainDojo = CustomTrainComponent:GetDojo()
    self.endTime = customTrainDojo:GetEndTime()
    self.data = {}
    local customTrainDojo = CustomTrainComponent:GetDojo()
    self.questVos = CustomTrainComponent:GetCustomTrainQuestVosByGroupId(customTrainDojo.schedule.groupId) 
end


function CustomTrainMainDialog:__delete()
    self.selectIndex = nil
    self.questVo = nil
    self.endTime = nil
    self.data = nil
    self.CustomTrainMainDialog_Stats = nil
    self.questVos = nil
end


function CustomTrainMainDialog:Awake()

end


function CustomTrainMainDialog:OnInitialize()
    self.CustomTrainMainDialog_Stats = {
        self.CustomTrainMainDialog_State_1, 
        self.CustomTrainMainDialog_State_2, 
        self.CustomTrainMainDialog_State_3, 
    }
    
    SetButtonAction(self.TeamFontStyleButton, Bind(self, self.OnBtnFightHandler))
    SetButtonAction(self.BtnCheck.gameObject,Bind(self,self.OnBtnCheckClick))
    SetButtonAction(self.BtnReward.gameObject,Bind(self,self.UIRankRewardDialog))
    SetButtonAction(self.DrawRewardBtn.gameObject,Bind(self,self.DrawRewardClick))
   self:RefreshUI()
   self:AddTimer()
end
function CustomTrainMainDialog:AddTimer()
    local serverTime = GameUtils.GetServerTime()
    ---@type CustomTrainDojo
    local dojo = CustomTrainComponent:GetDojo()
    local endDayTimestamp = dojo:GetStatusLeftSeconds()
    local leftTime = endDayTimestamp - serverTime
    if leftTime > 86400  then
        CfUtils.FillText(self.LeftTxtTime.gameObject, CfUtils.GetTimeHMS(leftTime))
    elseif leftTime > 0 then
        if isNotNull(self.leftTimer) then
            CDTimerModule.GetInstance():RemoveCD(self.leftTimer)
            self.leftTimer = nil
        end
        self.leftTimer = CDTimerModule:GetInstance():AddCD(1, function(count, id)
                if leftTime <= 0 then
                    -- 结束
                    CDTimerModule.GetInstance():RemoveCD(self.leftTimer)
                    CfUtils.SetActive(self.LeftTxtTime.gameObject, false)
                else
                    CfUtils.FillText(self.LeftTxtTime.gameObject, CfUtils.GetTimeHMS2(leftTime))
                end
        end,  leftTime + 10000, false, true, true)
    end
end

function CustomTrainMainDialog:DrawRewardClick()
    local customTrainDojo = CustomTrainComponent:GetDojo()
    if checkInt(customTrainDojo.hasDrawnDamageRewards) == 1  then
        GameUtils.Toast(localize("奖励已领取"))
        return
    end
    local damages = customTrainDojo.damages or {}
    local questVos = self.questVos
    local areaId = self.questVos[self.selectIndex].areaId
    if checkInt(damages[tostring(areaId)]) == 0 then
        GameUtils.Toast(localize("暂无挑战_name_", {_name_ = questVos[self.selectIndex].name}))
        return
    end
    GameUtils.SecondConfirm(localize( "即将以调查官在选中的区域<color=#e71f55>_name_</color>中记录的<color=#e71f55>_text_</color>" , {_name_ = questVos[self.selectIndex].name , _text_ = localize("最高伤害领取奖励")}), function()
        GameUtils.Request(Interfaces.CustomizedTrainingDrawDamageRewards , {areaId = areaId},function(request, response) 
            if checkNumber(response.errCode) ~= 0 then return end
            local data = response.data
            GoodsUtils.DrawRewards(data.rewards)
            -- 领取奖励打脸界面 被关闭后, 会执行的内容:
            CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop, {rewards = data.rewards, cb = function()
                CfUtils.SetButtonStyle(self.DrawRewardBtn , "B18" ,localize("已领取"))
            end})
            customTrainDojo:SethasDrawnDamageRewards(1)
        end)
    end, nil, localize("领取完成后在奖励重置前无法再领取其他区域的奖励"), 1)
end

function CustomTrainMainDialog:UIRankRewardDialog()
    local customTrainDojo = CustomTrainComponent:GetDojo()
    local damages = customTrainDojo.damages or {}
    local groupId =  customTrainDojo.schedule.groupId
    local questVos =  CustomTrainComponent:GetCustomTrainQuestVosByGroupId(groupId)
    local areaId = questVos[self.selectIndex].areaId
    local rewardGroup = questVos[self.selectIndex].rewardGroup
    UIModule.OpenDialog({ id = Constants.UITypeIds.CustomTrainrewardPreviewPopup, parameters = {areaId = areaId , rewardGroup = rewardGroup} })
end

function CustomTrainMainDialog:OnBtnCheckClick()
    local customTrainDojo = CustomTrainComponent:GetDojo()
    local damages = customTrainDojo.damages or {}
    local groupId =  customTrainDojo.schedule.groupId
    local questVos =  CustomTrainComponent:GetCustomTrainQuestVosByGroupId(groupId)
    local areaId = questVos[self.selectIndex].areaId
    local rewardGroup = questVos[self.selectIndex].rewardGroup
    local rewards = CustomTrainComponent:GetRewardsByRewardGroupArea(rewardGroup,areaId)
    local questVo = questVos[self.selectIndex]
    ---@type CustomTrainScheduleVo
    local vo8948 = CfUtils.GetCfVo(AutoIds.IdSetting8948 , "CustomTrainScheduleVo",customTrainDojo.schedule.id)
    ---@type CustomTrainLineUpVo
    local CustomTrainLineUpVo = CustomTrainComponent:GetCustomTrainLineUpByQuestId(questVo.id)
    local wave1NpcIds = CustomTrainLineUpVo.wave1NpcId 
    local wave1NpcTypes = CustomTrainLineUpVo.wave1NpcType 
    local index = 1
    for k, v in pairs(wave1NpcTypes) do
        if checkInt(v) == 3 then
            index = k 
            break
        end
    end
    local scheduleVo = {
       bossId =  wave1NpcIds[index],
       entranceImage = vo8948.modelId
    } 
	CfUtils.DialogOpen(Constants.UITypeIds.CommonBossDetailsDialog, {lineUpInfo = {CustomTrainLineUpVo} ,  planVo = scheduleVo, questVo = questVo }, { { id = Constants.UITypeIds.CustomTrainMainDialog } })
end

function CustomTrainMainDialog:OnBtnFightHandler()
    if checkInt(CustomTrainComponent:GetDojo().hasDrawnDamageRewards) == 1  then
        GameUtils.Toast(localize("奖励已领取,不能再挑战"))
        return
    end
    ---@type PlayerComponent
    local playerComp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.PlayerComponent)
    local curDate = playerComp:GetPlayerDojo():GetServerTimeWithTimeZone()
    local endTime = checkNumber(self.endTime)
    local leftTime = endTime - curDate
    if leftTime <= 0 then
        return GameUtils.Toast(localize("活动已经结束"))
    end
    local questVo = self.questVos[self.selectIndex]
    CfUtils.DialogOpen(Constants.UITypeIds.UIFightTeamChoose, { activityUuid = -1 ,
                                                                levelId = questVo.id  , upBuffData = self:GetUpBuffData(),upGroup = self.data.upGroup }, { { id = Constants.UITypeIds.CustomTrainMainDialog } })
    CfUtils.WriteLocalData("Custom_Index" , self.selectIndex)
    KCookie.Set("Custom_Index" , self.selectIndex)
end
function CustomTrainMainDialog:GetUpBuffData()
    local data = {}
    ---@type CardComponent
    local cardComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardComponent)
    for i, v in ipairs(self.data.upGroup) do
        local hasCard = cardComp:IsHasCard(v.refId)
        local tempData = {}
        tempData.refId = v.refId
        tempData.type = v.type
        local index = 1    
		if hasCard then
			local cardDojo = cardComp:GetCardByConfId(v.refId)
			local star = cardDojo.star
			index = star + 1
		
		end
        tempData.commonAddId = v.additions[index].commonAddId
        table.insert(data,tempData)
    end
    return data
end

function CustomTrainMainDialog:RefreshUI()
    
    self:UpdateLeftPanel()
    self:UpdateRightPanel()
    self:GetUpGrounp()
    ---@type ActivityMgr
    local ActivityMgr = import('Game.Activity.ActivityMgr')
    CfUtils.FillText(self.RuleTxtDesc , ActivityMgr.GetActivityRule("12003602") )
end
function CustomTrainMainDialog:UpdateRightPanel()
   self:UpdateBossDetail() 
end

function CustomTrainMainDialog:UpdateLeftPanel()
   self:UpdateQuetsNodes()
   self:UpdateRewardsNode()
   
end

function CustomTrainMainDialog:UpdateQuetsNodes()
    local customTrainDojo = CustomTrainComponent:GetDojo()
    local groupId =  customTrainDojo.schedule.groupId
    ---@type CustomTrainQuestVo[]
    local questVos =  self.questVos
    for i =1 ,#self.CustomTrainMainDialog_Stats do
        local oneCustomTrainMainDialog_Stats = self.CustomTrainMainDialog_Stats[i]
        ---@type CustomTrainNode
        local CustomTrainNode = CfUtils.GetLuaScr(oneCustomTrainMainDialog_Stats ,"Game.Activity.CustomTrain.CustomTrainNode")
        local questVo = questVos[i]
        CustomTrainNode:RefreshUI(questVo.name,questVo.proposalLevelInterval , function (index)
            -- 关卡id 
            local questId  = questVo.id
            self.selectIndex = index
            self:UpdateLeftPanel()
            self:UpdateRightPanel()
        end , i)
        CustomTrainNode:SetSelect(self.selectIndex == i)
    end
end
--- func desc 更新奖励的node 
function CustomTrainMainDialog:UpdateRewardsNode()
    local customTrainDojo = CustomTrainComponent:GetDojo()
    local damages = customTrainDojo.damages
    local questVos =  self.questVos
    local areaId = questVos[self.selectIndex].areaId
    local rewardGroup = questVos[self.selectIndex].rewardGroup
    local rewards = CustomTrainComponent:GetRewardsByRewardGroupArea(rewardGroup ,areaId)
    local questVo = questVos[self.selectIndex]
    local KTool =  CS.Engine.Lib.KTool
    KTool.SetActive(self.RestTxtTime.gameObject, false)
    if checkInt(customTrainDojo.hasDrawnDamageRewards) == 1  then
        CfUtils.SetButtonStyle(self.DrawRewardBtn , "B18" ,localize("已领取"))
    end
    
    if rewards then
        CfUtils.SetActive(self.Empty.gameObject ,false)
        CfUtils.SetActive(self.Button.gameObject ,true)
        CfUtils.SetActive(self.MaxBattleTxtDesc_1 , true)
        CfUtils.SetActive(self.MaxBattleTxtDesc_2 , true)
        CfUtils.FillText(self.MaxBattleTxtDesc_2, checkInt(damages[tostring(areaId)]))
        if customTrainDojo.hasDrawnDamageRewards then
            -- CfUtils.SetActive(self.Button.gameObject ,true)
            CfUtils.SetActive(self.Empty.gameObject ,false)
        end 
        if #rewards > 0 then
            CfUtils.SetActive(self.CommonGoodsListLight.gameObject ,true)
            CfUtils.RefreshCommonGoodsListLight(self.CommonGoodsListLight , rewards)
        end
    else 
        CfUtils.SetActive(self.MaxBattleTxtDesc_1 , false)
        CfUtils.SetActive(self.MaxBattleTxtDesc_2 , false)
        CfUtils.SetActive(self.CommonGoodsListLight.gameObject ,false)
        -- CfUtils.SetActive(self.Button.gameObject ,false)
        CfUtils.SetActive(self.Empty.gameObject ,true)
    end
end


function CustomTrainMainDialog:UpdateBossDetail()
    local questVos =  self.questVos
    local areaId = questVos[self.selectIndex].areaId
    local rewardGroup = questVos[self.selectIndex].rewardGroup
    local rewards = CustomTrainComponent:GetRewardsByRewardGroupArea(rewardGroup ,areaId)
    local questVo = questVos[self.selectIndex]
    ---@type CustomTrainLineUpVo
    local CustomTrainLineUpVo = CustomTrainComponent:GetCustomTrainLineUpByQuestId(questVo.id)
    local wave1NpcIds = CustomTrainLineUpVo.wave1NpcId
    local wave1NpcTypes = CustomTrainLineUpVo.wave1NpcType
    local index = 1
    for k, v in pairs(wave1NpcTypes) do
        if checkInt(v) == 3 then
            index = k 
            break
        end
    end

    local MonsterTypeVo = CardConfMgr:GetInstance():GetMonsterTypeVoById(wave1NpcIds[index])
    local skinVo = CardConfMgr:GetInstance():GetCardSkinBySkinId(MonsterTypeVo.skinId)
    CfUtils.FillText(self.BossNameText, skinVo.name)
    CfUtils.FillImage(self.ImgBossIcon, skinVo.hdCardDrawing)
end

function CustomTrainMainDialog:GetUpGrounp()
    local schedule = CustomTrainComponent:GetDojo().schedule
    local groupValue = checkInt(schedule.upGroup)   -- Get the group field from IdSetting8948
    
    -- Step 2: Query IdSetting8947 to find all data with matching group field
    ---@type CustomTrainUpGroupVo
    local voList8947 = CfUtils.GetWholeVo(AutoIds.IdSetting8947,"CustomTrainUpGroupVo")
    local result = {}
    if voList8947 then
        for _, vo in ipairs(voList8947) do
            if vo.group == groupValue then
                table.insert(result, vo)
            end
        end
    end
    -- Transform result to the required structure
    local transformedResult = {
        upGroup = {}
    }
    for _, vo in ipairs(result) do
        local upGroupItem = {
            type = vo.upType,
            refId = vo.upParam,
            additions = vo.additions,
        }
        table.insert(transformedResult.upGroup, upGroupItem)
    end
    self.data.upGroup = transformedResult.upGroup
    UICommonUtils.RefreshCommonUpGroup(self.CommRoleBonusLayoutGroup,transformedResult.upGroup, false,{{id = Constants.UITypeIds.CustomTrainMainDialog}})
end

function CustomTrainMainDialog:OnFinalize()
    return CoWaitDo(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        if isNotNull(self.leftTimer) then
            CDTimerModule.GetInstance():RemoveCD(self.leftTimer)
            self.leftTimer = nil
        end
        self:Delete()
    end)
end


return CustomTrainMainDialog