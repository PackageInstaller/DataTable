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
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
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
    self.mSkip = self:getChildGO("mSkip")
    -- 获得重复英雄转化相关
    self.mGroupConvert = self:getChildGO("mGroupConvert")
    self.mImgConvert = self:getChildGO("mImgConvert")
    self.mConvertContent = self:getChildTrans("mConvertContent")
    self.mImgNew = self:getChildGO("mImgNew")
    self.mImgEleBg = self:getChildGO("mImgEleBg")
    self.mImgEleType = self:getChildGO("mImgEleType"):GetComponent(ty.AutoRefImage)
    self.mAnimator = self.UIObject:GetComponent(ty.Animator)
    self.mImgClick = self:getChildGO("mImgClick")
    self.mImgClick:SetActive(false)

    self.mImgTxtBg = self:getChildGO("mImgTxtBg")
    self.mBtnFashion = self:getChildGO("mBtnFashion")
    self.mBtnFashioned = self:getChildGO("mBtnFashioned")
    self.mTxtFashionName = self:getChildGO("mTxtFashionName"):GetComponent(ty.Text)

    self.mTxtType = self:getChildGO("mTxtType"):GetComponent(ty.Text)
    self.mTxtDesc = self:getChildGO("mTxtDesc"):GetComponent(ty.Text)

    self.Content = self:getChildTrans("Content")
    self.mEffectNode = self:getChildTrans("mEffectNode")
end

--激活
function active(self, heroInfo)

    GameDispatcher:addEventListener(EventName.UPDATE_FASHION_PANEL, self.updateFasion, self)
    gs.Time.timeScale = 1
    self.heroTid = heroInfo.hero_tid
    self.heroId = hero.HeroManager:getHeroIdByTid(self.heroTid)


    self.propsList = {}
    self.isNoSkip = true
    self.heroConfigVo = hero.HeroManager:getHeroConfigVo(self.heroTid)
    self.mFashionId = heroInfo.fashion_id
    self.mFashionCoinNum = heroInfo.fashion_coin_num
    self.fashionVo = fashion.FashionManager:getHeroFashionConfigVo(fashion.Type.CLOTHES, self.heroTid, self.mFashionId)
    -- self.mImgNew:SetActive(self.mFashionCoinNum <= 0)


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

function updateFasion(self)

    if self.heroId == nil then
        self.mBtnFashion:SetActive(false)
        self.mBtnFashioned:SetActive(false)
    else
        local fashionVo, state = fashion.FashionManager:getHeroFashionVo(fashion.Type.CLOTHES, self.heroId, self.mFashionId)
        if state == fashion.State.WEARING then
            self.mBtnFashion:SetActive(false)
            self.mBtnFashioned:SetActive(true)
        else
            self.mBtnFashion:SetActive(true)
            self.mBtnFashioned:SetActive(false)
        end
    end

    -- self.mBtnFashion:SetActive(false)
    -- self.mBtnFashioned:SetActive(true)
end


--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_FASHION_PANEL, self.updateFasion, self)
    self:recoverAllGrid()
    self:clearSpine()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self:setBtnLabel(self.mBtnFashion, 62503, "穿戴")
    self:setBtnLabel(self.mBtnFashioned, 4329, "穿戴中")
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
    self:addUIEvent(self.mBtnFashion, self.onClickFasion)
end

function onClickFasion(self)
    GameDispatcher:dispatchEvent(EventName.REQ_HERO_WEAR_FASHION, {
        fashionType = fashion.Type.CLOTHES,
        heroId = self.heroId,
        fashionId = self.mFashionId
    })
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
    if self.heroId == nil then
        self.mBtnFashion:SetActive(false)
        self.mBtnFashioned:SetActive(false)
    else
        local fashionVo, state = fashion.FashionManager:getHeroFashionVo(fashion.Type.CLOTHES, self.heroId, self.mFashionId)
        if state == fashion.State.WEARING then
            self.mBtnFashion:SetActive(false)
            self.mBtnFashioned:SetActive(true)
        else
            self.mBtnFashion:SetActive(true)
            self.mBtnFashioned:SetActive(false)
        end
    end

    self.mTxtFashionName.text = self.heroConfigVo.name .. "[" .. self.fashionVo:getName() .. "]"

    self.mTxtType.text = "[" .. self.fashionVo:getFashionSeries() .. "]"
    self.mTxtDesc.text = self.fashionVo:getFashionDsc()
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mTxtDesc.transform) -- 立即刷新
    gs.TransQuick:LPosY(self.Content, 0)

    -- self.mTxtName.text = self.heroConfigVo.name --self.heroConfigVo.name
    self.mSkip:SetActive(not self.isNoSkip)

    self.mImgPosIcon:SetImg(UrlManager:getHeroJobSmallIconUrl(self.heroConfigVo.professionType), false)
    self.mImgHeroIcon:SetImg(UrlManager:getBgPath(string.format("heroRecord/%s", self.fashionVo.imgbody)), true)

    self.mImgTxtBg:SetActive(false)
    if self:isShowDynamic() then
        self:updateShowSpine()
    else
        self:clearSpine()
    end

    -- if self.heroConfigVo.eleType >= 0 then
    --     self.mImgEleType.gameObject:SetActive(true)
    --     self.mImgEleType:SetImg(UrlManager:getHeroEleTypeIconUrl(self.heroConfigVo.eleType), false)
    -- else
    --     self.mImgEleType.gameObject:SetActive(false)
    -- end
    for i = 1, 3 do
        self.m_childGos["mImgQuality_" .. i]:SetActive(self.heroConfigVo.color - 1 == i)
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

-- 更新显示模型或spine
function updateShowSpine(self)
    self:clearSpine()
    local modelId = self.fashionVo.model
    if not modelId then
        return
    end
    self.mImgTxtBg:SetActive(true)
    self.mEffectNode.gameObject:SetActive(false)

    local onLoadSpineFinish = function(go)
        self.mSpineGo = go

        local spineBgTrans = self.mSpineGo.transform:Find("mGroup/mImgBg")
        spineBgTrans.gameObject:SetActive(false)

        local spineTrans = self.mSpineGo.transform:Find(string.format("mGroup/spine_%s", modelId))
        local render = spineTrans:GetComponent(ty.MeshRenderer)
        if render and not gs.GoUtil.IsCompNull(render) then
            render.sortingOrder = 706
        end
        
        local spineBgTrans = self.mSpineGo.transform:Find(string.format("mGroup/spine_%s_bg", modelId))
        if spineBgTrans then
            local bgRender = spineBgTrans:GetComponent(ty.MeshRenderer)
            local bgCanvas = spineBgTrans:GetComponent(ty.Canvas)
            if bgRender and not gs.GoUtil.IsCompNull(bgRender) then
                bgRender.sortingOrder = 705
            end
            if bgCanvas and not gs.GoUtil.IsCompNull(bgCanvas) then
                bgCanvas.sortingOrder = 705
            end
        end

        gs.TransQuick:SetParentOrg(self.mSpineGo.transform, self:getChildTrans("mSpineNode"))
    end
    self.mSpineLoadSn = gs.ResMgr:LoadGOAysn(string.format("arts/fx/spine/%s/spine_%s.prefab", modelId, modelId), onLoadSpineFinish)
end

function clearSpine(self)
    if self.mSpineLoadSn and self.mSpineLoadSn ~= 0 then
        gs.ResMgr:CancelLoadAsync(self.mSpineLoadSn)
        self.mSpineLoadSn = nil
    end
    if self.mSpineGo then
        gs.GameObject.Destroy(self.mSpineGo)
        self.mSpineGo = nil
    end
    self.mEffectNode.gameObject:SetActive(true)
end

-- 是否有动态
function isShowDynamic(self)
    local dynamicData = hero.HeroInteractManager:getModelIsDynamic(self.fashionVo.model)
    return (dynamicData ~= nil)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(571):	"已转化"
]]