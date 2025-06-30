--[[ 
-----------------------------------------------------
@filename       : RecruitShowOneView
@Description    : 招募单人展示
@date           : 2021-03-23 16:38:46
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.recruit.view.RecruitCardShowOneView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("recruit/RecruitCardShowOneView.prefab")

destroyTime = -1 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isAdapta = 1 --是否开启适配刘海
isScreensave = 0
isAddMask = 0

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
    self.mImgHeroIcon = self:getChildGO("mImgHeroIcon"):GetComponent(ty.AutoRefImage)

    self.mSkip = self:getChildGO("mSkip")

    -- 获得重复英雄转化相关
    self.mGroupConvert = self:getChildGO("mGroupConvert")
    self.mImgConvert = self:getChildGO("mImgConvert")
    self.mConvertContent = self:getChildTrans("mConvertContent")
    self.mImgNew = self:getChildGO("mImgNew")

    self.mAnimator = self.UIObject:GetComponent(ty.Animator)

    self.mImgClick = self:getChildGO("mImgClick")
    self.mImgClick:SetActive(false)
end

--激活
function active(self, cardInfo)
    super.active(self)

    GameDispatcher:addEventListener(EventName.SYSTEM_SETTING_NOTCH_CHANGE, self.setAdapta, self)
    self:setAdapta()

    self.mTid = cardInfo.tid
    self.propsList = cardInfo.propsList
    self.isNoSkip = cardInfo.isNoSkip ~= nil and cardInfo.isNoSkip or false

    self.mPropsConfigVo = props.PropsManager:getPropsConfigVo(self.mTid)

    self:updateView()

    self.isCanClose = false
    self:setTimeout(1, function()
        self.isCanClose = true
    end)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:recoverAllGrid()
    if hero.HeroShowManager:getIsMess() then
        hero.HeroShowManager:setIsMess(false)
        local heroId = hero.HeroManager:getHeroIdByTid(self.mTid)
        showBoard.ShowBoardManager:GetSaveTheList(heroId)
        GameDispatcher:dispatchEvent(EventName.OPEN_HERO_DEVELOP_PANEL, { heroId = heroId, mTid = self.mTid })
    end

    if self.mCvAudioData then
        AudioManager:stopAudioSound(self.mCvAudioData)
        self.mCvAudioData = nil
    end
end

function getAdaptaTrans(self)
    return self:getChildTrans("mGroup")
end


--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)

end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mSkip, self.onSkip)
    self:addUIEvent(self.mImgClick, self.onClickClose)
end

function getOpenSoundPath(self)
    return "arts/audio/UI/recruit/ui_bracelets_get.prefab"
end

function __playOpenAction(self)
end

function __closeOpenAction(self)
    if self.isPop == 1 then
        self:close()
    end
end

function onClickClose(self)
    if self.isCanClose then
        super.onClickClose(self)
        GameDispatcher:dispatchEvent(EventName.CLOSE_RECRUIT_CARD_SHOW_ONE_VIEW)
    end
end

function onSkip(self)
    super.close(self)
    GameDispatcher:dispatchEvent(EventName.RECRUIT_SKIP)
end

function updateView(self)
    self.mTxtName.text = self.mPropsConfigVo.name
    self.mSkip:SetActive(not self.isNoSkip)

    self.mImgHeroIcon:SetImg(UrlManager:getPropsIconUrl(self.mTid))

    for i = 1, 3 do
        self:getChildGO("mImgQualityBg_" .. i):SetActive(self.mPropsConfigVo.color - 1 == i)
        self:getChildGO("mImgQuality_" .. i):SetActive(self.mPropsConfigVo.color - 1 == i)
        self:getChildGO("fxColor_0" .. (i + 1)):SetActive(self.mPropsConfigVo.color - 1 == i)
    end

    local isNew = bag.BagManager:checkIsNewAdd(self.mPropsConfigVo)
    self.mImgNew:SetActive(isNew)

    self.mImgClick:SetActive(false)
    self:addTimerClick()

    self:updateConvertView()
end

function addTimerClick(self)
    -- local time = sysParam.SysParamManager:getValue(77) / 1000
    -- self:setTimeout(time, function()
    --     self.mImgClick:SetActive(true)
    -- end)
    self.mImgClick:SetActive(true)
end

function updateConvertView(self)
    self:recoverAllGrid()
    self:recoverAllItemGrid()

    local isEmpty = table.empty(self.propsList)
    self.mGroupConvert:SetActive(not isEmpty)
    if not isEmpty then
        for i = 1, #self.propsList do
            local item = SimpleInsItem:create(self.mImgConvert, self.mConvertContent, "RecruitCardShowOneViewrecruitShowOneItem")
            local propsGrid = PropsGrid:create(item:getChildTrans("mItemPoint"), self.propsList[i], 1)
            propsGrid:setClickEnable(false)
            table.insert(self.mPropsGridList, propsGrid)
            table.insert(self.mItemList, item)
        end
    end
end

function recoverAllItemGrid(self)
    if (self.mItemList) then
        for i = 1, #self.mItemList do
            self.mItemList[i]:poolRecover()
        end
    end
    self.mItemList = {}
end

function recoverAllGrid(self)
    if (self.mPropsGridList) then
        for i = 1, #self.mPropsGridList do
            self.mPropsGridList[i]:poolRecover()
        end
    end
    self.mPropsGridList = {}
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(571):	"已转化"
]]