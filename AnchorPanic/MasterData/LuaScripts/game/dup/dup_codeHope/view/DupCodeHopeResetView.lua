--[[ 
-----------------------------------------------------
@filename       : DupCodeHopeResetView
@Description    : 代号·希望重置副本确认
@date           : 2021-05-14 19:54:18
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game..view.DupCodeHopeResetView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("dupCodeHope/DupCodeHopeResetView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

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
    self.mTxtContent = self:getChildGO("mTxtContent"):GetComponent(ty.Text)
    self.mTxtContent2 = self:getChildGO("mTxtContent2"):GetComponent(ty.Text)
    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)




    self.mBtnCancel = self:getChildGO("mBtnCancel")
    self.mBtnConfirm = self:getChildGO("mBtnConfirm")
    -- self.bb = self:getChildTrans("bb")
end

--激活
function active(self, args)
    super.active(self, args)
    self.curChapter = args

    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self:getChildTrans("mGroupFit"))
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
    self:setBtnLabel(self.mBtnCancel, 2, "取消")
    self:setBtnLabel(self.mBtnConfirm, 1, "确定")

    self.mTxtTime.text = _TT(29103) --"（每天1次）"
    self.mTxtContent.text = _TT(29104) --"是否要重置当前关卡？"
    self.mTxtContent2.text = _TT(29105) --"（所有战员耐力、关卡效果和当前通关进度重置，关卡奖励和章节奖励不重置）"
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnConfirm, self.onConfirm)
    self:addUIEvent(self.mBtnCancel, self.onCancel)
end

function onConfirm(self)
    self:close()
    GameDispatcher:dispatchEvent(EventName.REQ_CODE_HOPE_RESET, self.curChapter)
end

function onCancel(self)
    self:close()
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
