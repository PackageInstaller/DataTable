--[[ 
-----------------------------------------------------
@filename       : CycleShowOnePanel
@Description    : 招募单人展示
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('cycle.CycleShowOnePanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("cycle/CycleShowOnePanel.prefab")

destroyTime = -1 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 0
isAdapta = 1 --是否开启适配刘海
isScreensave = 0

-- 取父容器
function getParentTrans(self)
    return GameView.msg
end

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
    self.mImgNew = self:getChildGO("mImgNew")
    self.mImgEleBg = self:getChildGO("mImgEleBg")
    self.mImgEleType = self:getChildGO("mImgEleType"):GetComponent(ty.AutoRefImage)
    self.mTextDesc = self:getChildGO("mTextDesc"):GetComponent(ty.Text)
    self.mAnimator = self.UIObject:GetComponent(ty.Animator)
    self.mImgClick = self:getChildGO("mImgClick")
    self.mImgClick:SetActive(false)

    -- 品质特效
    self.mFx_01 = self:getChildGO("mFx_01")
    self.mFx_02 = self:getChildGO("mFx_02")
    self.mFx_03 = self:getChildGO("mFx_03")
    self.mFx_02_02 = self:getChildGO("mFx_02_02")
    self.mFx_03_03 = self:getChildGO("mFx_03_03")
end

--激活
function active(self, args)
    super.active(self, args)
    gs.Time.timeScale = 1
    local heroVo = hero.HeroManager:getHeroVo(args.heroId)
    self.heroTid = heroVo.tid
    self.isNoSkip = false
    self.isNoSkip = args.isNoSkip ~= nil and args.isNoSkip or false
    self.heroConfigVo = hero.HeroManager:getHeroConfigVo(self.heroTid)

    local vo = fashion.FashionManager:getHeroWearingFashionVo(fashion.Type.CLOTHES, heroVo.id)
    self.fashionVo = fashion.FashionManager:getHeroFashionConfigVo(fashion.Type.CLOTHES, self.heroTid, vo.fashionId)

    --self.fashionVo = fashion.FashionManager:getHeroWearingFashionVo(fashion.Type.CLOTHES, args.heroId)

    if not self.heroConfigVo then
        logError('==========配置没有战员tid:' .. self.heroTid)
        return
    end
    self:updateView()
    AudioManager:playSoundEffect("arts/audio/UI/recruit/ui_recruit_show01.prefab")
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    if self.mCvAudioData then
        AudioManager:stopAudioSound(self.mCvAudioData)
        self.mCvAudioData = nil
    end
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

    self:addUIEvent(self.mImgClick, self.onClickClose)
end

function onClickClose(self)
    super.onClickClose(self)
end


function updateView(self)
    self.mTxtName.text = self.heroConfigVo.name
    self.mImgPosIcon:SetImg(UrlManager:getHeroJobSmallIconUrl(self.heroConfigVo.professionType), false)
    self.mImgHeroIcon:SetImg(UrlManager:getBgPath(string.format("heroRecord/%s", self.fashionVo.imgbody)), true)
    self.mImgHeroIcon_bg:SetImg(UrlManager:getBgPath(string.format("heroRecord/%s", self.fashionVo.imgbody)), true)

    if self.heroConfigVo.eleType >= 0 then
        self.mImgEleType.gameObject:SetActive(true)
        self.mImgEleType:SetImg(UrlManager:getHeroEleTypeIconUrl(self.heroConfigVo.eleType), false)
    else
        self.mImgEleType.gameObject:SetActive(false)
    end

    local isNew = table.empty(self.propsList)


    for i = 1, 3 do
        self.m_childGos["mImgQuality_" .. i]:SetActive(self.heroConfigVo.color - 1 == i)
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
    self.mImgClick:SetActive(false)

    self:refreshHeroCv()

end

--更新Cv
function refreshHeroCv(self)
    local cv_id = self.heroConfigVo.recruit_voice
    self.mCvConfigData = AudioManager:getCVData(cv_id)
    if self.mCvConfigData then
        self.mCvAudioData = AudioManager:playCvByCVPath(UrlManager:getCVSoundPath(self.mCvConfigData.voice), function()
            self.mCvAudioData = nil
        end)

        local CharLength = string.toCharArray(self.mCvConfigData.lines)
        local charIndex = 1
        local str = CharLength[charIndex]
        self.mTextDesc.text = str

        local time = sysParam.SysParamManager:getValue(78) / 1000
        self.mCvTextTimer = self:addTimer(time, -1, function()
            charIndex = charIndex + 1
            if charIndex <= #CharLength then
                str = str .. CharLength[charIndex]
                self.mTextDesc.text = str
            else
                self:removeTimerByIndex(self.mCvTextTimer)
                self.mCvTextTimer = nil
            end
        end)
    end
end

function addTimerClick(self)
    local time = sysParam.SysParamManager:getValue(77) / 1000
    self:setTimeout(time, function()
        self.mImgClick:SetActive(true)
    end)
end


return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(571):	"已转化"
]]