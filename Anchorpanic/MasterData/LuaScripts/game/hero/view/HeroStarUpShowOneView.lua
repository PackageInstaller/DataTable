--[[ 
-----------------------------------------------------
@filename       : RecruitShowOneView
@Description    : 招募单人展示
@date           : 2021-03-23 16:38:46
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('hero.HeroStarUpShowOneView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("hero/HeroStarUpShowOneView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 0
isAdapta = 1 --是否开启适配刘海
isScreensave = 0

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function initData(self)
end

-- 初始化
function configUI(self)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mImgPosIcon = self:getChildGO("mImgPosIcon"):GetComponent(ty.AutoRefImage)
    self.mImgHeroIcon = self:getChildGO("mImgHeroIcon"):GetComponent(ty.AutoRefImage)
    self.mImgHeroIcon_bg = self:getChildGO("mImgHeroIcon_bg"):GetComponent(ty.AutoRefImage)
    -- 获得重复英雄转化相关
    self.mGroupConvert = self:getChildGO("mGroupConvert")
    self.mImgConvert = self:getChildGO("mImgConvert")
    self.mConvertContent = self:getChildTrans("mConvertContent")
    self.mImgEleBg = self:getChildGO("mImgEleBg")
    self.mImgEleType = self:getChildGO("mImgEleType"):GetComponent(ty.AutoRefImage)
    -- self.mTextDesc = self:getChildGO("mTextDesc"):GetComponent(ty.Text)
    self.mAnimator = self.UIObject:GetComponent(ty.Animator)
    self.mImgClick = self:getChildGO("mImgClick")
    self.mImgClick:SetActive(false)
    
    self.mFx_01 = self:getChildGO("mFx_01")
    self.mFx_02 = self:getChildGO("mFx_02")
    self.mFx_03 = self:getChildGO("mFx_03")
    self.mFx_02_02 = self:getChildGO("mFx_02_02")
    self.mFx_03_03 = self:getChildGO("mFx_03_03")
end

-- 设置全屏透明遮罩
function setMask(self)
    super.setMask(self)

    self:setGuideTrans("guide_heroStarUpOneView_CloseBtn", self.mask.transform)
end

--激活
function active(self, heroInfo)
    super.active(self)

    gs.Time.timeScale = 1
    self.heroTid = heroInfo.tid

    self.isNoSkip = heroInfo.isNoSkip ~= nil and heroInfo.isNoSkip or false
    self.heroConfigVo = hero.HeroManager:getHeroConfigVo(self.heroTid)

    AudioManager:playSoundEffect("arts/audio/UI/basic/ui_gain.prefab")
    if not self.heroConfigVo then
        logError('==========配置没有战员tid:' .. self.heroTid)
        return
    end

    self:updateView()


end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self.m_childGos["mImgHeroIcon_bg"]:SetActive(false)
    LoopManager:removeTimerByIndex(self.tweenTImeSn)
    self:recoverAllStars()
    self.mFx_01:SetActive(false)
    self.mFx_02:SetActive(false)
    self.mFx_03:SetActive(false)
    self.mFx_02_02:SetActive(false)
    self.mFx_03_03:SetActive(false)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)

end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    -- self:addUIEvent(self.mSkip, self.onSkip)
    -- self:addUIEvent(self.mImgClick, self.onClickClose)
end

-- function onClickClose(self)
--     super.onClickClose(self)
-- end

-- function onSkip(self)
--     super.close(self)
--     GameDispatcher:dispatchEvent(EventName.RECRUIT_SKIP)
-- end

function updateView(self)
    self.mTxtName.text = self.heroConfigVo.name
    -- self.mSkip:SetActive(not self.isNoSkip)

    self.mImgPosIcon:SetImg(UrlManager:getHeroJobSmallIconUrl(self.heroConfigVo.professionType), false)
    self.mImgHeroIcon:SetImg(UrlManager:getBgPath(string.format("heroRecord/record_pic_%s.png", self.heroConfigVo.showModel)), true)
    self.mImgHeroIcon_bg:SetImg(UrlManager:getBgPath(string.format("heroRecord/record_pic_%s.png", self.heroConfigVo.showModel)), true)

    if self.heroConfigVo.eleType >= 0 then
        self.mImgEleType.gameObject:SetActive(true)
        self.mImgEleType:SetImg(UrlManager:getHeroEleTypeIconUrl(self.heroConfigVo.eleType), false)
    else
        self.mImgEleType.gameObject:SetActive(false)
    end
    self:recoverAllStars()
    if not self.mStarGroup then
        self.mStarGroup = self:getChildTrans("QualityGroup")
    end
    self.evolutionLvl = hero.HeroManager:getHeroVoByTid(self.heroTid).evolutionLvl
    for i = 1, self.evolutionLvl do
        self.mStarItem[i] = SimpleInsItem:create(self.m_childGos["mImgStar"], self.mStarGroup, "HeroStarUpShowOneView_HeroStarItem")
    end
    if self.mStarItem[1] then
        self.mStarItem[1]:getGo():SetActive(false)
        --音效延迟至最高级出现时播放
        self:setTimeout(0.9, function()
            AudioManager:playSoundEffect("arts/audio/UI/recruit/ui_recruit_show01.prefab")
        end)

        self.tweenTImeSn = LoopManager:addTimer(1.2, 1, self, function()

            self.mStarItem[1]:getGo():SetActive(true)
            self.mStarItem[1]:getGo():GetComponent(ty.UIDoTween):BeginTween()
            self.mStarItem[1].m_childGos["UIParticle"]:SetActive(true)
        end)
    end

    -- 品质色
    if self.heroConfigVo.color - 1 == 1 then
        self.mFx_01:SetActive(true)
    elseif self.heroConfigVo.color - 1 == 2 then
        self.mFx_02:SetActive(true)
        self.mFx_02_02:SetActive(true)
    elseif self.heroConfigVo.color - 1 == 3 then
        self.mFx_03:SetActive(true)
        self.mFx_03_03:SetActive(true)
    end

    self.mImgClick:SetActive(true)
    self:addTimerClick()
end


function addTimerClick(self)
    local time = sysParam.SysParamManager:getValue(77) / 1000
    self:setTimeout(time, function()
        self.mImgClick:SetActive(false)
    end)
end


function recoverAllStars(self)
    if self.mStarItem and next(self.mStarItem) then
        for _, item in pairs(self.mStarItem) do
            item:poolRecover()
        end
    end
    self.mStarItem = {}
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(571):	"已转化"
]]