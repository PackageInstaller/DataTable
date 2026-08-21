module("hero.HeroLevelUpSucPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("hero/success/HeroLevelUpSucPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
escapeClose = 0 -- 是否能通过esc关闭窗口
--构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle("")
end

function setIsBlur(self, isBlur)
    if (self.mBlurMask) then
        self.mBlurMask:SetActive(isBlur)
    end
end

-- 初始化数据
function initData(self)
    self.mItemList = {}
    self.mOldHeroVo = nil
    self.mCurHeroVo = nil
    self.mRewardList = {}
    self.mIsOk = false
end

function configUI(self)
    super.configUI(self)
    self.mImgBg = self:getChildTrans("mImgBg")
    self.mGroupStartUp = self:getChildGO("mGroupStartUp")
    self.mGroupMilitary = self:getChildGO("mGroupMilitary")
    self.mAni = self.UIObject:GetComponent(ty.Animator)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtStarUp = self:getChildGO("mTxtStarUp"):GetComponent(ty.Text)
    self.mTxtNextMilitaryName = self:getChildGO("mTxtNextMilitaryName"):GetComponent(ty.Text)
    self.mTxtBeforeMilitaryName = self:getChildGO("mTxtBeforeMilitaryName"):GetComponent(ty.Text)
    self.mTxtNextLimitMilitaryLvl = self:getChildGO("mTxtNextLimitMilitaryLvl"):GetComponent(ty.Text)
    self.mTxtBeforeMilitaryLvl = self:getChildGO("mTxtBeforeMilitaryLvl"):GetComponent(ty.Text)
end

function active(self, args)
    super.active(self, args)
    self:setData(args.oldHeroVo, args.curHeroVo)
    self:setGuideTrans("guide_levelUpSuccess_closeGuide", self:getChildTrans("mCloseGuide"))
end

function deActive(self)
    super.deActive(self)
    if self.mLoopSn then
        LoopManager:removeFrameByIndex(self.mLoopSn)
        self.mLoopSn = nil
    end
    self:__recyAllItem()
end

function addAllUIEvent(self)

end

function onClickClose(self)
    self.mAni:SetTrigger("exit")
    local time = AnimatorUtil.getAnimatorClipTime(self.mAni, "HeroLevelUpSucPanel_Exit")
    self:setTimeout(time, function()
        super.onClickClose(self)
    end)
end

function getOpenSoundPath(self)
    return UrlManager:getUIBaseSoundPath("ui_upgrade.prefab")
end

function __recyAllItem(self)
    if (self.mItemList) then
        for i = 1, #self.mItemList do
            local item = self.mItemList[i]
            item.UIObject:SetActive(false)
            item:poolRecover()
        end
    end
    self.mItemList = {}
end

function setData(self, oldHeroVo, curHeroVo)
    self:__recyAllItem()
    self.mOldHeroVo = oldHeroVo
    self.mCurHeroVo = curHeroVo
    self:updateListView()
end

function updateListView(self)
    -- local curMilitaryRankVo = hero.HeroMilitaryRankManager:getMilitaryRankConfigVo(self.mCurHeroVo.tid, self.mCurHeroVo.militaryRank)
    -- if curMilitaryRankVo then
    --     if curMilitaryRankVo.unlockSkillId > 0 then
    --         local skillVo = fight.SkillManager:getSkillRo(curMilitaryRankVo.unlockSkillId)
    --         if (skillVo) then
    --             local item = hero.HeroSucPanelAttItem:poolGet()
    --             item:setData(self.mImgBg, { type = 2, desc = _TT(1367), skillName = skillVo:getName() }, nil, nil)
    --             item.UIObject:SetActive(false)
    --             table.insert(self.mItemList, item)
    --         end
    --     end

    --     if not table.empty(curMilitaryRankVo.warshipSkill) then
    --         local skillId = curMilitaryRankVo.warshipSkill[1]
    --         local buildBaseSkillVo = buildBase.BuildBaseHeroManager:getSkillConfigBySkillId(skillId)
    --         if (buildBaseSkillVo) then
    --             local descStr = ""
    --             if curMilitaryRankVo.warshipSkill[2] then
    --                 descStr = _TT(1369)
    --             else
    --                 descStr = _TT(1368)
    --             end

    --             local item = hero.HeroSucPanelAttItem:poolGet()
    --             item:setData(self.mImgBg, { type = 2, desc = descStr, skillName = _TT(buildBaseSkillVo.name) }, nil, nil)
    --             item.UIObject:SetActive(false)
    --             table.insert(self.mItemList, item)
    --         end
    --     end
    -- end

    -- 更新普通的属性展示
    local index = 0
    if self.mOldHeroVo.attrList then
        for i = 1, #self.mOldHeroVo.attrList do
            local attrVo = self.mOldHeroVo.attrList[i]
            attrVo.type = 1
            if (attrVo.value ~= self.mCurHeroVo.attrDic[attrVo.key]) then
                index = index + 1
                local item = hero.HeroSucPanelAttItem:poolGet()
                item:setData(self.mImgBg, attrVo, self.mCurHeroVo.attrDic, index)
                item.UIObject:SetActive(false)
                table.insert(self.mItemList, item)
            end
        end

        local attrVo = { key = 113, value = self.mOldHeroVo.allElementDefine, type = 1 }
        if (attrVo.value ~= self.mCurHeroVo.allElementDefine) then
            index = index + 1
            local nextDataDic = {}
            nextDataDic[113] = self.mCurHeroVo.allElementDefine
            local item = hero.HeroSucPanelAttItem:poolGet()
            item:setData(self.mImgBg, attrVo, nextDataDic, index)
            item.UIObject:SetActive(false)
            table.insert(self.mItemList, item)
        end
    end
    local curIndex = 1
    local aniTime = AnimatorUtil.getAnimatorClipTime(self.mAni, "HeroLevelUpSucPanel_Enter")
    self:addTimer(aniTime, 1, function()
        self.mLoopSn = LoopManager:addTimer(0.1, #self.mItemList, self, function()
            if self.mItemList[curIndex] then
                self.mItemList[curIndex].UIObject:SetActive(true)
                self.mItemList[curIndex].UIObject:GetComponent(ty.UIDoTween):BeginTween()
                curIndex = curIndex + 1
            end
            if curIndex >= #self.mItemList then
                LoopManager:removeFrameByIndex(self.mLoopSn)
                self.mIsOk = true
            end
        end)
    end)
end

function setMilitaryUp(self)
    self.mGroupMilitary:SetActive(true)
    self.mGroupStartUp:SetActive(false)
    self.mTxtTitle.text = _TT(71438)--突破成功
    local oldMilitaryRankVo = hero.HeroMilitaryRankManager:getMilitaryRankConfigVo(self.mOldHeroVo.tid, self.mOldHeroVo.militaryRank)
    self.mTxtBeforeMilitaryName.text = oldMilitaryRankVo.lvl
    self.mTxtBeforeMilitaryLvl.text = _TT(4304) .. oldMilitaryRankVo.heroMaxLvl
    local curMilitaryRankVo = hero.HeroMilitaryRankManager:getMilitaryRankConfigVo(self.mCurHeroVo.tid, self.mCurHeroVo.militaryRank)
    self.mTxtNextMilitaryName.text = curMilitaryRankVo.lvl
    self.mTxtNextLimitMilitaryLvl.text = _TT(4304) .. curMilitaryRankVo.heroMaxLvl
end

function setStarUp(self)
    self.mGroupMilitary:SetActive(false)
    self.mGroupStartUp:SetActive(true)
    self.mTxtTitle.text = _TT(53511)--升格成功
    local mod = self.mCurHeroVo.evolutionLvl % 2
    local oldmod = (self.mCurHeroVo.evolutionLvl - 1) % 2
    local oldsub = math.floor((self.mCurHeroVo.evolutionLvl - 1) / 2)
    local sub = math.floor(self.mCurHeroVo.evolutionLvl / 2)
    for i = 1, 6 do
        if (i <= sub) then
            self:getChildGO("mImgStar" .. i):SetActive(true)
            self:getChildGO("mImgStar" .. i):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getCommon5Path("common_0043.png"), false)
        else
            if (mod == 1 and i == (sub + 1)) then
                self:getChildGO("mImgStar" .. i):SetActive(true)
                self:getChildGO("mImgStar" .. i):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getCommon5Path("common_0050.png"), false)
            else
                self:getChildGO("mImgStar" .. i):SetActive(false)
            end
        end
        if (i <= oldsub) then
            self:getChildGO("mImgOldStar" .. i):SetActive(true)
            self:getChildGO("mImgOldStar" .. i):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getCommon5Path("common_0043.png"), false)
        else
            if (oldmod == 1 and i == (oldsub + 1)) then
                self:getChildGO("mImgOldStar" .. i):SetActive(true)
                self:getChildGO("mImgOldStar" .. i):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getCommon5Path("common_0050.png"), false)
            else
                self:getChildGO("mImgOldStar" .. i):SetActive(false)
            end
        end
    end
    if (self.mCurHeroVo.evolutionLvl < 6) then
        self.mTxtStarUp.gameObject:SetActive(true)
        self.mTxtStarUp.text = _TT(53506)--"战员3星时品质提升为<color=#eb8817>橙色</color >"
    else
        self.mTxtStarUp.gameObject:SetActive(false)
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]