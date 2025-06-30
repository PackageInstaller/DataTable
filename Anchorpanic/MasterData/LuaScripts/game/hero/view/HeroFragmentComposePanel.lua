--[[ 
-----------------------------------------------------
@filename       : HeroFragmentComposePanel
@Description    : 战员碎片合成界面
@date           : 2022-2-18 13:44:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("hero.HeroFragmentComposePanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("hero/HeroFragmentComposePanel.prefab")
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle("")

    self:setBg("common_bg_4110.jpg", false)
end

-- 初始化数据
function initData(self)
    self.mHeroTid = nil
    self.mHeroConfigVo = nil
end

function configUI(self)
    self.mBtnCvZh = self:getChildGO("mBtnCvZh")
    self.mBtnCvJp = self:getChildGO("mBtnCvJp")

    self.mBtnPre = self:getChildGO("mBtnPre")
    self.mBtnNext = self:getChildGO("mBtnNext")

    self.mImgHeroPic = self:getChildGO("mImgHeroPic"):GetComponent(ty.AutoRefImage)
    self.mImgColor = self:getChildGO("mImgColor"):GetComponent(ty.AutoRefImage)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)

    self.mTxtCvZh = self:getChildGO("mTxtCvZh"):GetComponent(ty.Text)
    self.mTxtCvJp = self:getChildGO("mTxtCvJp"):GetComponent(ty.Text)

    self.mTxtHeight = self:getChildGO("mTxtHeight"):GetComponent(ty.Text)
    self.mTxtWeight = self:getChildGO("mTxtWeight"):GetComponent(ty.Text)
    
    self.mScrollContent = self:getChildTrans("Content")
    self.mTxtContent = self:getChildGO("mTxtContent"):GetComponent(ty.Text)

    self.mTextFragment = self:getChildGO("mTextFragment"):GetComponent(ty.Text)
    self.mBtnCompose = self:getChildGO("mBtnCompose")
end

function active(self, args)
    super.active(self, args)
    self:setData(args.heroTid)
end

function deActive(self)
    super.deActive(self)
    self:stopCVAudio()
end

function initViewText(self)
    self:setBtnLabel(self.mBtnCompose, -1, "集结")
end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnCvZh, self.onClickZhVoiceHandler)
    self:addUIEvent(self.mBtnCvJp, self.onClickJpVoiceHandler)
    self:addUIEvent(self.mBtnPre, self.onClickHeroPreHandler)
    self:addUIEvent(self.mBtnNext, self.onClickHeroNextHandler)
    self:addUIEvent(self.mBtnCompose, self.onClickComposeHandler)
end

-- 设置货币栏
function setMoneyBar(self)
end

function onClickCloseHandler(self)
    self.onClickClose(self)
end

-- 停止cv播放
function stopCVAudio(self)
    if (self.isPlayIng) then
        -- Audio:stopCv()
    end
    self.isPlayIng = false
end

--中配cv
function onClickZhVoiceHandler(self)
    if self.isPlayIng then
        return
    end
    if self.mHeroConfigVo.zhCVId == 0 then
        -- gs.Message.Show('敬请期待')
        gs.Message.Show(_TT(1021))
        return
    end
    self.isPlayIng = true
    AudioManager:playHeroCV(self.mHeroConfigVo.zhCVId, function() self.isPlayIng = false end)
end

--日配cv
function onClickJpVoiceHandler(self)
    if self.isPlayIng then
        return
    end
    if self.mHeroConfigVo.jpCVId == 0 then
        -- gs.Message.Show('敬请期待')
        gs.Message.Show(_TT(1021))
        return
    end
    self.isPlayIng = true
    AudioManager:playHeroCV(self.mHeroConfigVo.zhCVId, function() self.isPlayIng = false end)
end

-- 点击前一个英雄
function onClickHeroPreHandler(self)
end

-- 点击后一个英雄
function onClickHeroNextHandler(self)
end

-- 点击英雄碎片合成
function onClickComposeHandler(self)
    local isCanUnLock = hero.HeroFlagManager:isHeroCanUnLock(self.mHeroConfigVo)
    if(isCanUnLock)then
        self:close()
        GameDispatcher:dispatchEvent(EventName.REQ_HERO_FRAGMENT_COMPOSE, {heroTid = self.mHeroConfigVo.tid})
    else
        gs.Message.Show(_TT(1322))
    end
end

function setData(self, cusHeroTid)
    self.mHeroTid = cusHeroTid
    self.mHeroConfigVo = hero.HeroManager:getHeroConfigVo(self.mHeroTid)
    self:updateBtnState()
    self:updateView()
end

function updateView(self)
    if (self.mHeroConfigVo) then
        self.mImgHeroPic:SetImg(UrlManager:getBgPath(string.format("heroRecord/record_pic_%s.png", self.mHeroTid)), true)

        self.mImgColor:SetImg(UrlManager:getHeroColorCharacterIconUrl_2(self.mHeroConfigVo.color), true)
        self.mTxtName.text = self.mHeroConfigVo.name

        self.mTxtCvZh.text = _TT(1015, self.mHeroConfigVo.zhCVName)--"中："
        self.mTxtCvJp.text = _TT(1016, self.mHeroConfigVo.jpCVName)--"日："

        self.mTxtHeight.text = _TT(1017, self.mHeroConfigVo.stature)--"身高："
        self.mTxtWeight.text = _TT(1018, self.mHeroConfigVo.weight)--"体重："

        self.mScrollContent.anchoredPosition = gs.Vector2.zero
        self.mTxtContent.text = self.mHeroConfigVo.life

        gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mScrollContent)--立即刷新
        gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mTxtContent:GetComponent(ty.RectTransform))--立即刷新

        local propsConfigVo = props.PropsManager:getPropsConfigVo(self.mHeroConfigVo.needFragment[1])
        local hasCount = bag.BagManager:getPropsCountByTid(self.mHeroConfigVo.needFragment[1])
        local needCount = self.mHeroConfigVo.needFragment[2]
        self.mTextFragment.text = string.format("%s：%s/%s", propsConfigVo.name, HtmlUtil:color(hasCount, hasCount >= needCount and ColorUtil.GREEN_NUM or ColorUtil.RED_NUM), needCount)
    end
end

function updateBtnState(self)
    local heroId = hero.HeroFlagManager:getConfigId(self.mHeroConfigVo.tid)
    local isFlag = hero.HeroFlagManager:getFlag(heroId, hero.HeroFlagManager.FLAG_CAN_FRAGMENT_COMPOSE)
    if (isFlag) then
        RedPointManager:add(self.mBtnCompose.transform, nil, 106, 27)
    else
        RedPointManager:remove(self.mBtnCompose.transform)
    end
    self.mBtnPre:SetActive(false)
    self.mBtnNext:SetActive(false)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(1322):	"材料不足"
]]
