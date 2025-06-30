--[[ 
-----------------------------------------------------
@filename       : FashionShow3DView
@Description    : 皮肤商店3D展示界面
@date           : 2023-3-28 15:59:00
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('purchase.FashionShow3DView', Class.impl(View))

UIRes = UrlManager:getUIPrefabPath('purchase/FashionShow3DView.prefab')
panelType = 1 -- 窗口类型 1 全屏 2 弹窗
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setTxtTitle(_TT(52120))--皮肤
    self:setBg("", false)
end

-- 初始化数据
function initData(self)
    super.initData(self)
end

function configUI(self)
    super.configUI(self)
    self.mModelPlayer = ModelScenePlayer.new()
    self.mModelClicker = self:getChildGO("mClickerArea")
    self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Text)
    self.mTxtHeroName = self:getChildGO("mTxtHeroName"):GetComponent(ty.Text)
    self.mTxtHeroSeries = self:getChildGO("mTxtHeroSeries"):GetComponent(ty.Text)
    self.mTxtSeriesName = self:getChildGO("mTxtSeriesName"):GetComponent(ty.Text)
end

function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})
    self:updateModelView(args)
end

function deActive(self)
    super.deActive(self)
    self:recoverModel(true)
end

function initViewText(self)
    super.initViewText(self)
    self.mTxtTips.text = "可旋转拖动预览"--_TT()
end

function addAllUIEvent(self)
end

-- 更新模型
function updateModelView(self, args)
    if (args.model) then
        self.mModelPlayer:setModelData(args.model, false, true, 1, true, MainCityConst.ROLE_MODE_OVERVIEW, "", self.mModelClicker, true, nil)
    else
        self:recoverModel(false)
    end
    self.mTxtHeroName.text = args.heroName
    self.mTxtSeriesName.text = args.seriesName
    self.mTxtHeroSeries.text = args.heroSeries
end

function recoverModel(self, isResetMaincity)
    self.mModelPlayer:reset(isResetMaincity)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]