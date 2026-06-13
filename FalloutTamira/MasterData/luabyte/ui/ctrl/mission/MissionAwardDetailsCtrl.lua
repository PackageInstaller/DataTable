local M = BaseClass("MissionAwardDetailsCtrl", BaseUICtrl)

function M:Init()
    self.m_starTags = ConfigHelper.GetSystemParams(188)
    self._view.backBtn:onClick(Bind(self, self.OnClickBack))
end

-- 入口
function M:OnEnter(mission, isDouble, doubleRewardId)
    if self.m_isOpen == true then return end

    self.m_isOpen = true
    self.m_mission = mission
    self.m_missionData = MissionDataMgr:GetInstance():GetMissionDataById(self.m_mission.id)
    self.m_missionDouble = ConfigHelper.GetCfg("itemGroup", (doubleRewardId or 0)) or {}

    self:_ShowMissionReward()
end

function M:OnClose()
    self.m_mission = nil
    self.m_missionData = nil
    self.m_missionDouble = nil
end

--点击设置退出键
function M:OnDeviceBack()
    self:Close()
    return true
end

function M:OnClickBack(go)
    self.m_isOpen = false
    self:Close()
end

-- 根据类型判断显示那种奖励
function M:_ShowMissionReward()
    local firstTitle, normalTitle, cfg = 532, 530, self.m_mission
    local firstReward, chestReward, randomReward = {}, {}, {}

    self:_AddCommonFirstRewards(firstReward) -- [通用] 都显示 首通奖励
    self:_AddCommonStarRewards(firstReward)  -- [通用] 如果配置了星级奖励，则显示星级奖励

    if MissionDataMgr:GetInstance():IsResTeachMission(cfg.id) then
        self:_AddCommonChestRewards(chestReward, Bind(self, self._AddRandomRewards))
    elseif MissionHelper.Is4StarMission(cfg) then
        self:_AddCommonChestRewards(chestReward, Bind(self, self._AddRandomRewards))
    elseif self.m_missionData:IsResource() then -- 资源本固定掉落显示区间
        firstTitle, normalTitle = 527, 528
        self:_AddCommonChestRewards(chestReward, Bind(self, self._AddSpaceReward))
    else
        self._view.titleTips:SetActive(not self.m_missionData:IsMain())
        self:_AddCommonChestRewards(chestReward, Bind(self, self._AddRandomRewards))
    end

    self._view.txt_first:SetText(firstTitle)
    self._view.txt_normal:SetText(normalTitle)
    self:_AddCommonRandomRewards(randomReward)
    self:_AddCommonDoubleRewards(randomReward)
    self:_AddCommonActivityRewards(chestReward)

    -- 根据数据 显示对应奖励的内容 如果其中一个奖励资源长度为0 则不显示这一类型
    self:_DataSort(firstReward)
    self:_DataSort(chestReward)
    self:_DataSort(randomReward)
    self._view.firstGo:SetActive(#firstReward > 0)
    self._view.normalGo:SetActive(#chestReward > 0)
    self._view.randomGo:SetActive(#randomReward > 0)
    self:_CreateItemsPfb(self._view.firstItem, firstReward)
    self:_CreateItemsPfb(self._view.normalItem, chestReward)
    self:_CreateItemsPfb(self._view.randomItem, randomReward)
end

-- 统一添加随机奖励
function M:_AddCommonRandomRewards(tbl)
    local randomReward = self.m_mission.randomReward
    for i = 0, (randomReward and randomReward.Length or 0) - 1 do
        local v = ConfigHelper.GetCfg("itemGroup", randomReward[i])
        if v then
            self:_AddRandomRewards(tbl, v.items, v.cnts)
        else
            Logger.LogError("itemGroup is nil, id = " .. tostring(randomReward[i]))
        end
    end
end

-- 统一添加首通奖励
function M:_AddCommonFirstRewards(tbl)
    local isFrist = self.m_missionData:GetPassCount() > 0
    local ig = ConfigHelper.GetCfg("itemGroup", self.m_mission.firstChests) or {}
    self:_AddRandomRewards(tbl, ig.items, ig.cnts, nil, 532, isFrist)
end

-- 统一添加星级奖励
function M:_AddCommonStarRewards(awards)
    local starNum, cfg = self.m_missionData:GetStar(), self.m_mission
    for i, items in ipairs({ cfg.headFullstar, cfg.secndFullstar, cfg.thirdFullstar, cfg.fourthFullstar }) do
        local tagId, isPass = self.m_starTags[i - 1], starNum >= i
        for k = 0, (items and items.Length or 0) - 1, 2 do
            awards[#awards + 1] = {
                tag = tagId,
                id = items[k],
                num = items[k + 1],
                isFinish = isPass,
                cfg = ConfigHelper.GetCfg("item", items[k])
            }
        end
    end
end

-- 统一添加固定奖励
function M:_AddCommonChestRewards(tbl, func)
    local chest = self.m_mission.chest
    for i = 0, (chest and chest.Length or 0) - 1 do
        local v = ConfigHelper.GetCfg("itemGroup", chest[i])
        if v then
            func(tbl, v.items, v.cnts, v.chanceLabel)
        else
            Logger.LogError("itemGroup is nil, id = " .. tostring(chest[i]))
        end
    end
end

-- 统一添加翻倍奖励
function M:_AddCommonDoubleRewards(tbl)
    self:_AddRandomRewards(tbl, self.m_missionDouble.items, self.m_missionDouble.cnts)
end

-- 统一添加活动奖励
function M:_AddCommonActivityRewards(tbl)
    local addItem = MissionHelper.ActivityAddMissionItem(self.m_mission.chapterID)
    if addItem > 0 then -- 主线预热额外活动道具
        local costNum = self.m_mission.energyCost
        if costNum > 0 then
            table.insert(tbl, {
                tag = 0,
                id = addItem,
                num = costNum,
                isFinish = false,
                cfg = ConfigHelper.GetCfg("item", addItem)
            })
        end
    end
end

-- 统一添加随机奖励
function M:_AddRandomRewards(data, items, cnts, chances, tag, isFrist)
    if not items or not cnts then return end

    for i, v in ipairs(items) do
        data[#data + 1] = {
            id = v,
            num = cnts[i],
            tag = tag or 0,
            isFinish = isFrist or false,
            chances = chances and chances[i] or nil,
            cfg = ConfigHelper.GetCfg("item", v)
        }
    end
end

-- 统一添加区间奖励
function M:_AddSpaceReward(data, items, cnts, chances)
    if not items or not cnts then return end

    data[#data + 1] = {
        tag = 0,
        id = items[1],
        num = cnts[1],
        minNum = cnts[1],
        maxNum = cnts[#cnts],
        isFinish = false,
        chances = chances and chances[1] or nil,
        cfg = ConfigHelper.GetCfg("item", items[1])
    }
end

-- 添加对应item
function M:_CreateItemsPfb(go, items)
    for _, reward in ipairs(items) do
        local itemClone = go:Instantiate()

        if not reward.minNum or (reward.minNum == reward.maxNum) then
            itemClone.itemPfb:SetInfo(reward.id, ItemNumberType.TOTLE, reward.num)
        else
            itemClone.itemPfb:SetInfo(reward.id, ItemNumberType.SPACE, reward.maxNum, reward.minNum)
        end
        itemClone.itemPfb:SetFinish(reward.isFinish) -- SetInfo 后面执行
        itemClone.itemPfb:EnablePopItem(true)
        itemClone:SetActive(true)

        if reward.tag > 0 then -- 首通标签
            itemClone.tagState:SetState(2)
            itemClone.textTag:SetText(reward.tag)
        else
            if reward.chances then -- 掉落标签
                itemClone.tagState:SetState(3)
                itemClone.dropState:SetState(reward.chances)
            else -- 无标签
                itemClone.tagState:SetState(1)
            end
        end
    end
    go:SetActive(false)
end

-- 道具排序
function M:_DataSort(data)
    if #data <= 0 then return end

    table.sort(data, function(v1, v2)
        local cfg1, cfg2 = v1.cfg, v2.cfg
        if cfg1.type ~= cfg2.type then return cfg1.type < cfg2.type end
        if cfg1.quality ~= cfg2.quality then return cfg1.quality > cfg2.quality end
        if cfg1.order ~= cfg2.order then return cfg1.order < cfg2.order end
        return v1.tag < v2.tag
    end)
end

return M
