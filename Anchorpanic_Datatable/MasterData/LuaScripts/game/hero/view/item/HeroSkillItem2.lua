module("hero.HeroSkillItem2", Class.impl(SimpleInsItem))

function initData(self)
    self.mItemType = 1
    self.forbid = nil
    self.mIsShowRightDefine = false
    self.mIsShowLeftUp = false
    self.mIsShowSkilllv = true
    self.mIsShowTopName = false
end


function create(self, cusParent, goPoolName)
    local go = gs.ResMgr:Load(UrlManager:getUIPrefabPath("hero/item/HeroSkillItem2.prefab"))
    return super.create(self, go, cusParent, goPoolName)
end

-- 设置data
function setData(self, heroVo, skillVo, isUnlock, cusType, isShowRightDefine, isShowLeft, isShowSkillLv, isShowTopName)
    self:initData()
    self:setItemType(cusType)
    self.isTalent = false
    if (heroVo and skillVo) then
        self.m_data = {}
        self.m_data.heroVo = heroVo
        self.m_data.skillVo = skillVo
        self.m_data.isUnlock = isUnlock
        self.mIsShowRightDefine = isShowRightDefine and isShowRightDefine or false
        self.mIsShowLeftUp = isShowLeft and isShowLeft or false
        self.mIsShowSkilllv = (isShowSkillLv == nil) and true or isShowSkillLv
        self.mIsShowTopName = (isShowTopName == nil) and false or isShowTopName
        self:updateContent()
    end
end

function updateContent(self)
    local heroVo = self.m_data.heroVo
    local heroTid = heroVo.tid
    if not heroTid then
        heroTid = hero.HeroManager:getHeroVo(heroVo.id)
    end
    local heroCingfigVo = hero.HeroManager:getHeroConfigVo(heroTid)
    local skillVo = self.m_data.skillVo
    --技能类型判断
    local mTxtLv = self.m_childGos["mTxtLv"]:GetComponent(ty.Text)
    local mTxtSkillLv = self.m_childGos["mTxtSkillLv"]:GetComponent(ty.Text)

    local skillType = skillVo:getType()
    if (skillType == fight.FightDef.SKILL_TYPE_PASSIVE_SKILL) then
        self.isTalent = true
        self.m_childGos["mImgItemBg"]:SetActive(false)
        local skillLv = heroVo:getActivePassiveSkill(skillVo:getRefID()) + heroVo:getExtraLv(skillVo:getRefID())
        mTxtLv.text = skillLv
        mTxtSkillLv.text = "Lv." .. skillLv
    else
        self.m_childGos["mImgItemBg"]:SetActive(true)
        local skillLv = heroVo:getActivePassiveSkill(skillVo:getRefID()) + heroVo:getExtraLv(skillVo:getRefID())
        if heroVo:getActiveSkill(skillVo:getRefID()) then
            skillLv = heroVo:getActiveSkill(skillVo:getRefID()) + heroVo:getExtraLv(skillVo:getRefID())
        end
        mTxtLv.text = skillLv
        mTxtSkillLv.text = "Lv." .. skillLv
    end
    --锁定状态

    if (self.m_data.isUnlock ~= 1) then
        self.m_childGos["mImgSkillLvl"]:SetActive(false)
        self.m_childGos["mImgSkillDefine"]:SetActive(false)
        self.m_childGos["mImgSkillDefineRight"]:SetActive(false)
        if (self.forbid) then
            self.m_childGos["mImgLock"]:SetActive(false)
        else
            self.m_childGos["mImgLock"]:SetActive(true)
        end
    else
        self.m_childGos["mImgSkillLvl"]:SetActive(true)
        self.m_childGos["mImgLock"]:SetActive(false)
    end
    --技能等级
    -- if(heroVo:getActiveSkill(skillVo:getRefID()))then
    -- elseif() then
    --     mTxtLv.text = heroVo:getActivePassiveSkill(skillVo:getRefID())
    --     mTxtSkillLv.text = "Lv." .. heroVo:getActivePassiveSkill(skillVo:getRefID())
    -- end
    --左下角标
    self:updateSkillDefineDes()
    --技能图标
    local mImgSkill = self.m_childGos["mImgSkill"]:GetComponent(ty.AutoRefImage)
    mImgSkill:SetImg(UrlManager:getSkillIconPath(skillVo:getIcon()), false)
    --技能名字
    local mTxtSkillName = self.m_childGos["mTxtSkillName"]:GetComponent(ty.Text)
    local mTxtSkillNameDown = self.m_childGos["mTxtSkillNameDown"]:GetComponent(ty.Text)
    local mTxtName = self.m_childGos["mTxtName"]:GetComponent(ty.Text)
    mTxtSkillName.text = skillVo:getName()
    mTxtSkillNameDown.text = skillVo:getName()
    local nameStr = skillVo:getName()
    if table.indexof(heroCingfigVo.inBornSkill, skillVo:getRefID()) == 1 then
        nameStr = _TT(27033)--天赋一
    elseif table.indexof(heroCingfigVo.inBornSkill, skillVo:getRefID()) == 2 then
        nameStr = _TT(27034)--天赋二
    end
    mTxtName.text = nameStr
    self.m_childGos["mTxtSkillNameDown"]:SetActive(false)
    self.m_childGos["mImgName"]:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("hero5/hero_skill_10"), false)
    gs.TransQuick:Scale(self.m_childGos["mImgSkillBg"]:GetComponent(ty.RectTransform), 0.7, 0.7, 0.7)
    if (self.mItemType == 1) then
        self.m_childGos["mImgSkillLvl"]:SetActive(true)
        self.m_childGos["mImgName"]:SetActive(false)
        self.m_childGos["mImgSkillDefine"]:SetActive((true and (self.mIsShowRightDefine == false)))
        self.m_childGos["mImgSkillDefineRight"]:SetActive(((self.m_childGos["mTxtSkillDefineRight"]:GetComponent(ty.Text).text ~= "") and self.mIsShowRightDefine))
        self.m_childGos["mTxtSkillName"]:SetActive(true)
        self.m_childGos["mTxtSkillLv"]:SetActive(self.mIsShowSkilllv)
        if self.m_data.isUnlock == 1 then
            local canUp = true
            local extraLv = heroVo:getExtraLv(skillVo:getRefID())
            local maxSkillLvl = sysParam.SysParamManager:getValue(SysParamType.SKILLREALYCEILING) 
            local skillLvl = (heroVo:getActiveSkill(skillVo:getRefID())) >= maxSkillLvl and maxSkillLvl or (heroVo:getActiveSkill(skillVo:getRefID()))
            if (self.isTalent) then
                skillLvl = (heroVo:getActivePassiveSkill(skillVo:getRefID())) >= maxSkillLvl and maxSkillLvl or (heroVo:getActivePassiveSkill(skillVo:getRefID()))
            end

            if (self.isTalent or skillLvl >= maxSkillLvl) then
                canUp = false
            else
                -- 判断升级材料
                local skillUpVo = hero.HeroSkillUpManager:getSkillUpConfigVo(heroVo.tid, skillVo:getRefID(), skillLvl)
                if heroVo.militaryRank < skillUpVo.needHeroRank or heroVo.evolutionLvl < skillUpVo.needStar then
                    canUp = false
                else
                    local costMoneyTid = skillUpVo.cost[1]
                    local costMoneyCount = skillUpVo.cost[2]
                    local costItem = skillUpVo.costItem
                    local mon = MoneyUtil.getMoneyCountByTid(costMoneyTid)
                    if mon < costMoneyCount then
                        canUp = false
                    end
                    for i = 1, #costItem do
                        local needNum = costItem[i][2]
                        local hasNum = bag.BagManager:getPropsCountByTid(costItem[i][1])
                        if hasNum < needNum then
                            canUp = false
                        end
                    end
                end
            end
            if canUp then
                self.m_childGos["mImgSkillUpLeft"]:SetActive(true)
            else
                self.m_childGos["mImgSkillUpLeft"]:SetActive(false)
            end
        else
            self.m_childGos["mImgSkillUpLeft"]:SetActive(false)
        end
    elseif (self.mItemType == 2) then
        self.m_childGos["mImgSkillLvl"]:SetActive(true)
        self.m_childGos["mImgName"]:SetActive(true)
        self.m_childGos["mImgItemBg"]:SetActive(false)
        self.m_childGos["mImgSkillDefine"]:SetActive((false and (self.mIsShowRightDefine == false)))
        self.m_childGos["mImgSkillDefineRight"]:SetActive(false)
        self.m_childGos["mTxtSkillName"]:SetActive(false)
        self.m_childGos["mTxtSkillLv"]:SetActive(false)
        gs.TransQuick:Scale(self.m_childGos["mImgSkillBg"]:GetComponent(ty.RectTransform), 1.2, 1.2, 1)
        gs.TransQuick:Scale(self.m_childGos["mImgSkill"]:GetComponent(ty.RectTransform), 1.2, 1.2, 1)
    elseif (self.mItemType == 3) then
        self.m_childGos["mImgSkillLvl"]:SetActive(true)
        self.m_childGos["mImgName"]:SetActive(true)
        self.m_childGos["mImgItemBg"]:SetActive(false)
        self.m_childGos["mImgSkillDefine"]:SetActive((false and (self.mIsShowRightDefine == false)))
        self.m_childGos["mImgSkillDefineRight"]:SetActive(false)
        self.m_childGos["mTxtSkillName"]:SetActive(false)
        self.m_childGos["mTxtSkillLv"]:SetActive(false)
        gs.TransQuick:Scale(self.m_childGos["mImgSkillBg"]:GetComponent(ty.RectTransform), 1.2, 1.2, 1)
        gs.TransQuick:Scale(self.m_childGos["mImgSkill"]:GetComponent(ty.RectTransform), 1.2, 1.2, 1)
    elseif (self.mItemType == 4) then
        self.m_childGos["mImgSkillLvl"]:SetActive(false)
        self.m_childGos["mImgName"]:SetActive(false)
        self.m_childGos["mTxtSkillName"]:SetActive(false)
        self.m_childGos["mTxtSkillLv"]:SetActive(false)
        gs.TransQuick:Scale(self.m_childGos["mImgSkillBg"]:GetComponent(ty.RectTransform), 0.9, 0.9, 1)
        gs.TransQuick:Scale(self.m_childGos["mImgSkill"]:GetComponent(ty.RectTransform), 0.9, 0.9, 1)
    elseif (self.mItemType == 5) then
        self.m_childGos["mImgSkillLvl"]:SetActive(false)
        self.m_childGos["mImgName"]:SetActive(false)
        self.m_childGos["mTxtSkillName"]:SetActive(false)
        self.m_childGos["mTxtSkillLv"]:SetActive(false)
        gs.TransQuick:Scale(self.m_childGos["mImgSkillBg"]:GetComponent(ty.RectTransform), 1, 1, 1)
        gs.TransQuick:Scale(self.m_childGos["mImgSkill"]:GetComponent(ty.RectTransform), 1, 1, 1)
    elseif (self.mItemType == 6) then
        self.m_childGos["mImgSkillLvl"]:SetActive(true)
        self.m_childGos["mImgName"]:SetActive(true)
        self.m_childGos["mImgItemBg"]:SetActive(false)
        self.m_childGos["mImgSkillDefine"]:SetActive((true and (self.mIsShowRightDefine == false)))
        self.m_childGos["mImgSkillDefineRight"]:SetActive(self.mIsShowRightDefine)
        self.m_childGos["mTxtSkillName"]:SetActive(false)
        self.m_childGos["mTxtSkillLv"]:SetActive(false)
        self.m_childGos["mImgName"]:GetComponent(ty.AutoRefImage):SetImg("", false)
        gs.TransQuick:Scale(self.m_childGos["mImgSkillBg"]:GetComponent(ty.RectTransform), 1, 1, 1)
        gs.TransQuick:Scale(self.m_childGos["mImgSkill"]:GetComponent(ty.RectTransform), 1, 1, 1)
    elseif (self.mItemType == 7) then         --只保留技能图标和背景 - 战员资料卡
        self.m_childGos["mImgSkillLvl"]:SetActive(true)
        self.m_childGos["mImgName"]:SetActive(false)
        self.m_childGos["mImgItemBg"]:SetActive(false)
        self.m_childGos["mImgSkillDefine"]:SetActive((false and (self.mIsShowRightDefine == false)))
        self.m_childGos["mImgSkillDefineRight"]:SetActive(false)
        self.m_childGos["mTxtSkillName"]:SetActive(false)
        self.m_childGos["mTxtSkillLv"]:SetActive(false)
    elseif (self.mItemType == 8) then
        self.m_childGos["mImgSkillLvl"]:SetActive(true)
        self.m_childGos["mImgLock"]:SetActive(false)
        self.m_childGos["mImgName"]:SetActive(false)
        self.m_childGos["mImgSkillDefine"]:SetActive((true and (self.mIsShowRightDefine == false)))
        self.m_childGos["mImgSkillDefineRight"]:SetActive(self.mIsShowRightDefine)
        self.m_childGos["mTxtSkillName"]:SetActive(true)
        self.m_childGos["mTxtSkillLv"]:SetActive(false)
        self.m_childGos["mImgSkillUpLeft"]:SetActive(false)
    end

    self.m_childGos["mImgForbid"]:SetActive(self.forbid)
end

function updateSkillDefineDes(self, skillIndex)
    local mImgSkillDefine = self.m_childGos["mImgSkillDefine"]:GetComponent(ty.AutoRefImage)
    local mTxtSkillDefine = self.m_childGos["mTxtSkillDefine"]:GetComponent(ty.Text)
    local mTxtSkillDefineRight = self.m_childGos["mTxtSkillDefineRight"]:GetComponent(ty.Text)
    local skillDes = (skillIndex ~= nil) and hero.getHeroSkillTypeName(skillIndex) or self.m_data.skillVo:getLocation()[2]
    if (#self.m_data.skillVo:getLocation() >= 2 or (skillIndex ~= nil)) then
        -- mImgSkillDefine.color = gs.ColorUtil.GetColor(self.m_data.skillVo:getLocation()[1])
        self.m_childGos["mImgSkillDefineRight"]:SetActive(true)
        mTxtSkillDefine.text = _TT(skillDes)
        mTxtSkillDefineRight.text = _TT(skillDes)
    else
        -- mImgSkillDefine.color = gs.ColorUtil.GetColor("FFFFFF00")
        mTxtSkillDefine.text = ""
        mTxtSkillDefineRight.text = ""
    end
end

function setItemType(self, type)
    self.mItemType = type
end

function setSkillDefineDes(self, index)
    self:updateSkillDefineDes(index)
end

function setIsShowDownName(self, isShow)
    self.m_childGos["mTxtSkillNameDown"]:SetActive(isShow)
end

function setScale(self, scale)
    gs.TransQuick:Scale(self.m_childGos["mImgSkillBg"]:GetComponent(ty.RectTransform), scale, scale, scale)
end

function setHideSkillName(self, isHide)
    self.m_childGos["mGroupRight"]:SetActive(isHide == false)
end

function setForbid(self, forbid)
    self.forbid = forbid
    self:updateContent()
end
return _M

--[[ 替换语言包自动生成，请勿修改！
]]