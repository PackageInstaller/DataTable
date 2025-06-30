--[[ 
-----------------------------------------------------
@filename       : RoleGuradGroupFashionView
@Description    : 预备看板战员组选择换装
@date           : 2025-01-06 15:32:52
@Author         : Jacob
@copyright      : (LY) 2025 雷焰网络
-----------------------------------------------------
]]
module('game.role.view.RoleGuradGroupFashionView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("role/RoleGuradGroupFashionView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
-- isShow3DBg = 1

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1120, 480)
    self:setTxtTitle(_TT(41736)) --"值班选择"
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
    self.mLyScroller:SetItemRender(role.RoleGuradGroupFashionItem)

end

--激活
function active(self, args)
    super.active(self, args)

    self.heroId = args.heroId

    GameDispatcher:addEventListener(EventName.REQ_HERO_WEAR_FASHION, self.onHeroGroupFashionWear, self)
    self:updateView()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.REQ_HERO_WEAR_FASHION, self.onHeroGroupFashionWear, self)
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
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    -- self:addUIEvent(self.aa,self.onClick)
end

function updateView(self)

    local scrollList = {}
    local heroVo = hero.HeroManager:getHeroVo(self.heroId)

    local heroFashionDic = fashion.FashionManager:getHeroFashionConfigDic(fashion.Type.CLOTHES, heroVo.tid)
    for fashionId, vo in pairs(heroFashionDic) do
        table.insert(scrollList, vo)
    end

    self.mLyScroller.DataProvider = scrollList
end

function updateHeroItem(self)

end

function onHeroGroupFashionWear(self, args)
    self:close()
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]