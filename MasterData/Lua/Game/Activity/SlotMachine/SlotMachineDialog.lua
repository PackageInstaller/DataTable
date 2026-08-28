local ActivityUtils = import("Game.Activity.ActivityUtils")
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
local RectTransform = CS.UnityEngine.RectTransform
local CanvasGroup = CS.UnityEngine.CanvasGroup
local DOTween = CS.DG.Tweening.DOTween

--- from: Assets/BundleResources/Prefabs/Activity/ActivityScratchDialog120030.prefab > name: ActivityScratchDialog120030
---@class SlotMachineDialog
---@field Env                            SlotMachineDialog
---@field controller                        Engine.Modules.LuaBehaviour
---@field RoleNode                        UnityEngine.RectTransform                @ 0
---@field UIFX_bgGlow                    UnityEngine.RectTransform                @ 1
---@field Container                        UnityEngine.RectTransform                @ 2
---@field ImgTitleName                    UnityEngine.RectTransform                @ 3
---@field TxtTime                        UnityEngine.RectTransform                @ 4
---@field BtnExplain                        UnityEngine.RectTransform                @ 5
---@field RewardItem                        UnityEngine.RectTransform                @ 6
---@field GoodImageIcon                    UnityEngine.RectTransform                @ 7
---@field RewardTxtTime                    UnityEngine.RectTransform                @ 8
---@field BtnNotice                        UnityEngine.RectTransform                @ 9
---@field Btn                            UnityEngine.RectTransform                @ 10
---@field Content                        UnityEngine.RectTransform                @ 11
---@field TimesNode                        UnityEngine.RectTransform                @ 12
---@field ButtonOpen                        UnityEngine.RectTransform                @ 13
---@field ButtonClose                    UnityEngine.RectTransform                @ 14
local SlotMachineDialog = Class('SlotMachineDialog')

function SlotMachineDialog:__init()
    self.data = nil
end

function SlotMachineDialog:__delete()
    self.data = nil
    self.textTrans = nil
    ---@type UnityEngine.RectTransform
    self.textRectTrans = nil
end

function SlotMachineDialog:Awake()
    self:SetActiveSelf(false)
    self.textTrans = self.BtnNotice.transform:Find("Mask/Text1")
    if self.textTrans then
        self.textRectTrans = KTool.GetComponent(self.textTrans.gameObject, typeof(RectTransform))
    end
    SetButtonAction(self.BtnExplain, function()
        if self.data then
            if checkNumber(self.data.ruleId) > 0 then
                CfUtils.ShowModuleToast(self.data.ruleId)
            end
        end
    end)
    SetButtonAction(self.BtnNotice, function()
        if self.data then
            UIModule.OpenDialog({ id = Constants.UITypeIds.ActivityFashionPreheatingHistory, parameters = { preview = self.data.grandRewardList } })
        end
    end)
    SetButtonAction(self.Btn, function()
        if self.data then
            UIModule.OpenDialog({ id = Constants.UITypeIds.ActivityFashionPreheatingRule, parameters = { ruleId = self.data.ruleId, preview = checkTable(self.data.preview) } })
        end
    end)
    SetButtonAction(self.ButtonClose, function()
        GameUtils.Toast(localize('今日剩余次数不足'))
    end)
    SetButtonAction(self.ButtonOpen, function()
        if self.data then
            if checkNumber(self.data.todayLeftLotteryTimes) > 0 then
                local consume = table.takeFirst(self.data.consume)
                local consumeNum = checkNumber(consume.num)
                local haveNo = GoodsUtils.GetThingNo(consume.goodsId)
                if haveNo < consumeNum then
                    --不足的情况
                    GoodsUtils.CheckCurrencyConsume({goodsId = consume.goodsId, num = consumeNum}, function()
                        -- 请求兑换的逻辑
                        --self:FreshUI()
                    end)
                else
                    GameUtils.Request("activity2/slotMachineLottery", { activityUuid = self.activityDojo.id }, function(request, response)
                        if checkNumber(response.errCode) == 0 then
                            ---请求成功
                            self.data.todayLeftLotteryTimes = math.max(checkNumber(self.data.todayLeftLotteryTimes), 0)
                            local rewards = clone(response.data.rewards)
                            table.insert(rewards, {
                                goodsId = consume.goodsId,
                                num = -consumeNum
                            })
                            GoodsUtils.DrawRewards(rewards, true)
                            local rewardClone = clone(response.data.rewards)
                            UIModule.OpenDialog(UIArgs(Constants.UITypeIds.SlotMachinePopUp, {
                                rewards = rewardClone,
                                data = clone(self.data),
                                cb = function()
                                    UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonRewardPop, parameters = { rewards = rewardClone, cb = function()
                                        ---回调后播放动画过程
                                        CfUtils.StartCoroutineWithBlocker(function()
                                            xTry(function()
                                                --刷新group值
                                                self:FreshGroupInfo(false, rewardClone)
                                                CoYield(0.2)
                                                CfUtils.PlayAnimation(self.Btn.transform.parent, "ActivityScratchDialog_RightPanel_Change")
                                                CoYield(0.28)
                                                ---再还原值
                                                self:FreshGroupInfo(true, nil)
                                                CoYield(0.2)
                                            end)
                                        end)
                                    end } })
                                end
                            }))
                            ---重请求一次数据
                            self:StartRequest()
                        end
                    end)
                end
            end
        end
    end)
end

function SlotMachineDialog:RefreshCurrencyBarInfo()
    if self.data then
        local consume = table.takeFirst(self.data.consume)
        ActivityUtils.RefreshNavigatorGoods({consume.goodsId})
    end
end

function SlotMachineDialog:FreshGroupInfo(isBlank, rewards)
    isBlank = checkBool(isBlank)
    for i = 1, 3 do
        local groupKey = "Group" .. i
        local groupTrans = self.Content.transform:Find(groupKey)
        if groupTrans then
            if isBlank then
                CfUtils.SetActive(groupTrans:Find("ImgRed"), false)
                CfUtils.SetActive(groupTrans:Find("MaskIcon"), false)
                CfUtils.SetActive(groupTrans:Find("ImgNone"), true)
                CfUtils.FillText(groupTrans:Find("TxtNumber"), "")
            else
                local reward = rewards[i]
                CfUtils.SetActive(groupTrans:Find("ImgRed"), checkNumber(reward.isGrand) == 1)
                CfUtils.SetActive(groupTrans:Find("ImgNone"), false)
                CfUtils.SetActive(groupTrans:Find("MaskIcon"), true)
                CfUtils.FillText(groupTrans:Find("TxtNumber"), string.format("x%d", checkNumber(reward.num)))
                CfUtils.FillImage(groupTrans:Find("MaskIcon/ImgGoods"), GoodsUtils.GetGoodsIconById(reward.goodsId))
            end
        end
    end
end

function SlotMachineDialog:SetActiveSelf(active)
    active = checkBool(active)
    CfUtils.SetActive(self.RoleNode.transform.parent, active)
    CfUtils.SetActive(self.Container, active)
end

--region public
---刷新自身
---@param activityDojo ActivityDojo
function SlotMachineDialog:Refresh(activityDojo)
    self.activityDojo = activityDojo
    self:SetActiveSelf(true)
    self:RefreshActivityUI(self.activityDojo)
    self:FreshGroupInfo(true)
    self:StartRequest()
end

function SlotMachineDialog:StartRequest()
    GameUtils.Request("activity2/slotMachine", { activityUuid = self.activityDojo.id }, function(request, response)
        if checkNumber(response.errCode) ~= 0 then
            return
        end
        self.data = checkTable(response.data)
        --self.data.grandRewardList = {
        --    {
        --        playerId = 4364,
        --        playerName = "xiangyuan",
        --        rewardId = Constants.Currency.FreeDiamondId,
        --        rewardNum = 222,
        --        time = os.time()
        --    },
        --    {
        --        playerId = 4364,
        --        playerName = "xiangyuan2",
        --        rewardId = Constants.Currency.FreeDiamondId,
        --        rewardNum = 222,
        --        time = os.time()
        --    },
        --    {
        --        playerId = 4364,
        --        playerName = "xiangyuan4",
        --        rewardId = Constants.Currency.FreeDiamondId,
        --        rewardNum = 222,
        --        time = os.time()
        --    }
        --}
        self:SetActiveSelf(true)
        self:FreshUI()
    end)
end

function SlotMachineDialog:FreshUI()
    self:RefreshCurrencyBarInfo()
    ---刷新状态
    CfUtils.SetActive(self.ButtonOpen, checkNumber(self.data.todayLeftLotteryTimes) > 0)
    CfUtils.SetActive(self.ButtonClose, checkNumber(self.data.todayLeftLotteryTimes) <= 0)
    local consume = table.takeFirst(self.data.consume)
    ---@type GoodsVo
    local goodsVo = GoodsUtils.GetGoodsVoById(consume.goodsId)
    if checkNumber(self.data.todayLeftLotteryTimes) > 0 then
        CfUtils.FillImage(self.ButtonOpen.transform:Find("LayoutGroup/Icon/ImgIcon"), goodsVo.photoPath)
        CfUtils.FillText(self.ButtonOpen.transform:Find("LayoutGroup/TxtNum"), "x" .. checkNumber(consume.num))
    else
        CfUtils.FillImage(self.ButtonClose.transform:Find("LayoutGroup/Icon/ImgIcon"), goodsVo.photoPath)
        CfUtils.FillText(self.ButtonClose.transform:Find("LayoutGroup/TxtNum"), "x" .. checkNumber(consume.num))
    end
    CfUtils.FillText(self.TimesNode.transform:Find("TextTime2"), string.format("%d/%d", checkNumber(self.data.todayLeftLotteryTimes), checkNumber(self.data.todayTotalLotteryTimes)))
    CfUtils.SetActive(self.RewardItem, table.count(self.data.grandRewardList) > 0)
    ---@type GoodsVo
    local goodsVo1 = GoodsUtils.GetGoodsVoById(self.data.grandRewardId)
    if goodsVo1 then
        CfUtils.FillText(self.Content.transform:Find("TxtNumber"), string.format("x%d", checkNumber(self.data.grandRewardNum)))
        CfUtils.FillImage(self.Content.transform:Find("TxtNumber/ImgIcon"), goodsVo1.photoPath)
        CfUtils.FillText(self.RewardTxtTime, string.format("x%d", checkNumber(self.data.grandRewardNum)))
        CfUtils.FillImage(self.GoodImageIcon, goodsVo1.photoPath)
    end
    self:PlayNoticeAnimation(true, 1)
end

function SlotMachineDialog:PlayNoticeAnimation(isStart, alpha)
    if table.count(self.data.grandRewardList) > 0 then
        local canvasGroup = self.textTrans.transform:GetComponent(typeof(CanvasGroup))
        if isStart then
            self.startIndex = 1
            canvasGroup.alpha = alpha
            self.textRectTrans.anchoredPosition = Vector2.New(0, 1)
        end
        local data = self.data.grandRewardList[self.startIndex]
        ---@type GoodsVo
        local goodsVo = GoodsUtils.GetGoodsVoById(data.rewardId)
        CfUtils.FillText(self.textTrans, localize("恭喜_playerName_获得_name_ x_num_", {
            _playerName_ = data.playerName,
            _name_ = goodsVo.name,
            _num_ = checkNumber(data.rewardNum),
        }))

        local anchoredPosition = self.textRectTrans.anchoredPosition
        --self.textRectTrans.anchoredPosition = Vector3.New(anchoredPosition.x, anchoredPosition.y - 45)
        local sequence = DOTween:Sequence()
        local moveAni = self.textRectTrans:DOLocalMoveY(anchoredPosition.y + 45, 0.3):SetDelay(2)
        local fadeAni = canvasGroup:DOFade(0, 0.3)
        sequence:Append(moveAni)
        sequence:Join(fadeAni)
        sequence:AppendCallback(function()
            self.textRectTrans.anchoredPosition = Vector2.New(0, -10)
            self.startIndex = self.startIndex + 1
            if self.startIndex > #self.data.grandRewardList then
                self.startIndex = 1
            end
            data = self.data.grandRewardList[self.startIndex]
            ---@type GoodsVo
            goodsVo = GoodsUtils.GetGoodsVoById(data.rewardId)
            CfUtils.FillText(self.textTrans, localize("恭喜_playerName_获得_name_ x_num_", {
                _playerName_ = data.playerName,
                _name_ = goodsVo.name,
                _num_ = checkNumber(data.rewardNum),
            }))
            local sequence1 = DOTween:Sequence()
            local moveAni1 = self.textRectTrans:DOLocalMoveY(self.textRectTrans.anchoredPosition.y + 11, 0.1)
            local fadeAni1 = canvasGroup:DOFade(1, 0.1)
            sequence1:Append(moveAni1)
            sequence1:Join(fadeAni1)
            sequence1:AppendCallback(function()
                self:PlayNoticeAnimation(false, 0)
            end)
        end)
        sequence:PlayForward()
    end
end

--region private
---刷新UI
---@param activityDojo ActivityDojo
function SlotMachineDialog:RefreshActivityUI(activityDojo)
    CfUtils.FillText(self.TxtTime, ActivityUtils.ConventActivityDurationTime(activityDojo.startTime, activityDojo.endTime))
    --CfUtils.FillText(self.DescrText, activityDojo.detail)
    -- 网络标题
    local titleImgUrl = checkString(activityDojo.titleImage)
    if string.len(titleImgUrl) > 0 then
        CfUtils.FillWebRawImage(self.ImgTitleName, titleImgUrl)
    end
end

function SlotMachineDialog:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end

return SlotMachineDialog