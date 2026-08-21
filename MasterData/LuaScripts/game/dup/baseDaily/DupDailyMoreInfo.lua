--[[ 
-----------------------------------------------------
@filename       : DupDailyMoreInfoPanel
@Description    : 日常副本详情
@Author         : sxt
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("dup.DupDailyMoreInfoPanel", Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("dupDaily/DupDailyMoreInfoPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 0

--构造函数
function ctor(self)
    super.ctor(self)
end

--析构
function dtor(self)
end


function configUI(self)
    self.mcloseBtn = self:getChildGO("closeBtn")
    self.mTipsTxt = self:getChildGO("TipTxt"):GetComponent(ty.Text)
    self.mInfoTxt = self:getChildGO("InfoTxt"):GetComponent(ty.Text)
end
--激活
function active(self, args)
    super.active(self, args)
end


--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end

function initViewText(self)
    self.mTipsTxt.text = _TT(146)
    self.mInfoTxt.text = _TT(147)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mcloseBtn ,self.onClickClose)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
