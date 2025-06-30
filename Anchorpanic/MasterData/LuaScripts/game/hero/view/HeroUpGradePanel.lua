module("hero.HeroUpGradePanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("hero/HeroUpGradePanel.prefab")
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗 3 不应用遮罩的常驻页面(事影循回)
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
isShowCloseAll = 0
--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle("战员升格")
    self:setBg("")
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.mCheckLvHelper = -1
    self.mSkillGridList = {}
    self.mDelayStartView = nil
    self.mDelaySkillView = nil
    --当前选中的星级
    self.selectedIdx = 1
    --特效管理
    self.mEffectList = {}
    --点击管理 
    self.mClickStarDic = {}
end

-- 玩家点击关闭
function onClickClose(self)
    super.onClickClose(self)
    self:playerClose()
end

-- 玩家关闭所有窗口的c#回调
function onCloseAllCall(self)
    super.onCloseAllCall(self)
    self:playerClose()
end

function playerClose(self)
    self:recoveryAll()
end

function configUI(self)
    super.configUI(self)
    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mTxtSkillName = self:getChildGO("mTxtSkillName"):GetComponent(ty.Text)
    self.mTxtSkillPosName = self:getChildGO("mTxtSkillPosName"):GetComponent(ty.Text)
    self.mTxtSkillDes = self:getChildGO("mTxtSkillDes"):GetComponent(ty.TMP_Text)
    self.mTxtSkillDesLink = self:getChildGO("mTxtSkillDes"):GetComponent(ty.TextMeshProLink)
    self.mTxtSkillDesLink:SetEventCall(notice.HrefUtil.commonTitleDesLinkData)
end

function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})
    self:adjust3DModleByResolution()
    self:setData(args.heroTid)
    if next(self.m_senceChildGos) then
        for i = 1, 6 do
            self.m_senceChildGos["mGroupItem_0" .. i]:GetComponent(ty.GoMouseEvent):SetCallFun(self, nil,
            function()
                self:onStarClickedhandler(i)
            end, nil, nil)
        end
    end
end

function deActive(self)
    super.deActive(self)
    self:recoveryAll()
    self:removeAllDelay()
    hero.HeroController:stopCurPlayCVData()
    MoneyManager:setMoneyTidList()
    UISceneBgUtil:reset()
    if (self.scene) then
        self.scene = nil
    end

end

function removeAllDelay(self)
    if (self.mDelayStartView) then
        LoopManager:removeFrameByIndex(self.mDelayStartView)
        self.mDelayStartView = nil
    end
    if (self.mDelaySkillView) then
        LoopManager:removeFrameByIndex(self.mDelaySkillView)
        self.mDelaySkillView = nil
    end
end

function initViewText(self)
    --"已激活"
end

function setData(self, curHeroTid)
    self.mClickStarDic = {}
    self.mCurHeroTid = curHeroTid
    self.maxStarLvl = hero.HeroStarManager:getHeroMaxStarLvl(self.mCurHeroTid)
    self:updateView()
end

function adjust3DModleByResolution(self)
    if not self.scene then
        self.scene = UISceneBgUtil:create3DBg("arts/sceneModule/ui_shengge/prefabs/ui_shengge_01.prefab")
    end
    self.m_senceChildGos, self.m_senceChildTrans = GoUtil.GetChildHash(self.scene)
    local mScreenRate = gs.Screen.height / gs.Screen.width
    if mScreenRate > 0.55 then
        gs.TransQuick:LPosZ(self.m_senceChildTrans["root"], 4.36)
    else
        gs.TransQuick:LPosZ(self.m_senceChildTrans["root"], 3.4)
    end
end

function updateView(self)
    self:recoveryAll()
    self:refreshText()
    self.mDelayStartView = LoopManager:addFrame(1, 1, self, self.updateStarView)
    self.mDelaySkillView = LoopManager:addFrame(2, 1, self, self.updateSkillView)

end

--更新星级显示
function updateStarView(self)
    self:recoverAllEffect()
    for i = 1, self.maxStarLvl do
        self:addEffect(hero.StarUpEffect.Deactived, self.m_senceChildTrans["mGroupItem_0" .. i])
    end
    self:onStarClickedhandler(1)

end

--点击星级回调
function onStarClickedhandler(self, idx)
    if self.mClickStarDic[idx] == nil then
        self.mClickStarDic[idx] = false
    end
    if self.mClickStarDic[idx] == false then
        self:removeEffect(hero.StarUpEffect.Selected)
        for i = 1, 6 do
            self.mClickStarDic[i] = i == idx
            if idx == i then
                self:addEffect(hero.StarUpEffect.Selected, self.m_senceChildTrans["mGroupItem_0" .. i])
                self.selectedIdx = idx
                self:updateSkillView()
            end
        end
    end
end

-- 更新选择显示的技能
function updateSkillView(self)
    local heroVo = hero.HeroManager:getHeroConfigVo(self.mCurHeroTid)
    local starDic = hero.HeroStarManager:getHeroStarDic(self.mCurHeroTid)
    local showIdx = self.selectedIdx
    self:recoverSkillGrid()
    for _, v in pairs(starDic) do
        if (showIdx == v.star) and (v.passiveSkillId > 0) then
            local skillVo = fight.SkillManager:getSkillRo(v.passiveSkillId)
            self.mTxtSkillName.text = skillVo:getName()
            self.mTxtSkillDes.text = skillVo:getDescTip()
            self.mTxtSkillPosName.text = _TT(1393, v.star)
            local skillGrid = SkillGrid:create(self:getChildTrans("mSkillNode"), { skillId = v.passiveSkillId, heroVo = heroVo }, 1, false)
            skillGrid:setDetailVisible(false)
            local rect = skillGrid.m_childTrans["ImgSkill"]:GetComponent(ty.RectTransform)
            gs.TransQuick:Scale(rect, 0.75, 0.75, 0.75)
            table.insert(self.mSkillGridList, skillGrid)
        end
    end

    if (self.mDelaySkillView) then
        LoopManager:removeFrameByIndex(self.mDelaySkillView)
        self.mDelaySkillView = nil
    end
end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.onClickClose)
end

function onClickFuncTipsHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FUNCTIPS_VIEW, { id = LinkCode.HeroStar })
end

function recoveryAll(self)
    self:recoverSkillGrid()
end


function refreshText(self)
    self.selectedIdx = 1
    self.mTxtSkillName.text = ""
    self.mTxtSkillDes.text = ""
    self.mTxtSkillPosName.text = ""
end

function recoverAllEffect(self)
    for _, effectName in pairs(hero.StarUpEffect) do
        self:removeEffect(effectName)
    end
end

function recoverSkillGrid(self)
    if (self.mSkillGridList) then
        for i = 1, #self.mSkillGridList do
            self.mSkillGridList[i]:poolRecover()
            self.mSkillGridList[i] = nil
        end
    end
    self.mSkillGridList = {}
end


--覆盖基类特效加载逻辑
function addEffect(self, effectName, parentTrans)
    local effectData = { effectSn = nil, effectName = nil, effectGo = nil }
    table.insert(self.mEffectList, effectData)
    local function _loadAysnCall(effectGo)
        if (effectGo) then
            local effectTrans = effectGo.transform
            effectData.effectGo = effectGo
            effectData.effectGo:SetActive(true)
            gs.TransQuick:SetParentOrg(effectTrans, parentTrans)
            gs.TransQuick:LPosXY(effectTrans, 0, 0)
        else
            if (effectName) then
                self:removeEffect(effectName)
            end

        end
    end
    effectData.effectName = effectName
    effectData.effectSn = gs.GOPoolMgr:GetAsyc(UrlManager:getUIEfxPath(string.format("%s.prefab", effectData.effectName)), _loadAysnCall)
end

-- 移除界面UI特效
function removeEffect(self, effectName)
    if next(self.mEffectList) then
        for i = #self.mEffectList, 1, -1 do
            local effectData = self.mEffectList[i]
            if effectData then
                if (effectName == nil or effectName == effectData.effectName) then
                    gs.GOPoolMgr:CancelAsyc(effectData.effectSn)
                    if (effectData.effectGo and not gs.GoUtil.IsGoNull(effectData.effectGo)) then
                        effectData.effectGo:SetActive(false)
                        gs.GOPoolMgr:Recover(effectData.effectGo, UrlManager:getUIEfxPath(string.format("%s.prefab", effectData.effectName)))
                    end
                    table.remove(self.mEffectList, i)
                end
            end
        end
        if (effectName == nil) then
            self.mEffectList = {}
            return true
        end

    end
    return false
end


return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(1321):	"货币不足"
	语言包: _TT(1320):	"成长"
	语言包: _TT(1319):	"预览星级"
	语言包: _TT(1318):	"当前星级"
	语言包: _TT(1053):	"该战员无法进化"
]]