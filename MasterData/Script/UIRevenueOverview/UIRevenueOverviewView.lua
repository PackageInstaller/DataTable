local RevenueOverview = {
  self = nil,
  Img_BG = nil,
  Img_Blur = nil,
  Img_TopBG = nil,
  Img_BGDecoration = nil,
  SpineAnimation_ = nil,
  Group_CommonTopLeft = {
    self = nil,
    Btn_Return = nil,
    Btn_Home = nil,
    Btn_Menu = nil,
    Btn_Help = {
      self = nil,
      Img_Tips = {
        self = nil,
        Img_icon = nil,
        Txt_ = nil
      }
    }
  },
  Group_Tab = {
    self = nil,
    ScrollGrid_Tab = {
      self = nil,
      grid = {
        self = nil,
        Group_Off = {
          self = nil,
          Img_ = nil,
          Txt_Name = nil,
          Img_Icon = nil
        },
        Group_On = {
          self = nil,
          Img_ = nil,
          Txt_Name = nil,
          Img_Icon = nil
        },
        Btn_ = nil
      }
    }
  },
  Group_MoneyTab = {
    self = nil,
    Group_On = {
      self = nil,
      Img_ = nil,
      Txt_Name = nil,
      Img_Icon = nil
    }
  },
  Group_Report = {
    self = nil,
    Img_RevenueTitle = nil,
    Img_BGBook = nil,
    Img_BGChart = nil,
    Group_RecentDays = {
      self = nil,
      Img_DecorationLine = nil,
      Txt_Title = nil,
      Img_BGLabel = {
        self = nil,
        Img_LastDays = nil,
        Txt_LastDays = nil,
        Img_Today = nil,
        Txt_Today = nil
      },
      Img_BGRecentDays = nil,
      Group_Day1Bar = {
        self = nil,
        Txt_Date = nil,
        Img_Bar = {
          self = nil,
          Img_Num = {self = nil, Txt_ = nil}
        }
      },
      Group_Day2Bar = {
        self = nil,
        Txt_Date = nil,
        Img_Bar = {
          self = nil,
          Img_Num = {self = nil, Txt_ = nil}
        }
      },
      Group_Day3Bar = {
        self = nil,
        Txt_Date = nil,
        Img_Bar = {
          self = nil,
          Img_Num = {self = nil, Txt_ = nil}
        }
      },
      Group_Day4Bar = {
        self = nil,
        Txt_Date = nil,
        Img_Bar = {
          self = nil,
          Img_Num = {self = nil, Txt_ = nil}
        }
      },
      Group_TodayBar = {
        self = nil,
        Img_ = nil,
        Txt_Date = nil,
        Img_Bar = {
          self = nil,
          Img_Dot = nil,
          Img_Num = {self = nil, Txt_ = nil}
        }
      }
    },
    Group_Ratio = {
      self = nil,
      Img_DecorationLine = nil,
      Txt_Title = nil,
      Group_Circle = {
        self = nil,
        Img_BGCircle = nil,
        Img_CircleTrade = nil,
        Img_CirclePassenger = nil,
        Img_CircleCoc = nil,
        Img_CircleBattle = nil,
        Img_CircleMaterial = nil,
        Img_CircleTrash = nil,
        Img_CircleIsland = nil,
        Img_CirclePrison = nil,
        Img_CirclePDD = nil
      },
      Group_Label = {
        self = nil,
        Img_ = nil,
        ScrollGrid_ = {
          self = nil,
          grid = {
            self = nil,
            Img_BG = nil,
            Img_Label = nil,
            Txt_Num = nil,
            Group_Title = {
              self = nil,
              Txt_Title = nil,
              Group_Top = {self = nil, Img_Top = nil}
            }
          }
        }
      }
    },
    Group_Pick = {
      self = nil,
      Img_ = nil,
      Btn_Report = {
        self = nil,
        Group_off = {self = nil, Txt_Num = nil},
        Group_On = {
          self = nil,
          Img_Pick = nil,
          Txt_Num = nil
        }
      },
      Btn_Ratio = {
        self = nil,
        Group_off = {self = nil, Txt_Num = nil},
        Group_On = {
          self = nil,
          Img_Pick = nil,
          Txt_Num = nil
        }
      }
    },
    Group_Date = {
      self = nil,
      Img_IconRevenue = nil,
      Txt_Day = nil,
      Img_BGDate = {
        self = nil,
        Txt_ = nil,
        Txt_ddl = nil
      },
      Txt_Tip = nil,
      Group_Money = {
        self = nil,
        Img_ = nil,
        Txt_ = nil
      }
    }
  },
  Group_Rank = {
    self = nil,
    Img_BGBook = nil,
    Img_DecorationLine = nil,
    Group_Title = {
      self = nil,
      Txt_Title = nil,
      Group_LikesNum = {
        self = nil,
        Img_bg = nil,
        Group_NumLikes = {
          self = nil,
          Img_Icon = nil,
          Txt_ = nil,
          Img_ = nil
        },
        Btn_ = nil
      }
    },
    Img_Lv = {
      self = nil,
      Img_Arrow = nil,
      Txt_ = nil,
      Btn_ = nil
    },
    Group_List = {
      self = nil,
      ScrollGrid_List = {
        self = nil,
        grid = {
          self = nil,
          Img_BG = nil,
          Img_ = nil,
          Btn_ProfilePhoto = {
            self = nil,
            Img_Head = nil,
            Img_spAdd = nil
          },
          Group_NameGrade = {
            self = nil,
            Txt_Name = nil,
            Group_Grade = {
              self = nil,
              Txt_ = nil,
              Txt_Grade = nil
            }
          },
          Img_Oneself = {self = nil, Txt_ = nil},
          Txt_Order = {self = nil, Txt_ = nil},
          Group_Likes = {
            self = nil,
            Group_Unlike = {
              self = nil,
              Img_ = nil,
              Img_Like = nil,
              Btn_ = nil
            },
            Group_Liked = {
              self = nil,
              Img_ = nil,
              Img_Like = nil,
              Group_Likes_effect = {
                self = nil,
                Glow = nil,
                huan = nil,
                spark = nil
              }
            }
          },
          Img_LikesNum = {
            self = nil,
            Img_ = nil,
            Txt_ = nil
          },
          Group_Content = {
            self = nil,
            Img_Icon = nil,
            Txt_Num = nil
          },
          Btn_Ratio = nil
        }
      }
    },
    Group_Empty = {
      self = nil,
      Img_ = nil,
      Txt_ = nil
    },
    Group_Oneself = {
      self = nil,
      Img_ = nil,
      Img_BG = nil,
      Img_ = nil,
      Btn_ProfilePhoto = {
        self = nil,
        Img_Head = nil,
        Img_spAdd = nil
      },
      Txt_Order = {self = nil, Txt_ = nil},
      Group_NameGrade = {
        self = nil,
        Txt_Name = {
          self = nil,
          Img_Oneself = {self = nil, Txt_ = nil}
        },
        Group_Grade = {
          self = nil,
          Txt_ = nil,
          Txt_Grade = nil
        }
      },
      Group_Content = {
        self = nil,
        Img_Icon = nil,
        Txt_Num = nil
      },
      Btn_Ratio = nil,
      Img_LikesNum = {
        self = nil,
        Img_ = nil,
        Txt_ = nil
      },
      Group_Likes = {
        self = nil,
        Group_Unlike = {
          self = nil,
          Img_ = nil,
          Img_Like = nil,
          Btn_ = nil
        },
        Group_Liked = {
          self = nil,
          Img_ = nil,
          Img_Like = nil,
          Group_Likes_effect = {
            self = nil,
            Glow = nil,
            huan = nil,
            spark = nil
          }
        }
      }
    },
    Group_Pick = {
      self = nil,
      Img_ = nil,
      Btn_Friend = {
        self = nil,
        Group_off = {self = nil, Txt_Num = nil},
        Group_On = {
          self = nil,
          Img_Pick = nil,
          Txt_Num = nil
        }
      },
      Btn_All = {
        self = nil,
        Group_off = {self = nil, Txt_Num = nil},
        Group_On = {
          self = nil,
          Img_Pick = nil,
          Txt_Num = nil
        }
      }
    },
    Img_RankTitle = nil,
    Group_Date = {
      self = nil,
      Img_IconRevenue = nil,
      Txt_Day = nil,
      Img_BGDate = {
        self = nil,
        Txt_ = nil,
        Txt_ddl = nil
      },
      Txt_Tip = nil,
      Group_Money = {
        self = nil,
        Img_ = nil,
        Txt_ = nil
      }
    },
    Group_OtherRatio = {
      self = nil,
      Img_Bg = nil,
      Img_ = nil,
      Img_Book = nil,
      Img_BGChart = nil,
      Img_DecorationLine = nil,
      Txt_Title = nil,
      Group_Circle = {
        self = nil,
        Img_BGCircle = nil,
        Img_CircleTrade = nil,
        Img_CirclePassenger = nil,
        Img_CircleCoc = nil,
        Img_CircleBattle = nil,
        Img_CircleMaterial = nil,
        Img_CircleTrash = nil,
        Img_CircleIsland = nil,
        Img_CirclePrison = nil,
        Img_CirclePDD = nil
      },
      Group_Label = {
        self = nil,
        Img_ = nil,
        ScrollGrid_ = {
          self = nil,
          grid = {
            self = nil,
            Img_BG = nil,
            Img_Label = nil,
            Txt_Num = nil,
            Group_Title = {
              self = nil,
              Txt_Title = nil,
              Group_Top = {self = nil, Img_Top = nil}
            }
          }
        }
      },
      Group_Title = {
        self = nil,
        Txt_Name = nil,
        Txt_Uid = nil,
        Txt_Tip = nil,
        Group_Money = {
          self = nil,
          Img_ = nil,
          Txt_ = nil
        },
        Img_BGProfile = nil,
        Btn_ProfilePhoto = {
          self = nil,
          Img_Head = nil,
          Img_spAdd = nil
        }
      },
      Btn_Close = nil
    },
    Group_LVInterval = {
      self = nil,
      StaticGrid_ = {
        self = nil,
        grid = {
          self = nil,
          Group_Unchoose = {
            self = nil,
            Btn_ = {self = nil, Txt_ = nil}
          },
          Group_Choose = {
            self = nil,
            Img_ = {self = nil, Txt_ = nil}
          }
        }
      }
    }
  },
  Group_Money = {
    self = nil,
    Img_BGBook = nil,
    Img_DecorationLine = nil,
    Group_Title = {self = nil, Txt_Title = nil},
    Img_Lv = {
      self = nil,
      Img_Arrow = nil,
      Txt_ = nil,
      Btn_ = nil
    },
    Group_List = {
      self = nil,
      ScrollGrid_List = {
        self = nil,
        grid = {
          self = nil,
          Img_BG = nil,
          Img_ = nil,
          Btn_ProfilePhoto = {
            self = nil,
            Img_Head = nil,
            Img_spAdd = nil
          },
          Group_NameGrade = {
            self = nil,
            Txt_Name = nil,
            Group_Grade = {
              self = nil,
              Txt_ = nil,
              Txt_Grade = nil
            }
          },
          Img_Oneself = {self = nil, Txt_ = nil},
          Txt_Order = {self = nil, Txt_ = nil},
          Group_Content = {
            self = nil,
            Img_Icon = nil,
            Txt_Num = nil
          },
          Img_Empty = nil
        }
      }
    },
    Group_Empty = {
      self = nil,
      Img_ = nil,
      Txt_ = nil
    },
    Group_Oneself = {
      self = nil,
      Img_ = nil,
      Img_BG = nil,
      Img_ = nil,
      Btn_ProfilePhoto = {
        self = nil,
        Img_Head = nil,
        Img_spAdd = nil
      },
      Txt_Order = {self = nil, Txt_ = nil},
      Group_NameGrade = {
        self = nil,
        Txt_Name = {
          self = nil,
          Img_Oneself = {self = nil, Txt_ = nil}
        },
        Group_Grade = {
          self = nil,
          Txt_ = nil,
          Txt_Grade = nil
        }
      },
      Group_Content = {
        self = nil,
        Img_Icon = nil,
        Txt_Num = nil
      }
    },
    Group_Pick = {
      self = nil,
      Img_ = nil,
      Btn_Friend = {
        self = nil,
        Group_off = {self = nil, Txt_Num = nil},
        Group_On = {
          self = nil,
          Img_Pick = nil,
          Txt_Num = nil
        }
      },
      Btn_All = {
        self = nil,
        Group_off = {self = nil, Txt_Num = nil},
        Group_On = {
          self = nil,
          Img_Pick = nil,
          Txt_Num = nil
        }
      }
    },
    Img_RankTitle = nil,
    Group_Date = {
      self = nil,
      Img_IconRevenue = nil,
      Txt_Day = nil,
      Img_BGDate = {self = nil, Txt_ = nil},
      Txt_Tip = nil,
      Group_Money = {
        self = nil,
        Img_ = nil,
        Txt_ = nil
      }
    },
    Group_LVInterval = {
      self = nil,
      StaticGrid_ = {
        self = nil,
        grid = {
          self = nil,
          Group_Unchoose = {
            self = nil,
            Btn_ = {self = nil, Txt_ = nil}
          },
          Group_Choose = {
            self = nil,
            Img_ = {self = nil, Txt_ = nil}
          }
        }
      }
    }
  },
  Group_PickPanel = {
    self = nil,
    Group_Report = {
      self = nil,
      Btn_ = nil,
      Img_Off = nil
    },
    Group_Rank = {
      self = nil,
      Btn_ = nil,
      Img_Off = nil
    },
    Group_Hurun = {
      self = nil,
      Btn_ = nil,
      Img_Off = nil
    }
  },
  Img_RedDot = nil,
  Img_GiveLikeMask = nil
}
return RevenueOverview
