module("favorable.FavorableLevelUpPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("favorable/FavorableLevelUpPanel.prefab")
destroyTime = -1 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.m_itemList = {}
    self.m_rewardList = {}
    self.tweenTimeSn={}
end

function configUI(self)
    super.configUI(self)
    self.Content = self:getChildTrans("Content")
    self.RewardItem = self:getChildGO("RewardItem")
    self.FavorableAttrItem = self:getChildGO("FavorableAttrItem")
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mLvNumTxt1 = self:getChildGO("LvNumTxt1"):GetComponent(ty.Text)
    self.mLvNumTxt2 = self:getChildGO("LvNumTxt2"):GetComponent(ty.Text)
    self.mFavorableTxt = self:getChildGO("FavorableTxt"):GetComponent(ty.Text)
    self.anim = self.UIObject:GetComponent(ty.Animator)
end

function active(self, args)
    super.active(self, args)
    self:show()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtTitle.text = _TT(41724)--信赖提升
    self.mFavorableTxt.text = _TT(41720) --"亲密度"
end

function show(self)
    self.m_oldHeroVo = favorable.FavorableManager:getOldHeroVo()
    self.m_curHeroVo = hero.HeroManager:getHeroVo(self.m_oldHeroVo.id)
    self.mLvNumTxt1.text = self.m_oldHeroVo.favorableLevel
    self.mLvNumTxt2.text = self.m_curHeroVo.favorableLevel

    if self.m_oldHeroVo.attrList then
        local time = 1.4
        for i = 1, #self.m_oldHeroVo.attrList do
            local attrVo = self.m_oldHeroVo.attrList[i]
            if (attrVo.value ~= self.m_curHeroVo.attrDic[attrVo.key]) then
                local item = SimpleInsItem:create(self.FavorableAttrItem, self.Content, "FavorableLevelUpPanelFavorableAttrItem")
                local textAttrName = item:getChildGO("TextAttrName"):GetComponent(ty.Text)
                local textCurAttrValue = item:getChildGO("TextCurAttrValue"):GetComponent(ty.Text)
                local textNextAttrValue = item:getChildGO("TextNextAttrValue"):GetComponent(ty.Text)
                textAttrName.text = AttConst.getName(attrVo.key)
                textCurAttrValue.text = AttConst.getValueStr(attrVo.key, attrVo.value)
                if (self.m_curHeroVo.attrDic and self.m_curHeroVo.attrDic[attrVo.key]) then
                    textNextAttrValue.text = AttConst.getValueStr(attrVo.key, self.m_curHeroVo.attrDic[attrVo.key])
                else
                    textNextAttrValue.text = _TT(1066)--"已最大"
                end
                item:getGo():SetActive(false)
                self.m_itemList[i] = item
                self:onTweenStart(time, i)
                time = time + 0.2
            end
        end

    end

    local addItem = {}
    local heroFavorableData = favorable.FavorableManager:getHeroFavorableData(self.m_oldHeroVo.tid)
    for lv, data in pairs(heroFavorableData.favorableData) do
        if lv > self.m_oldHeroVo.favorableLevel and lv <= self.m_curHeroVo.favorableLevel then
            local hasDes = false
            for i = 1, #addItem do
                if (addItem[i].des == data.des) then
                    hasDes = true
                    break
                end
            end
            if not hasDes and data.des ~= 0 then
                table.insert(addItem, data)
            end
        end
    end

    for i = 1, #addItem do
        local item = SimpleInsItem:create(self.RewardItem, self.Content)
        local rewardTxt = item:getChildGO("RewardTxt"):GetComponent(ty.Text)
        local typeText = item:getChildGO("TypeText"):GetComponent(ty.Text)
        rewardTxt.text = _TT(addItem[i].des)
        typeText.text = "其他"
        table.insert(self.m_rewardList, item)
    end
end

function onTweenStart(self, time, idx)
    self:recover(idx)
 
    if self.m_itemList[idx]:getGo()== nil then
        return
    end
    local function callTween()
        if (not gs.GoUtil.IsCompNull(self.m_itemList[idx]:getGo():GetComponent(ty.UIDoTween))) then
            if self.m_itemList[idx]:getGo() ~= nil then
                self.m_itemList[idx]:getGo():SetActive(true)
                self.m_itemList[idx]:getGo():GetComponent(ty.UIDoTween):BeginTween()
            end
        end
    end
    self.tweenTimeSn[idx] = LoopManager:addTimer(time, 1, self, callTween)
end

function recover(self, idx)
    local idxHelper = self.tweenTimeSn[idx]
    if idxHelper then
        LoopManager:removeTimerByIndex(self.tweenTimeSn[idx])
        self.tweenTimeSn[idx] = nil
    end
end

function __closeOpenAction(self)
    if (self.panelType ~= 1 and not self.isCloseing) then
        self.isCloseing = true
        local tweenTime = AnimatorUtil.getAnimatorClipTime(self.anim, "FavorableLevelUpPanel_Exit")
        gs.UIBlurManager.SetSuperBlur(false, self.UIRootNode, self:getUiNodeName(), self.blurTweenTime)

        if self.mBlurMask then
            gs.GameObject.Destroy(self.mBlurMask)
            self.mBlurMask = nil
        end
        if self.UIObject then
            self.anim:SetTrigger("exit")
            local _viewTweenFinishCall = function()
                if self.isPop == 1 then
                    self:close()
                end
            end
            self:addTimer(tweenTime, 1, _viewTweenFinishCall)
        end
    end
end

function deActive(self)
    super.deActive(self)
    -- self.anim:SetTrigger("exit")
    self:recover_02()
    for i = 1, #self.m_itemList do
        self.m_itemList[i]:poolRecover()
    end
    self.m_itemList = {}

    for i = 1, #self.m_rewardList do
        self.m_rewardList[i]:poolRecover()
    end
    self.m_rewardList = {}
end

function recover_02(self)
    for i = 1, #self.tweenTimeSn  do
        local idxHelper = self.tweenTimeSn[i]
        if idxHelper then
            LoopManager:removeTimerByIndex(self.tweenTimeSn[i])
            self.tweenTimeSn[i] = nil
        end
    end
    self.tweenTimeSn = {}
end
return _M

--[[ 替换语言包自动生成，请勿修改！
]]-----------