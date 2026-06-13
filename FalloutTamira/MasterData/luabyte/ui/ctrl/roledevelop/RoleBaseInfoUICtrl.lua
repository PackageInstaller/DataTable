--角色养成主界面中的属性面板
local RoleBaseInfoUICtrl = BaseClass("RoleBaseInfoUICtrl", UIBaseComponent)
local M = RoleBaseInfoUICtrl
local EQuality = EnumConst.EQuality
local CRoleAttr = CS.GameBase.CRoleAttr
local EAttributeType = EnumConst.EAttributeType
local ATTRIBUTENUM = 8
local tInsert = table.insert
local MessageId = Proto.MessageId
--仅属性于该文件的枚举，可放于此处
local RoleInfoUIType = {}
RoleInfoUIType.RIT_Interactive = 1 -- 交互   完整操作
RoleInfoUIType.RIT_Preview = 2     -- 预览   不可操作
RoleInfoUIType.RIT_QuickUp = 3     -- 快捷   觉醒跳转



--构造函数 相当于mono的 awake , 一般的变量可在此处声明
function M:__init()
    --声明变量
    self._isMaxLv = false  --是否达到最大等级
    self._nextBreak = nil  --下一个突破的配置
    self._curCore = nil    --当前核心配置
    self._heroLevel = 0
    self._attrState = true -- false:收起 true:展开
    self._costItems = {}
    self.m_heroId = 0
    self.m_idList = nil
    self.m_index = 0
    ---------

    self._view.costItem:SetActive(false)
    self._view.uplvBtn:onClick(Bind(self, self._ClickLvUp))
    self._view.breakBtn:onClick(Bind(self, self._ClickLvUp))
    self._view.awakeBtn:onClick(Bind(self, self._ClickLvUp))
    self._view.infoBtn:onClick(Bind(self, self.OnClickInfo))
    self._view.attrBtn:onClick(Bind(self, self._ClickAttr))
end

function M:SetInfo(heroData, upgradeFun, type)
    self._heroData = heroData
    self._upgradeFun = upgradeFun

    if type == nil then
        type = RoleInfoUIType.RIT_Interactive
    end

    self._intType = type
    self._allBreaks = CS.GameBase.JHeroBreak.GetBreaks(self._heroData:GetHeroId())
    self:UpdateState()
    self:_SetBaseInfo()
    self:_ClickAttr(nil)
    self._view.infoBtn:SetActive(self._nextBreak ~= nil)
end

--更新状态
function M:UpdateState()
    if self._intType == RoleInfoUIType.RIT_Preview then
        self._isMaxLv = true
        self._nextBreak = nil
        self._attrState = true
        local sys176 = ConfigHelper.GetSystemParams(176)
        self._heroLevel = sys176[self._heroData:GetHeroCfg().rare - 1]
    else
        self._nextBreak = CS.GameBase.JHeroBreak.GetBreak(self._heroData:GetHeroId(), self._heroData:GetBreakLevel() + 1)
        self._heroLevel = self._heroData:GetLevel()
        local curCores = ConfigHelper.GetCfgsByLua("heroCore",
            { id = self._heroData:GetSkinId(), coreLevel = self._heroData:GetCoreLevel() })

        if curCores.Length == 0 then
            self._curCore = nil
        else
            self._curCore = curCores[0]
        end

        local stars = self._heroData:GetGenesStars()
        local geneStars = {}
        self.curGeneStars = {}
        local geneIdx = 0

        if stars ~= nil then
            for i = 0, stars.Length - 1 do
                if stars[i] > 0 then
                    geneIdx = geneIdx + 1
                    local heroAi = ConfigHelper.GetCfgsByLua("heroAi",
                        { heroId = self._heroData:GetHeroId(), slot = i + 1 })

                    geneStars = ConfigHelper.GetCfgsByLua("heroAiStar", { aiType = heroAi[1].aiType })

                    for index, value in ipairs(geneStars) do
                        if value.star == stars[i] then
                            tInsert(self.curGeneStars, value)
                        end
                    end
                end
            end
        end
    end

    local limit = self:_CountLimitLv(self._nextBreak)
    self._view.limitLv:SetText("/" .. tostring(limit))

    if self._heroLevel < limit then
        --升级
        self._view.uplvBtn:SetActive(true)
        self._view.breakBtn:SetActive(false)
        self._view.awakeBtn:SetActive(false)
        self:_SetCostInfo(false)
    else
        --突破 觉醒
        self._view.uplvBtn:SetActive(false)

        if self._nextBreak ~= nil then
            self._view.breakBtn:SetActive(self._nextBreak.awaken == 0)
            self._view.awakeBtn:SetActive(self._nextBreak.awaken >= 1)
            self:_SetCostInfo(true)
        else
            self._isMaxLv = true

            if self._attrState == false then
                self._attrState = true
                self:_ClickAttr(nil)
            end

            self._view.breakBtn:SetActive(false)
            self._view.awakeBtn:SetActive(false)
        end
    end

    self:_SetAttribute()
end

--计算突破需要的等级
function M:_CountLimitLv(nextBreak)
    if nextBreak == nil then
        local addLv = ConfigHelper.GetSystemParams(187)
        return self._heroData:GetHeroBreak().needLevel + addLv[self._heroData:GetHeroCfg().rare - 1]
    end
    return nextBreak.needLevel
end

--基础信息
function M:_SetBaseInfo()
    local specialtyLength = self._heroData:GetHeroCfg().specialty.Length
    --最多3个槽位
    for i = 1, 3 do
        local index = i - 1

        if index < specialtyLength then
            self._view["attackType" .. index]:SetActive(true)
            self._view["attackTypeName" .. index]:SetText(self._heroData:GetHeroCfg().specialty[index])
        else
            self._view["attackType" .. index]:SetActive(false)
        end
    end
end

--升级 突破 觉醒
function M:_ClickLvUp(go)
    if self._intType == RoleInfoUIType.RIT_Interactive then
        if self._upgradeFun then
            self._upgradeFun()
        end
    elseif self._intType == RoleInfoUIType.RIT_Preview then
        -- body
        return
    elseif self._intType == RoleInfoUIType.RIT_QuickUp then
        self:_OnRoleQuickUp()
    end
end

--点击详情
function M:OnClickInfo(go)
    UIContextMgr:GetInstance():Show("RolePreviewPop", self._heroData)
end

--点击属性
function M:_ClickAttr(go)
    local triggerName = "UIUp"

    if self._intType == RoleInfoUIType.RIT_QuickUp and not self._isMaxLv then
        if self._attrState then
            triggerName = "UIUp"
        else
            triggerName = "UIDown"
        end

        self._attrState = not self._attrState
    else
        if not self._attrState then
            return
        end

        self._attrState = false
        triggerName = "UIDown"
    end

    if not IsNull(self._view.m_animator) then
        self._view.m_animator:SetTrigger(triggerName)
    end
end

--刷新属性
function M:_SetAttribute()
    local heroCfg = self._heroData:GetHeroCfg()
    local roleCfg = self._heroData:GetRoleCfg()
    local breakLv = self._heroData:GetBreakLevel()
    self._view.starGroup:SetHeroData(8, breakLv)
    self._view.chName:SetText(heroCfg.name)
    self._view.enName:SetText(heroCfg.nameEn)
    self._view.curLv:SetText(tostring(self._heroLevel))
    self._view.proImg:SetPic("UI/SpritePics/profession/ui_icon_profession_0" .. roleCfg.profession)
    self._view.rareImg:SetPic("UI/SpritePics/develop/ui_develop_icon_" .. heroCfg.rare)
    if not IsNull(self._view.upRedPoint) then
        self._view.upRedPoint:SetParam(0, self._heroData:GetHeroId())
        self._view.upRedPoint:Check()
    end

    local dataId = {
        EAttributeType.EAT_MaxHP,     --生命
        EAttributeType.EAT_Damage,    --攻击
        EAttributeType.EAT_DamageDef, --物理防御
        EAttributeType.EAT_MagicDef,  --魔法防御
        EAttributeType.EAT_MaxArmor,  --护盾
        EAttributeType.EAT_Block,     --阻挡
        EAttributeType.EAT_Summon,    --部署物资
    }

    local idx = 1
    for i = 1, ATTRIBUTENUM - 1 do
        local data = {}
        local attribute = ConfigHelper.GetCfgByLua("attribute", dataId[i])
        if attribute then
            data.num = self._heroData:GetDevelopAttribute(dataId[i], self._heroLevel, breakLv)
            data.icon = attribute.icon
            data.desc = attribute.name
        else
            Logger.LogError("attribute is nil, id = " .. dataId[i])
        end
        idx = idx + self._view["Attr" .. i]:UpdateData(data, idx)

        if i == 5 then --攻击速度
            idx = idx + self._view.Attr8:UpdateData({
                num = self:GetAttackSpeed(heroCfg),
                icon = "UI/SpritePics/develop/ui_develop_icon_interval",
                desc = 100006
            }, idx)
        end
    end
end

--获取攻击速度
function M:GetAttackSpeed(heroCfg)
    local cur = CRoleAttr(heroCfg, self._heroLevel)
    --设置攻速
    local sys15 = ConfigHelper.GetSystemParams(15)
    local sys17 = ConfigHelper.GetSystemParams(17)
    local atkspeed = cur[EAttributeType.EAT_Idle]

    if atkspeed <= sys15[0] then
        return ConfigHelper.GetLocalString(sys17[0])
    elseif atkspeed <= sys15[1] then
        return ConfigHelper.GetLocalString(sys17[1])
    elseif atkspeed <= sys15[2] then
        return ConfigHelper.GetLocalString(sys17[2])
    elseif atkspeed <= sys15[3] then
        return ConfigHelper.GetLocalString(sys17[3])
    else
        return ConfigHelper.GetLocalString(sys17[4])
    end
end

function M:_AccountWeight(index)
    if index == 1 then
        return ConfigHelper.GetLocalString(4170)
        --"轻"
    elseif index == 2 then
        return ConfigHelper.GetLocalString(4171)
        --"中"
    elseif index == 3 then
        return ConfigHelper.GetLocalString(4172)
        --"重"
    else
        return ConfigHelper.GetLocalString(4173)
        --"超重"
    end
end

function M:_SetCostInfo(isBreak)
    if self._intType == RoleInfoUIType.RIT_Interactive then
        return
    end

    local needItems = nil
    local needNums = nil

    if isBreak then
        needItems = self._nextBreak.costItems or { Length = 0 }
        needNums = self._nextBreak.costNum or { Length = 0 }
    else
        local cfg = ConfigHelper.GetCfg("heroLevelcost", self._heroLevel) or {}
        needItems = cfg.needItem or { Length = 0 }
        local rare = self._heroData:GetHeroCfg().rare

        if rare == EQuality.N then
            needNums = cfg.needNumN or { Length = 0 }
        elseif rare == EQuality.R then
            needNums = cfg.needNumR or { Length = 0 }
        elseif rare == EQuality.SR then
            needNums = cfg.needNumSR or { Length = 0 }
        elseif rare == EQuality.SSR then
            needNums = cfg.needNumSSR or { Length = 0 }
        end
    end

    for i = 0, needItems.Length - 1 do
        local itemPfb = nil

        if i < #self._costItems then
            itemPfb = self._costItems[i + 1]
        else
            if not IsNull(self._view.costItem) then
                itemPfb = self._view.costItem:Instantiate()
                tInsert(self._costItems, itemPfb)
            end
        end

        if itemPfb then
            itemPfb:SetInfo(needItems[i], ItemNumberType.BALANCE, needNums[i])
            itemPfb.gameObject.name = tostring(needItems[i])
            itemPfb:EnablePopItem(true)
            itemPfb:SetActive(true)
        end
    end

    for i = needItems.Length + 1, #self._costItems do
        self._costItems[i]:SetActive(false)
    end
end

--快悚升级
function M:_OnRoleQuickUp()
    if self._view.uplvBtn.gameObject.activeSelf then
        local isEnough, lackId = self:_CheckHeroLimitLv(false)

        if not isEnough then
            self:_ItemLackTips(lackId)
            return
        end

        if self._waitNet then
            return
        end

        local RequestHeroLevelUp = {}
        RequestHeroLevelUp.HeroId = self._heroData:GetHeroId()

        if not NetPack:SendMessage(MessageId.RequestHeroLevelUp, RequestHeroLevelUp) then
            return
        end

        self._waitNet = true
    elseif self._view.breakBtn.gameObject.activeSelf then
        local isEnough, lackId = self:_CheckHeroLimitLv(true)

        if not isEnough then
            self:_ItemLackTips(lackId)
            return
        end

        if self._waitNet then
            return
        end

        local RequestHeroAdvanced = {}
        RequestHeroAdvanced.HeroId = self._heroData:GetHeroId()

        if not NetPack:SendMessage(MessageId.RequestHeroAdvanced, RequestHeroAdvanced) then
            return
        end

        self._waitNet = true
    elseif self._view.awakeBtn.gameObject.activeSelf then
        ModuleMgr:GetInstance():ChangeModule(
            ModuleConfig.Training.id, 1,
            self.m_heroId,
            self.m_idList,
            self.m_index
        )
    end
end

function M:_CheckHeroLimitLv(isBreak)
    local needItems, needNums

    if isBreak then
        needItems = self._nextBreak.costItems or {}
        needNums = self._nextBreak.costNum or {}
    else
        local cfg = ConfigHelper.GetCfg("heroLevelcost", self._heroLevel) or {}
        needItems = cfg.needItem
        local rare = self._heroData:GetHeroCfg().rare

        if rare == EQuality.N then
            needNums = cfg.needNumN
        elseif rare == EQuality.R then
            needNums = cfg.needNumR
        elseif rare == EQuality.SR then
            needNums = cfg.needNumSR
        elseif rare == EQuality.SSR then
            needNums = cfg.needNumSSR
        end
    end

    return GameHelper.Check_ItemsEnough(needItems, needNums)
end

function M:_ItemLackTips(itemId)
    local item = ConfigHelper.GetCfg("item", itemId) or {}
    local lackName = ConfigHelper.GetLocalString(item.name)
    GameHelper.Tips(string.format(ConfigHelper.GetLocalString(158), lackName))
end

function M:SetHeroList(list, heroId)
    if type(list) == "userdata" then
        for i = 0, list.Count - 1 do
            if list[i] == heroId then
                self.m_index = i
                break
            end
        end
    else
        for i = 1, #list do
            if list[i] == heroId then
                self.m_index = i - 1
                break
            end
        end
    end

    self.m_idList = list
    self.m_heroId = heroId
end

function M:IsUpLvActive()
    return self._view.uplvBtn.gameObject.activeSelf
end

function M:IsBreakActive()
    return self._view.breakBtn.gameObject.activeSelf
end

function M:IsAwakeActive()
    return self._view.awakeBtn.gameObject.activeSelf
end

return RoleBaseInfoUICtrl
