---
--- Created by Eric.
--- DateTime: 2022/11/21 16:44
---

------------ import ------------
local util = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
local cs_coroutine = require 'XLua.cs_coroutine'
local ResourceModule = CS.Engine.Modules.ResourceModule
local Animator = CS.UnityEngine.Animator
local GameObject          = CS.UnityEngine.GameObject

------------ import ------------

------------ define ------------
local TLPlayTimeStamp = "SpringFestivalClothesDialogTLPlay"
local OpenType --定义在对应comp中
--= {
--    Resident = 1,--常驻
--    Activity = 2,--活动
--}
------------ define ------------



--- from: Assets/BundleResources/Prefabs/SpringFestival121401/SpringFestivalClothesDialog.prefab
---@class SpringFestivalClothesDialog
---@field Env                           	SpringFestivalClothesDialog
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field ImgIcon2                      	UnityEngine.RectTransform
---@field TxtPriceNumber                	UnityEngine.RectTransform
---@field ImgBuyBg2                     	UnityEngine.RectTransform
---@field ImgBuyBg                      	UnityEngine.RectTransform
---@field BtnBuy                        	UnityEngine.RectTransform
---@field TxtExplain                    	UnityEngine.RectTransform
---@field TxtReceive                    	UnityEngine.RectTransform
---@field GoodNode                      	UnityEngine.RectTransform
---@field ImgIconGet                    	UnityEngine.RectTransform
---@field ImgBgGet                      	UnityEngine.RectTransform
---@field TxtTimeContent                	UnityEngine.RectTransform
local SpringFestivalClothesDialog = Class("SpringFestivalClothesDialog")
function SpringFestivalClothesDialog:__init()
    self.data = {}
    self.scheduleData = {}
    self.storeData = {}
    self.displayIdList = {}
    self.ownCount = 0
    
end

function SpringFestivalClothesDialog:__delete()
    self.scheduleData = nil
    self.data = nil
    self.storeData = nil
    self.displayIdList = nil
    self.ownCount = nil

    self.controller = nil
end

function SpringFestivalClothesDialog:Awake()


end

function SpringFestivalClothesDialog:OnFocus(focus)
    printInfo("--->> focus", focus)
end

function SpringFestivalClothesDialog:OnInitialize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        
        
    end))
    return coWait
end

function SpringFestivalClothesDialog:OnShow()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        GameUtils.Request(
                Interfaces.ActivityRoleMuftiHome,
                {},
                function(request, response)
                    if checkInt(response.errCode) == 0 then
                        self.data = response.data
                        print("data---->>"..table.dump(self.data, nil, 3))
                        self:LoadScene()
                        self:FreshBaseUI()
                    end
                end
        )
        
        

        


        --CfUtils.WriteLocalData("SpringFestivalClothesDialog", curDateStr)
        --
        --
        --local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.RoleClothesComponent)
        --
        --self:InitData()
    end))
    return coWait
end

function SpringFestivalClothesDialog:InitData()
    self.ownCount = 0
    self.scheduleData = CfUtils.GetCfVo(AutoIds.IdSetting2848, "RoleClothesScheduleVo", self.data.activityConf.id)
    local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.RoleClothesComponent)
    local storeIds = comp:GetClothesStoreIdsByActivityId(self.scheduleData.id)
    for k, v in pairs(storeIds) do
        local vo = CfUtils.GetCfVo(AutoIds.IdSetting2849, "RoleClothesStoreVo", v)
        self.storeData[tostring(v)] = vo
        local displayId = comp:GetClothesDisplayIdByGoodsId(vo.goodsId)
        local isUnlock = comp:IsUnlockClothByGoodsId(vo.goodsId)
        if isUnlock then
            self.ownCount = self.ownCount + 1
        end
        table.insert(self.displayIdList, displayId)
    end
    
    

    --["startTime"] = -427457,
    --["endTime"] = 2510142,
    --["closeTime"] = 2855742,
    --["finalRewardStatus"] = 0,
    --["activityContentId"] = 0,
    

end

function SpringFestivalClothesDialog:FreshBaseUI()
    local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.RoleClothesComponent)

    --region 时间
    local curTime = os.time()
    local startTime =  self.data.startTime + curTime
    local closeTime =  self.data.closeTime + curTime
    CfUtils.FillText(self.TxtTimeContent, os.date("%Y.%m.%d", startTime).."-"..os.date("%Y.%m.%d  %H:%M", closeTime))
    --endregion
    local hasGet = self.data.finalRewardStatus == Constants.GetStatus.Has
    local canGet = self.data.finalRewardStatus == Constants.GetStatus.Can
    --local notGet = self.data.finalRewardStatus == Constants.GetStatus.Not
    local isBuyAll = self.ownCount >= table.count(self.storeData)
    KTool.SetActive(self.ImgBgGet, hasGet)
    KTool.SetActive(self.ImgIconGet, hasGet)
    KTool.SetActive(self.TxtReceive, canGet)
    KTool.SetActive(self.ImgBuyBg, not isBuyAll)
    KTool.SetActive(self.ImgBuyBg2, isBuyAll)
    KTool.SetActive(self.TxtPriceNumber, not isBuyAll)
    CfUtils.FillText(self.TxtPriceNumber, self.scheduleData.goodsConsumNum)
    local goodsVo       = GoodsConfMgr:GetInstance():GetGoodsVoById(self.scheduleData.goodsConsum)
    CfUtils.FillImage(self.ImgIcon2, goodsVo.photoPath)
    CfUtils.RefreshTopGoods({
        goodsVo.id,
    })
    CfUtils.FillText(self.TxtExplain, localize("购买全部常服（_num1_/_num2_），附赠",{_num1_ = self.ownCount, _num2_ = table.count(self.storeData) }))

    local nodeEnv = CfUtils.GetLuaScr(self.GoodNode.gameObject, "Game.Behaviours.GoodNodeMB")
    if nodeEnv then
        local data = {
            goodsId = self.scheduleData.rewardId,
            num = self.scheduleData.rewardNum,
        }
        nodeEnv:SetClickButtonAction(function()
            local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(data.goodsId)
            if isTable(vo) then
                GameUtils.ShowCommonTipsBoard(self.GoodNode, vo.name, vo.desc, vo.quality, vo.id)
            end
        end)
        nodeEnv:Reload(
                {
                    goodsId = data.goodsId,
                    isShowNo = false, --text = 'x' .. tostring(data.num)
                }
        )
    end
    
    SetButtonAction(self.BtnBuy, function()
        if not isBuyAll then
            comp:OpenRoleClothesDialogByDisplayIdList(self.displayIdList, {
                {id = Constants.UITypeIds.MapDecryptionClothesDialog}
            })
        end
    end)
    SetButtonAction(self.BtnReward, function()
        if canGet then
            GameUtils.Request(
                    Interfaces.ActivityRoleMuftiRewardReceive,
                    {},
                    function(request, response)
                        if checkInt(response.errCode) == 0 then
                            self.data.finalRewardStatus = Constants.GetStatus.Has
                            GoodsUtils.DrawRewards(response.data.rewards)
                            UIModule.OpenDialog(
                                    {
                                        id = Constants.UITypeIds.UICommonRewardPop,
                                        parameters = { rewards = response.data.rewards, cb = function()

                                        end }
                                    }
                            )
                            self:FreshBaseUI()
                        end
                    end
            )
        end
    end)
end

function SpringFestivalClothesDialog:LoadScene()
    local tlPlayTimeStamp = CfUtils.GetLocalData(TLPlayTimeStamp, '1')
    local preDateStr = os.date('%Y-%m-%d', tlPlayTimeStamp)
    local nowDateStr = os.date('%Y-%m-%d', os.time())
    local isPlayEntranceTimeLine = preDateStr ~= nowDateStr
    local rawImage = self.controller.transform:Find("Root")
    if not isNull(rawImage) then
        ---@type CriWare.CriManaMovieControllerForUI
        local controllerForUI = KTool.GetOrAddComponent(rawImage.gameObject, typeof(CS.CriWare.CriManaMovieControllerForUI))
        if not isNull(controllerForUI) then
            if isPlayEntranceTimeLine then
                CfUtils.WriteLocalData(TLPlayTimeStamp,  tostring(os.time()))
                controllerForUI.player:SetFile(nil, GameUtils.GetManaPath(self.scheduleData.timeline1))
                controllerForUI:Play()
                MapDecryptionUtils.SetBgmPlayStatus(false)
                controllerForUI.player.statusChangeCallback = function(status)
                    if status == CS.CriWare.CriMana.Player.Status.PlayEnd then
                        controllerForUI:Stop()
                        MapDecryptionUtils.SetBgmPlayStatus(true)
                        controllerForUI.player.statusChangeCallback = nil
                        controllerForUI.player:SetFile(nil, GameUtils.GetManaPath(self.scheduleData.timeline2))
                        controllerForUI:Play()
                        controllerForUI.player:Loop(true)
                    end
                end
            else
                controllerForUI.player:SetFile(nil, GameUtils.GetManaPath(self.scheduleData.activityConf.timeline2))
                controllerForUI:Play()
                controllerForUI.player:Loop(true)
            end
        end
    end
end

function SpringFestivalClothesDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end

return SpringFestivalClothesDialog