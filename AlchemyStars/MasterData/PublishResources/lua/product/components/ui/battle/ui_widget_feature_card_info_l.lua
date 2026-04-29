_class("UIWidgetFeatureCardInfo_L", UIWidgetFeatureCardInfo)
UIWidgetFeatureCardInfo_L = UIWidgetFeatureCardInfo_L

function UIWidgetFeatureCardInfo_L:InitLocalData()
  self.depotUi = {
    [FeatureCardType.A] = {
      go = self.cardA,
      numGo = self.cardNumBgA,
      numText = self.cardNumA,
      imgLoader = self.cardImgA,
      imgGo = self.cardImgAGo,
      imgResMore = "n21_jieruo_red5_l",
      imgRes = {
        [0] = "n21_jieruo_red0_l",
        [1] = "n21_jieruo_red1_l",
        [2] = "n21_jieruo_red2_l",
        [3] = "n21_jieruo_red3_l"
      }
    },
    [FeatureCardType.B] = {
      go = self.cardB,
      numGo = self.cardNumBgB,
      numText = self.cardNumB,
      imgLoader = self.cardImgB,
      imgGo = self.cardImgBGo,
      imgResMore = "n21_jieruo_yellow5_l",
      imgRes = {
        [0] = "n21_jieruo_yellow0_l",
        [1] = "n21_jieruo_yellow1_l",
        [2] = "n21_jieruo_yellow2_l",
        [3] = "n21_jieruo_yellow3_l"
      }
    },
    [FeatureCardType.C] = {
      go = self.cardC,
      numGo = self.cardNumBgC,
      numText = self.cardNumC,
      imgLoader = self.cardImgC,
      imgGo = self.cardImgCGo,
      imgResMore = "n21_jieruo_blue4_l",
      imgRes = {
        [0] = "n21_jieruo_blue0_l",
        [1] = "n21_jieruo_blue1_l",
        [2] = "n21_jieruo_blue2_l",
        [3] = "n21_jieruo_blue3_l"
      }
    }
  }
  self.selectedUi = {
    [1] = {
      go = self.selectedFillAreaGo1,
      rect = self.selectedFillAreaRect1,
      imgLoader = self.selectedCardImg1,
      anim = self._selAnim1,
      animNamePutDown = "SelectedCell1_putdown",
      animNameIn = "SelectedCell1_enlarge",
      animNameOut = "SelectedCell1_recover",
      animNameUnselected = "SelectedCell1_off",
      moveInPlayer = nil,
      moveOutPlayer = nil
    },
    [2] = {
      go = self.selectedFillAreaGo2,
      rect = self.selectedFillAreaRect2,
      imgLoader = self.selectedCardImg2,
      anim = self._selAnim2,
      animNamePutDown = "SelectedCell2_putdown",
      animNameIn = "SelectedCell2_enlarge",
      animNameOut = "SelectedCell2_recover",
      animNameUnselected = "SelectedCell2_off",
      moveInPlayer = nil,
      moveOutPlayer = nil
    },
    [3] = {
      go = self.selectedFillAreaGo3,
      rect = self.selectedFillAreaRect3,
      imgLoader = self.selectedCardImg3,
      anim = self._selAnim3,
      animNamePutDown = "SelectedCell3_putdown",
      animNameIn = "SelectedCell3_enlarge",
      animNameOut = "SelectedCell3_recover",
      animNameUnselected = "SelectedCell3_off",
      moveInPlayer = nil,
      moveOutPlayer = nil
    }
  }
  self.selectedCardRes = {
    [FeatureCardType.A] = {
      res = "n21_jieruo_ka_red_l"
    },
    [FeatureCardType.B] = {
      res = "n21_jieruo_ka_yellow_l"
    },
    [FeatureCardType.C] = {
      res = "n21_jieruo_ka_blue_l"
    }
  }
  self.skillLocalInfoDic = {
    [1] = {title = "abc", infoParamType = 2},
    [2] = {title = "aaa", infoParamType = 1},
    [3] = {title = "aab", infoParamType = 0}
  }
  self.comTypeToSkillLocalInfoDic = {
    [FeatureCardCompositionType.ABC] = 1,
    [FeatureCardCompositionType.AAA] = 2,
    [FeatureCardCompositionType.BBB] = 2,
    [FeatureCardCompositionType.CCC] = 2,
    [FeatureCardCompositionType.AAB] = 3,
    [FeatureCardCompositionType.AAC] = 3,
    [FeatureCardCompositionType.BBA] = 3,
    [FeatureCardCompositionType.BBC] = 3,
    [FeatureCardCompositionType.CCA] = 3,
    [FeatureCardCompositionType.CCB] = 3
  }
  self:AttachDragEvent(FeatureCardType.A)
  self:AttachDragEvent(FeatureCardType.B)
  self:AttachDragEvent(FeatureCardType.C)
  self._dragEndDisappearAnimNames = {
    [FeatureCardType.A] = "DragCard_sun",
    [FeatureCardType.B] = "DragCard_moon",
    [FeatureCardType.C] = "DragCard_star"
  }
  self._dragEndDisRefreshDepotAnimNames = {
    [FeatureCardType.A] = "CardBagArea_A",
    [FeatureCardType.B] = "CardBagArea_B",
    [FeatureCardType.C] = "CardBagArea_C"
  }
  self:SetFontMat(self._castTextTmp, "battle_feature_card_info_l_text_mt.mat")
  self:SetFontMat(self._closeTextTmp, "battle_feature_card_info_l_text_mt.mat")
end
