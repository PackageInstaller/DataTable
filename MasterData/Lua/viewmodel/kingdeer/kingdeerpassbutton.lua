
















KingDeerPassButton = {}
KingDeerPassButton.__index = KingDeerPassButton

local objs = {
    intoBattleBtn = {path = "", type = UITool.Button},
    passBG = {path = "Group/PassBG", type = UITool.GameObject},
    noverBG = {path = "Group/NovalBG", type = UITool.GameObject},
    noverRedPoint = {path = "Group/NovalBG/RedPoint", type = UITool.GameObject},
    raringBG = {path = "Group/PassBG/RaringBG", type = UITool.Image},
    lockBG = {path = "Group/LockBG", type = UITool.GameObject},
    raringTxt = {path = "Group/PassBG/RaringBG/RaringText", type = UITool.Text},
    passName = {path = "Group/PassName", type = UITool.Text}
}

function KingDeerPassButton.New(obj, index, callback)

    local self = {}
    setmetatable(self, KingDeerPassButton)
    self.gameObject = obj
    self.index = index
    self.clickCallback = callback
    UITool.Parse(self.gameObject, self, objs)
    local clickBattleBtn = function()
        self:OnClickPassBtn()
    end
    LuaMgr.AddClick(self.intoBattleBtn, clickBattleBtn)
    return self
end

function KingDeerPassButton:OnClickPassBtn()
    if not DataExHelper.CommonActivityCheck(ActivityKey.KingDeerActivity) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_7206"))
        return
    end
    if self.data.isUnLock == false then
        local tips = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_7319")
        local frontConfig = KingDeerData.GetPassData(self.data.config.unlockParam).config
        local name = LuaMgr.GetLangText(frontConfig.namelan)
        if frontConfig.type == 1 then
            tips = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_7320")
        end
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, string.format(tips, name))
        return
    end
    KingDeerData.SetLastZoneIndex(self.zoneIndex)
    if self.data.isNovel == false then
        local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams()
        enterDungeonParams.eventId = self.data.config.id
        enterDungeonParams.dungeonId = self.data.config.eventParam
        BattlePrepareMgr.BattlePrepare(enterDungeonParams)
    else
        local playNovelCallback = function()
            LuaMgr.ShowLuaPanel(UIName.KingDeerMainViewModel)
        end
        LuaMgr.PlayNovel(self.data.config.eventParam, playNovelCallback)
    end
    self.clickCallback()
end

function KingDeerPassButton:SetData(data, zoneIndex)
    self.data = data
    self.zoneIndex = zoneIndex
    SetActive(self.passBG, self.data.config.type == 2)
    SetActive(self.noverBG, self.data.config.type == 1)
    SetActive(self.raringBG.gameObject, self.data.rating > 0)
    SetActive(self.lockBG, self.data.isUnLock == false)
    SetActive(self.noverRedPoint, self.data.isUnLock == true and self.data.isComplete == false)
    self.passName.text = LuaMgr.GetLangText(self.data.config.namelan)
    self.raringTxt.text = self:GetRaringText()
    self.raringBG.sprite = LuaMgr.GetSprite("ActivityKingDeer", "ui_hd_hy_zjmtc_gqpj" .. self.data.rating)
end

function KingDeerPassButton:GetRaringText()
    if self.data.rating == 1 then
        return LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_7316")
    elseif self.data.rating == 2 then
        return LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_7317")
    else
        return LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_7318")
    end
end

KingDeerPassButton.OnAfterBattle = function()
    local lastZoneIndex = KingDeerData.GetlastZoneIndex()
    if lastZoneIndex ~= nil then
        LuaMgr.ShowLuaPanel(UIName.KingDeerPassPopup, lastZoneIndex)
    end
end