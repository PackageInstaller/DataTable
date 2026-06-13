local M = BaseClass("DormPersonalEventPopupCtrl", BaseUICtrl)

function M:Init()
    self.m_mission = nil
    self._view.btn_map:onClick(Bind(self, self.OnClickMap))
    self._view.btn_mask:onClick(Bind(self, self.OnClickMask))
    self._view.btn_more:onClick(Bind(self, self.OnClickMore))
    self._view.btn_enemy:onClick(Bind(self, self.OnClickEnemy))
    self._view.btn_battle:onClick(Bind(self, self.OnClickBatter))
end

function M:OnEnter(data)
    self.m_mission = data.MissionCfg
    self.m_IsPass = data.IsPass()
    self.m_heroId = data.HeroId()
    local text = ConfigHelper.GetLocalStringByPlayerName(self.m_mission.shortStory)
    self._view.txt_desc:SetText(text)
    self._view.img_map:SetPic(self.m_mission.map)
    self._view.txt_name:SetText(self.m_mission.name)
    self:_InitAwardGroup()
    self:_InitFavorNum()
end

function M:OnClickMap(go)
    UIContextMgr:GetInstance():Show("MissionMapUI", self.m_mission.map)
end

function M:OnClickMask(go)
    GameHelper.DoPlayerAction(PlayerAction.OpenRoom)
    self:Close()
end

function M:OnClickMore(go)
    UIContextMgr:GetInstance():Show("MissionAwardDetails", self.m_mission, false)
end

function M:OnClickEnemy(go)
    UIContextMgr:GetInstance():Show("MonsterInfoUI", self.m_mission.Stage)
end

function M:OnClickBatter(go)
    local TeamConfigStyle = EnumConst.TeamConfigStyle
    local energy = EnergyMgr:GetInstance():EnergyValue()
    if energy < self.m_mission.energyCost then
        -- 体力不足
        GameHelper.TipsById(30171)
        return
    end
    TeamConfMgr:GetInstance():OpenTeamConfUI(false, self.m_mission.id, TeamConfigStyle.Battle, self.m_heroId,
        EnumConst.EBattleStyle.Personal)
end

function M:_InitAwardGroup()
    if self.m_mission.firstChests > 0 then
        local firstChestsCfg = ConfigHelper.GetCfg("itemGroup", self.m_mission.firstChests)
        local items = firstChestsCfg.items
        local nums = firstChestsCfg.cnts
        for i = 1, #items do
            local itemClone = self._view.itemPfb:Instantiate()
            itemClone:SetInfo(items[i], ItemNumberType.TOTLE, nums[i])
            -- itemClone.itemPfb:EnablePopItem(true)
            itemClone:SetFinish(self.m_IsPass)
        end
    end
    self._view.itemPfb:SetActive(false)
end

function M:_InitFavorNum()
    self._view.node_favor:SetActive(false)
end

return M
