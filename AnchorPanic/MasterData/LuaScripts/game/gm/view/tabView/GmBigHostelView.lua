--[[
-----------------------------------------------------
@filename       : GmBigHostelView
@Description    : gm快捷道具面板
@date           : 2021-05-21 20:22:07
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('gm.GmBigHostelView', Class.impl(TabSubView))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("gm/GmBigHostelView.prefab")

function initData(self)

end

-- 初始化
function configUI(self)
    -- self.mBtnAll = self:getChildGO("mBtnAll"):GetComponent(ty.Image)
    -- self.bb = self:getChildTrans("bb")
    self.mLyScroller = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.mLyScroller:SetItemRender(gm.GmBigHostelItem)
end

--激活
function active(self)
    super.active(self)

    self:updateView()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
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

end

function updateView(self)
    local vo_list = {}

    local baseData = RefMgr:getData("hero_interact_scene_data")
    for key, data in pairs(baseData) do
        for k, scene_dic in pairs(data.scene_data) do
            local vo = {hero_tid = key, item_id = scene_dic.item_id, model_id = scene_dic.model_id}
            table.insert(vo_list, vo)
        end
    end
    
    self.mLyScroller.DataProvider = vo_list
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
