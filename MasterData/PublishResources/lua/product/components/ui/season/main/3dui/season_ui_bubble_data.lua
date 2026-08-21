_class("SeasonUIBubbleData", Object)
SeasonUIBubbleData = SeasonUIBubbleData

function SeasonUIBubbleData:Constructor(bubble)
  self.text = bubble.text
  self.time = bubble.bubbleTime * 1000
  self.delay = bubble.textDelay * 1000
  self.audio = bubble.audio
end
