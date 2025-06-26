-- 看板娘预设选择列表
module("role.RoleGuradGroupFashionItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

    self.mImgUse = self:getChildGO("mImgUse")
    self.mImgLock = self:getChildGO("mImgLock")
    self.mImgNoSpine = self:getChildGO("mImgNoSpine")
    self.mImgHeroGo = self:getChildGO("mImgHero")
    self.mImgHero = self:getChildGO("mImgHero"):GetComponent(ty.AutoRefImage)
    self.mTxtUse = self:getChildGO("mTxtUse"):GetComponent(ty.Text)
    self.mTxtUse.text = _TT(25194) --"使用中"
end

function setData(self, param)
    super.setData(self, param)
    self.fashionConfigVo = self.data
    self.mImgHero:SetImg(UrlManager:getHeroBodyImgUrl(self.fashionConfigVo.model))
    self.mHeroId = hero.HeroManager:getHeroIdByTid(self.fashionConfigVo.heroTid)
    local fashionVo, state = fashion.FashionManager:getHeroFashionVo(fashion.Type.CLOTHES, self.mHeroId, self.fashionConfigVo.fashionId)

    self.mImgNoSpine:SetActive(false)
    if (state == fashion.State.LOCK) then
        self.mImgUse:SetActive(false)
        self.mImgLock:SetActive(true)
    elseif (state == fashion.State.WEARING) then
        self.mImgUse:SetActive(true)
        self.mImgLock:SetActive(false)
    elseif (state == fashion.State.UNLOCK) then
        self.mImgUse:SetActive(false)
        self.mImgLock:SetActive(false)
        local isShowSpine = role.RoleManager:getHeroGroupShowSpine()
        if isShowSpine == 1 and not hero.HeroInteractManager:getModelIsDynamic(self.fashionConfigVo.model) then
            self.mImgNoSpine:SetActive(true)
        end
    end
end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self.mImgHeroGo, self.onClickItemHandler)
end

function onClickItemHandler(self)
    local fashionVo, state = fashion.FashionManager:getHeroFashionVo(fashion.Type.CLOTHES, self.mHeroId, self.fashionConfigVo.fashionId)
    if (state == fashion.State.LOCK) then
        -- gs.Message.Show("该时装未解锁")
        gs.Message.Show(_TT(41739))
    elseif (state == fashion.State.WEARING) then
        -- gs.Message.Show("已穿戴")
        gs.Message.Show(_TT(50036))
    elseif (state == fashion.State.UNLOCK) then
        local isShowSpine = role.RoleManager:getHeroGroupShowSpine()
        if isShowSpine == 1 and not hero.HeroInteractManager:getModelIsDynamic(self.fashionConfigVo.model) then
            -- gs.Message.Show("该时装不支持动态立绘，无法直接更换")
            gs.Message.Show(_TT(41740))
        else
            -- gs.Message.Show("穿戴时装成功")
            gs.Message.Show(_TT(41741))
            GameDispatcher:dispatchEvent(EventName.REQ_HERO_WEAR_FASHION, { fashionType = fashion.Type.CLOTHES, heroId = self.mHeroId, fashionId = self.fashionConfigVo.fashionId })
        end
    end
end

function deActive(self)
    super.deActive(self)
end

function onDelete(self)
    super.onDelete(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(25207):	"-当前选中-"
	语言包: _TT(25168):	"展示中"
]]