--[[ 
-----------------------------------------------------
@filename       : DormitorySettledHeroView
@Description    : 宿舍战员入住选择界面
@date           : 2022-03-08 16:09:43
@Author         : Jacob
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module('game.dormitory.view.DormitorySettledHeroView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("dormitory/DormitorySettledHeroView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1117, 518)
    self:setTxtTitle(_TT(49716))
end
--析构  
function dtor(self)
end

function initData(self)

    -- 是否显示排序界面
    self.m_isShowSort = false
    self.m_isDescending = true
    self.m_tempIsDescending = true
    self.m_selectSortType = showBoard.panelSortType.SETTLEIN 
    self.m_tempSelectSortType = self.m_selectSortType
    self.m_selectFilterDic = {}
    self.m_tempSelectFilterDic = {}
    for type in pairs(showBoard.panelFilterTypeDic) do
        self.m_selectFilterDic[type] = {}
        self.m_selectFilterDic[type][showBoard.filterSubTypeAll] = true
        self.m_tempSelectFilterDic[type] = {}
        self.m_tempSelectFilterDic[type][showBoard.filterSubTypeAll] = true
    end
end

-- 初始化
function configUI(self)
    self.mBtnSure = self:getChildGO("mBtnSure")
    self.mLyScroller = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.mLyScroller:SetItemRender(dormitory.DormitorySettledHeroItem)
end

--激活
function active(self)
    super.active(self)

    self:updateView()

    self:setGuideTrans("guide_DormitorySettled_Sure", self.mBtnSure.transform)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    dormitory.DormitoryManager:resetSelectHero()
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
    self:addUIEvent(self.mBtnSure, self.onClickSure)
end

-- 保存
function onClickSure(self)
    GameDispatcher:dispatchEvent(EventName.DORMITORY_SAVE_SETTLED_HERO)
    self:onClickClose()
end

-- 更新页面
function updateView(self)
    local heroList, idDic = showBoard.ShowBoardManager:getHeroScrollList(nil, self.m_selectSortType, self.m_isDescending, self.m_selectFilterDic)
    for i, heroScrollVo in ipairs(heroList) do
        local heroVo = heroScrollVo:getDataVo()
        if dormitory.DormitoryManager:getSettledHeroPos(heroVo.tid) then
            heroScrollVo:setSelect(true)
        else
            heroScrollVo:setSelect(false)
        end
    end

    if self.mLyScroller.Count <= 0 then
        self.mLyScroller.DataProvider = heroList
    else
        self.mLyScroller:ReplaceAllDataProvider(heroList)
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(49716):	"<size=24>选</size>择战员"
]]
