--[[ 
-----------------------------------------------------
@filename       : ReceiveFashionSuccess
@Description    : 时装获取展示
@date           : 2021-03-23 16:38:46
@Author         : lyx
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('fashion.ReceiveFashionSuccess', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("recruit/ReceiveFashionSuccess.prefab")

destroyTime = -1 -- 自动销毁时间-1默认 0即时销毁 999不销毁
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
    self.mSkip = self:getChildGO("mSkip")
    -- 获得重复英雄转化相关
    self.mGroupConvert = self:getChildGO("mGroupConvert")
    self.mImgConvert = self:getChildGO("mImgConvert")
    self.mConvertContent = self:getChildTrans("mConvertContent")
    self.mImgNew = self:getChildGO("mImgNew")
    self.mImgEleBg = self:getChildGO("mImgEleBg")
    self.mImgEleType = self:getChildGO("mImgEleType"):GetComponent(ty.AutoRefImage)
    self.mTextDesc_1 = self:getChildGO("mTextDesc_1"):GetComponent(ty.Text)
    self.mTextDesc_2 = self:getChildGO("mTextDesc_2"):GetComponent(ty.Text)
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
function active(self, heroInfo)
    gs.Time.timeScale = 1
    self.heroTid = heroInfo.hero_tid
    local heroId = hero.HeroManager:getHeroIdByTid(self.heroTid)
    self.propsList = {}
    self.isNoSkip = false
    self.heroConfigVo = hero.HeroManager:getHeroConfigVo(self.heroTid)
    self.mFashionId = heroInfo.fashion_id
    self.mFashionCoinNum = heroInfo.fashion_coin_num
    self.fashionVo = fashion.FashionManager:getHeroFashionConfigVo(fashion.Type.CLOTHES, self.heroTid, self.mFashionId)
    self.mImgNew:SetActive(self.mFashionCoinNum <= 0)
    if self.mFashionCoinNum > 0 then
        local propVo = props.PropsManager:getPropsConfigVo(MoneyTid.FASHION_TID)
        propVo.num = self.fashionVo:getFshionCion()
        table.insert(self.propsList, propVo)
    end
    if not self.heroConfigVo then
        logError('==========配置没有战员tid:' .. self.heroTid)
        return
    end

    self:updateView()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:recoverAllGrid()

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

function getOpenSoundPath(self)
    return "arts/audio/UI/recruit/ui_recruit_show01.prefab"
end

function __playOpenAction(self)
end

function __closeOpenAction(self)
    if self.isPop == 1 then
        self:close()
    end
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mSkip, self.onSkip)
    self:addUIEvent(self.mImgClick, self.onClickClose)
end

function onClickClose(self)
    super.onClickClose(self)
    GameDispatcher:dispatchEvent(EventName.CLOSE_RECRUIT_SHOW_ONE_VIEW)
end

function onSkip(self)
    super.close(self)
    GameDispatcher:dispatchEvent(EventName.RECRUIT_SKIP)
end

function updateView(self)
    self.mTxtName.text = self.fashionVo:getName() --self.heroConfigVo.name
    self.mSkip:SetActive(not self.isNoSkip)

    self.mImgPosIcon:SetImg(UrlManager:getHeroJobSmallIconUrl(self.heroConfigVo.professionType), false)
    self.mImgHeroIcon:SetImg(UrlManager:getBgPath(string.format("heroRecord/%s", self.fashionVo.imgbody)), true)
    self.mImgHeroIcon_bg:SetImg(UrlManager:getBgPath(string.format("heroRecord/%s", self.fashionVo.imgbody)), true)

    if self.heroConfigVo.eleType >= 0 then
        self.mImgEleType.gameObject:SetActive(true)
        self.mImgEleType:SetImg(UrlManager:getHeroEleTypeIconUrl(self.heroConfigVo.eleType), false)
    else
        self.mImgEleType.gameObject:SetActive(false)
    end
    for i = 1, 3 do
        self.m_childGos["mImgQuality_" .. i]:SetActive(self.heroConfigVo.color - 1 == i)
    end
    self:getChildGO("desc"):SetActive(false)

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
    self:updateConvertView()
end

function updateConvertView(self)
    self:recoverAllGrid()
    self:recoverAllItemGrid()

    local isEmpty = table.empty(self.propsList)
    self.mGroupConvert:SetActive(not isEmpty)
    if not isEmpty then
        for i = 1, #self.propsList do
            local item = SimpleInsItem:create(self.mImgConvert, self.mConvertContent, "recruitShowOneItem_ReceiveFashionSuccess")
            local propsGrid = PropsGrid:create(item:getChildTrans("mItemPoint"), self.propsList[i], 1)
            propsGrid:setClickEnable(false)
            table.insert(self.mPropsGridList, propsGrid)
            table.insert(self.mItemList, item)
        end
    end

    -- self.mAnimator:Play("RecruitShowOneView_Enter01")
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