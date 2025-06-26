--[[ 
-----------------------------------------------------
@filename       : DupImpliedMatrixItem
@Description    : 默示之境矩阵item
@date           : 2021-07-07 11:11:58
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('dup.DupImpliedMatrixItem', Class.impl(BaseReuseItem))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("dupImplied/DupImpliedMatrixItem.prefab")

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
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
end

--激活
function active(self)
    super.active(self)
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

end

function setData(self, cusParent, cusDupData)
    super.setData(self, cusParent, cusDupData)
    self.mTxtName.text = cusDupData:getName()
    self.mTxtDes.text = cusDupData:getDes()
    self.mImgIcon:SetImg(UrlManager:getIconPath(string.format("dupImplied/matrix/%s", cusDupData.icon)), true)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
