--[[ 
-----------------------------------------------------
@filename       : FashionShowView
@Description    : 单个皮肤展示
@date           : 2023-09-20 14:20:33
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('purchase.FashionShowOneView', Class.impl("game/purchase/fashionShop/view/FashionShowView"))
-- UIRes = UrlManager:getUIPrefabPath('purchase/FashionShowView.prefab')


function active(self, args)
    self.mHeroTid = args.heroTid
    self.mFashionId = args.fashionId
    self.mIsShow3D = args.isShow3D
    super.active(self, args)
    MoneyManager:setMoneyTidList({})
    self:getChildGO("mGroup"):SetActive(false)
    self.mImgBg.gameObject:SetActive(false)
end

function deActive(self)
    super.deActive(self)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnHide, self.onClickHideHanler)
    self:addUIEvent(self.mBtnShow3D, self.onClickOpen3DShowView, nil, true)
    self:addUIEvent(self.mBtnShow, self.onClickOpen3DShowView, nil, false)
    self:addUIEvent(self.mBtnFashionColor, self.onClickShowFashionColor)
    self:addUIEvent(self.mBtnFColorPre, self.onClickCloseFashionColor)
    self:addUIEvent(self.mBtnFColorControl, self.onClickFColorControl)
    -- self:addUIEvent(self.mImgLeft, self.onClickNextHandler, nil, true)
    -- self:addUIEvent(self.mImgRight, self.onClickNextHandler, nil, false)
end


function onClickShowFashionColor(self)
    self.mBtnFColorPre:SetActive(true)
    self.mGroupFColorMenu:SetActive(true)
    self.mModelPlayer:showSiwai()
    self:resetFColorSelect(0)
end

function onClickCloseFashionColor(self)
    self.mBtnFColorPre:SetActive(false)
    self.mGroupFColorMenu:SetActive(false)
end

-- 获取该时装的部位配置
function getFashionColorList(self)
    local list = fashion.FashionManager:getFasionColorList(self.mHeroTid, self.mFashionId)
    return list
end

-- 是否有动态
function isShowDynamic(self)
    local dynamicData = hero.HeroInteractManager:getModelIsDynamic(self:getModelId())
    return not self.mIsShow3D and (dynamicData ~= nil)
end

-- 皮肤部位更换列表
function updateFColorItem(self)
    self:recoverFColorItem()
    local list = self:getFashionColorList()
    if not list then
        return
    end

    for i, v in ipairs(list) do
        local item = SimpleInsItem:create(self:getChildGO("mGroupFColorItem"), self.mGroupFColorMenu.transform, "FashionShowViewGroupFColorItem")
        item:getChildGO("mImgFColorIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getIconPath(v.icon), false)
        item:setArgs(v.id)
        item:getChildGO("mImgFColorLock"):SetActive(v.id > 0)
        item:getChildGO("mImgFColorSelect"):SetActive(v.id == 0)
        item:getChildGO("mImgFColorUse"):SetActive(false)
        table.insert(self.mFColorItemList, item)
        item:addUIEvent(nil, function()
            self.mFashionColorBaseVo = v
            self:resetFColorSelect()
            item:getChildGO("mImgFColorSelect"):SetActive(true)
            --self.mBtnFColorControl:SetActive(v.id > 0)

            -- 替换材质球预览
            self.mModelPlayer:setMaterial(v.posList, v.materials)
        end)
    end
end

-- 取模型id
function getModelId(self)
    return self.mFashionVo.model
end

function update3DShow(self, isShow3D)
    self.mIsShow3D = isShow3D
    if isShow3D and not self.mIsFristShowModel then
        self:updateModelView(self.mFashionVo:getUIModel())
    elseif not isShow3D then
        self.mModelPlayer.m_modelView:clearModel()
    end
    self.mImgFashionShowBg:SetActive((not isShow3D))
    self:getChildGO("mImgShowHero"):SetActive((not isShow3D))
    self:getChildGO("mImgShowHero3D"):SetActive(isShow3D)
    local color1 = (self:getChildGO("mImgShowHero").activeSelf == true) and "404548ff" or "82898Cff"
    local color2 = (self:getChildGO("mImgShowHero3D").activeSelf == true) and "404548ff" or "82898Cff"
    self.mTxtShow.color = gs.ColorUtil.GetColor(color1)
    self.mTxtModel.color = gs.ColorUtil.GetColor(color2)

    self:updateDynamicState()
    self:updateFashionColorBtn()
end

-- 更新皮肤部件按钮
function updateFashionColorBtn(self)
    local list = self:getFashionColorList()
    self.mBtnFashionColor:SetActive(not (list == nil) and self.mIsShow3D)
    self:updateFColorItem()
end


-- 更新模型
function updateModelView(self, args)
    if (args) then
        if (self.mIsShow3D or self.mIsFristShowModel) then
            self:recoverModel(false)
            self.mModelPlayer:setModelData(args, false, true, 1, true, MainCityConst.ROLE_MODE_OVERVIEW, nil, self.mModelClicker, true, function()
                if self.mIsFristShowModel then
                    local isFirstShow3D = self.mIsShow3D
                    self:update3DShow(isFirstShow3D)
                    self.mIsFristShowModel = false
                end
                self:resetFColorSelect(0)
            end)
        end
    else
        self:recoverModel(false)
    end
end

function updateView(self)
    self.mImgFashionShowBg:SetActive((not self.mIsShow3D))

    self.mFashionVo = fashion.FashionManager:getHeroFashionConfigVo(fashion.Type.CLOTHES, self.mHeroTid, self.mFashionId)
    self.mTxtHeroSeries.text = self.mFashionVo:getFashionSeries()
    self.mTxtSeriesName.text = self.mFashionVo:getName()
    self.mTxtHeroNameLeft.text = self.mFashionVo:getHeroName()
    self.mImgFashionShow:SetImg(UrlManager:getPainImg(self.mFashionVo:getUrlBody()), true)
    self.mTxtFashionDsc.text = self.mFashionVo:getFashionDsc()
    self:updateModelView(self.mFashionVo:getUIModel())
    self:addTimer(0.01, 10, function()
        gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mDesContent) -- 立即刷新
        local height = self.mDesContent.rect.height <= 240 and (self.mDesContent.rect.height + 11.45) or 240
        gs.TransQuick:SizeDelta02(self.mDesScrollView, height)
        self.mDesScrolSR.vertical = self.mDesContent.rect.height > 240
        gs.TransQuick:LPosY(self.mDesContent, 0)
        if self.mDesScrolSR.vertical == true then
            self.mDesScrolSR.verticalNormalizedPosition = 1
            self:removeAllTimer()
        end
    end)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]