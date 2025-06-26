--[[ 
-----------------------------------------------------
@filename       : DupCodeHopeShowBuffView
@Description    : 代号·希望新buff展示
@date           : 2021-05-17 11:07:03
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dupCodeHope.view.DupCodeHopeShowBuffView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("dupCodeHope/DupCodeHopeShowBuffView.prefab")

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
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    -- self.bb = self:getChildTrans("bb")
end

--激活
function active(self, args)
    super.active(self, args)
    self.buffId = args
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
    -- self:addUIEvent(self.aa,self.onClick)
end

function updateView(self)
    local buffVo = dup.DupCodeHopeManager:getBuffData(self.buffId)
    local skillVo = fight.SkillManager:getSkillRo(buffVo.skillId)

    self.mImgIcon:SetImg(UrlManager:getSkillIconPath(skillVo:getIcon()), true)

    self.mTxtName.text = skillVo:getName()
    self.mTxtDes.text = skillVo:getDesc()
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
