local MoveJoyData = Vue.reactive({})
MoveJoyData.move_Joy_RectTransformType = 4
MoveJoyData.move_Joy_RectTransformTypeEnum = {
  [0] = "自由起始+固定位置",
  [1] = "自由起始+跟随手指",
  [2] = "固定位置",
  [3] = "固定位置-仅表现",
  [4] = "自由起始+固定位置+隐藏中心圆圈+外层箭头旋转"
}
MoveJoyData.speedLamda = 10
MoveJoyData.limitInScreen = true
MoveJoyData.sizeLamda = 1.5
MoveJoyData.initOffsetX = 0
MoveJoyData.initOffsetY = 0
MoveJoyData.dySpeed = true
MoveJoyData.smooth = true
MoveJoyData.level1 = {0.6, 1}
MoveJoyData.level2 = {0.25, 0.6}
MoveJoyData.level3 = {0, 0.25}
MoveJoyData.stop = 0.13
MoveJoyData.angle1 = 67.5
MoveJoyData.angle2 = 22.5
return MoveJoyData
