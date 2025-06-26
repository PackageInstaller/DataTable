module('seabed.SeabedShowLayerPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("seabed/SeabedShowLayerPanel.prefab")

panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
destroyTime = 0

--构造函数
function ctor(self)
    super.ctor(self)
end
-- 取父容器
function getParentTrans(self)
    return GameView.msg
end

function initData(self)

end

function configUI(self)
    super.configUI(self)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
end

function setCallFinish(self,call)
    self.call = call
end

function active(self, args)
    super.active(self, args)

    self:showFisish()
end

function showFisish(self)
    local lineVo = seabed.SeabedManager:getCurSeabedLineData()
    self.mTxtName.text = _TT(lineVo.name)
    self.mTxtDes.text = _TT(lineVo.des)

    local function closeSelf()
        self:close()
    end
    LoopManager:setTimeout(2, nil, closeSelf)
end


function close(self)
    super.close(self)

    if(self.call) then
        self.call()
        self.call = nil
    end
end

function deActive(self)
    super.deActive(self)
end

return _M
 