--[[ 
-----------------------------------------------------
@filename       : RoleGuradGroupSelectView
@Description    : 预备看板战员组选择战员
@date           : 2024-12-20 15:26:43
@Author         : Jacob
@copyright      : (LY) 2024 雷焰网络
-----------------------------------------------------
]]
module('game.role.view.RoleGuradGroupSelectView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("role/RoleGuradGroupSelectView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
-- isShow3DBg = 1

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1120, 480)
    self:setTxtTitle(_TT(41737)) --"值班选择"
    -- self:setBg("common_bg_016.jpg", false)
    -- self:setUICode(LinkCode.HomePage)
end
--析构  
function dtor(self)
end

function initData(self)
end

-- 初始化
function configUI(self)
    self.mLyScroller = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.mLyScroller:SetItemRender(role.RoleGuradGroupSelectItem)

    self.mEmptyStateItem = self:getChildGO("EmptyStateItem")
    self.mTxtEmptyTip = self:getChildGO("mTxtEmptyTip"):GetComponent(ty.Text)
end

--激活
function active(self, args)
    super.active(self, args)

    self.heroId = args.heroId

    GameDispatcher:addEventListener(EventName.HERO_GROUP_SELECT_ONE, self.onHeroGroupSelectOne, self)
    self:updateView()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.HERO_GROUP_SELECT_ONE, self.onHeroGroupSelectOne, self)
    if self.mLyScroller then
        self.mLyScroller:CleanAllItem()
    end
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
    self.mTxtEmptyTip.text = _TT(41742)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    -- self:addUIEvent(self.aa,self.onClick)
end

function updateView(self)
    local scrollList = {}

    local isShowSpine = role.RoleManager:getHeroGroupShowSpine()
    local heroList = hero.HeroManager:getHeroList()
    for i, heroVo in ipairs(heroList) do
        if isShowSpine == 0 or (isShowSpine == 1 and hero.HeroInteractManager:getModelIsDynamic(heroVo:getHeroModel())) then

            local scrollerVo = LuaPoolMgr:poolGet(LyScrollerSelectVo)
            scrollerVo:setDataVo(heroVo)
            scrollerVo:setSelect(self.heroId == heroVo.id)
            table.insert(scrollList, scrollerVo)
        end
    end
    self.mLyScroller.DataProvider = scrollList

    self.mEmptyStateItem:SetActive(not scrollList or table.empty(scrollList))
end

function updateHeroItem(self)

end

function onHeroGroupSelectOne(self, args)
    self:close()
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]