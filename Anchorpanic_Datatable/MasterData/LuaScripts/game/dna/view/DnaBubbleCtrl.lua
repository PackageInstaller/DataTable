--[[
-----------------------------------------------------
   @CreateTime:2024/12/24 15:18:45
   @Author:zengweiwen
   @Copyright: (LY)2021 雷焰网络
   @Description:dna培养主界面冒泡消息处理类
]]

module("game.dna.view.DnaCultivatePanelBubble", Class.impl('lib.event.EventDispatcher'))

DNA_BUBBLE_FINIISH_WAIT = "DNA_BUBBLE_FINIISH_WAIT"

function initData(self)
    self.mTxtContentCharArray = nil
    self.mTxtCurPrintText = ""
end

function initUiRef(self, isActive, objBubble, txtBubble)
    self.mObjBubble = isActive and objBubble or nil
    self.mTfBubble = isActive and objBubble.transform or nil
    self.mTxtBubble = isActive and txtBubble or nil
end

function active(self, objBubble, txtBubble)
    self:initUiRef(true,
        objBubble,
        txtBubble
    )
    self.mObjBubble:SetActive(false)
    self:setTimeParams()
end

function deActive(self)
    self:stopPrintText()
    self:initUiRef()
    self:initData()
    self:removeAllEventListener()
end

function destroyTimeSn(self)
    if self.mPrintSn then
        LoopManager:clearTimeout(self.mPrintSn)
        self.mPrintSn = nil
    end
end

function setTimeParams(self, charPrintInterval, finishWaitTime)
    self.mCharPrintInterval = charPrintInterval or 0.03
    self.mFinishWaitTime = finishWaitTime or 5
end

function playBubbleText(self, content)
    self:stopPrintText()
    self:initData()
    self.mObjBubble:SetActive(true)
    self.mTxtBubble.text = self.mTxtCurPrintText

    self.mTxtContentCharArray = string.toCharArray(content)
    self.mCharIdx = 0
    self.mTotalCharNum = #self.mTxtContentCharArray

    self:printText()
end

function printText(self)
    self:destroyTimeSn()
    self.mCharIdx = self.mCharIdx + 1
    if self.mCharIdx > self.mTotalCharNum then
        self:onFinishPrint()
        return
    end
    
    local char = self.mTxtContentCharArray[self.mCharIdx]
    self.mTxtCurPrintText = self.mTxtCurPrintText .. char
    self.mTxtBubble.text = self.mTxtCurPrintText
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mTfBubble)
    self.mPrintSn = LoopManager:setTimeout(self.mCharPrintInterval, self, self.printText)
end

function onFinishPrint(self)
    self:destroyTimeSn()
    self.mPrintSn = LoopManager:setTimeout(self.mFinishWaitTime, self, function ()
        self:stopPrintText()
        self:dispatchEvent(self.DNA_BUBBLE_FINIISH_WAIT)
    end)
end

function stopPrintText(self)
    self:destroyTimeSn()
    self.mObjBubble:SetActive(false)
end

return _M
