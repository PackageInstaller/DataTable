module('disaster.DisasterResultPanel', Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("disaster/DisasterResultPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isAdapta = 0
isBlur = 0 -- 是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

function ctor(self)
    super.ctor(self)
end

function configUI(self)
    super.configUI(self)

    self.mMask = self:getChildGO("mMask")
    -- self.mTextBossName = self:getChildGO("mTextBossName"):GetComponent(ty.Text)
    -- self.mTextBossStage = self:getChildGO("mTextBossStage"):GetComponent(ty.Text)
    self.mTxtRemHp = self:getChildGO("mTxtRemHp")
    self.mProgress = self:getChildGO("mProgress")
    self.mImgProgress = self:getChildGO("mImgProgress"):GetComponent(ty.Image)
    self.mTxtHp = self:getChildGO("mTxtHp"):GetComponent(ty.Text)
    self.mTxtDamage = self:getChildGO("mTxtDamage"):GetComponent(ty.Text)
    self.mTxtDamageCount = self:getChildGO("mTxtDamageCount"):GetComponent(ty.Text)
    self.mTxtDamageRound = self:getChildGO("mTxtDamageRound"):GetComponent(ty.Text)
    self.mTxtDamageRoundCount = self:getChildGO("mTxtDamageRoundCount"):GetComponent(ty.Text)

    self.mHpInfo = self:getChildGO("mHpInfo")

    self.mPreviewBtn = self:getChildGO("mPreviewBtn")
    -- self.mNewRecord = self:getChildGO("mNewRecord")
end

--[[
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtDamage.text = _TT(104020)
    self.mTxtDamageRound.text = _TT(104019)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mPreviewBtn, self.onPreviewClick)
end

function onPreviewClick(self)
    GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_PREVIEW_SHOW)
end

-- 激活
function active(self, args)
    super.active(self, args)
    self.datas = args
    self.mTxtDamageCount.text = "0" -- ,args.damage
    self.mTxtHp.text = args.now_hp .. "/" .. args.max_hp
    self.mImgProgress.fillAmount = args.now_hp / args.max_hp
    -- self.mTxtDamageMax.gameObject:SetActive(args.dupId == disaster.DisasterManager:getMaxDupId())
    self.mTxtDamageRoundCount.text = "0" -- args.hisDamage
    -- self.mNewRecord:SetActive(args.damage == args.hisDamage)

    self.mHpInfo:SetActive(args.dupId ~= disaster.DisasterManager:getMaxDupId())

    self.curTime = 0
    self.endTime = 2
    self.aniSn = LoopManager:addFrame(0, 0, self, self.onLoopAni)

    if #args.award >=1 then
        ShowAwardPanel_New:showPropsAwardMsg(args.award,nil)
    end
end

function onLoopAni(self)
    self.curTime = self.curTime + gs.Time.deltaTime
    if self.curTime <= self.endTime then
        self.mTxtDamageCount.text = math.floor(tonumber(self.datas.damage) * self.curTime / self.endTime)
        self.mTxtDamageRoundCount.text = math.floor(tonumber(self.datas.hisDamage) * self.curTime / self.endTime)
    else
        self:endCall()
    end
end

function endCall(self)
    self.mTxtDamageCount.text = self.datas.damage
    self.mTxtDamageRoundCount.text = self.datas.hisDamage
    self.mMask:SetActive(false)

    if self.aniSn then
        LoopManager:removeFrameByIndex(self.aniSn)
    end
    self.aniSn = nil
end
-- 非激活
function deActive(self)
    super.deActive(self)
    if self.aniSn then
        LoopManager:removeFrameByIndex(self.aniSn)
    end
    self.aniSn = nil
    -- guild.GuildManager:clearGuildBossFightDamage()
    self:sendFightOver()
end

-- 关闭界面发送通知
function sendFightOver(self)
    if not self.isLink then
        GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_PANEL_OVER, {
            isWin = false
        })
    end
end

return _M
