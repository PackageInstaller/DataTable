--[[ 
-----------------------------------------------------
@filename       : DupApostlesBossInfoView
@Description    : Boss信息界面
@date           : 2022-11-07 15:12:35
@Author         : Shuai
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module('game.dup_apostle_war.view.DupApostlesBossInfoView', Class.impl(View))
--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("dupApostleWar/DupApostlesBossInfoPanel.prefab")
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 0

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(29563))
end

--析构  
function dtor(self)
end

function initData(self)
end

-- 初始化
function configUI(self)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtHarm = self:getChildGO("mTxtHarm"):GetComponent(ty.Text)
    self.mTxtAttack = self:getChildGO("mTxtAttack"):GetComponent(ty.Text)
    self.mTxtDanger = self:getChildGO("mTxtDanger"):GetComponent(ty.Text)
    self.mTxtElement = self:getChildGO("mTxtElement"):GetComponent(ty.Text)
    self.mTxtDefense = self:getChildGO("mTxtDefense"):GetComponent(ty.Text)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
end

--激活
function active(self, args)
    super.active(self, args)
    self.mBossData = dup.DupApostlesWarManager:getBossInfoVoToModel(args.model)
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
    --危险级别
    self.mTxtDanger.text = _TT(70098)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)

end

function updateView(self)
    --颜色
    local color = "ffffffff"
    self.mImgIcon:SetImg(UrlManager:getMonsterModelHeadUrl(tonumber(self.mBossData.model)), false)
    self.mTxtName.text = HtmlUtil:color(self.mBossData:getName(), color)
    --伤害系数
    self.mTxtHarm.text = _TT(70094) .. HtmlUtil:color(self.mBossData:getAtk(), color)
    --攻击范围
    self.mTxtAttack.text = _TT(70097) .. HtmlUtil:color(self.mBossData:getAttRange(), color)
    --元素属性
    self.mTxtElement.text = _TT(70095) .. HtmlUtil:color(self.mBossData:getElement(), color)
    --防御系数
    self.mTxtDefense.text = _TT(70096) .. HtmlUtil:color(self.mBossData:getDefense(), color)
    --危险级别
    for i = 1, self.mBossData:getDangerousrating() do
        self:getChildGO("Image" .. i):SetActive(true)
    end
end

return _M