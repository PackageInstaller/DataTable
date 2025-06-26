--[[ 
-----------------------------------------------------
@filename       : ManualMonsterInfoView
@Description    : 怪物信息面板
@date           : 2022-4-19 
@Author         : Shuai
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module("manual.ManualMonsterInfoView", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("manual/ManualMonsterInfoView.prefab")
destroyTime = -1 -- 自动销毁时间-1默认
panelType = 1 -- 窗口类型 1 全屏 2 弹窗
isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图
--构造函数
function ctor(self, args)
    super.ctor(self, args)
    self:setSize(1334, 750);
    self:setBg("", false)
    self:setTxtTitle(_TT(70087))
end

function initData(self)
    self.mImgStarList = {}
    self.mSkillGridList = {}
    self.mShowModel = 0
    self.mIndex = nil
    --相机位置
    self.mCameraPosX = 0
    self.scenceCamera = nil
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mBtnLast = self:getChildGO("mBtnLast")
    self.mBtnNext = self:getChildGO("mBtnNext")
    self.mModelPlayer = ModelScenePlayer.new()
    self.mBtnDetails = self:getChildGO("mBtnDetails")
    self.mSkillTrans = self:getChildTrans("mSkillTrans")
    self.mModelClicker = self:getChildGO("mClickerArea")
    self.mDangerousTrans = self:getChildTrans("mDangerousTrans")
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtInfo = self:getChildGO("mTxtInfo"):GetComponent(ty.Text)
    self.mTxtHigh = self:getChildGO("mTxtHigh"):GetComponent(ty.Text)
    self.mTxtSpeed = self:getChildGO("mTxtSpeed"):GetComponent(ty.Text)
    self.mTxtHeavy = self:getChildGO("mTxtHeavy"):GetComponent(ty.Text)
    self.mTxtSkill = self:getChildGO("mTxtSkill"):GetComponent(ty.Text)
    self.mTxtDamage = self:getChildGO("mTxtDamage"):GetComponent(ty.Text)
    self.mTxtDefense = self:getChildGO("mTxtDefense"):GetComponent(ty.Text)
    self.mTxtHighDec = self:getChildGO("mTxtHighDec"):GetComponent(ty.Text)
    self.mTxtElement = self:getChildGO("mTxtElement"):GetComponent(ty.Text)
    self.mImgJob = self:getChildGO("mImgJob"):GetComponent(ty.AutoRefImage)
    self.mTxtAbstract = self:getChildGO("mTxtAbstract"):GetComponent(ty.Text)
    self.mTxtAttRange = self:getChildGO("mTxtAttRange"):GetComponent(ty.Text)
    self.mTxtFeatures = self:getChildGO("mTxtFeatures"):GetComponent(ty.Text)
    self.mTxtHeavyDec = self:getChildGO("mTxtHeavyDec"):GetComponent(ty.Text)
    self.mTxtSpeedDec = self:getChildGO("mTxtSpeedDec"):GetComponent(ty.Text)
    self.mTxtDamageDec = self:getChildGO("mTxtDamageDec"):GetComponent(ty.Text)
    self.mTxtSerialNum = self:getChildGO("mTxtSerialNum"):GetComponent(ty.Text)
    self.mTxtElementDec = self:getChildGO("mTxtElementDec"):GetComponent(ty.Text)
    self.mTxtDefenseDec = self:getChildGO("mTxtDefenseDec"):GetComponent(ty.Text)
    self.mTxtWeaknessDec = self:getChildGO("mTxtWeaknessDec"):GetComponent(ty.Text)
    self.mImgElement = self:getChildGO("mImgElement"):GetComponent(ty.AutoRefImage)
    self.mTxtAttRangeDec = self:getChildGO("mTxtAttRangeDec"):GetComponent(ty.Text)
    self.mTxtFeaturesDec = self:getChildGO("mTxtFeaturesDec"):GetComponent(ty.Text)
    self.mTxtSerialNumDec = self:getChildGO("mTxtSerialNumDec"):GetComponent(ty.Text)
    self.mTxtDangerousDec = self:getChildGO("mTxtDangerousDec"):GetComponent(ty.Text)
    self.mTxtAbstractDec = self:getChildGO("mTxtAbstractDec"):GetComponent(ty.Text)
end

--激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList()
    self.mShowModel = args.model
    self.mIndex = manual.ManualManager:getCurIndexByModel(args.model, manual.ManualManager:getLastIndex())
    self:updateBtnState()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:recoverModel(true)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnDetails, self.onClickOpenDetailsView)
    self:addUIEvent(self.mBtnNext, self.onClickNextModelHandler)
    self:addUIEvent(self.mBtnLast, self.onClickLastModelHandler)
end

function initViewText(self)
    self.mTxtAbstract.text = _TT(70088)--"简介"
    self.mTxtSkill.text = _TT(1041) --"技能"
    self.mTxtHighDec.text = _TT(70089)--"高         度："
    self.mTxtHeavyDec.text = _TT(70090)--"重         量："
    self.mTxtFeaturesDec.text = _TT(70091)--"特         性："
    self.mTxtSerialNumDec.text = _TT(70092)-- "编         号："
    self.mTxtSpeedDec.text = _TT(70093)--"移动速度："
    self.mTxtDamageDec.text = _TT(70094)--"伤害系数："
    self.mTxtElementDec.text = _TT(70095)--"元素属性："
    self.mTxtDefenseDec.text = _TT(70096)--"防御系数："
    self.mTxtAttRangeDec.text = _TT(70097)--"攻击范围："
    self.mTxtDangerousDec.text = _TT(70098)--"危险级别："
    self.mTxtWeaknessDec.text = _TT(70085)--"弱         点："
    self:setBtnLabel(self.mBtnDetails, 25027, "详情")
end
function updateView(self, dataVo)
    if dataVo then
        self:clearStar()
        self:clearSkill()
        self.mTxtName.text = dataVo.name
        self.mTxtAbstractDec.text = dataVo.story
        self.mTxtSerialNum.text = dataVo.manualId
        self.mTxtHigh.text = dataVo.stature
        self.mTxtDefense.text = dataVo.defense
        self.mTxtHeavy.text = dataVo.weight
        self.mTxtDamage.text = dataVo.atk
        self.mTxtFeatures.text = dataVo.special
        self.mTxtAttRange.text = dataVo.range
        self.mTxtSpeed.text = dataVo.speed
        local color, name = hero.getHeroTypeName(dataVo:getElement())
        self.mTxtElement.text = HtmlUtil:color(name, color)
        self.mImgElement:SetImg(UrlManager:getHeroEleTypeIconUrl2(dataVo:getElement()), true)
        for index, eleType in ipairs(dataVo:getWeekPoint()) do
            self:getChildGO("mImgWeakness" .. index):SetActive(true)
            self:getChildGO("mImgWeakness" .. index):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getHeroEleTypeIconUrl2(eleType), true)
        end
        self.mImgJob:SetImg(UrlManager:getMonsterJobSmallIconUrl(dataVo.professionType, false))
        for i = 1, dataVo:getDangerousrating() do
            local imgDangerous = SimpleInsItem:create(self:getChildGO("mImgStar"), self.mDangerousTrans, "mDangerousStar")
            table.insert(self.mImgStarList, imgDangerous)
        end
        for _, skillId in ipairs(dataVo.skillList) do
            local skillGridItem = SkillGrid:create(self.mSkillTrans, { skillId = skillId, heroVo = dataVo }, 0.55, false, nil)
            skillGridItem:setDetailVisible(false)
            skillGridItem:setNameVisible(false)
            skillGridItem:setCallBack(self, function()
                TipsFactory:skillTips(nil, skillId, dataVo, true)
            end)
            table.insert(self.mSkillGridList, skillGridItem)
        end
        self:updateModelView(dataVo)
        gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self:getChildTrans("mGroupTxt")) --立即刷新
        gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self:getChildTrans("Content"))
    end
end
--打开详情页面
function onClickOpenDetailsView(self)

end
--下一个
function onClickNextModelHandler(self)
    self:updateBtnState(1)
end
--上一个
function onClickLastModelHandler(self)
    self:updateBtnState(-1)
end

function updateBtnState(self, dir)
    local curIndex = self.mIndex
    local data = manual.ManualManager:getTypeHasFightMonsterList(manual.ManualManager:getLastIndex())
    if dir == 1 and data[curIndex + 1] then
        self.mIndex = curIndex + 1
        curIndex = self.mIndex
    elseif dir == -1 and data[curIndex - 1] then
        self.mIndex = curIndex - 1
        curIndex = self.mIndex
    end
    if data[curIndex] then
        self.mBtnLast:SetActive(true)
        self.mBtnNext:SetActive(true)
        self.mShowModel = data[curIndex].model
        self:updateView(data[curIndex])
    end

    if (not data[curIndex + 1]) and (not data[curIndex - 1]) then
        self.mBtnNext:SetActive(false)
        self.mBtnLast:SetActive(false)
        return
    elseif not data[curIndex + 1] then
        self.mBtnNext:SetActive(false)
    elseif not data[curIndex - 1] then
        self.mBtnLast:SetActive(false)
    end
    if data[curIndex]:getIsNew() then
        GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, { type = ReadConst.MANUAL_MONSTER, id = data[curIndex].id })
    end
end
-- 更新模型
function updateModelView(self, data)
    self:recoverModel(false)
    local configVo = manual.ManualManager:getMonsterConfigVo(data.model)
    if (configVo) then
        local monsterConfigVo = monster.MonsterManager:getMonsterConfigVoByModel(configVo.model)
        self.mModelPlayer:setModelData(configVo.model, true, false, nil, true, MainCityConst.ROLE_MODE_MANUAL_MONSTER, UrlManager:getBgPath("manual/monster_info_bg.png"), self.mModelClicker, true, nil)

        --self.mModelPlayer:setScale(configVo.size / 100)
        --gs.TransQuick:LPosX(self.mModelPlayer.transform, -10)
    else
        self:recoverModel(false)
    end
end
--删除星星
function clearStar(self)
    if #self.mImgStarList > 0 then
        for _, v in ipairs(self.mImgStarList) do
            v:poolRecover()
        end
        self.mImgStarList = {}
    end
end
--删除技能
function clearSkill(self)
    if #self.mSkillGridList > 0 then
        for _, vo in ipairs(self.mSkillGridList) do
            vo:poolRecover()
        end
        self.mSkillGridList = {}
    end
end
--删除模型
function recoverModel(self, isResetMaincity)
    self.mModelPlayer:reset(isResetMaincity)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]