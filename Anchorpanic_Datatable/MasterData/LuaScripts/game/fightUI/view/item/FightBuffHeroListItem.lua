module("fight.FightBuffHeroListItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.m_buffIconArr = {}

    self.mImgBuffIcon = self:getChildGO("mImgBuffIcon"):GetComponent(ty.AutoRefImage)
    self.mHeroNode = self:getChildGO("mHeroNode"):GetComponent(ty.AutoRefImage)

    self.mGroupDead = self:getChildGO("mGroupDead")
    self.mBuffOther = self:getChildGO("mBuffOther")
    self.mBuffHero = self:getChildGO("mBuffHero")
    -- self.mLevel = self:getChildGO("mLevel")
    self.mImgSelected = self:getChildGO("mImgSelected")
    -- self.mGroupStar = self:getChildGO("mGroupStar")
    self.mGroupBuff = self:getChildGO("mGroupBuff")
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)

    self:addOnClick(self:getChildGO("mBtnClick"), self.onClick)
end

function setData(self, param)
    super.setData(self, param)
    self.mFightBuffIcon = self.data.mFightBuffIcon

    self.mFightHero = self.data.fightHero --战斗Buff数据
    self.mAssist = self.data.assist --助战技能数据
    self.mDir = self.data.dir --当前在左边还是右边
    self.mOtherBuff = self.data.otherBuff --其他（场景）技能数据

    self:recoverBuffIcon()
    if self.mFightHero then
        self.mfightBuffDic = self:copyBuffData(self.mFightHero)
        self:updateBuffList(self.mfightBuffDic)
    elseif self.mAssist then
        self:updateBuffList(self.mAssist.skill_id_list)
    end

    self:updateView()
    self:onUpdateSelectedId()
    fight.FightManager:addEventListener(fight.FightManager.EVENT_SHOW_BUFF_INFO_ID_CHANGE, self.onUpdateSelectedId, self)
end

function updateView(self)
    ---右边的头像
    if self.mFightHero ~= nil then
        local vo = fight.FightManager:getHero(self.mFightHero)
        local livething = fight.SceneManager:getThing(self.mFightHero)
        self.mGroupDead:SetActive(livething:isDead())

        if vo.type == 0 then
            if self.heroHead == nil then
                self.heroHead = HeroHeadGrid:poolGet()
            end

            local heroConfigVo = hero.HeroManager:getHeroConfigVo(vo.tid)
            heroConfigVo.getHeroModel = function()
                return livething:getModelID()
            end
            self.heroHead:setData(heroConfigVo)
            self.heroHead:setParent(self.mHeroNode.transform)
            self.heroHead:setLvl(vo.lv)
            self.heroHead:setStarLvl(vo.evolution)
        else
            --特殊类型，怪物当战员使用
            if self.heroHead == nil then
                self.heroHead = HeroHeadGrid:poolGet()
            end
            local _vo = {
                headUrl = UrlManager:getIconPath(monster.MonsterManager:getMonsterVo01(vo.tid).head),
                lvl = vo.lv,
                evolutionLvl = vo.evolution,
                color = vo.color + 1, --因为英雄的品质是 2、3、4 所以怪物的需要+1
            }
            self.heroHead:setData(_vo)
            self.heroHead:setParent(self.mHeroNode.transform)
        end
        self.mBuffHero:SetActive(true)
        self.mBuffOther:SetActive(false)
    elseif self.mAssist ~= nil then
        --如果需要显示时装头像的话 需要在pt_battle_assist_fight加上id
        local heroConfigVo = hero.HeroManager:getHeroConfigVo(self.mAssist.hero_tid)
        self.mGroupDead:SetActive(false)

        if self.heroHead == nil then
            self.heroHead = HeroHeadGrid:poolGet()
        end

        self.heroHead:setData(heroConfigVo)
        self.heroHead:setParent(self.mHeroNode.transform)
        self.heroHead:setLvl(self.mAssist.hero_lv)
        self.heroHead:setStarLvl(self.mAssist.hero_evolution)
    elseif self.mOtherBuff ~= nil then
        self.mBuffHero:SetActive(false)
        self.mBuffOther:SetActive(true)

        local iconUrl = UrlManager:getSkillIconPath(self.mOtherBuff:getIcon())
        self.mImgBuffIcon:SetImg(iconUrl)
        self.mTxtDes.text = self.mOtherBuff:getDesc()
    end
end

-- function __setStar(self,go,star)
--     for i = 1 , 6 do
--         go.transform:Find("mImgStar_" .. i).gameObject:SetActive(i <= star)
--     end
-- end

function onClick(self)
    if self.mFightHero ~= nil then
        fight.FightManager:setShowBuffInfoId(self.mFightHero, self.mfightBuffDic)
    else
        fight.FightManager:setShowBuffInfoId()
    end

    if self.mAssist then
        local tid = self.mAssist.hero_tid .. self.mDir
        fight.FightManager:setShowSkillInfo(tid, self.mAssist.skill_id_list)
    else
        fight.FightManager:setShowSkillInfo()
    end
end

function onUpdateSelectedId(self)
    if self.mFightHero then
        self.mImgSelected:SetActive(self.mFightHero == fight.FightManager.m_showBuffInfoId)
    elseif self.mAssist ~= nil then
        local tid = self.mAssist.hero_tid .. self.mDir
        self.mImgSelected:SetActive(tid == fight.FightManager.m_showHeroID)
    else
        self.mImgSelected:SetActive(false)
    end
end
--更新buff图标
function updateBuffList(self, buffDic)
    if buffDic then
        for i, v in ipairs(buffDic) do
            --最多只显示10个，超过的不显示
            if #self.m_buffIconArr >= 10 then
                break
            end

            local voData = nil
            local iconUrl = nil
            local isShow = false
            if v.buffRefID then--站员buff
                voData = Buff.BuffRoMgr:getBuffRo(v.buffRefID)
                iconUrl = UrlManager:getBuffIconUrl(v:getIcon())
                isShow = voData and voData:getBuff_show()
            elseif v.skill_id then --助战技能
                voData = fight.SkillManager:getSkillRo(v.skill_id)
                iconUrl = UrlManager:getSkillIconPath(voData:getIcon())
                isShow = voData ~= nil
            end

            if isShow then
                local tIcon = SimpleInsItem:create(self.mFightBuffIcon, self.mGroupBuff.transform, self.__cname .. "_buff_icon")
                local mImgIcon = tIcon:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)

                mImgIcon:SetImg(iconUrl, false)

                local mLevelTxt = tIcon:getChildGO("mLevelTxt"):GetComponent(ty.Text)
                local mRoundTxt = tIcon:getChildGO("mRoundTxt"):GetComponent(ty.Text)

                mLevelTxt.text = v.level or ""
                mRoundTxt.text = v.round > 0 and v.round or ""

                table.insert(self.m_buffIconArr, tIcon)
            end
        end
    end
end

function recoverBuffIcon(self)
    if (self.m_buffIconArr) then
        for k, item in pairs(self.m_buffIconArr) do
            item:poolRecover()
        end
    end
    self.m_buffIconArr = {}
end

function copyBuffData(self, id)
    if id == nil then return nil end
    local result = {}
    local data = BuffHandler:getAllBuff(id)
    local vo = fight.SceneManager:getThing(id)
    if data then
        for i, v in ipairs(data) do
            local bdata = vo:getBuffData(v:getRefID())
            table.insert(result, { buffRefID = v:getRefID(), round = bdata[1], level = bdata[2], bdesc_value = bdata[3] })
        end
    end
    return result
end


function deActive(self)
    fight.FightManager:removeEventListener(fight.FightManager.EVENT_SHOW_BUFF_INFO_ID_CHANGE, self.onUpdateSelectedId, self)

    self:recoverBuffIcon()
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]