--[[ 
-----------------------------------------------------
@filename       : MainExploreFirstIntroducePanel
@Description    : 首次介绍面板
@date           : 2021年5月11日 15:59:35
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('mainExplore.MainExploreFirstIntroducePanel', Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("mainExplore/MainExploreFirstIntroducePanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
end

-- 初始化数据
function initData(self)
    self.mIntroduceConfigVo = nil
    self.mFirstShowData = nil
end

--初始化UI
function configUI(self)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.ImgContent = self:getChildGO("ImgContent"):GetComponent(ty.AutoRefImage)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)

    self.mBtnLast = self:getChildGO('mBtnLast')
    self.mBtnNext = self:getChildGO('mBtnNext')
end

function initViewText(self)
end

function addAllUIEvent(self)
    self:addOnClick(self.mBtnLast, self.onClickLastHandler)
    self:addOnClick(self.mBtnNext, self.onClickNextHandler)
end

--激活
function active(self, args)
    super.active(self, args)

    self.mIntroduceConfigVo = mainExplore.MainExploreSceneManager:getFirstIntroduceConfigVo(args.introduceId)
    self.mCallFun = args.callFun
    self:updateView()
end

--非激活
function deActive(self)
    super.deActive(self)
end

function close(self)
    super.close(self)
    if(self.mCallFun)then
        self.mCallFun()
    end
end

function onClickLastHandler(self)
    local showData = self.mIntroduceConfigVo:getLast(self.mFirstShowData.index)
    if(showData)then
        self.mFirstShowData = showData
    end
    self:updateContent()
end

function onClickNextHandler(self)
    local showData = self.mIntroduceConfigVo:getNext(self.mFirstShowData.index)
    if(showData)then
        self.mFirstShowData = showData
    end
    self:updateContent()
end

function updateView(self)
    self.mFirstShowData = self.mIntroduceConfigVo:getFirst()
    self:updateContent()
end

function updateContent(self)
    if(self.mFirstShowData)then
        self.mTxtTitle.text = self.mFirstShowData.title
        self.ImgContent:SetImg(self.mFirstShowData.imgRes, false)
        self.mTxtDes.text = self.mFirstShowData.des
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
