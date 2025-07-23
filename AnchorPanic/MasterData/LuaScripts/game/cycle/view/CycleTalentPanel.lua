module("cycle.CycleTalentPanel", Class.impl(View))
-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("cycle/CycleTalentPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isShow3DBg = 1

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(4550))
    self:setBg("")

    self:setUICode(LinkCode.Cycle)
end

-- 析构
function dtor(self)
end

function initData(self)
    self.isOpenTips = false
    self.mCurDifficulty = nil
    self.mNowSelectTalentId = 0
    self.fx = nil
end

function getAdaptaTrans(self)
    return self.base_childTrans["mGroupTop"]
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mTalentItems = {}
    for i=1, 40 do
        table.insert(self.mTalentItems, self:getChildGO("mTalentItem"..i))
        self:setGuideTrans("guide_Talent_item_" .. i, self:getChildTrans("mTalentItem"..i))
    end
    self.mTalentLines = {}
    for i=2, 40 do
        self.mTalentLines[i] = self:getChildGO("mImgLine"..i):GetComponent(ty.CanvasGroup)
    end
    self.mTalentProgress = self:getChildGO("mTalentProgress")
    self.mTxtProgress = self:getChildGO("mTxtProgress"):GetComponent(ty.Text)
    self.mTxtHasTalent = self:getChildGO("mTxtHasTalent"):GetComponent(ty.Text)
    self.mEmptyClick = self:getChildGO("mEmptyClick")

    ------------------------------ Tip --------------------------------
    self.mTalentTip = self:getChildGO("mTalentTip")
    self.mIconTalent = self:getChildGO("mIconTalent"):GetComponent(ty.AutoRefImage)
    self.mTxtTalentName = self:getChildGO("mTxtTalentName"):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    self.mBtnActive = self:getChildGO("mBtnActive")
    self.mTxtNeedTalent = self:getChildGO("mTxtNeedTalent"):GetComponent(ty.Text)
    self.mTxtCannotUnlock = self:getChildGO("mTxtCannotUnlock"):GetComponent(ty.Text)
    self.mHasActive = self:getChildGO("mHasActive")

    self.mTipsAni = self.mTalentTip:GetComponent(ty.Animator)

    self.mBtnTipsTalent = self:getChildGO("mBtnTipsTalent")

    self.mBtnHideTipsTalent = self:getChildGO("mBtnHideTipsTalent")
    self.mTipsTalent = self:getChildGO("mTipsTalent")
    self.mTitleTalent = self:getChildGO("mTitleTalent"):GetComponent(ty.Text)
    self.mDesTalent = self:getChildGO("mDesTalent"):GetComponent(ty.Text)


    self:setGuideTrans("guide_Talent_Progress", self.mTalentProgress.transform)
    self:setGuideTrans("guide_Talent_TalentPoint", self:getChildTrans("mBgTalentPoint"))
end

-- 激活
function active(self)
    super.active(self)
    self.mTalentTip:SetActive(false)
    MoneyManager:setMoneyTidList({})
    GameDispatcher:addEventListener(EventName.UPDATE_TALENT_PANEL, self.updateView, self)
    self.isOpenTips = false
    self:updateView()
    self:loadFx()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTitleTalent.text = _TT(77843)
    self.mDesTalent.text = _TT(77844)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mEmptyClick, self.onClickEmptyHandler)
    self:addUIEvent(self.mBtnActive, self.onReqUnlockTalent)
    self:addUIEvent(self.mTalentProgress, self.onOpenCongnitionPanelHandler)

    self:addUIEvent(self.mBtnTipsTalent,function ()
        self.mTipsTalent:SetActive(true)
    end)

    self:addUIEvent(self.mBtnHideTipsTalent,function ()
        self.mTipsTalent:SetActive(false)
    end)
end

function onClickEmptyHandler(self)
    if self.mNowSelectTalentId ~= 0 then
        if self.mNowSelectTalentId ~= nil and self.mNowSelectTalentId > 0 then 
            self.mTalentItems[self.mNowSelectTalentId].transform:Find("mImgCanUnlock"):GetComponent(ty.UIDoTween):BeginTween()
        end

        self.mNowSelectTalentId = 0
        self:updateSelect()
        self.mTalentTip:SetActive(false)

    end
end

function onOpenCongnitionPanelHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_TALENT_CONGNITION_PANEL)
end

function onReqUnlockTalent(self)
    local configVo = cycle.CycleTalentManager:getTalentConfig(self.mNowSelectTalentId)
    local isCanUnLock = true
    for k,v in pairs(configVo.preId) do
        isCanUnLock = cycle.CycleTalentManager:getTalentIsUnlock(v)
        if isCanUnLock then
            break
        end
    end
    if isCanUnLock == false then 
        gs.Message.Show(_TT(27595))
        return
    end

    local needTalentPoint = configVo.needTalent
    if cycle.CycleTalentManager:getTalentPoint() >= needTalentPoint then 
        GameDispatcher:dispatchEvent(EventName.REQ_UNLOCK_TALENT, self.mNowSelectTalentId)
        self.fx.transform:SetParent(self.mTalentItems[self.mNowSelectTalentId].transform, false)
        self.fx:SetActive(false)
        self.fx:SetActive(true)
    else
        gs.Message.Show(_TT(27596))
    end
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_TALENT_PANEL, self.updateView, self)
    if self.fx then 
        gs.GOPoolMgr:Recover(self.fx, self.fxName)
        self.fx = nil
    end
end

function loadFx(self)
    if self.fx == nil then
        self.fxName = "arts/fx/ui/effect/fx_ui_activation.prefab"
        self.fx = gs.ResMgr:LoadGO(self.fxName)
        self.fx:SetActive(false)
        self.fx.transform:SetParent(self.UITrans, false)
    end
end

function updateView(self)
    for i=1, 40 do
        local configVo = cycle.CycleTalentManager:getTalentConfig(i)
        local unlock = cycle.CycleTalentManager:getTalentIsUnlock(i)
        local canvasGroup = self.mTalentItems[i].transform:Find("mGroup"):GetComponent(ty.CanvasGroup)
        local icon = self.mTalentItems[i].transform:Find("mGroup/mImgBg/mIconTalent"):GetComponent(ty.AutoRefImage)
        local nameBg = self.mTalentItems[i].transform:Find("mGroup/mNameBg").gameObject
        local txtName = nameBg.transform:Find("mTxtName"):GetComponent(ty.Text)
        local select = self.mTalentItems[i].transform:Find("mImgSelect").gameObject
        local canBeUnlock = self.mTalentItems[i].transform:Find("mImgCanUnlock").gameObject
        local canBeTween = canBeUnlock:GetComponent(ty.UIDoTween)

        canvasGroup.alpha = unlock and 1 or 0.3
        if i > 1 then 
            self.mTalentLines[i].alpha = unlock and 1 or 0.3
        end
        nameBg:SetActive(unlock)
        txtName.text = _TT(configVo.title)
        icon:SetImg(UrlManager:getIconPath(configVo.icon))
        select:SetActive(i == self.mNowSelectTalentId)

        local isCanUnLock = true
        if i ~= 1 then 
            if unlock then 
                isCanUnLock = false
            else
                for k,v in pairs(configVo.preId) do
                    isCanUnLock = cycle.CycleTalentManager:getTalentIsUnlock(v)
                    if isCanUnLock then
                        break
                    end
                end
                local needTalentPoint = configVo.needTalent
                if cycle.CycleTalentManager:getTalentPoint() < needTalentPoint then
                    isCanUnLock = false
                end
            end
        else
            isCanUnLock = not unlock
        end
        canBeUnlock:SetActive(isCanUnLock)

        local onClickItem = function()
            if self.mNowSelectTalentId == i then 
                self.mNowSelectTalentId = 0 
                self.mTalentTip:SetActive(false)
                self.isOpenTips = false
            else
                local lastSelect = self.mNowSelectTalentId
                self.mNowSelectTalentId = i
                self:openTalentTip(configVo, unlock, isCanUnLock, lastSelect == 0)

                canBeTween:EndTween()
                canBeUnlock:GetComponent(ty.CanvasGroup).alpha = 1
                if lastSelect > 0 then 
                    self.mTalentItems[lastSelect].transform:Find("mImgCanUnlock"):GetComponent(ty.UIDoTween):BeginTween()
                end
            end
            self:updateSelect()
        end
        self:addUIEvent(self.mTalentItems[i], onClickItem)
        if self.isOpenTips and i == self.mNowSelectTalentId then 
            self:openTalentTip(configVo, unlock, isCanUnLock)
        end
        table.insert(self.mTalentItems, self:getChildGO("mTalentItem"..i))
    end

    self.mTxtProgress.text = cycle.CycleTalentManager:getUnlockNum() .. "/" .. 40
    self.mTxtHasTalent.text = cycle.CycleTalentManager:getTalentPoint()
end

function openTalentTip(self, talentVo, unlock, isCanUnLock, firstOpen)

    self.mIconTalent:SetImg(UrlManager:getIconPath(talentVo.icon))
    self.mTxtTalentName.text = _TT(talentVo.title)
    self.mTxtDes.text = _TT(talentVo.des)
    self.mBtnActive:SetActive(isCanUnLock and not unlock)
    self.mTxtNeedTalent.text = talentVo.needTalent
    self.mTalentTip:SetActive(true)
    if self.mTipsAni and not firstOpen then 
        self.mTipsAni:SetTrigger("show")
    end
    self.isOpenTips = true

    local needTalentPoint = talentVo.needTalent
    local preUnlock = false
    for k,v in pairs(talentVo.preId) do
        preUnlock = cycle.CycleTalentManager:getTalentIsUnlock(v)
        if preUnlock then
            break
        end
    end
    if preUnlock and cycle.CycleTalentManager:getTalentPoint() < needTalentPoint then
        self.mTxtCannotUnlock.text = _TT(27597, needTalentPoint) --"需要" ..  .. "点天赋点解锁"
    else
        self.mTxtCannotUnlock.text = _TT(27598)
    end
    self.mTxtCannotUnlock.gameObject:SetActive(not isCanUnLock)
    self.mHasActive:SetActive(unlock)
end

function updateSelect(self)
    for i=1, 40 do
        local select = self.mTalentItems[i].transform:Find("mImgSelect").gameObject
        select:SetActive(i == self.mNowSelectTalentId)
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(27598):	"需要激活前置天赋"
	语言包: _TT(27596):	"天赋点不足"
	语言包: _TT(27595):	"解锁条件不足"
	语言包: _TT(27589):	"天赋"
]]
