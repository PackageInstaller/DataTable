module("formation.FormationPowerTipsPanel", Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("formation/FormationPowerTipsPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
  
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtContent = self:getChildGO("mTxtContent"):GetComponent(ty.Text)
end

--激活
function active(self)
    super.active(self)

    local vo = branchStory.BranchPowerManager:getLastVo()

    self.mTxtTitle.text = _TT(vo.pointTitle)
    self.mTxtContent.text = _TT(vo.pointDes)
end


function deActive(self)

end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
