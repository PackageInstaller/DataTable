---@type OverseaClubCatCarMgr
local Mgr = import("Game.UI.Club.CatCar.OverseaClubCatCarMgr"):GetInstance()

local UIRaycastBlocker = CS.Engine.UI.UIRaycastBlocker.Instance

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubCatCarRollDiceDialog.prefab > name: OverseaClubCatCarRollDiceDialog
---@class OverseaClubCatCarRollDiceDialog
---@field Env                           	OverseaClubCatCarRollDiceDialog         
---@field controller                    	Engine.UI.UILuaDialog                   
---@field Root                          	UnityEngine.RectTransform               	@ 0    
---@field ImgRole                       	UnityEngine.RectTransform               	@ 1    
---@field BubbleNode                    	UnityEngine.RectTransform               	@ 2    
---@field BubbleAnim                    	UnityEngine.RectTransform               	@ 3    
---@field TxtBubble                     	UnityEngine.RectTransform               	@ 4    
---@field BtnReset                      	UnityEngine.RectTransform               	@ 5    
---@field TextNumber                    	UnityEngine.RectTransform               	@ 6    
---@field CommonBtnConsumePopVariant    	UnityEngine.RectTransform               	@ 7    
---@field DiceGroup                     	UnityEngine.RectTransform               	@ 8    
---@field ImgPoint1                     	UnityEngine.RectTransform               	@ 9    
---@field ImgPoint2                     	UnityEngine.RectTransform               	@ 10   
---@field ImgPoint3                     	UnityEngine.RectTransform               	@ 11   
---@field TotalPoints                   	UnityEngine.RectTransform               	@ 12   
---@field NumberGroup                   	UnityEngine.RectTransform               	@ 13   
---@field BtnSubmit                     	UnityEngine.RectTransform               	@ 14   
local OverseaClubCatCarRollDiceDialog = Class("OverseaClubCatCarRollDiceDialog")

---@class OverseaClubCatCarRollDiceDialog.InputData

function OverseaClubCatCarRollDiceDialog:__init()
    self.controller = nil
end

function OverseaClubCatCarRollDiceDialog:__delete()
    self.controller = nil
end

function OverseaClubCatCarRollDiceDialog:Awake()
    SetButtonAction(self.BtnReset,Bind(self,self.OnResetClick))
    SetButtonAction(self.BtnSubmit,Bind(self,self.OnSubmitClick))
end

function OverseaClubCatCarRollDiceDialog:OnInitialize()
    return CoWaitDo(function()
        local inited = false
        local initParams = self.controller.Argument.parameters or {}
        self.closeCallback = initParams.closeCallback

        local playerDiceNumber = Mgr.Server.dojo.catCarInfo.playerDiceNumber
        if playerDiceNumber == nil or table.count(playerDiceNumber) == 0 then
            Mgr.Server:ReqCallDice(function()
                inited = true
                self:RefreshUI(true)
            end,function() 
                inited = true
            end)
        else
            inited = true
            self:RefreshUI()
        end
        
        while not inited do
            coroutine.yield()
        end
    end)
end

function OverseaClubCatCarRollDiceDialog:RefreshUI(roll)
    local carInfo = Mgr.Server.dojo.catCarInfo
    if roll then
        local length = CfUtils.GetAnimationTime(self.Root, "OverseaClubCatCarRollDiceDialog_Entry")
        CoStart(function()
            UIRaycastBlocker:AddCondition("OverseaClubCatCarRollDiceDialog_Anim")
            CoYield(length)
            UIRaycastBlocker:RemoveCondition("OverseaClubCatCarRollDiceDialog_Anim")
        end)
        CfUtils.PlayAnimation(self.Root, "OverseaClubCatCarRollDiceDialog_Entry")    
    end
    
    --CfUtils.FillText(self.TextNumber,table.concat({checkNumber(carInfo.playerDiceTimesLeft),"/",self:GetFreeResetDiceLimit()}))
    ---@type CommonBtnConsumePop
    local consumePop = CfUtils.GetLuaScr(self.CommonBtnConsumePopVariant, Constants.UILuaTablePath.BtnConsumePop)
    consumePop:RefreshUI(ClubUtils.GetParamValue(ClubUtils.ParamsId.Dice_Reset_Pay_GID), ClubUtils.GetParamValue(ClubUtils.ParamsId.Dice_Reset_Pay_Num))
    CfUtils.SetActive(self.CommonBtnConsumePopVariant,checkNumber(carInfo.freeResetDiceTimes) == 0)

    local remainTimeDesc = self.BtnReset:Find("RemainTimes/TextDesc")
    if carInfo.freeResetDiceTimes > 0 then
        CfUtils.FillText(remainTimeDesc,localize("免费重置次数"))
        CfUtils.FillText(self.TextNumber,table.concat({checkNumber(carInfo.freeResetDiceTimes),"/",checkNumber(carInfo.freeDiceTimes)}))
    else
        CfUtils.FillText(remainTimeDesc,localize("额外重置次数"))
        CfUtils.FillText(self.TextNumber,table.concat({checkNumber(carInfo.playerDiceTimesLeft),"/",self:GetFreeResetDiceLimit()}))
    end
    
    CfUtils.SetUISwitchImage(self.ImgPoint1, carInfo.playerDiceNumber[1])
    CfUtils.SetUISwitchImage(self.ImgPoint2, carInfo.playerDiceNumber[2])
    CfUtils.SetUISwitchImage(self.ImgPoint3, carInfo.playerDiceNumber[3])
    
    local totalPoints = checkNumber(carInfo.playerDiceNumber[1]) + checkNumber(carInfo.playerDiceNumber[2]) + checkNumber(carInfo.playerDiceNumber[3])
    CfUtils.FillText(self.TxtBubble,self:GetTextBubbleContent(totalPoints))
    CfUtils.PlayAnimation(self.TotalPoints, self:GetTotalPointsAnimName(totalPoints))
    CfUtils.SetUISwitchImage(self.ImgRole, self:GetDiceResultLevel(totalPoints))
    for i = 1, 3 do
        local txtNumber = self.NumberGroup:Find("TextNumber"..i)
        CfUtils.FillText(txtNumber, totalPoints)
    end
    
    --特权卡特殊处理
    self.CommonPrivilegeCardNode = self.BtnReset:Find("CommonPrivilegeCardNode")
    local vo = CfUtils.GetCfVo(AutoIds.IdSetting4032, "WelfareSettingVo", 1)
    local num = GameUtils.GetPrivilegeCardAddNumByName(tonumber(vo.giftId), "catBus")
    if checkNumber(num)== 0 then
        CfUtils.SetActive(self.CommonPrivilegeCardNode,false)
    else
        CfUtils.SetActive(self.CommonPrivilegeCardNode,true)
    end
end

---@private
function OverseaClubCatCarRollDiceDialog:GetTotalPointsAnimName(totalPoints)
    if totalPoints < 6 then
        return "OverseaClubCatCarRollDiceDialog_TotalPoints_Little"
    elseif totalPoints < 12 then
        return "OverseaClubCatCarRollDiceDialog_TotalPoints_Middle"
    else
        return "OverseaClubCatCarRollDiceDialog_TotalPoints_Great"
    end
end

function OverseaClubCatCarRollDiceDialog:GetTextBubbleContent(totalPoints)
    if totalPoints < 6 then
        return localize("或许还能挽救一下...")
    elseif totalPoints < 12 then
        return localize("不好不坏，要再试试看吗？")
    else
        return localize("哇！调查官运气真不错。")
    end
end

function OverseaClubCatCarRollDiceDialog:GetDiceResultLevel(totalPoints)
    if totalPoints < 6 then
        return 1
    elseif totalPoints < 12 then
        return 2
    else
        return 3
    end
end

function OverseaClubCatCarRollDiceDialog:GetFreeResetDiceLimit()
    return Mgr.Server.dojo.catCarInfo.totalDiceTimes
end

function OverseaClubCatCarRollDiceDialog:OnResetClick()
    local hasFreeTime = Mgr.Server.dojo.catCarInfo.freeResetDiceTimes > 0
    local goodsId = ClubUtils.GetParamValue(ClubUtils.ParamsId.Dice_Reset_Pay_GID)
    local goodsNum = ClubUtils.GetParamValue(ClubUtils.ParamsId.Dice_Reset_Pay_Num)
    local resetFunc = function()
        Mgr.Server:ReqCallDice(function()
            if Mgr.Server.dojo.catCarInfo.freeResetDiceTimes <= 0 then
                GoodsUtils.DrawRewards({ { goodsId = goodsId, num = - goodsNum } }, true)
            end
            Mgr.Server.dojo.catCarInfo.freeResetDiceTimes = checkNumber(Mgr.Server.dojo.catCarInfo.freeResetDiceTimes) - 1
            self:RefreshUI(true)
        end)
    end
    
    if hasFreeTime then
        resetFunc()
    else
        local leftTime = Mgr.Server.dojo.catCarInfo.playerDiceTimesLeft
        if leftTime <= 0 then
            GameUtils.Toast(localize("骰子重置次数不足"))
            return
        end
       
        local itemEnough = GoodsUtils.GetThingNo(goodsId) >= goodsNum
        if not itemEnough then
            local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(goodsId)
            if goodsVo then
                GameUtils.Toast(localize("_name_不足",{_name_ = goodsVo.name}))
            end
            return
        end
        resetFunc()
    end
end

function OverseaClubCatCarRollDiceDialog:OnSubmitClick()
    Mgr.Server:ReqSubmitDice(function()
       self.controller:Close()
    end)
end

function OverseaClubCatCarRollDiceDialog:OnFinalize()
    if self.closeCallback then
        self.closeCallback()
    end
    self:Delete()
end

return OverseaClubCatCarRollDiceDialog