-- 看板娘预设选择列表
module("role.RoleGuradGroupSelectItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

    self.mImgSelect = self:getChildGO("mImgSelect")
    self.mImgUse = self:getChildGO("mImgUse")
    self.mImgHeroGo = self:getChildGO("mImgHero")
    self.mImgHero = self:getChildGO("mImgHero"):GetComponent(ty.AutoRefImage)
    self.mTxtUse = self:getChildGO("mTxtUse"):GetComponent(ty.Text)
    self.mTxtUse.text = "使用中"
end

function setData(self, param)
    super.setData(self, param)
    self.heroVo = self.data:getDataVo()
    self.mImgHero:SetImg(UrlManager:getHeroBodyImgUrl(self.heroVo:getHeroModel()))

    self.mImgSelect:SetActive(self.data:getSelect())

    local groupData = role.RoleManager:getHeroGroup()
    self.mImgUse:SetActive(false)
    for k, v in pairs(groupData) do
        if v == self.heroVo.id then
            self.mImgUse:SetActive(true)
            break
        end
    end
end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self.mImgHeroGo, self.onClickItemHandler)
end

function onClickItemHandler(self)
    GameDispatcher:dispatchEvent(EventName.HERO_GROUP_SELECT_ONE, { heroId = self.heroVo.id })
end

function deActive(self)
    super.deActive(self)
    -- if (self.m_heroCard) then
    --     self.m_heroCard:poolRecover()
    --     self.m_heroCard = nil
    -- end
    -- self.data = nil
end

function onDelete(self)
    super.onDelete(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(25207):	"-当前选中-"
	语言包: _TT(25168):	"展示中"
]]