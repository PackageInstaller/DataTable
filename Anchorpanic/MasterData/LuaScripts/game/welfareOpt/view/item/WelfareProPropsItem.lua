

module('welfareOpt.WelfareOptOpenBetaItem', Class.impl(BaseReuseItem))

UIRes = UrlManager:getUIPrefabPath("welfareOpt/item/WelfareOptOpenBetaItem.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
    self.mProp = nil
end
--析构  
function dtor(self)
end

function initData(self)
end

function configUI(self) 
    self.mPropContent = self:getChildTrans("PropContent")
    self.mProTxt = self:getChildGO("ProTxt"):GetComponent(ty.Text)
end


--激活
function active(self)
    super.active(self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:recoverItem()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)

end

function recoverItem(self)
    if self.mProp ~= nil then
    self.mProp:poolRecover()
    end
    self.mProp = nil
end


function setData(self, cusParent, data)
    self:recoverItem()
    self:setParentTrans(cusParent)

    self.mProTxt.text = data.chance/10 .."%"
        local propsVo = props.PropsManager:getPropsVo({ tid = data.item_id, num = data.num })
        self.mProp = PropsGrid:create(self.mPropContent,propsVo,1)
        self.mProp:setIsShowName(true)
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
