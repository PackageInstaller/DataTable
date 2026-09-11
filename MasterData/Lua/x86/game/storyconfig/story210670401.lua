return {
	Play1106704001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1106704001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1106704002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST24 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST24")
				var_4_0.name = "ST24"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST24 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST24

				arg_1_1.bgs_.ST24.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST24" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 2

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = Color.New(0, 0, 0)

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_7.a = 0
				arg_1_1.mask_.color = var_4_7
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_10 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_10

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_10
						arg_1_1.bgmTxt2_.text = var_4_10
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.333333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.333333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_13 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_13

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_13
						arg_1_1.bgmTxt2_.text = var_4_13
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_side_1067", "se_story_1067_engrave", "")
			end

			local var_4_15 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_15 + 2.8 and arg_1_1.time_ < var_4_15 + 2.8 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_16 = 2
			local var_4_17 = 0.8

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0
				arg_1_1.dialogCg_.alpha = 1

				arg_1_1.dialog_:SetActive(true)
				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_18 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(1106704001).content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 32 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_18) / 32)

				if (32 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_18) / 32)) > 0 and var_4_17 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20

					if var_4_20 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_16
					end
				end

				arg_1_1.text_.text = var_4_18
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_21 = math.max(var_4_17, arg_1_1.talkMaxDuration)

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_21 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_16) / var_4_21

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_16 + var_4_21 and arg_1_1.time_ < var_4_16 + var_4_21 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play1106704002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 1106704002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play1106704003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1:AudioAction("stop", "effect", "se_story_side_1067", "se_story_1067_engrave", "")
			end

			local var_10_1 = 0
			local var_10_2 = 1.5

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_1 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, false)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_3 = arg_7_1:FormatText(arg_7_1:GetWordFromCfg(1106704002).content)

				arg_7_1.text_.text = var_10_3

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_5 = 60 <= 0 and var_10_2 or var_10_2 * (utf8.len(var_10_3) / 60)

				if (60 <= 0 and var_10_2 or var_10_2 * (utf8.len(var_10_3) / 60)) > 0 and var_10_2 < var_10_5 then
					arg_7_1.talkMaxDuration = var_10_5

					if var_10_5 + var_10_1 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_5 + var_10_1
					end
				end

				arg_7_1.text_.text = var_10_3
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)
				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_6 = math.max(var_10_2, arg_7_1.talkMaxDuration)

			if var_10_1 <= arg_7_1.time_ and arg_7_1.time_ < var_10_1 + var_10_6 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_1) / var_10_6

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_1 + var_10_6 and arg_7_1.time_ < var_10_1 + var_10_6 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play1106704003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 1106704003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play1106704004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1:AudioAction("play", "effect", "se_story_side_1067", "se_story_1067_ring", "")
			end

			local var_14_1 = 0
			local var_14_2 = 0.1

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_1 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, false)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_3 = arg_11_1:FormatText(arg_11_1:GetWordFromCfg(1106704003).content)

				arg_11_1.text_.text = var_14_3

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_5 = 4 <= 0 and var_14_2 or var_14_2 * (utf8.len(var_14_3) / 4)

				if (4 <= 0 and var_14_2 or var_14_2 * (utf8.len(var_14_3) / 4)) > 0 and var_14_2 < var_14_5 then
					arg_11_1.talkMaxDuration = var_14_5

					if var_14_5 + var_14_1 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_5 + var_14_1
					end
				end

				arg_11_1.text_.text = var_14_3
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_6 = math.max(var_14_2, arg_11_1.talkMaxDuration)

			if var_14_1 <= arg_11_1.time_ and arg_11_1.time_ < var_14_1 + var_14_6 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_1) / var_14_6

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_1 + var_14_6 and arg_11_1.time_ < var_14_1 + var_14_6 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play1106704004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 1106704004
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play1106704005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1:AudioAction("stop", "effect", "se_story_side_1067", "se_story_1067_ring", "")
			end

			local var_18_1 = 0
			local var_18_2 = 0.825

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_1 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, true)
				arg_15_1.iconController_:SetSelectedState("hero")

				arg_15_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_15_1.callingController_:SetSelectedState("normal")

				arg_15_1.keyicon_.color = Color.New(1, 1, 1)
				arg_15_1.icon_.color = Color.New(1, 1, 1)

				local var_18_3 = arg_15_1:FormatText(arg_15_1:GetWordFromCfg(1106704004).content)

				arg_15_1.text_.text = var_18_3

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_5 = 33 <= 0 and var_18_2 or var_18_2 * (utf8.len(var_18_3) / 33)

				if (33 <= 0 and var_18_2 or var_18_2 * (utf8.len(var_18_3) / 33)) > 0 and var_18_2 < var_18_5 then
					arg_15_1.talkMaxDuration = var_18_5

					if var_18_5 + var_18_1 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_5 + var_18_1
					end
				end

				arg_15_1.text_.text = var_18_3
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_6 = math.max(var_18_2, arg_15_1.talkMaxDuration)

			if var_18_1 <= arg_15_1.time_ and arg_15_1.time_ < var_18_1 + var_18_6 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_1) / var_18_6

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_1 + var_18_6 and arg_15_1.time_ < var_18_1 + var_18_6 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play1106704005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 1106704005
		arg_19_1.duration_ = 5.2

		local var_19_0 = {
			zh = 3.133,
			ja = 5.2
		}
		local var_19_1 = manager.audio:GetLocalizationFlag()

		if var_19_0[var_19_1] ~= nil then
			arg_19_1.duration_ = var_19_0[var_19_1]
		end

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play1106704006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if arg_19_1.actors_["1042ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1042ui_story"))) then
				local var_22_0 = Object.Instantiate(Asset.Load("Char/" .. "1042ui_story"), arg_19_1.stage_.transform)

				var_22_0.name = "1042ui_story"
				var_22_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_19_1.actors_["1042ui_story"] = var_22_0

				local var_22_1 = var_22_0:GetComponentInChildren(typeof(CharacterEffect))

				var_22_1.enabled = true

				local var_22_2 = GameObjectTools.GetOrAddComponent(var_22_0, typeof(DynamicBoneHelper))

				if var_22_2 then
					var_22_2:EnableDynamicBone(false)
				end

				arg_19_1:ShowWeapon(var_22_1.transform, false)

				arg_19_1.var_["1042ui_story" .. "Animator"] = var_22_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_19_1.var_["1042ui_story" .. "Animator"].applyRootMotion = true
				arg_19_1.var_["1042ui_story" .. "LipSync"] = var_22_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_22_3 = arg_19_1.actors_["1042ui_story"].transform

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos1042ui_story = var_22_3.localPosition
			end

			local var_22_4 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_4 then
				var_22_3.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1042ui_story, Vector3.New(0, -1.06, -6.2), (arg_19_1.time_ - 0) / var_22_4)
				var_22_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_22_3.position).x, (manager.ui.mainCamera.transform.position - var_22_3.position).y, (manager.ui.mainCamera.transform.position - var_22_3.position).z)
				var_22_3.localEulerAngles.z = 0
				var_22_3.localEulerAngles.x = 0
				var_22_3.localEulerAngles = var_22_3.localEulerAngles
			end

			if arg_19_1.time_ >= 0 + var_22_4 and arg_19_1.time_ < 0 + var_22_4 + arg_22_0 then
				var_22_3.localPosition = Vector3.New(0, -1.06, -6.2)
				var_22_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_22_3.position).x, (manager.ui.mainCamera.transform.position - var_22_3.position).y, (manager.ui.mainCamera.transform.position - var_22_3.position).z)
				var_22_3.localEulerAngles.z = 0
				var_22_3.localEulerAngles.x = 0
				var_22_3.localEulerAngles = var_22_3.localEulerAngles
			end

			local var_22_5 = arg_19_1.actors_["1042ui_story"]

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(var_22_5) and arg_19_1.var_.characterEffect1042ui_story == nil then
				arg_19_1.var_.characterEffect1042ui_story = var_22_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_6 = 0.2

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_6 and not isNil(var_22_5) then
				if arg_19_1.var_.characterEffect1042ui_story and not isNil(var_22_5) then
					arg_19_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_19_1.time_ >= 0 + var_22_6 and arg_19_1.time_ < 0 + var_22_6 + arg_22_0 and not isNil(var_22_5) and arg_19_1.var_.characterEffect1042ui_story then
				arg_19_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action8_1")
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				if arg_19_1.var_.characterEffect1042ui_story == nil then
					arg_19_1.var_.characterEffect1042ui_story = arg_19_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_22_8 = arg_19_1.var_.characterEffect1042ui_story

				arg_19_1.var_.characterEffect1042ui_story.imageEffect:turnOff()

				var_22_8.interferenceEffect.enabled = true
				var_22_8.interferenceEffect.noise = 0.001
				var_22_8.interferenceEffect.simTimeScale = 1
				var_22_8.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				if arg_19_1.var_.characterEffect1042ui_story == nil then
					arg_19_1.var_.characterEffect1042ui_story = arg_19_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_19_1.var_.characterEffect1042ui_story.imageEffect:turnOn(false)
			end

			local var_22_10 = 0
			local var_22_11 = 0.375

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_10 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_12 = arg_19_1:GetWordFromCfg(1106704005)
				local var_22_13 = arg_19_1:FormatText(var_22_12.content)

				arg_19_1.text_.text = var_22_13

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_15 = 15 <= 0 and var_22_11 or var_22_11 * (utf8.len(var_22_13) / 15)

				if (15 <= 0 and var_22_11 or var_22_11 * (utf8.len(var_22_13) / 15)) > 0 and var_22_11 < var_22_15 then
					arg_19_1.talkMaxDuration = var_22_15

					if var_22_15 + var_22_10 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_15 + var_22_10
					end
				end

				arg_19_1.text_.text = var_22_13
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704005", "story_v_side_new_1106704.awb") ~= 0 then
					local var_22_16 = manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704005", "story_v_side_new_1106704.awb") / 1000

					if var_22_16 + var_22_10 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_16 + var_22_10
					end

					if var_22_12.prefab_name ~= "" and arg_19_1.actors_[var_22_12.prefab_name] ~= nil then
						local var_22_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_12.prefab_name].transform, "story_v_side_new_1106704", "1106704005", "story_v_side_new_1106704.awb")

						arg_19_1:RecordAudio("1106704005", var_22_17)
						arg_19_1:RecordAudio("1106704005", var_22_17)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_side_new_1106704", "1106704005", "story_v_side_new_1106704.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_side_new_1106704", "1106704005", "story_v_side_new_1106704.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_18 = math.max(var_22_11, arg_19_1.talkMaxDuration)

			if var_22_10 <= arg_19_1.time_ and arg_19_1.time_ < var_22_10 + var_22_18 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_10) / var_22_18

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_10 + var_22_18 and arg_19_1.time_ < var_22_10 + var_22_18 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_19_1:InitPlayNodeList()
	end,
	Play1106704006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 1106704006
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play1106704007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(arg_23_1.actors_["1042ui_story"]) and arg_23_1.var_.characterEffect1042ui_story == nil then
				arg_23_1.var_.characterEffect1042ui_story = arg_23_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_0 = 0.2

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_0 and not isNil(arg_23_1.actors_["1042ui_story"]) then
				if arg_23_1.var_.characterEffect1042ui_story and not isNil(arg_23_1.actors_["1042ui_story"]) then
					arg_23_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_23_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_23_1.time_ - 0) / var_26_0)
				end
			end

			if arg_23_1.time_ >= 0 + var_26_0 and arg_23_1.time_ < 0 + var_26_0 + arg_26_0 and not isNil(arg_23_1.actors_["1042ui_story"]) and arg_23_1.var_.characterEffect1042ui_story then
				arg_23_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_23_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_26_1 = 0
			local var_26_2 = 0.25

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_1 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, true)
				arg_23_1.iconController_:SetSelectedState("hero")

				arg_23_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_23_1.callingController_:SetSelectedState("normal")

				arg_23_1.keyicon_.color = Color.New(1, 1, 1)
				arg_23_1.icon_.color = Color.New(1, 1, 1)

				local var_26_3 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(1106704006).content)

				arg_23_1.text_.text = var_26_3

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_5 = 10 <= 0 and var_26_2 or var_26_2 * (utf8.len(var_26_3) / 10)

				if (10 <= 0 and var_26_2 or var_26_2 * (utf8.len(var_26_3) / 10)) > 0 and var_26_2 < var_26_5 then
					arg_23_1.talkMaxDuration = var_26_5

					if var_26_5 + var_26_1 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_5 + var_26_1
					end
				end

				arg_23_1.text_.text = var_26_3
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_6 = math.max(var_26_2, arg_23_1.talkMaxDuration)

			if var_26_1 <= arg_23_1.time_ and arg_23_1.time_ < var_26_1 + var_26_6 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_1) / var_26_6

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_1 + var_26_6 and arg_23_1.time_ < var_26_1 + var_26_6 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play1106704007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 1106704007
		arg_27_1.duration_ = 9.5

		local var_27_0 = {
			zh = 6.2,
			ja = 9.5
		}
		local var_27_1 = manager.audio:GetLocalizationFlag()

		if var_27_0[var_27_1] ~= nil then
			arg_27_1.duration_ = var_27_0[var_27_1]
		end

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play1106704008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(arg_27_1.actors_["1042ui_story"]) and arg_27_1.var_.characterEffect1042ui_story == nil then
				arg_27_1.var_.characterEffect1042ui_story = arg_27_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_0 = 0.2

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 and not isNil(arg_27_1.actors_["1042ui_story"]) then
				if arg_27_1.var_.characterEffect1042ui_story and not isNil(arg_27_1.actors_["1042ui_story"]) then
					arg_27_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 and not isNil(arg_27_1.actors_["1042ui_story"]) and arg_27_1.var_.characterEffect1042ui_story then
				arg_27_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action8_2")
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_30_2 = 0
			local var_30_3 = 0.8

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_2 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_4 = arg_27_1:GetWordFromCfg(1106704007)
				local var_30_5 = arg_27_1:FormatText(var_30_4.content)

				arg_27_1.text_.text = var_30_5

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_7 = 32 <= 0 and var_30_3 or var_30_3 * (utf8.len(var_30_5) / 32)

				if (32 <= 0 and var_30_3 or var_30_3 * (utf8.len(var_30_5) / 32)) > 0 and var_30_3 < var_30_7 then
					arg_27_1.talkMaxDuration = var_30_7

					if var_30_7 + var_30_2 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_7 + var_30_2
					end
				end

				arg_27_1.text_.text = var_30_5
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704007", "story_v_side_new_1106704.awb") ~= 0 then
					local var_30_8 = manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704007", "story_v_side_new_1106704.awb") / 1000

					if var_30_8 + var_30_2 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_8 + var_30_2
					end

					if var_30_4.prefab_name ~= "" and arg_27_1.actors_[var_30_4.prefab_name] ~= nil then
						local var_30_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_4.prefab_name].transform, "story_v_side_new_1106704", "1106704007", "story_v_side_new_1106704.awb")

						arg_27_1:RecordAudio("1106704007", var_30_9)
						arg_27_1:RecordAudio("1106704007", var_30_9)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_side_new_1106704", "1106704007", "story_v_side_new_1106704.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_side_new_1106704", "1106704007", "story_v_side_new_1106704.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_10 = math.max(var_30_3, arg_27_1.talkMaxDuration)

			if var_30_2 <= arg_27_1.time_ and arg_27_1.time_ < var_30_2 + var_30_10 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_2) / var_30_10

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_2 + var_30_10 and arg_27_1.time_ < var_30_2 + var_30_10 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play1106704008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 1106704008
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play1106704009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(arg_31_1.actors_["1042ui_story"]) and arg_31_1.var_.characterEffect1042ui_story == nil then
				arg_31_1.var_.characterEffect1042ui_story = arg_31_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_0 = 0.2

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 and not isNil(arg_31_1.actors_["1042ui_story"]) then
				if arg_31_1.var_.characterEffect1042ui_story and not isNil(arg_31_1.actors_["1042ui_story"]) then
					arg_31_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_31_1.time_ - 0) / var_34_0)
				end
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 and not isNil(arg_31_1.actors_["1042ui_story"]) and arg_31_1.var_.characterEffect1042ui_story then
				arg_31_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_34_1 = 0
			local var_34_2 = 0.65

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, true)
				arg_31_1.iconController_:SetSelectedState("hero")

				arg_31_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_31_1.callingController_:SetSelectedState("normal")

				arg_31_1.keyicon_.color = Color.New(1, 1, 1)
				arg_31_1.icon_.color = Color.New(1, 1, 1)

				local var_34_3 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(1106704008).content)

				arg_31_1.text_.text = var_34_3

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_5 = 26 <= 0 and var_34_2 or var_34_2 * (utf8.len(var_34_3) / 26)

				if (26 <= 0 and var_34_2 or var_34_2 * (utf8.len(var_34_3) / 26)) > 0 and var_34_2 < var_34_5 then
					arg_31_1.talkMaxDuration = var_34_5

					if var_34_5 + var_34_1 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_5 + var_34_1
					end
				end

				arg_31_1.text_.text = var_34_3
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_6 = math.max(var_34_2, arg_31_1.talkMaxDuration)

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_6 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_1) / var_34_6

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_1 + var_34_6 and arg_31_1.time_ < var_34_1 + var_34_6 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play1106704009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 1106704009
		arg_35_1.duration_ = 8.9

		local var_35_0 = {
			zh = 7.466,
			ja = 8.9
		}
		local var_35_1 = manager.audio:GetLocalizationFlag()

		if var_35_0[var_35_1] ~= nil then
			arg_35_1.duration_ = var_35_0[var_35_1]
		end

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play1106704010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(arg_35_1.actors_["1042ui_story"]) and arg_35_1.var_.characterEffect1042ui_story == nil then
				arg_35_1.var_.characterEffect1042ui_story = arg_35_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_0 = 0.2

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 and not isNil(arg_35_1.actors_["1042ui_story"]) then
				if arg_35_1.var_.characterEffect1042ui_story and not isNil(arg_35_1.actors_["1042ui_story"]) then
					arg_35_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 and not isNil(arg_35_1.actors_["1042ui_story"]) and arg_35_1.var_.characterEffect1042ui_story then
				arg_35_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action6_1")
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_38_2 = 0
			local var_38_3 = 0.875

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_2 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_4 = arg_35_1:GetWordFromCfg(1106704009)
				local var_38_5 = arg_35_1:FormatText(var_38_4.content)

				arg_35_1.text_.text = var_38_5

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_7 = 35 <= 0 and var_38_3 or var_38_3 * (utf8.len(var_38_5) / 35)

				if (35 <= 0 and var_38_3 or var_38_3 * (utf8.len(var_38_5) / 35)) > 0 and var_38_3 < var_38_7 then
					arg_35_1.talkMaxDuration = var_38_7

					if var_38_7 + var_38_2 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_7 + var_38_2
					end
				end

				arg_35_1.text_.text = var_38_5
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704009", "story_v_side_new_1106704.awb") ~= 0 then
					local var_38_8 = manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704009", "story_v_side_new_1106704.awb") / 1000

					if var_38_8 + var_38_2 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_8 + var_38_2
					end

					if var_38_4.prefab_name ~= "" and arg_35_1.actors_[var_38_4.prefab_name] ~= nil then
						local var_38_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_4.prefab_name].transform, "story_v_side_new_1106704", "1106704009", "story_v_side_new_1106704.awb")

						arg_35_1:RecordAudio("1106704009", var_38_9)
						arg_35_1:RecordAudio("1106704009", var_38_9)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_side_new_1106704", "1106704009", "story_v_side_new_1106704.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_side_new_1106704", "1106704009", "story_v_side_new_1106704.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_10 = math.max(var_38_3, arg_35_1.talkMaxDuration)

			if var_38_2 <= arg_35_1.time_ and arg_35_1.time_ < var_38_2 + var_38_10 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_2) / var_38_10

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_2 + var_38_10 and arg_35_1.time_ < var_38_2 + var_38_10 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play1106704010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 1106704010
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play1106704011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(arg_39_1.actors_["1042ui_story"]) and arg_39_1.var_.characterEffect1042ui_story == nil then
				arg_39_1.var_.characterEffect1042ui_story = arg_39_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_0 = 0.2

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 and not isNil(arg_39_1.actors_["1042ui_story"]) then
				if arg_39_1.var_.characterEffect1042ui_story and not isNil(arg_39_1.actors_["1042ui_story"]) then
					arg_39_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_39_1.time_ - 0) / var_42_0)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 and not isNil(arg_39_1.actors_["1042ui_story"]) and arg_39_1.var_.characterEffect1042ui_story then
				arg_39_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_42_1 = 0
			local var_42_2 = 0.25

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_3 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(1106704010).content)

				arg_39_1.text_.text = var_42_3

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_5 = 10 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_3) / 10)

				if (10 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_3) / 10)) > 0 and var_42_2 < var_42_5 then
					arg_39_1.talkMaxDuration = var_42_5

					if var_42_5 + var_42_1 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_5 + var_42_1
					end
				end

				arg_39_1.text_.text = var_42_3
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_6 = math.max(var_42_2, arg_39_1.talkMaxDuration)

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_6 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_1) / var_42_6

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_1 + var_42_6 and arg_39_1.time_ < var_42_1 + var_42_6 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play1106704011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 1106704011
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play1106704012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0.8

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_1 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(1106704011).content)

				arg_43_1.text_.text = var_46_1

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_3 = 32 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 32)

				if (32 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 32)) > 0 and var_46_0 < var_46_3 then
					arg_43_1.talkMaxDuration = var_46_3

					if var_46_3 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_3 + 0
					end
				end

				arg_43_1.text_.text = var_46_1
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_4 = math.max(var_46_0, arg_43_1.talkMaxDuration)

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_4 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - 0) / var_46_4

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= 0 + var_46_4 and arg_43_1.time_ < 0 + var_46_4 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play1106704012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 1106704012
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play1106704013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0.225

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_1 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(1106704012).content)

				arg_47_1.text_.text = var_50_1

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_3 = 9 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_1) / 9)

				if (9 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_1) / 9)) > 0 and var_50_0 < var_50_3 then
					arg_47_1.talkMaxDuration = var_50_3

					if var_50_3 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_3 + 0
					end
				end

				arg_47_1.text_.text = var_50_1
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_4 = math.max(var_50_0, arg_47_1.talkMaxDuration)

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_4 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - 0) / var_50_4

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= 0 + var_50_4 and arg_47_1.time_ < 0 + var_50_4 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play1106704013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 1106704013
		arg_51_1.duration_ = 4.93

		local var_51_0 = {
			zh = 2.766,
			ja = 4.933
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play1106704014(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(arg_51_1.actors_["1042ui_story"]) and arg_51_1.var_.characterEffect1042ui_story == nil then
				arg_51_1.var_.characterEffect1042ui_story = arg_51_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_0 = 0.2

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 and not isNil(arg_51_1.actors_["1042ui_story"]) then
				if arg_51_1.var_.characterEffect1042ui_story and not isNil(arg_51_1.actors_["1042ui_story"]) then
					arg_51_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 and not isNil(arg_51_1.actors_["1042ui_story"]) and arg_51_1.var_.characterEffect1042ui_story then
				arg_51_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action6_2")
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_54_2 = 0
			local var_54_3 = 0.25

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_2 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_4 = arg_51_1:GetWordFromCfg(1106704013)
				local var_54_5 = arg_51_1:FormatText(var_54_4.content)

				arg_51_1.text_.text = var_54_5

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_7 = 10 <= 0 and var_54_3 or var_54_3 * (utf8.len(var_54_5) / 10)

				if (10 <= 0 and var_54_3 or var_54_3 * (utf8.len(var_54_5) / 10)) > 0 and var_54_3 < var_54_7 then
					arg_51_1.talkMaxDuration = var_54_7

					if var_54_7 + var_54_2 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_7 + var_54_2
					end
				end

				arg_51_1.text_.text = var_54_5
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704013", "story_v_side_new_1106704.awb") ~= 0 then
					local var_54_8 = manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704013", "story_v_side_new_1106704.awb") / 1000

					if var_54_8 + var_54_2 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_8 + var_54_2
					end

					if var_54_4.prefab_name ~= "" and arg_51_1.actors_[var_54_4.prefab_name] ~= nil then
						local var_54_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_4.prefab_name].transform, "story_v_side_new_1106704", "1106704013", "story_v_side_new_1106704.awb")

						arg_51_1:RecordAudio("1106704013", var_54_9)
						arg_51_1:RecordAudio("1106704013", var_54_9)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_side_new_1106704", "1106704013", "story_v_side_new_1106704.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_side_new_1106704", "1106704013", "story_v_side_new_1106704.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_10 = math.max(var_54_3, arg_51_1.talkMaxDuration)

			if var_54_2 <= arg_51_1.time_ and arg_51_1.time_ < var_54_2 + var_54_10 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_2) / var_54_10

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_2 + var_54_10 and arg_51_1.time_ < var_54_2 + var_54_10 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play1106704014 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 1106704014
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play1106704015(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(arg_55_1.actors_["1042ui_story"]) and arg_55_1.var_.characterEffect1042ui_story == nil then
				arg_55_1.var_.characterEffect1042ui_story = arg_55_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_0 = 0.2

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 and not isNil(arg_55_1.actors_["1042ui_story"]) then
				if arg_55_1.var_.characterEffect1042ui_story and not isNil(arg_55_1.actors_["1042ui_story"]) then
					arg_55_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_55_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_55_1.time_ - 0) / var_58_0)
				end
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 and not isNil(arg_55_1.actors_["1042ui_story"]) and arg_55_1.var_.characterEffect1042ui_story then
				arg_55_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_55_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_58_1 = 0
			local var_58_2 = 0.95

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_3 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(1106704014).content)

				arg_55_1.text_.text = var_58_3

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_5 = 38 <= 0 and var_58_2 or var_58_2 * (utf8.len(var_58_3) / 38)

				if (38 <= 0 and var_58_2 or var_58_2 * (utf8.len(var_58_3) / 38)) > 0 and var_58_2 < var_58_5 then
					arg_55_1.talkMaxDuration = var_58_5

					if var_58_5 + var_58_1 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_5 + var_58_1
					end
				end

				arg_55_1.text_.text = var_58_3
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_6 = math.max(var_58_2, arg_55_1.talkMaxDuration)

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_6 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_1) / var_58_6

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_1 + var_58_6 and arg_55_1.time_ < var_58_1 + var_58_6 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play1106704015 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 1106704015
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play1106704016(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0.325

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_1 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(1106704015).content)

				arg_59_1.text_.text = var_62_1

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_3 = 13 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 13)

				if (13 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 13)) > 0 and var_62_0 < var_62_3 then
					arg_59_1.talkMaxDuration = var_62_3

					if var_62_3 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_3 + 0
					end
				end

				arg_59_1.text_.text = var_62_1
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_4 = math.max(var_62_0, arg_59_1.talkMaxDuration)

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_4 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - 0) / var_62_4

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= 0 + var_62_4 and arg_59_1.time_ < 0 + var_62_4 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play1106704016 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 1106704016
		arg_63_1.duration_ = 6.83

		local var_63_0 = {
			zh = 3.8,
			ja = 6.833
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play1106704017(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["1042ui_story"]) and arg_63_1.var_.characterEffect1042ui_story == nil then
				arg_63_1.var_.characterEffect1042ui_story = arg_63_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_0 = 0.2

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["1042ui_story"]) then
				if arg_63_1.var_.characterEffect1042ui_story and not isNil(arg_63_1.actors_["1042ui_story"]) then
					arg_63_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["1042ui_story"]) and arg_63_1.var_.characterEffect1042ui_story then
				arg_63_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_66_2 = 0
			local var_66_3 = 0.425

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_2 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_4 = arg_63_1:GetWordFromCfg(1106704016)
				local var_66_5 = arg_63_1:FormatText(var_66_4.content)

				arg_63_1.text_.text = var_66_5

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_7 = 17 <= 0 and var_66_3 or var_66_3 * (utf8.len(var_66_5) / 17)

				if (17 <= 0 and var_66_3 or var_66_3 * (utf8.len(var_66_5) / 17)) > 0 and var_66_3 < var_66_7 then
					arg_63_1.talkMaxDuration = var_66_7

					if var_66_7 + var_66_2 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_7 + var_66_2
					end
				end

				arg_63_1.text_.text = var_66_5
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704016", "story_v_side_new_1106704.awb") ~= 0 then
					local var_66_8 = manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704016", "story_v_side_new_1106704.awb") / 1000

					if var_66_8 + var_66_2 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_8 + var_66_2
					end

					if var_66_4.prefab_name ~= "" and arg_63_1.actors_[var_66_4.prefab_name] ~= nil then
						local var_66_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_4.prefab_name].transform, "story_v_side_new_1106704", "1106704016", "story_v_side_new_1106704.awb")

						arg_63_1:RecordAudio("1106704016", var_66_9)
						arg_63_1:RecordAudio("1106704016", var_66_9)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_side_new_1106704", "1106704016", "story_v_side_new_1106704.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_side_new_1106704", "1106704016", "story_v_side_new_1106704.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_10 = math.max(var_66_3, arg_63_1.talkMaxDuration)

			if var_66_2 <= arg_63_1.time_ and arg_63_1.time_ < var_66_2 + var_66_10 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_2) / var_66_10

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_2 + var_66_10 and arg_63_1.time_ < var_66_2 + var_66_10 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play1106704017 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 1106704017
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play1106704018(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(arg_67_1.actors_["1042ui_story"]) and arg_67_1.var_.characterEffect1042ui_story == nil then
				arg_67_1.var_.characterEffect1042ui_story = arg_67_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_0 = 0.2

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 and not isNil(arg_67_1.actors_["1042ui_story"]) then
				if arg_67_1.var_.characterEffect1042ui_story and not isNil(arg_67_1.actors_["1042ui_story"]) then
					arg_67_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_67_1.time_ - 0) / var_70_0)
				end
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 and not isNil(arg_67_1.actors_["1042ui_story"]) and arg_67_1.var_.characterEffect1042ui_story then
				arg_67_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_70_1 = 0
			local var_70_2 = 0.325

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_3 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(1106704017).content)

				arg_67_1.text_.text = var_70_3

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 13 <= 0 and var_70_2 or var_70_2 * (utf8.len(var_70_3) / 13)

				if (13 <= 0 and var_70_2 or var_70_2 * (utf8.len(var_70_3) / 13)) > 0 and var_70_2 < var_70_5 then
					arg_67_1.talkMaxDuration = var_70_5

					if var_70_5 + var_70_1 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_5 + var_70_1
					end
				end

				arg_67_1.text_.text = var_70_3
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_6 = math.max(var_70_2, arg_67_1.talkMaxDuration)

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_6 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_1) / var_70_6

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_1 + var_70_6 and arg_67_1.time_ < var_70_1 + var_70_6 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play1106704018 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 1106704018
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play1106704019(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0.625

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_1 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(1106704018).content)

				arg_71_1.text_.text = var_74_1

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_3 = 25 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_1) / 25)

				if (25 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_1) / 25)) > 0 and var_74_0 < var_74_3 then
					arg_71_1.talkMaxDuration = var_74_3

					if var_74_3 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_3 + 0
					end
				end

				arg_71_1.text_.text = var_74_1
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_4 = math.max(var_74_0, arg_71_1.talkMaxDuration)

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_4 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - 0) / var_74_4

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= 0 + var_74_4 and arg_71_1.time_ < 0 + var_74_4 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play1106704019 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 1106704019
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play1106704020(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos1042ui_story = arg_75_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_78_0 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 then
				arg_75_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_75_1.time_ - 0) / var_78_0)
				arg_75_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1042ui_story"].transform.position).z)
				arg_75_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["1042ui_story"].transform.localEulerAngles = arg_75_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 then
				arg_75_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_75_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1042ui_story"].transform.position).z)
				arg_75_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["1042ui_story"].transform.localEulerAngles = arg_75_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			local var_78_1 = 0
			local var_78_2 = 0.975

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_3 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(1106704019).content)

				arg_75_1.text_.text = var_78_3

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 39 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_3) / 39)

				if (39 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_3) / 39)) > 0 and var_78_2 < var_78_5 then
					arg_75_1.talkMaxDuration = var_78_5

					if var_78_5 + var_78_1 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_5 + var_78_1
					end
				end

				arg_75_1.text_.text = var_78_3
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_6 = math.max(var_78_2, arg_75_1.talkMaxDuration)

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_6 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_1) / var_78_6

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_1 + var_78_6 and arg_75_1.time_ < var_78_1 + var_78_6 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_75_1:InitPlayNodeList()
	end,
	Play1106704020 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 1106704020
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play1106704021(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0.5

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_1 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(1106704020).content)

				arg_79_1.text_.text = var_82_1

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_3 = 20 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_1) / 20)

				if (20 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_1) / 20)) > 0 and var_82_0 < var_82_3 then
					arg_79_1.talkMaxDuration = var_82_3

					if var_82_3 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_3 + 0
					end
				end

				arg_79_1.text_.text = var_82_1
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_4 = math.max(var_82_0, arg_79_1.talkMaxDuration)

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_4 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - 0) / var_82_4

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= 0 + var_82_4 and arg_79_1.time_ < 0 + var_82_4 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play1106704021 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 1106704021
		arg_83_1.duration_ = 8.8

		local var_83_0 = {
			zh = 5.2,
			ja = 8.8
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play1106704022(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if arg_83_1.actors_["1067ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1067ui_story"))) then
				local var_86_0 = Object.Instantiate(Asset.Load("Char/" .. "1067ui_story"), arg_83_1.stage_.transform)

				var_86_0.name = "1067ui_story"
				var_86_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_83_1.actors_["1067ui_story"] = var_86_0

				local var_86_1 = var_86_0:GetComponentInChildren(typeof(CharacterEffect))

				var_86_1.enabled = true

				local var_86_2 = GameObjectTools.GetOrAddComponent(var_86_0, typeof(DynamicBoneHelper))

				if var_86_2 then
					var_86_2:EnableDynamicBone(false)
				end

				arg_83_1:ShowWeapon(var_86_1.transform, false)

				arg_83_1.var_["1067ui_story" .. "Animator"] = var_86_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_83_1.var_["1067ui_story" .. "Animator"].applyRootMotion = true
				arg_83_1.var_["1067ui_story" .. "LipSync"] = var_86_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_86_3 = arg_83_1.actors_["1067ui_story"].transform

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos1067ui_story = var_86_3.localPosition
			end

			local var_86_4 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_4 then
				var_86_3.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1067ui_story, Vector3.New(0, -1.06, -6.2), (arg_83_1.time_ - 0) / var_86_4)
				var_86_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_86_3.position).x, (manager.ui.mainCamera.transform.position - var_86_3.position).y, (manager.ui.mainCamera.transform.position - var_86_3.position).z)
				var_86_3.localEulerAngles.z = 0
				var_86_3.localEulerAngles.x = 0
				var_86_3.localEulerAngles = var_86_3.localEulerAngles
			end

			if arg_83_1.time_ >= 0 + var_86_4 and arg_83_1.time_ < 0 + var_86_4 + arg_86_0 then
				var_86_3.localPosition = Vector3.New(0, -1.06, -6.2)
				var_86_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_86_3.position).x, (manager.ui.mainCamera.transform.position - var_86_3.position).y, (manager.ui.mainCamera.transform.position - var_86_3.position).z)
				var_86_3.localEulerAngles.z = 0
				var_86_3.localEulerAngles.x = 0
				var_86_3.localEulerAngles = var_86_3.localEulerAngles
			end

			local var_86_5 = arg_83_1.actors_["1067ui_story"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_5) and arg_83_1.var_.characterEffect1067ui_story == nil then
				arg_83_1.var_.characterEffect1067ui_story = var_86_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_6 = 0.2

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_6 and not isNil(var_86_5) then
				if arg_83_1.var_.characterEffect1067ui_story and not isNil(var_86_5) then
					arg_83_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= 0 + var_86_6 and arg_83_1.time_ < 0 + var_86_6 + arg_86_0 and not isNil(var_86_5) and arg_83_1.var_.characterEffect1067ui_story then
				arg_83_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action3_1")
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_86_8 = 0
			local var_86_9 = 0.65

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_8 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_10 = arg_83_1:GetWordFromCfg(1106704021)
				local var_86_11 = arg_83_1:FormatText(var_86_10.content)

				arg_83_1.text_.text = var_86_11

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_13 = 26 <= 0 and var_86_9 or var_86_9 * (utf8.len(var_86_11) / 26)

				if (26 <= 0 and var_86_9 or var_86_9 * (utf8.len(var_86_11) / 26)) > 0 and var_86_9 < var_86_13 then
					arg_83_1.talkMaxDuration = var_86_13

					if var_86_13 + var_86_8 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_13 + var_86_8
					end
				end

				arg_83_1.text_.text = var_86_11
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704021", "story_v_side_new_1106704.awb") ~= 0 then
					local var_86_14 = manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704021", "story_v_side_new_1106704.awb") / 1000

					if var_86_14 + var_86_8 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_14 + var_86_8
					end

					if var_86_10.prefab_name ~= "" and arg_83_1.actors_[var_86_10.prefab_name] ~= nil then
						local var_86_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_10.prefab_name].transform, "story_v_side_new_1106704", "1106704021", "story_v_side_new_1106704.awb")

						arg_83_1:RecordAudio("1106704021", var_86_15)
						arg_83_1:RecordAudio("1106704021", var_86_15)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_side_new_1106704", "1106704021", "story_v_side_new_1106704.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_side_new_1106704", "1106704021", "story_v_side_new_1106704.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_16 = math.max(var_86_9, arg_83_1.talkMaxDuration)

			if var_86_8 <= arg_83_1.time_ and arg_83_1.time_ < var_86_8 + var_86_16 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_8) / var_86_16

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_8 + var_86_16 and arg_83_1.time_ < var_86_8 + var_86_16 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play1106704022 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 1106704022
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play1106704023(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(arg_87_1.actors_["1067ui_story"]) and arg_87_1.var_.characterEffect1067ui_story == nil then
				arg_87_1.var_.characterEffect1067ui_story = arg_87_1.actors_["1067ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_0 = 0.2

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 and not isNil(arg_87_1.actors_["1067ui_story"]) then
				if arg_87_1.var_.characterEffect1067ui_story and not isNil(arg_87_1.actors_["1067ui_story"]) then
					arg_87_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_87_1.time_ - 0) / var_90_0)
				end
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 and not isNil(arg_87_1.actors_["1067ui_story"]) and arg_87_1.var_.characterEffect1067ui_story then
				arg_87_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			local var_90_1 = 0
			local var_90_2 = 0.175

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, true)
				arg_87_1.iconController_:SetSelectedState("hero")

				arg_87_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_87_1.callingController_:SetSelectedState("normal")

				arg_87_1.keyicon_.color = Color.New(1, 1, 1)
				arg_87_1.icon_.color = Color.New(1, 1, 1)

				local var_90_3 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(1106704022).content)

				arg_87_1.text_.text = var_90_3

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 7 <= 0 and var_90_2 or var_90_2 * (utf8.len(var_90_3) / 7)

				if (7 <= 0 and var_90_2 or var_90_2 * (utf8.len(var_90_3) / 7)) > 0 and var_90_2 < var_90_5 then
					arg_87_1.talkMaxDuration = var_90_5

					if var_90_5 + var_90_1 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_5 + var_90_1
					end
				end

				arg_87_1.text_.text = var_90_3
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_6 = math.max(var_90_2, arg_87_1.talkMaxDuration)

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_6 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_1) / var_90_6

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_1 + var_90_6 and arg_87_1.time_ < var_90_1 + var_90_6 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play1106704023 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 1106704023
		arg_91_1.duration_ = 4.93

		local var_91_0 = {
			zh = 2.966,
			ja = 4.933
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play1106704024(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(arg_91_1.actors_["1067ui_story"]) and arg_91_1.var_.characterEffect1067ui_story == nil then
				arg_91_1.var_.characterEffect1067ui_story = arg_91_1.actors_["1067ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_0 = 0.2

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 and not isNil(arg_91_1.actors_["1067ui_story"]) then
				if arg_91_1.var_.characterEffect1067ui_story and not isNil(arg_91_1.actors_["1067ui_story"]) then
					arg_91_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 and not isNil(arg_91_1.actors_["1067ui_story"]) and arg_91_1.var_.characterEffect1067ui_story then
				arg_91_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067actionlink/1067action437")
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_94_2 = 0
			local var_94_3 = 0.325

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_2 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_4 = arg_91_1:GetWordFromCfg(1106704023)
				local var_94_5 = arg_91_1:FormatText(var_94_4.content)

				arg_91_1.text_.text = var_94_5

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_7 = 13 <= 0 and var_94_3 or var_94_3 * (utf8.len(var_94_5) / 13)

				if (13 <= 0 and var_94_3 or var_94_3 * (utf8.len(var_94_5) / 13)) > 0 and var_94_3 < var_94_7 then
					arg_91_1.talkMaxDuration = var_94_7

					if var_94_7 + var_94_2 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_7 + var_94_2
					end
				end

				arg_91_1.text_.text = var_94_5
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704023", "story_v_side_new_1106704.awb") ~= 0 then
					local var_94_8 = manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704023", "story_v_side_new_1106704.awb") / 1000

					if var_94_8 + var_94_2 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_8 + var_94_2
					end

					if var_94_4.prefab_name ~= "" and arg_91_1.actors_[var_94_4.prefab_name] ~= nil then
						local var_94_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_4.prefab_name].transform, "story_v_side_new_1106704", "1106704023", "story_v_side_new_1106704.awb")

						arg_91_1:RecordAudio("1106704023", var_94_9)
						arg_91_1:RecordAudio("1106704023", var_94_9)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_side_new_1106704", "1106704023", "story_v_side_new_1106704.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_side_new_1106704", "1106704023", "story_v_side_new_1106704.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_10 = math.max(var_94_3, arg_91_1.talkMaxDuration)

			if var_94_2 <= arg_91_1.time_ and arg_91_1.time_ < var_94_2 + var_94_10 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_2) / var_94_10

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_2 + var_94_10 and arg_91_1.time_ < var_94_2 + var_94_10 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play1106704024 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 1106704024
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play1106704025(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos1067ui_story = arg_95_1.actors_["1067ui_story"].transform.localPosition
			end

			local var_98_0 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 then
				arg_95_1.actors_["1067ui_story"].transform.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1067ui_story, Vector3.New(0, 100, 0), (arg_95_1.time_ - 0) / var_98_0)
				arg_95_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1067ui_story"].transform.position).z)
				arg_95_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["1067ui_story"].transform.localEulerAngles = arg_95_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 then
				arg_95_1.actors_["1067ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_95_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1067ui_story"].transform.position).z)
				arg_95_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["1067ui_story"].transform.localEulerAngles = arg_95_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			local var_98_1 = 0
			local var_98_2 = 0.7

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_3 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(1106704024).content)

				arg_95_1.text_.text = var_98_3

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_5 = 28 <= 0 and var_98_2 or var_98_2 * (utf8.len(var_98_3) / 28)

				if (28 <= 0 and var_98_2 or var_98_2 * (utf8.len(var_98_3) / 28)) > 0 and var_98_2 < var_98_5 then
					arg_95_1.talkMaxDuration = var_98_5

					if var_98_5 + var_98_1 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_5 + var_98_1
					end
				end

				arg_95_1.text_.text = var_98_3
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_6 = math.max(var_98_2, arg_95_1.talkMaxDuration)

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_6 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_1) / var_98_6

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_1 + var_98_6 and arg_95_1.time_ < var_98_1 + var_98_6 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play1106704025 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 1106704025
		arg_99_1.duration_ = 8

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play1106704026(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if arg_99_1.bgs_.ST25 == nil then
				local var_102_0 = Object.Instantiate(arg_99_1.paintGo_)

				var_102_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST25")
				var_102_0.name = "ST25"
				var_102_0.transform.parent = arg_99_1.stage_.transform
				var_102_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_99_1.bgs_.ST25 = var_102_0
			end

			if 1.5 < arg_99_1.time_ and arg_99_1.time_ <= 1.5 + arg_102_0 then
				local var_102_1 = arg_99_1.bgs_.ST25

				arg_99_1.bgs_.ST25.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_102_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_102_2 = var_102_1:GetComponent("SpriteRenderer")

				if var_102_2 and var_102_2.sprite then
					local var_102_3 = 2 * (var_102_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_102_1.transform.localScale = Vector3.New(var_102_3 / var_102_2.sprite.bounds.size.y < var_102_3 * manager.ui.mainCameraCom_.aspect / var_102_2.sprite.bounds.size.x and var_102_3 * manager.ui.mainCameraCom_.aspect / var_102_2.sprite.bounds.size.x or var_102_3 / var_102_2.sprite.bounds.size.y, var_102_3 / var_102_2.sprite.bounds.size.y < var_102_3 * manager.ui.mainCameraCom_.aspect / var_102_2.sprite.bounds.size.x and var_102_3 * manager.ui.mainCameraCom_.aspect / var_102_2.sprite.bounds.size.x or var_102_3 / var_102_2.sprite.bounds.size.y, 0)
				end

				for iter_102_0, iter_102_1 in pairs(arg_99_1.bgs_) do
					if iter_102_0 ~= "ST25" then
						iter_102_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_102_4 = 0

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_4 + arg_102_0 then
				arg_99_1.mask_.enabled = true
				arg_99_1.mask_.raycastTarget = false

				arg_99_1:SetGaussion(false)
			end

			local var_102_5 = 1.5

			if var_102_4 <= arg_99_1.time_ and arg_99_1.time_ < var_102_4 + var_102_5 then
				local var_102_6 = Color.New(0, 0, 0)

				var_102_6.a = Mathf.Lerp(0, 1, (arg_99_1.time_ - var_102_4) / var_102_5)
				arg_99_1.mask_.color = var_102_6
			end

			if arg_99_1.time_ >= var_102_4 + var_102_5 and arg_99_1.time_ < var_102_4 + var_102_5 + arg_102_0 then
				local var_102_7 = Color.New(0, 0, 0)

				var_102_7.a = 1
				arg_99_1.mask_.color = var_102_7
			end

			local var_102_8 = 1.5

			if 1.5 < arg_99_1.time_ and arg_99_1.time_ <= var_102_8 + arg_102_0 then
				arg_99_1.mask_.enabled = true
				arg_99_1.mask_.raycastTarget = false

				arg_99_1:SetGaussion(false)
			end

			local var_102_9 = 1.5

			if var_102_8 <= arg_99_1.time_ and arg_99_1.time_ < var_102_8 + var_102_9 then
				local var_102_10 = Color.New(0, 0, 0)

				var_102_10.a = Mathf.Lerp(1, 0, (arg_99_1.time_ - var_102_8) / var_102_9)
				arg_99_1.mask_.color = var_102_10
			end

			if arg_99_1.time_ >= var_102_8 + var_102_9 and arg_99_1.time_ < var_102_8 + var_102_9 + arg_102_0 then
				local var_102_11 = Color.New(0, 0, 0)

				arg_99_1.mask_.enabled = false
				var_102_11.a = 0
				arg_99_1.mask_.color = var_102_11
			end

			local var_102_12 = 0

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_12 + arg_102_0 then
				arg_99_1.allBtn_.enabled = false
			end

			if arg_99_1.time_ >= var_102_12 + 3.85 and arg_99_1.time_ < var_102_12 + 3.85 + arg_102_0 then
				arg_99_1.allBtn_.enabled = true
			end

			if arg_99_1.frameCnt_ <= 1 then
				arg_99_1.dialog_:SetActive(false)
			end

			local var_102_13 = 3
			local var_102_14 = 0.85

			if 3 < arg_99_1.time_ and arg_99_1.time_ <= var_102_13 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0

				arg_99_1.dialog_:SetActive(true)

				arg_99_1.dialogCg_.alpha = 0

				local var_102_15 = LeanTween.value(arg_99_1.dialog_, 0, 1, 0.3)

				var_102_15:setOnUpdate(LuaHelper.FloatAction(function(arg_103_0)
					arg_99_1.dialogCg_.alpha = arg_103_0
				end))
				var_102_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_99_1.dialog_)
					var_102_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_99_1.duration_ = arg_99_1.duration_ + 0.3

				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_16 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(1106704025).content)

				arg_99_1.text_.text = var_102_16

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_18 = 34 <= 0 and var_102_14 or var_102_14 * (utf8.len(var_102_16) / 34)

				if (34 <= 0 and var_102_14 or var_102_14 * (utf8.len(var_102_16) / 34)) > 0 and var_102_14 < var_102_18 then
					arg_99_1.talkMaxDuration = var_102_18
					var_102_13 = var_102_13 + 0.3

					if var_102_18 + var_102_13 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_18 + var_102_13
					end
				end

				arg_99_1.text_.text = var_102_16
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_19 = var_102_13 + 0.3
			local var_102_20 = math.max(var_102_14, arg_99_1.talkMaxDuration)

			if var_102_13 + 0.3 <= arg_99_1.time_ and arg_99_1.time_ < var_102_19 + var_102_20 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_19) / var_102_20

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_19 + var_102_20 and arg_99_1.time_ < var_102_19 + var_102_20 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play1106704026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 1106704026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play1106704027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.875

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_1 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(1106704026).content)

				arg_105_1.text_.text = var_108_1

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_3 = 35 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 35)

				if (35 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 35)) > 0 and var_108_0 < var_108_3 then
					arg_105_1.talkMaxDuration = var_108_3

					if var_108_3 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_3 + 0
					end
				end

				arg_105_1.text_.text = var_108_1
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_4 = math.max(var_108_0, arg_105_1.talkMaxDuration)

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - 0) / var_108_4

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play1106704027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 1106704027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play1106704028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 1.525

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_1 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(1106704027).content)

				arg_109_1.text_.text = var_112_1

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_3 = 54 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 54)

				if (54 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 54)) > 0 and var_112_0 < var_112_3 then
					arg_109_1.talkMaxDuration = var_112_3

					if var_112_3 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_3 + 0
					end
				end

				arg_109_1.text_.text = var_112_1
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_4 = math.max(var_112_0, arg_109_1.talkMaxDuration)

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_4 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - 0) / var_112_4

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= 0 + var_112_4 and arg_109_1.time_ < 0 + var_112_4 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play1106704028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 1106704028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play1106704029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 1.325

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_1 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(1106704028).content)

				arg_113_1.text_.text = var_116_1

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_3 = 53 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 53)

				if (53 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 53)) > 0 and var_116_0 < var_116_3 then
					arg_113_1.talkMaxDuration = var_116_3

					if var_116_3 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_3 + 0
					end
				end

				arg_113_1.text_.text = var_116_1
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_4 = math.max(var_116_0, arg_113_1.talkMaxDuration)

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_4 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - 0) / var_116_4

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= 0 + var_116_4 and arg_113_1.time_ < 0 + var_116_4 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play1106704029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 1106704029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play1106704030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 1.45

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_1 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(1106704029).content)

				arg_117_1.text_.text = var_120_1

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_3 = 40 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 40)

				if (40 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 40)) > 0 and var_120_0 < var_120_3 then
					arg_117_1.talkMaxDuration = var_120_3

					if var_120_3 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_3 + 0
					end
				end

				arg_117_1.text_.text = var_120_1
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_4 = math.max(var_120_0, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_4 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - 0) / var_120_4

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_4 and arg_117_1.time_ < 0 + var_120_4 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play1106704030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 1106704030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play1106704031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0.175

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_1 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(1106704030).content)

				arg_121_1.text_.text = var_124_1

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_3 = 7 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_1) / 7)

				if (7 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_1) / 7)) > 0 and var_124_0 < var_124_3 then
					arg_121_1.talkMaxDuration = var_124_3

					if var_124_3 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_3 + 0
					end
				end

				arg_121_1.text_.text = var_124_1
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_4 = math.max(var_124_0, arg_121_1.talkMaxDuration)

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_4 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - 0) / var_124_4

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= 0 + var_124_4 and arg_121_1.time_ < 0 + var_124_4 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play1106704031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 1106704031
		arg_125_1.duration_ = 2.23

		local var_125_0 = {
			zh = 1.999999999999,
			ja = 2.233
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play1106704032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1067ui_story = arg_125_1.actors_["1067ui_story"].transform.localPosition
			end

			local var_128_0 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 then
				arg_125_1.actors_["1067ui_story"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1067ui_story, Vector3.New(0, -1.06, -6.2), (arg_125_1.time_ - 0) / var_128_0)
				arg_125_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1067ui_story"].transform.position).z)
				arg_125_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1067ui_story"].transform.localEulerAngles = arg_125_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 then
				arg_125_1.actors_["1067ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_125_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1067ui_story"].transform.position).z)
				arg_125_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1067ui_story"].transform.localEulerAngles = arg_125_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			local var_128_1 = arg_125_1.actors_["1067ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1067ui_story == nil then
				arg_125_1.var_.characterEffect1067ui_story = var_128_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.2

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_2 and not isNil(var_128_1) then
				if arg_125_1.var_.characterEffect1067ui_story and not isNil(var_128_1) then
					arg_125_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_2 and arg_125_1.time_ < 0 + var_128_2 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1067ui_story then
				arg_125_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action3_1")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_128_4 = 0
			local var_128_5 = 0.1

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_4 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_6 = arg_125_1:GetWordFromCfg(1106704031)
				local var_128_7 = arg_125_1:FormatText(var_128_6.content)

				arg_125_1.text_.text = var_128_7

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_9 = 4 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 4)

				if (4 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 4)) > 0 and var_128_5 < var_128_9 then
					arg_125_1.talkMaxDuration = var_128_9

					if var_128_9 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_9 + var_128_4
					end
				end

				arg_125_1.text_.text = var_128_7
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704031", "story_v_side_new_1106704.awb") ~= 0 then
					local var_128_10 = manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704031", "story_v_side_new_1106704.awb") / 1000

					if var_128_10 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_10 + var_128_4
					end

					if var_128_6.prefab_name ~= "" and arg_125_1.actors_[var_128_6.prefab_name] ~= nil then
						local var_128_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_6.prefab_name].transform, "story_v_side_new_1106704", "1106704031", "story_v_side_new_1106704.awb")

						arg_125_1:RecordAudio("1106704031", var_128_11)
						arg_125_1:RecordAudio("1106704031", var_128_11)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_side_new_1106704", "1106704031", "story_v_side_new_1106704.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_side_new_1106704", "1106704031", "story_v_side_new_1106704.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_12 = math.max(var_128_5, arg_125_1.talkMaxDuration)

			if var_128_4 <= arg_125_1.time_ and arg_125_1.time_ < var_128_4 + var_128_12 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_4) / var_128_12

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_4 + var_128_12 and arg_125_1.time_ < var_128_4 + var_128_12 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play1106704032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 1106704032
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play1106704033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["1067ui_story"]) and arg_129_1.var_.characterEffect1067ui_story == nil then
				arg_129_1.var_.characterEffect1067ui_story = arg_129_1.actors_["1067ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_0 = 0.2

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["1067ui_story"]) then
				if arg_129_1.var_.characterEffect1067ui_story and not isNil(arg_129_1.actors_["1067ui_story"]) then
					arg_129_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_0)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["1067ui_story"]) and arg_129_1.var_.characterEffect1067ui_story then
				arg_129_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			local var_132_1 = 0
			local var_132_2 = 0.3

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_3 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(1106704032).content)

				arg_129_1.text_.text = var_132_3

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 12 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_3) / 12)

				if (12 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_3) / 12)) > 0 and var_132_2 < var_132_5 then
					arg_129_1.talkMaxDuration = var_132_5

					if var_132_5 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + var_132_1
					end
				end

				arg_129_1.text_.text = var_132_3
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_6 = math.max(var_132_2, arg_129_1.talkMaxDuration)

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_6 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_1) / var_132_6

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_1 + var_132_6 and arg_129_1.time_ < var_132_1 + var_132_6 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play1106704033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 1106704033
		arg_133_1.duration_ = 9.13

		local var_133_0 = {
			zh = 9.133,
			ja = 6.4
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play1106704034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["1067ui_story"]) and arg_133_1.var_.characterEffect1067ui_story == nil then
				arg_133_1.var_.characterEffect1067ui_story = arg_133_1.actors_["1067ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.2

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["1067ui_story"]) then
				if arg_133_1.var_.characterEffect1067ui_story and not isNil(arg_133_1.actors_["1067ui_story"]) then
					arg_133_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["1067ui_story"]) and arg_133_1.var_.characterEffect1067ui_story then
				arg_133_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067actionlink/1067action436")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_136_2 = 0
			local var_136_3 = 0.825

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_2 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_4 = arg_133_1:GetWordFromCfg(1106704033)
				local var_136_5 = arg_133_1:FormatText(var_136_4.content)

				arg_133_1.text_.text = var_136_5

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_7 = 33 <= 0 and var_136_3 or var_136_3 * (utf8.len(var_136_5) / 33)

				if (33 <= 0 and var_136_3 or var_136_3 * (utf8.len(var_136_5) / 33)) > 0 and var_136_3 < var_136_7 then
					arg_133_1.talkMaxDuration = var_136_7

					if var_136_7 + var_136_2 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_7 + var_136_2
					end
				end

				arg_133_1.text_.text = var_136_5
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704033", "story_v_side_new_1106704.awb") ~= 0 then
					local var_136_8 = manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704033", "story_v_side_new_1106704.awb") / 1000

					if var_136_8 + var_136_2 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_8 + var_136_2
					end

					if var_136_4.prefab_name ~= "" and arg_133_1.actors_[var_136_4.prefab_name] ~= nil then
						local var_136_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_4.prefab_name].transform, "story_v_side_new_1106704", "1106704033", "story_v_side_new_1106704.awb")

						arg_133_1:RecordAudio("1106704033", var_136_9)
						arg_133_1:RecordAudio("1106704033", var_136_9)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_side_new_1106704", "1106704033", "story_v_side_new_1106704.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_side_new_1106704", "1106704033", "story_v_side_new_1106704.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_10 = math.max(var_136_3, arg_133_1.talkMaxDuration)

			if var_136_2 <= arg_133_1.time_ and arg_133_1.time_ < var_136_2 + var_136_10 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_2) / var_136_10

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_2 + var_136_10 and arg_133_1.time_ < var_136_2 + var_136_10 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play1106704034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 1106704034
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play1106704035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["1067ui_story"]) and arg_137_1.var_.characterEffect1067ui_story == nil then
				arg_137_1.var_.characterEffect1067ui_story = arg_137_1.actors_["1067ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_0 = 0.2

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["1067ui_story"]) then
				if arg_137_1.var_.characterEffect1067ui_story and not isNil(arg_137_1.actors_["1067ui_story"]) then
					arg_137_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_0)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["1067ui_story"]) and arg_137_1.var_.characterEffect1067ui_story then
				arg_137_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action6_2")
			end

			local var_140_1 = 0
			local var_140_2 = 0.85

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_3 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(1106704034).content)

				arg_137_1.text_.text = var_140_3

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 34 <= 0 and var_140_2 or var_140_2 * (utf8.len(var_140_3) / 34)

				if (34 <= 0 and var_140_2 or var_140_2 * (utf8.len(var_140_3) / 34)) > 0 and var_140_2 < var_140_5 then
					arg_137_1.talkMaxDuration = var_140_5

					if var_140_5 + var_140_1 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + var_140_1
					end
				end

				arg_137_1.text_.text = var_140_3
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_6 = math.max(var_140_2, arg_137_1.talkMaxDuration)

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_6 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_1) / var_140_6

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_1 + var_140_6 and arg_137_1.time_ < var_140_1 + var_140_6 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play1106704035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 1106704035
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play1106704036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0.45

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_1 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(1106704035).content)

				arg_141_1.text_.text = var_144_1

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_3 = 18 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 18)

				if (18 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 18)) > 0 and var_144_0 < var_144_3 then
					arg_141_1.talkMaxDuration = var_144_3

					if var_144_3 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_3 + 0
					end
				end

				arg_141_1.text_.text = var_144_1
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_4 = math.max(var_144_0, arg_141_1.talkMaxDuration)

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_4 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - 0) / var_144_4

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= 0 + var_144_4 and arg_141_1.time_ < 0 + var_144_4 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play1106704036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 1106704036
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play1106704037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0.775

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_1 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(1106704036).content)

				arg_145_1.text_.text = var_148_1

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_3 = 31 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 31)

				if (31 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 31)) > 0 and var_148_0 < var_148_3 then
					arg_145_1.talkMaxDuration = var_148_3

					if var_148_3 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_3 + 0
					end
				end

				arg_145_1.text_.text = var_148_1
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_4 = math.max(var_148_0, arg_145_1.talkMaxDuration)

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_4 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - 0) / var_148_4

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= 0 + var_148_4 and arg_145_1.time_ < 0 + var_148_4 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play1106704037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 1106704037
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play1106704038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 1.025

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_1 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(1106704037).content)

				arg_149_1.text_.text = var_152_1

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_3 = 41 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 41)

				if (41 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 41)) > 0 and var_152_0 < var_152_3 then
					arg_149_1.talkMaxDuration = var_152_3

					if var_152_3 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_3 + 0
					end
				end

				arg_149_1.text_.text = var_152_1
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_4 = math.max(var_152_0, arg_149_1.talkMaxDuration)

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_4 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - 0) / var_152_4

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= 0 + var_152_4 and arg_149_1.time_ < 0 + var_152_4 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play1106704038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 1106704038
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play1106704039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_156_0 = 0
			local var_156_1 = 0.5

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_2 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(1106704038).content)

				arg_153_1.text_.text = var_156_2

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_4 = 20 <= 0 and var_156_1 or var_156_1 * (utf8.len(var_156_2) / 20)

				if (20 <= 0 and var_156_1 or var_156_1 * (utf8.len(var_156_2) / 20)) > 0 and var_156_1 < var_156_4 then
					arg_153_1.talkMaxDuration = var_156_4

					if var_156_4 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_4 + var_156_0
					end
				end

				arg_153_1.text_.text = var_156_2
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_5 = math.max(var_156_1, arg_153_1.talkMaxDuration)

			if var_156_0 <= arg_153_1.time_ and arg_153_1.time_ < var_156_0 + var_156_5 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_0) / var_156_5

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_0 + var_156_5 and arg_153_1.time_ < var_156_0 + var_156_5 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play1106704039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 1106704039
		arg_157_1.duration_ = 9.13

		local var_157_0 = {
			zh = 5.466,
			ja = 9.133
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play1106704040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if arg_157_1.bgs_.R6701 == nil then
				local var_160_0 = Object.Instantiate(arg_157_1.paintGo_)

				var_160_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "R6701")
				var_160_0.name = "R6701"
				var_160_0.transform.parent = arg_157_1.stage_.transform
				var_160_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_157_1.bgs_.R6701 = var_160_0
			end

			if 1.5 < arg_157_1.time_ and arg_157_1.time_ <= 1.5 + arg_160_0 then
				local var_160_1 = arg_157_1.bgs_.R6701

				arg_157_1.bgs_.R6701.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_160_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_160_2 = var_160_1:GetComponent("SpriteRenderer")

				if var_160_2 and var_160_2.sprite then
					local var_160_3 = 2 * (var_160_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_160_1.transform.localScale = Vector3.New(var_160_3 / var_160_2.sprite.bounds.size.y < var_160_3 * manager.ui.mainCameraCom_.aspect / var_160_2.sprite.bounds.size.x and var_160_3 * manager.ui.mainCameraCom_.aspect / var_160_2.sprite.bounds.size.x or var_160_3 / var_160_2.sprite.bounds.size.y, var_160_3 / var_160_2.sprite.bounds.size.y < var_160_3 * manager.ui.mainCameraCom_.aspect / var_160_2.sprite.bounds.size.x and var_160_3 * manager.ui.mainCameraCom_.aspect / var_160_2.sprite.bounds.size.x or var_160_3 / var_160_2.sprite.bounds.size.y, 0)
				end

				for iter_160_0, iter_160_1 in pairs(arg_157_1.bgs_) do
					if iter_160_0 ~= "R6701" then
						iter_160_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_160_4 = 0

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_4 + arg_160_0 then
				arg_157_1.mask_.enabled = true
				arg_157_1.mask_.raycastTarget = false

				arg_157_1:SetGaussion(false)
			end

			local var_160_5 = 1.5

			if var_160_4 <= arg_157_1.time_ and arg_157_1.time_ < var_160_4 + var_160_5 then
				local var_160_6 = Color.New(0, 0, 0)

				var_160_6.a = Mathf.Lerp(0, 1, (arg_157_1.time_ - var_160_4) / var_160_5)
				arg_157_1.mask_.color = var_160_6
			end

			if arg_157_1.time_ >= var_160_4 + var_160_5 and arg_157_1.time_ < var_160_4 + var_160_5 + arg_160_0 then
				local var_160_7 = Color.New(0, 0, 0)

				var_160_7.a = 1
				arg_157_1.mask_.color = var_160_7
			end

			local var_160_8 = 1.5

			if 1.5 < arg_157_1.time_ and arg_157_1.time_ <= var_160_8 + arg_160_0 then
				arg_157_1.mask_.enabled = true
				arg_157_1.mask_.raycastTarget = false

				arg_157_1:SetGaussion(false)
			end

			local var_160_9 = 1.5

			if var_160_8 <= arg_157_1.time_ and arg_157_1.time_ < var_160_8 + var_160_9 then
				local var_160_10 = Color.New(0, 0, 0)

				var_160_10.a = Mathf.Lerp(1, 0, (arg_157_1.time_ - var_160_8) / var_160_9)
				arg_157_1.mask_.color = var_160_10
			end

			if arg_157_1.time_ >= var_160_8 + var_160_9 and arg_157_1.time_ < var_160_8 + var_160_9 + arg_160_0 then
				local var_160_11 = Color.New(0, 0, 0)

				arg_157_1.mask_.enabled = false
				var_160_11.a = 0
				arg_157_1.mask_.color = var_160_11
			end

			local var_160_12 = arg_157_1.actors_["1067ui_story"].transform

			if 1.5 < arg_157_1.time_ and arg_157_1.time_ <= 1.5 + arg_160_0 then
				arg_157_1.var_.moveOldPos1067ui_story = var_160_12.localPosition
			end

			local var_160_13 = 0.001

			if 1.5 <= arg_157_1.time_ and arg_157_1.time_ < 1.5 + var_160_13 then
				var_160_12.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1067ui_story, Vector3.New(0, 100, 0), (arg_157_1.time_ - 1.5) / var_160_13)
				var_160_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_160_12.position).x, (manager.ui.mainCamera.transform.position - var_160_12.position).y, (manager.ui.mainCamera.transform.position - var_160_12.position).z)
				var_160_12.localEulerAngles.z = 0
				var_160_12.localEulerAngles.x = 0
				var_160_12.localEulerAngles = var_160_12.localEulerAngles
			end

			if arg_157_1.time_ >= 1.5 + var_160_13 and arg_157_1.time_ < 1.5 + var_160_13 + arg_160_0 then
				var_160_12.localPosition = Vector3.New(0, 100, 0)
				var_160_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_160_12.position).x, (manager.ui.mainCamera.transform.position - var_160_12.position).y, (manager.ui.mainCamera.transform.position - var_160_12.position).z)
				var_160_12.localEulerAngles.z = 0
				var_160_12.localEulerAngles.x = 0
				var_160_12.localEulerAngles = var_160_12.localEulerAngles
			end

			local var_160_14 = arg_157_1.bgs_.R6701.transform

			if 1.5 < arg_157_1.time_ and arg_157_1.time_ <= 1.5 + arg_160_0 then
				arg_157_1.var_.moveOldPosR6701 = var_160_14.localPosition
			end

			local var_160_15 = 1.999999999999

			if 1.5 <= arg_157_1.time_ and arg_157_1.time_ < 1.5 + var_160_15 then
				var_160_14.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPosR6701, Vector3.New(0, 0.87, 9.26), (arg_157_1.time_ - 1.5) / var_160_15)
			end

			if arg_157_1.time_ >= 1.5 + var_160_15 and arg_157_1.time_ < 1.5 + var_160_15 + arg_160_0 then
				var_160_14.localPosition = Vector3.New(0, 0.87, 9.26)
			end

			local var_160_16 = 0

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_16 + arg_160_0 then
				arg_157_1.allBtn_.enabled = false
			end

			if arg_157_1.time_ >= var_160_16 + 3.499999999999 and arg_157_1.time_ < var_160_16 + 3.499999999999 + arg_160_0 then
				arg_157_1.allBtn_.enabled = true
			end

			if arg_157_1.frameCnt_ <= 1 then
				arg_157_1.dialog_:SetActive(false)
			end

			local var_160_17 = 3
			local var_160_18 = 0.275

			if 3 < arg_157_1.time_ and arg_157_1.time_ <= var_160_17 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0

				arg_157_1.dialog_:SetActive(true)

				arg_157_1.dialogCg_.alpha = 0

				local var_160_19 = LeanTween.value(arg_157_1.dialog_, 0, 1, 0.3)

				var_160_19:setOnUpdate(LuaHelper.FloatAction(function(arg_161_0)
					arg_157_1.dialogCg_.alpha = arg_161_0
				end))
				var_160_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_157_1.dialog_)
					var_160_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_157_1.duration_ = arg_157_1.duration_ + 0.3

				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_20 = arg_157_1:GetWordFromCfg(1106704039)
				local var_160_21 = arg_157_1:FormatText(var_160_20.content)

				arg_157_1.text_.text = var_160_21

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_23 = 11 <= 0 and var_160_18 or var_160_18 * (utf8.len(var_160_21) / 11)

				if (11 <= 0 and var_160_18 or var_160_18 * (utf8.len(var_160_21) / 11)) > 0 and var_160_18 < var_160_23 then
					arg_157_1.talkMaxDuration = var_160_23
					var_160_17 = var_160_17 + 0.3

					if var_160_23 + var_160_17 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_23 + var_160_17
					end
				end

				arg_157_1.text_.text = var_160_21
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704039", "story_v_side_new_1106704.awb") ~= 0 then
					local var_160_24 = manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704039", "story_v_side_new_1106704.awb") / 1000

					if var_160_24 + var_160_17 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_24 + var_160_17
					end

					if var_160_20.prefab_name ~= "" and arg_157_1.actors_[var_160_20.prefab_name] ~= nil then
						local var_160_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_20.prefab_name].transform, "story_v_side_new_1106704", "1106704039", "story_v_side_new_1106704.awb")

						arg_157_1:RecordAudio("1106704039", var_160_25)
						arg_157_1:RecordAudio("1106704039", var_160_25)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_side_new_1106704", "1106704039", "story_v_side_new_1106704.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_side_new_1106704", "1106704039", "story_v_side_new_1106704.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_26 = var_160_17 + 0.3
			local var_160_27 = math.max(var_160_18, arg_157_1.talkMaxDuration)

			if var_160_17 + 0.3 <= arg_157_1.time_ and arg_157_1.time_ < var_160_26 + var_160_27 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_26) / var_160_27

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_26 + var_160_27 and arg_157_1.time_ < var_160_26 + var_160_27 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "R6701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.999999999999,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play1106704040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 1106704040
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play1106704041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0.175

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_1 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(1106704040).content)

				arg_163_1.text_.text = var_166_1

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_3 = 7 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_1) / 7)

				if (7 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_1) / 7)) > 0 and var_166_0 < var_166_3 then
					arg_163_1.talkMaxDuration = var_166_3

					if var_166_3 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_3 + 0
					end
				end

				arg_163_1.text_.text = var_166_1
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_4 = math.max(var_166_0, arg_163_1.talkMaxDuration)

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_4 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - 0) / var_166_4

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= 0 + var_166_4 and arg_163_1.time_ < 0 + var_166_4 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play1106704041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 1106704041
		arg_167_1.duration_ = 11.83

		local var_167_0 = {
			zh = 7.166,
			ja = 11.833
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play1106704042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0.775

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_1 = arg_167_1:GetWordFromCfg(1106704041)
				local var_170_2 = arg_167_1:FormatText(var_170_1.content)

				arg_167_1.text_.text = var_170_2

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_4 = 31 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 31)

				if (31 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 31)) > 0 and var_170_0 < var_170_4 then
					arg_167_1.talkMaxDuration = var_170_4

					if var_170_4 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_4 + 0
					end
				end

				arg_167_1.text_.text = var_170_2
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704041", "story_v_side_new_1106704.awb") ~= 0 then
					local var_170_5 = manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704041", "story_v_side_new_1106704.awb") / 1000

					if var_170_5 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_5 + 0
					end

					if var_170_1.prefab_name ~= "" and arg_167_1.actors_[var_170_1.prefab_name] ~= nil then
						local var_170_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_1.prefab_name].transform, "story_v_side_new_1106704", "1106704041", "story_v_side_new_1106704.awb")

						arg_167_1:RecordAudio("1106704041", var_170_6)
						arg_167_1:RecordAudio("1106704041", var_170_6)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_side_new_1106704", "1106704041", "story_v_side_new_1106704.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_side_new_1106704", "1106704041", "story_v_side_new_1106704.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_7 = math.max(var_170_0, arg_167_1.talkMaxDuration)

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_7 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - 0) / var_170_7

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= 0 + var_170_7 and arg_167_1.time_ < 0 + var_170_7 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play1106704042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 1106704042
		arg_171_1.duration_ = 11.5

		local var_171_0 = {
			zh = 9.466,
			ja = 11.5
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play1106704043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 1.125

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_1 = arg_171_1:GetWordFromCfg(1106704042)
				local var_174_2 = arg_171_1:FormatText(var_174_1.content)

				arg_171_1.text_.text = var_174_2

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_4 = 45 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 45)

				if (45 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 45)) > 0 and var_174_0 < var_174_4 then
					arg_171_1.talkMaxDuration = var_174_4

					if var_174_4 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_4 + 0
					end
				end

				arg_171_1.text_.text = var_174_2
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704042", "story_v_side_new_1106704.awb") ~= 0 then
					local var_174_5 = manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704042", "story_v_side_new_1106704.awb") / 1000

					if var_174_5 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_5 + 0
					end

					if var_174_1.prefab_name ~= "" and arg_171_1.actors_[var_174_1.prefab_name] ~= nil then
						local var_174_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_1.prefab_name].transform, "story_v_side_new_1106704", "1106704042", "story_v_side_new_1106704.awb")

						arg_171_1:RecordAudio("1106704042", var_174_6)
						arg_171_1:RecordAudio("1106704042", var_174_6)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_side_new_1106704", "1106704042", "story_v_side_new_1106704.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_side_new_1106704", "1106704042", "story_v_side_new_1106704.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_7 = math.max(var_174_0, arg_171_1.talkMaxDuration)

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_7 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - 0) / var_174_7

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= 0 + var_174_7 and arg_171_1.time_ < 0 + var_174_7 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play1106704043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 1106704043
		arg_175_1.duration_ = 11.4

		local var_175_0 = {
			zh = 8.733,
			ja = 11.4
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play1106704044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.75

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_1 = arg_175_1:GetWordFromCfg(1106704043)
				local var_178_2 = arg_175_1:FormatText(var_178_1.content)

				arg_175_1.text_.text = var_178_2

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_4 = 30 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 30)

				if (30 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 30)) > 0 and var_178_0 < var_178_4 then
					arg_175_1.talkMaxDuration = var_178_4

					if var_178_4 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_4 + 0
					end
				end

				arg_175_1.text_.text = var_178_2
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704043", "story_v_side_new_1106704.awb") ~= 0 then
					local var_178_5 = manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704043", "story_v_side_new_1106704.awb") / 1000

					if var_178_5 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + 0
					end

					if var_178_1.prefab_name ~= "" and arg_175_1.actors_[var_178_1.prefab_name] ~= nil then
						local var_178_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_1.prefab_name].transform, "story_v_side_new_1106704", "1106704043", "story_v_side_new_1106704.awb")

						arg_175_1:RecordAudio("1106704043", var_178_6)
						arg_175_1:RecordAudio("1106704043", var_178_6)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_side_new_1106704", "1106704043", "story_v_side_new_1106704.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_side_new_1106704", "1106704043", "story_v_side_new_1106704.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_7 = math.max(var_178_0, arg_175_1.talkMaxDuration)

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_7 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - 0) / var_178_7

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= 0 + var_178_7 and arg_175_1.time_ < 0 + var_178_7 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play1106704044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 1106704044
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play1106704045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 1.25

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_1 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(1106704044).content)

				arg_179_1.text_.text = var_182_1

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_3 = 50 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 50)

				if (50 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 50)) > 0 and var_182_0 < var_182_3 then
					arg_179_1.talkMaxDuration = var_182_3

					if var_182_3 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_3 + 0
					end
				end

				arg_179_1.text_.text = var_182_1
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_4 = math.max(var_182_0, arg_179_1.talkMaxDuration)

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_4 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - 0) / var_182_4

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= 0 + var_182_4 and arg_179_1.time_ < 0 + var_182_4 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play1106704045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 1106704045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play1106704046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0.4

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_1 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(1106704045).content)

				arg_183_1.text_.text = var_186_1

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_3 = 16 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_1) / 16)

				if (16 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_1) / 16)) > 0 and var_186_0 < var_186_3 then
					arg_183_1.talkMaxDuration = var_186_3

					if var_186_3 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_3 + 0
					end
				end

				arg_183_1.text_.text = var_186_1
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_4 = math.max(var_186_0, arg_183_1.talkMaxDuration)

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_4 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - 0) / var_186_4

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= 0 + var_186_4 and arg_183_1.time_ < 0 + var_186_4 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play1106704046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 1106704046
		arg_187_1.duration_ = 7.7

		local var_187_0 = {
			zh = 7.7,
			ja = 7.066
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play1106704047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0.75

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_1 = arg_187_1:GetWordFromCfg(1106704046)
				local var_190_2 = arg_187_1:FormatText(var_190_1.content)

				arg_187_1.text_.text = var_190_2

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_4 = 30 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 30)

				if (30 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 30)) > 0 and var_190_0 < var_190_4 then
					arg_187_1.talkMaxDuration = var_190_4

					if var_190_4 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_4 + 0
					end
				end

				arg_187_1.text_.text = var_190_2
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704046", "story_v_side_new_1106704.awb") ~= 0 then
					local var_190_5 = manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704046", "story_v_side_new_1106704.awb") / 1000

					if var_190_5 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + 0
					end

					if var_190_1.prefab_name ~= "" and arg_187_1.actors_[var_190_1.prefab_name] ~= nil then
						local var_190_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_1.prefab_name].transform, "story_v_side_new_1106704", "1106704046", "story_v_side_new_1106704.awb")

						arg_187_1:RecordAudio("1106704046", var_190_6)
						arg_187_1:RecordAudio("1106704046", var_190_6)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_side_new_1106704", "1106704046", "story_v_side_new_1106704.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_side_new_1106704", "1106704046", "story_v_side_new_1106704.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_7 = math.max(var_190_0, arg_187_1.talkMaxDuration)

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_7 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - 0) / var_190_7

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= 0 + var_190_7 and arg_187_1.time_ < 0 + var_190_7 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play1106704047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 1106704047
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play1106704048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0.375

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_1 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(1106704047).content)

				arg_191_1.text_.text = var_194_1

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_3 = 15 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_1) / 15)

				if (15 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_1) / 15)) > 0 and var_194_0 < var_194_3 then
					arg_191_1.talkMaxDuration = var_194_3

					if var_194_3 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_3 + 0
					end
				end

				arg_191_1.text_.text = var_194_1
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_4 = math.max(var_194_0, arg_191_1.talkMaxDuration)

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_4 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - 0) / var_194_4

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= 0 + var_194_4 and arg_191_1.time_ < 0 + var_194_4 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play1106704048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 1106704048
		arg_195_1.duration_ = 7.9

		local var_195_0 = {
			zh = 7.233,
			ja = 7.9
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play1106704049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0.725

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_1 = arg_195_1:GetWordFromCfg(1106704048)
				local var_198_2 = arg_195_1:FormatText(var_198_1.content)

				arg_195_1.text_.text = var_198_2

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_4 = 29 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 29)

				if (29 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 29)) > 0 and var_198_0 < var_198_4 then
					arg_195_1.talkMaxDuration = var_198_4

					if var_198_4 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_4 + 0
					end
				end

				arg_195_1.text_.text = var_198_2
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704048", "story_v_side_new_1106704.awb") ~= 0 then
					local var_198_5 = manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704048", "story_v_side_new_1106704.awb") / 1000

					if var_198_5 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + 0
					end

					if var_198_1.prefab_name ~= "" and arg_195_1.actors_[var_198_1.prefab_name] ~= nil then
						local var_198_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_1.prefab_name].transform, "story_v_side_new_1106704", "1106704048", "story_v_side_new_1106704.awb")

						arg_195_1:RecordAudio("1106704048", var_198_6)
						arg_195_1:RecordAudio("1106704048", var_198_6)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_side_new_1106704", "1106704048", "story_v_side_new_1106704.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_side_new_1106704", "1106704048", "story_v_side_new_1106704.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_7 = math.max(var_198_0, arg_195_1.talkMaxDuration)

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_7 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - 0) / var_198_7

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= 0 + var_198_7 and arg_195_1.time_ < 0 + var_198_7 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play1106704049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 1106704049
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play1106704050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0.825

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_1 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(1106704049).content)

				arg_199_1.text_.text = var_202_1

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_3 = 33 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 33)

				if (33 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 33)) > 0 and var_202_0 < var_202_3 then
					arg_199_1.talkMaxDuration = var_202_3

					if var_202_3 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_3 + 0
					end
				end

				arg_199_1.text_.text = var_202_1
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_4 = math.max(var_202_0, arg_199_1.talkMaxDuration)

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_4 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - 0) / var_202_4

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= 0 + var_202_4 and arg_199_1.time_ < 0 + var_202_4 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play1106704050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 1106704050
		arg_203_1.duration_ = 1

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"

			SetActive(arg_203_1.choicesGo_, true)

			for iter_204_0, iter_204_1 in ipairs(arg_203_1.choices_) do
				SetActive(iter_204_1.go, iter_204_0 <= 1)
			end

			arg_203_1.choices_[1].txt.text = arg_203_1:FormatText(StoryChoiceCfg[380].name)
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play1106704051(arg_203_1)
			end

			arg_203_1:RecordChoiceLog(1106704050, 380)
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.allBtn_.enabled = false
			end

			if arg_203_1.time_ >= 0 + 1 and arg_203_1.time_ < 0 + 1 + arg_206_0 then
				arg_203_1.allBtn_.enabled = true
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play1106704051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 1106704051
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play1106704052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0.25

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_1 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(1106704051).content)

				arg_207_1.text_.text = var_210_1

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_3 = 10 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_1) / 10)

				if (10 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_1) / 10)) > 0 and var_210_0 < var_210_3 then
					arg_207_1.talkMaxDuration = var_210_3

					if var_210_3 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_3 + 0
					end
				end

				arg_207_1.text_.text = var_210_1
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_4 = math.max(var_210_0, arg_207_1.talkMaxDuration)

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_4 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - 0) / var_210_4

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= 0 + var_210_4 and arg_207_1.time_ < 0 + var_210_4 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play1106704052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 1106704052
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play1106704053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0.15

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, true)
				arg_211_1.iconController_:SetSelectedState("hero")

				arg_211_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_211_1.callingController_:SetSelectedState("normal")

				arg_211_1.keyicon_.color = Color.New(1, 1, 1)
				arg_211_1.icon_.color = Color.New(1, 1, 1)

				local var_214_1 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(1106704052).content)

				arg_211_1.text_.text = var_214_1

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_3 = 6 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_1) / 6)

				if (6 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_1) / 6)) > 0 and var_214_0 < var_214_3 then
					arg_211_1.talkMaxDuration = var_214_3

					if var_214_3 + 0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_3 + 0
					end
				end

				arg_211_1.text_.text = var_214_1
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_4 = math.max(var_214_0, arg_211_1.talkMaxDuration)

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_4 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - 0) / var_214_4

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= 0 + var_214_4 and arg_211_1.time_ < 0 + var_214_4 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play1106704053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 1106704053
		arg_215_1.duration_ = 1.4

		local var_215_0 = {
			zh = 1.333,
			ja = 1.4
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play1106704054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0.125

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_1 = arg_215_1:GetWordFromCfg(1106704053)
				local var_218_2 = arg_215_1:FormatText(var_218_1.content)

				arg_215_1.text_.text = var_218_2

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_4 = 5 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 5)

				if (5 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 5)) > 0 and var_218_0 < var_218_4 then
					arg_215_1.talkMaxDuration = var_218_4

					if var_218_4 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_4 + 0
					end
				end

				arg_215_1.text_.text = var_218_2
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704053", "story_v_side_new_1106704.awb") ~= 0 then
					local var_218_5 = manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704053", "story_v_side_new_1106704.awb") / 1000

					if var_218_5 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_5 + 0
					end

					if var_218_1.prefab_name ~= "" and arg_215_1.actors_[var_218_1.prefab_name] ~= nil then
						local var_218_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_1.prefab_name].transform, "story_v_side_new_1106704", "1106704053", "story_v_side_new_1106704.awb")

						arg_215_1:RecordAudio("1106704053", var_218_6)
						arg_215_1:RecordAudio("1106704053", var_218_6)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_side_new_1106704", "1106704053", "story_v_side_new_1106704.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_side_new_1106704", "1106704053", "story_v_side_new_1106704.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_7 = math.max(var_218_0, arg_215_1.talkMaxDuration)

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_7 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - 0) / var_218_7

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= 0 + var_218_7 and arg_215_1.time_ < 0 + var_218_7 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play1106704054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 1106704054
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play1106704055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0.875

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_1 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(1106704054).content)

				arg_219_1.text_.text = var_222_1

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_3 = 35 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_1) / 35)

				if (35 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_1) / 35)) > 0 and var_222_0 < var_222_3 then
					arg_219_1.talkMaxDuration = var_222_3

					if var_222_3 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_3 + 0
					end
				end

				arg_219_1.text_.text = var_222_1
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_4 = math.max(var_222_0, arg_219_1.talkMaxDuration)

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_4 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - 0) / var_222_4

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= 0 + var_222_4 and arg_219_1.time_ < 0 + var_222_4 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play1106704055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 1106704055
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play1106704056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0.75

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_1 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(1106704055).content)

				arg_223_1.text_.text = var_226_1

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_3 = 30 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_1) / 30)

				if (30 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_1) / 30)) > 0 and var_226_0 < var_226_3 then
					arg_223_1.talkMaxDuration = var_226_3

					if var_226_3 + 0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_3 + 0
					end
				end

				arg_223_1.text_.text = var_226_1
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_4 = math.max(var_226_0, arg_223_1.talkMaxDuration)

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_4 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - 0) / var_226_4

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= 0 + var_226_4 and arg_223_1.time_ < 0 + var_226_4 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play1106704056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 1106704056
		arg_227_1.duration_ = 2.97

		local var_227_0 = {
			zh = 2.333,
			ja = 2.966
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play1106704057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0.3

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_1 = arg_227_1:GetWordFromCfg(1106704056)
				local var_230_2 = arg_227_1:FormatText(var_230_1.content)

				arg_227_1.text_.text = var_230_2

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_4 = 12 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_2) / 12)

				if (12 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_2) / 12)) > 0 and var_230_0 < var_230_4 then
					arg_227_1.talkMaxDuration = var_230_4

					if var_230_4 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_4 + 0
					end
				end

				arg_227_1.text_.text = var_230_2
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704056", "story_v_side_new_1106704.awb") ~= 0 then
					local var_230_5 = manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704056", "story_v_side_new_1106704.awb") / 1000

					if var_230_5 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_5 + 0
					end

					if var_230_1.prefab_name ~= "" and arg_227_1.actors_[var_230_1.prefab_name] ~= nil then
						local var_230_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_1.prefab_name].transform, "story_v_side_new_1106704", "1106704056", "story_v_side_new_1106704.awb")

						arg_227_1:RecordAudio("1106704056", var_230_6)
						arg_227_1:RecordAudio("1106704056", var_230_6)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_side_new_1106704", "1106704056", "story_v_side_new_1106704.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_side_new_1106704", "1106704056", "story_v_side_new_1106704.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_7 = math.max(var_230_0, arg_227_1.talkMaxDuration)

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_7 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - 0) / var_230_7

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= 0 + var_230_7 and arg_227_1.time_ < 0 + var_230_7 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play1106704057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 1106704057
		arg_231_1.duration_ = 8

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play1106704058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if arg_231_1.bgs_.ST03 == nil then
				local var_234_0 = Object.Instantiate(arg_231_1.paintGo_)

				var_234_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST03")
				var_234_0.name = "ST03"
				var_234_0.transform.parent = arg_231_1.stage_.transform
				var_234_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_231_1.bgs_.ST03 = var_234_0
			end

			if 1.5 < arg_231_1.time_ and arg_231_1.time_ <= 1.5 + arg_234_0 then
				local var_234_1 = arg_231_1.bgs_.ST03

				arg_231_1.bgs_.ST03.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_234_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_234_2 = var_234_1:GetComponent("SpriteRenderer")

				if var_234_2 and var_234_2.sprite then
					local var_234_3 = 2 * (var_234_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_234_1.transform.localScale = Vector3.New(var_234_3 / var_234_2.sprite.bounds.size.y < var_234_3 * manager.ui.mainCameraCom_.aspect / var_234_2.sprite.bounds.size.x and var_234_3 * manager.ui.mainCameraCom_.aspect / var_234_2.sprite.bounds.size.x or var_234_3 / var_234_2.sprite.bounds.size.y, var_234_3 / var_234_2.sprite.bounds.size.y < var_234_3 * manager.ui.mainCameraCom_.aspect / var_234_2.sprite.bounds.size.x and var_234_3 * manager.ui.mainCameraCom_.aspect / var_234_2.sprite.bounds.size.x or var_234_3 / var_234_2.sprite.bounds.size.y, 0)
				end

				for iter_234_0, iter_234_1 in pairs(arg_231_1.bgs_) do
					if iter_234_0 ~= "ST03" then
						iter_234_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_234_4 = 0

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_4 + arg_234_0 then
				arg_231_1.mask_.enabled = true
				arg_231_1.mask_.raycastTarget = false

				arg_231_1:SetGaussion(false)
			end

			local var_234_5 = 1.5

			if var_234_4 <= arg_231_1.time_ and arg_231_1.time_ < var_234_4 + var_234_5 then
				local var_234_6 = Color.New(0, 0, 0)

				var_234_6.a = Mathf.Lerp(0, 1, (arg_231_1.time_ - var_234_4) / var_234_5)
				arg_231_1.mask_.color = var_234_6
			end

			if arg_231_1.time_ >= var_234_4 + var_234_5 and arg_231_1.time_ < var_234_4 + var_234_5 + arg_234_0 then
				local var_234_7 = Color.New(0, 0, 0)

				var_234_7.a = 1
				arg_231_1.mask_.color = var_234_7
			end

			local var_234_8 = 1.5

			if 1.5 < arg_231_1.time_ and arg_231_1.time_ <= var_234_8 + arg_234_0 then
				arg_231_1.mask_.enabled = true
				arg_231_1.mask_.raycastTarget = false

				arg_231_1:SetGaussion(false)
			end

			local var_234_9 = 1.5

			if var_234_8 <= arg_231_1.time_ and arg_231_1.time_ < var_234_8 + var_234_9 then
				local var_234_10 = Color.New(0, 0, 0)

				var_234_10.a = Mathf.Lerp(1, 0, (arg_231_1.time_ - var_234_8) / var_234_9)
				arg_231_1.mask_.color = var_234_10
			end

			if arg_231_1.time_ >= var_234_8 + var_234_9 and arg_231_1.time_ < var_234_8 + var_234_9 + arg_234_0 then
				local var_234_11 = Color.New(0, 0, 0)

				arg_231_1.mask_.enabled = false
				var_234_11.a = 0
				arg_231_1.mask_.color = var_234_11
			end

			if 2.66666666666667 < arg_231_1.time_ and arg_231_1.time_ <= 2.66666666666667 + arg_234_0 then
				arg_231_1:AudioAction("play", "effect", "se_story_v1_environment_crowd", "se_story_v1_environment_crowd", "se_story_v1_environment_crowd.awb")
			end

			local var_234_13 = 0

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_13 + arg_234_0 then
				arg_231_1.allBtn_.enabled = false
			end

			if arg_231_1.time_ >= var_234_13 + 4.1 and arg_231_1.time_ < var_234_13 + 4.1 + arg_234_0 then
				arg_231_1.allBtn_.enabled = true
			end

			if arg_231_1.frameCnt_ <= 1 then
				arg_231_1.dialog_:SetActive(false)
			end

			local var_234_14 = 3
			local var_234_15 = 1.1

			if 3 < arg_231_1.time_ and arg_231_1.time_ <= var_234_14 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0

				arg_231_1.dialog_:SetActive(true)

				arg_231_1.dialogCg_.alpha = 0

				local var_234_16 = LeanTween.value(arg_231_1.dialog_, 0, 1, 0.3)

				var_234_16:setOnUpdate(LuaHelper.FloatAction(function(arg_235_0)
					arg_231_1.dialogCg_.alpha = arg_235_0
				end))
				var_234_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_231_1.dialog_)
					var_234_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_231_1.duration_ = arg_231_1.duration_ + 0.3

				SetActive(arg_231_1.leftNameGo_, false)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_17 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(1106704057).content)

				arg_231_1.text_.text = var_234_17

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_19 = 44 <= 0 and var_234_15 or var_234_15 * (utf8.len(var_234_17) / 44)

				if (44 <= 0 and var_234_15 or var_234_15 * (utf8.len(var_234_17) / 44)) > 0 and var_234_15 < var_234_19 then
					arg_231_1.talkMaxDuration = var_234_19
					var_234_14 = var_234_14 + 0.3

					if var_234_19 + var_234_14 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_19 + var_234_14
					end
				end

				arg_231_1.text_.text = var_234_17
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_20 = var_234_14 + 0.3
			local var_234_21 = math.max(var_234_15, arg_231_1.talkMaxDuration)

			if var_234_14 + 0.3 <= arg_231_1.time_ and arg_231_1.time_ < var_234_20 + var_234_21 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_20) / var_234_21

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_20 + var_234_21 and arg_231_1.time_ < var_234_20 + var_234_21 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play1106704058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 1106704058
		arg_237_1.duration_ = 6.27

		local var_237_0 = {
			zh = 4.166,
			ja = 6.266
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play1106704059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if arg_237_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_240_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_237_1.stage_.transform)

				var_240_0.name = "1084ui_story"
				var_240_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_237_1.actors_["1084ui_story"] = var_240_0

				local var_240_1 = var_240_0:GetComponentInChildren(typeof(CharacterEffect))

				var_240_1.enabled = true

				local var_240_2 = GameObjectTools.GetOrAddComponent(var_240_0, typeof(DynamicBoneHelper))

				if var_240_2 then
					var_240_2:EnableDynamicBone(false)
				end

				arg_237_1:ShowWeapon(var_240_1.transform, false)

				arg_237_1.var_["1084ui_story" .. "Animator"] = var_240_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_237_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_237_1.var_["1084ui_story" .. "LipSync"] = var_240_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_240_3 = arg_237_1.actors_["1084ui_story"].transform

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos1084ui_story = var_240_3.localPosition
			end

			local var_240_4 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_4 then
				var_240_3.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_237_1.time_ - 0) / var_240_4)
				var_240_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_240_3.position).x, (manager.ui.mainCamera.transform.position - var_240_3.position).y, (manager.ui.mainCamera.transform.position - var_240_3.position).z)
				var_240_3.localEulerAngles.z = 0
				var_240_3.localEulerAngles.x = 0
				var_240_3.localEulerAngles = var_240_3.localEulerAngles
			end

			if arg_237_1.time_ >= 0 + var_240_4 and arg_237_1.time_ < 0 + var_240_4 + arg_240_0 then
				var_240_3.localPosition = Vector3.New(0, -0.97, -6)
				var_240_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_240_3.position).x, (manager.ui.mainCamera.transform.position - var_240_3.position).y, (manager.ui.mainCamera.transform.position - var_240_3.position).z)
				var_240_3.localEulerAngles.z = 0
				var_240_3.localEulerAngles.x = 0
				var_240_3.localEulerAngles = var_240_3.localEulerAngles
			end

			local var_240_5 = arg_237_1.actors_["1084ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_5) and arg_237_1.var_.characterEffect1084ui_story == nil then
				arg_237_1.var_.characterEffect1084ui_story = var_240_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_6 = 0.2

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_6 and not isNil(var_240_5) then
				if arg_237_1.var_.characterEffect1084ui_story and not isNil(var_240_5) then
					arg_237_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= 0 + var_240_6 and arg_237_1.time_ < 0 + var_240_6 + arg_240_0 and not isNil(var_240_5) and arg_237_1.var_.characterEffect1084ui_story then
				arg_237_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_240_8 = 0
			local var_240_9 = 0.425

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_8 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_10 = arg_237_1:GetWordFromCfg(1106704058)
				local var_240_11 = arg_237_1:FormatText(var_240_10.content)

				arg_237_1.text_.text = var_240_11

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_13 = 17 <= 0 and var_240_9 or var_240_9 * (utf8.len(var_240_11) / 17)

				if (17 <= 0 and var_240_9 or var_240_9 * (utf8.len(var_240_11) / 17)) > 0 and var_240_9 < var_240_13 then
					arg_237_1.talkMaxDuration = var_240_13

					if var_240_13 + var_240_8 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_13 + var_240_8
					end
				end

				arg_237_1.text_.text = var_240_11
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704058", "story_v_side_new_1106704.awb") ~= 0 then
					local var_240_14 = manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704058", "story_v_side_new_1106704.awb") / 1000

					if var_240_14 + var_240_8 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_14 + var_240_8
					end

					if var_240_10.prefab_name ~= "" and arg_237_1.actors_[var_240_10.prefab_name] ~= nil then
						local var_240_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_10.prefab_name].transform, "story_v_side_new_1106704", "1106704058", "story_v_side_new_1106704.awb")

						arg_237_1:RecordAudio("1106704058", var_240_15)
						arg_237_1:RecordAudio("1106704058", var_240_15)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_side_new_1106704", "1106704058", "story_v_side_new_1106704.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_side_new_1106704", "1106704058", "story_v_side_new_1106704.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_16 = math.max(var_240_9, arg_237_1.talkMaxDuration)

			if var_240_8 <= arg_237_1.time_ and arg_237_1.time_ < var_240_8 + var_240_16 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_8) / var_240_16

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_8 + var_240_16 and arg_237_1.time_ < var_240_8 + var_240_16 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_237_1:InitPlayNodeList()
	end,
	Play1106704059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 1106704059
		arg_241_1.duration_ = 3.33

		local var_241_0 = {
			zh = 2.033,
			ja = 3.333
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play1106704060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if arg_241_1.actors_["1148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1148ui_story"))) then
				local var_244_0 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_241_1.stage_.transform)

				var_244_0.name = "1148ui_story"
				var_244_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_241_1.actors_["1148ui_story"] = var_244_0

				local var_244_1 = var_244_0:GetComponentInChildren(typeof(CharacterEffect))

				var_244_1.enabled = true

				local var_244_2 = GameObjectTools.GetOrAddComponent(var_244_0, typeof(DynamicBoneHelper))

				if var_244_2 then
					var_244_2:EnableDynamicBone(false)
				end

				arg_241_1:ShowWeapon(var_244_1.transform, false)

				arg_241_1.var_["1148ui_story" .. "Animator"] = var_244_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_241_1.var_["1148ui_story" .. "Animator"].applyRootMotion = true
				arg_241_1.var_["1148ui_story" .. "LipSync"] = var_244_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_244_3 = arg_241_1.actors_["1148ui_story"].transform

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos1148ui_story = var_244_3.localPosition
			end

			local var_244_4 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_4 then
				var_244_3.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1148ui_story, Vector3.New(0.7, -0.8, -6.2), (arg_241_1.time_ - 0) / var_244_4)
				var_244_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_244_3.position).x, (manager.ui.mainCamera.transform.position - var_244_3.position).y, (manager.ui.mainCamera.transform.position - var_244_3.position).z)
				var_244_3.localEulerAngles.z = 0
				var_244_3.localEulerAngles.x = 0
				var_244_3.localEulerAngles = var_244_3.localEulerAngles
			end

			if arg_241_1.time_ >= 0 + var_244_4 and arg_241_1.time_ < 0 + var_244_4 + arg_244_0 then
				var_244_3.localPosition = Vector3.New(0.7, -0.8, -6.2)
				var_244_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_244_3.position).x, (manager.ui.mainCamera.transform.position - var_244_3.position).y, (manager.ui.mainCamera.transform.position - var_244_3.position).z)
				var_244_3.localEulerAngles.z = 0
				var_244_3.localEulerAngles.x = 0
				var_244_3.localEulerAngles = var_244_3.localEulerAngles
			end

			local var_244_5 = arg_241_1.actors_["1084ui_story"].transform

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos1084ui_story = var_244_5.localPosition
			end

			local var_244_6 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_6 then
				var_244_5.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_241_1.time_ - 0) / var_244_6)
				var_244_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_244_5.position).x, (manager.ui.mainCamera.transform.position - var_244_5.position).y, (manager.ui.mainCamera.transform.position - var_244_5.position).z)
				var_244_5.localEulerAngles.z = 0
				var_244_5.localEulerAngles.x = 0
				var_244_5.localEulerAngles = var_244_5.localEulerAngles
			end

			if arg_241_1.time_ >= 0 + var_244_6 and arg_241_1.time_ < 0 + var_244_6 + arg_244_0 then
				var_244_5.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_244_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_244_5.position).x, (manager.ui.mainCamera.transform.position - var_244_5.position).y, (manager.ui.mainCamera.transform.position - var_244_5.position).z)
				var_244_5.localEulerAngles.z = 0
				var_244_5.localEulerAngles.x = 0
				var_244_5.localEulerAngles = var_244_5.localEulerAngles
			end

			local var_244_7 = arg_241_1.actors_["1084ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_7) and arg_241_1.var_.characterEffect1084ui_story == nil then
				arg_241_1.var_.characterEffect1084ui_story = var_244_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_8 = 0.2

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_8 and not isNil(var_244_7) then
				if arg_241_1.var_.characterEffect1084ui_story and not isNil(var_244_7) then
					arg_241_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_241_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_241_1.time_ - 0) / var_244_8)
				end
			end

			if arg_241_1.time_ >= 0 + var_244_8 and arg_241_1.time_ < 0 + var_244_8 + arg_244_0 and not isNil(var_244_7) and arg_241_1.var_.characterEffect1084ui_story then
				arg_241_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_241_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_244_9 = arg_241_1.actors_["1148ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_9) and arg_241_1.var_.characterEffect1148ui_story == nil then
				arg_241_1.var_.characterEffect1148ui_story = var_244_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_10 = 0.2

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_10 and not isNil(var_244_9) then
				if arg_241_1.var_.characterEffect1148ui_story and not isNil(var_244_9) then
					arg_241_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= 0 + var_244_10 and arg_241_1.time_ < 0 + var_244_10 + arg_244_0 and not isNil(var_244_9) and arg_241_1.var_.characterEffect1148ui_story then
				arg_241_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action7_1")
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_244_12 = 0
			local var_244_13 = 0.225

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_12 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_14 = arg_241_1:GetWordFromCfg(1106704059)
				local var_244_15 = arg_241_1:FormatText(var_244_14.content)

				arg_241_1.text_.text = var_244_15

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_17 = 9 <= 0 and var_244_13 or var_244_13 * (utf8.len(var_244_15) / 9)

				if (9 <= 0 and var_244_13 or var_244_13 * (utf8.len(var_244_15) / 9)) > 0 and var_244_13 < var_244_17 then
					arg_241_1.talkMaxDuration = var_244_17

					if var_244_17 + var_244_12 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_17 + var_244_12
					end
				end

				arg_241_1.text_.text = var_244_15
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704059", "story_v_side_new_1106704.awb") ~= 0 then
					local var_244_18 = manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704059", "story_v_side_new_1106704.awb") / 1000

					if var_244_18 + var_244_12 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_18 + var_244_12
					end

					if var_244_14.prefab_name ~= "" and arg_241_1.actors_[var_244_14.prefab_name] ~= nil then
						local var_244_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_14.prefab_name].transform, "story_v_side_new_1106704", "1106704059", "story_v_side_new_1106704.awb")

						arg_241_1:RecordAudio("1106704059", var_244_19)
						arg_241_1:RecordAudio("1106704059", var_244_19)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_side_new_1106704", "1106704059", "story_v_side_new_1106704.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_side_new_1106704", "1106704059", "story_v_side_new_1106704.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_20 = math.max(var_244_13, arg_241_1.talkMaxDuration)

			if var_244_12 <= arg_241_1.time_ and arg_241_1.time_ < var_244_12 + var_244_20 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_12) / var_244_20

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_12 + var_244_20 and arg_241_1.time_ < var_244_12 + var_244_20 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play1106704060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 1106704060
		arg_245_1.duration_ = 7.73

		local var_245_0 = {
			zh = 5.733,
			ja = 7.733
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play1106704061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(arg_245_1.actors_["1148ui_story"]) and arg_245_1.var_.characterEffect1148ui_story == nil then
				arg_245_1.var_.characterEffect1148ui_story = arg_245_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_0 = 0.2

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 and not isNil(arg_245_1.actors_["1148ui_story"]) then
				if arg_245_1.var_.characterEffect1148ui_story and not isNil(arg_245_1.actors_["1148ui_story"]) then
					arg_245_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_245_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_245_1.time_ - 0) / var_248_0)
				end
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 and not isNil(arg_245_1.actors_["1148ui_story"]) and arg_245_1.var_.characterEffect1148ui_story then
				arg_245_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_245_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_248_1 = 0
			local var_248_2 = 0.575

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_1")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_3 = arg_245_1:GetWordFromCfg(1106704060)
				local var_248_4 = arg_245_1:FormatText(var_248_3.content)

				arg_245_1.text_.text = var_248_4

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_6 = 23 <= 0 and var_248_2 or var_248_2 * (utf8.len(var_248_4) / 23)

				if (23 <= 0 and var_248_2 or var_248_2 * (utf8.len(var_248_4) / 23)) > 0 and var_248_2 < var_248_6 then
					arg_245_1.talkMaxDuration = var_248_6

					if var_248_6 + var_248_1 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_6 + var_248_1
					end
				end

				arg_245_1.text_.text = var_248_4
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704060", "story_v_side_new_1106704.awb") ~= 0 then
					local var_248_7 = manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704060", "story_v_side_new_1106704.awb") / 1000

					if var_248_7 + var_248_1 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_7 + var_248_1
					end

					if var_248_3.prefab_name ~= "" and arg_245_1.actors_[var_248_3.prefab_name] ~= nil then
						local var_248_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_3.prefab_name].transform, "story_v_side_new_1106704", "1106704060", "story_v_side_new_1106704.awb")

						arg_245_1:RecordAudio("1106704060", var_248_8)
						arg_245_1:RecordAudio("1106704060", var_248_8)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_side_new_1106704", "1106704060", "story_v_side_new_1106704.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_side_new_1106704", "1106704060", "story_v_side_new_1106704.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_9 = math.max(var_248_2, arg_245_1.talkMaxDuration)

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_9 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_1) / var_248_9

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_1 + var_248_9 and arg_245_1.time_ < var_248_1 + var_248_9 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play1106704061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 1106704061
		arg_249_1.duration_ = 9.1

		local var_249_0 = {
			zh = 3.766,
			ja = 9.1
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play1106704062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(arg_249_1.actors_["1084ui_story"]) and arg_249_1.var_.characterEffect1084ui_story == nil then
				arg_249_1.var_.characterEffect1084ui_story = arg_249_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_0 = 0.2

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 and not isNil(arg_249_1.actors_["1084ui_story"]) then
				if arg_249_1.var_.characterEffect1084ui_story and not isNil(arg_249_1.actors_["1084ui_story"]) then
					arg_249_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 and not isNil(arg_249_1.actors_["1084ui_story"]) and arg_249_1.var_.characterEffect1084ui_story then
				arg_249_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action438")
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_252_2 = 0
			local var_252_3 = 0.45

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_2 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_4 = arg_249_1:GetWordFromCfg(1106704061)
				local var_252_5 = arg_249_1:FormatText(var_252_4.content)

				arg_249_1.text_.text = var_252_5

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_7 = 18 <= 0 and var_252_3 or var_252_3 * (utf8.len(var_252_5) / 18)

				if (18 <= 0 and var_252_3 or var_252_3 * (utf8.len(var_252_5) / 18)) > 0 and var_252_3 < var_252_7 then
					arg_249_1.talkMaxDuration = var_252_7

					if var_252_7 + var_252_2 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_7 + var_252_2
					end
				end

				arg_249_1.text_.text = var_252_5
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704061", "story_v_side_new_1106704.awb") ~= 0 then
					local var_252_8 = manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704061", "story_v_side_new_1106704.awb") / 1000

					if var_252_8 + var_252_2 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_8 + var_252_2
					end

					if var_252_4.prefab_name ~= "" and arg_249_1.actors_[var_252_4.prefab_name] ~= nil then
						local var_252_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_4.prefab_name].transform, "story_v_side_new_1106704", "1106704061", "story_v_side_new_1106704.awb")

						arg_249_1:RecordAudio("1106704061", var_252_9)
						arg_249_1:RecordAudio("1106704061", var_252_9)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_side_new_1106704", "1106704061", "story_v_side_new_1106704.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_side_new_1106704", "1106704061", "story_v_side_new_1106704.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_10 = math.max(var_252_3, arg_249_1.talkMaxDuration)

			if var_252_2 <= arg_249_1.time_ and arg_249_1.time_ < var_252_2 + var_252_10 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_2) / var_252_10

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_2 + var_252_10 and arg_249_1.time_ < var_252_2 + var_252_10 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play1106704062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 1106704062
		arg_253_1.duration_ = 9.93

		local var_253_0 = {
			zh = 6.166,
			ja = 9.933
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play1106704063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(arg_253_1.actors_["1084ui_story"]) and arg_253_1.var_.characterEffect1084ui_story == nil then
				arg_253_1.var_.characterEffect1084ui_story = arg_253_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_0 = 0.2

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 and not isNil(arg_253_1.actors_["1084ui_story"]) then
				if arg_253_1.var_.characterEffect1084ui_story and not isNil(arg_253_1.actors_["1084ui_story"]) then
					arg_253_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_253_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_253_1.time_ - 0) / var_256_0)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 and not isNil(arg_253_1.actors_["1084ui_story"]) and arg_253_1.var_.characterEffect1084ui_story then
				arg_253_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_253_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_256_1 = arg_253_1.actors_["1148ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect1148ui_story == nil then
				arg_253_1.var_.characterEffect1148ui_story = var_256_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.2

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_2 and not isNil(var_256_1) then
				if arg_253_1.var_.characterEffect1148ui_story and not isNil(var_256_1) then
					arg_253_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= 0 + var_256_2 and arg_253_1.time_ < 0 + var_256_2 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect1148ui_story then
				arg_253_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1048/story1048actionlink/1048action475")
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_256_4 = 0
			local var_256_5 = 0.8

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_4 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_6 = arg_253_1:GetWordFromCfg(1106704062)
				local var_256_7 = arg_253_1:FormatText(var_256_6.content)

				arg_253_1.text_.text = var_256_7

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_9 = 32 <= 0 and var_256_5 or var_256_5 * (utf8.len(var_256_7) / 32)

				if (32 <= 0 and var_256_5 or var_256_5 * (utf8.len(var_256_7) / 32)) > 0 and var_256_5 < var_256_9 then
					arg_253_1.talkMaxDuration = var_256_9

					if var_256_9 + var_256_4 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_9 + var_256_4
					end
				end

				arg_253_1.text_.text = var_256_7
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704062", "story_v_side_new_1106704.awb") ~= 0 then
					local var_256_10 = manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704062", "story_v_side_new_1106704.awb") / 1000

					if var_256_10 + var_256_4 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_10 + var_256_4
					end

					if var_256_6.prefab_name ~= "" and arg_253_1.actors_[var_256_6.prefab_name] ~= nil then
						local var_256_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_6.prefab_name].transform, "story_v_side_new_1106704", "1106704062", "story_v_side_new_1106704.awb")

						arg_253_1:RecordAudio("1106704062", var_256_11)
						arg_253_1:RecordAudio("1106704062", var_256_11)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_side_new_1106704", "1106704062", "story_v_side_new_1106704.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_side_new_1106704", "1106704062", "story_v_side_new_1106704.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_12 = math.max(var_256_5, arg_253_1.talkMaxDuration)

			if var_256_4 <= arg_253_1.time_ and arg_253_1.time_ < var_256_4 + var_256_12 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_4) / var_256_12

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_4 + var_256_12 and arg_253_1.time_ < var_256_4 + var_256_12 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play1106704063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 1106704063
		arg_257_1.duration_ = 3.17

		local var_257_0 = {
			zh = 2.633,
			ja = 3.166
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play1106704064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(arg_257_1.actors_["1148ui_story"]) and arg_257_1.var_.characterEffect1148ui_story == nil then
				arg_257_1.var_.characterEffect1148ui_story = arg_257_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_0 = 0.2

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 and not isNil(arg_257_1.actors_["1148ui_story"]) then
				if arg_257_1.var_.characterEffect1148ui_story and not isNil(arg_257_1.actors_["1148ui_story"]) then
					arg_257_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_257_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_257_1.time_ - 0) / var_260_0)
				end
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 and not isNil(arg_257_1.actors_["1148ui_story"]) and arg_257_1.var_.characterEffect1148ui_story then
				arg_257_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_257_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_260_1 = arg_257_1.actors_["1084ui_story"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_1) and arg_257_1.var_.characterEffect1084ui_story == nil then
				arg_257_1.var_.characterEffect1084ui_story = var_260_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_2 = 0.2

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_2 and not isNil(var_260_1) then
				if arg_257_1.var_.characterEffect1084ui_story and not isNil(var_260_1) then
					arg_257_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= 0 + var_260_2 and arg_257_1.time_ < 0 + var_260_2 + arg_260_0 and not isNil(var_260_1) and arg_257_1.var_.characterEffect1084ui_story then
				arg_257_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action486")
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_260_4 = 0
			local var_260_5 = 0.125

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_4 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_6 = arg_257_1:GetWordFromCfg(1106704063)
				local var_260_7 = arg_257_1:FormatText(var_260_6.content)

				arg_257_1.text_.text = var_260_7

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_9 = 5 <= 0 and var_260_5 or var_260_5 * (utf8.len(var_260_7) / 5)

				if (5 <= 0 and var_260_5 or var_260_5 * (utf8.len(var_260_7) / 5)) > 0 and var_260_5 < var_260_9 then
					arg_257_1.talkMaxDuration = var_260_9

					if var_260_9 + var_260_4 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_9 + var_260_4
					end
				end

				arg_257_1.text_.text = var_260_7
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704063", "story_v_side_new_1106704.awb") ~= 0 then
					local var_260_10 = manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704063", "story_v_side_new_1106704.awb") / 1000

					if var_260_10 + var_260_4 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_10 + var_260_4
					end

					if var_260_6.prefab_name ~= "" and arg_257_1.actors_[var_260_6.prefab_name] ~= nil then
						local var_260_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_6.prefab_name].transform, "story_v_side_new_1106704", "1106704063", "story_v_side_new_1106704.awb")

						arg_257_1:RecordAudio("1106704063", var_260_11)
						arg_257_1:RecordAudio("1106704063", var_260_11)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_side_new_1106704", "1106704063", "story_v_side_new_1106704.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_side_new_1106704", "1106704063", "story_v_side_new_1106704.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_12 = math.max(var_260_5, arg_257_1.talkMaxDuration)

			if var_260_4 <= arg_257_1.time_ and arg_257_1.time_ < var_260_4 + var_260_12 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_4) / var_260_12

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_4 + var_260_12 and arg_257_1.time_ < var_260_4 + var_260_12 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play1106704064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 1106704064
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play1106704065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos1148ui_story = arg_261_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_264_0 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 then
				arg_261_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_261_1.time_ - 0) / var_264_0)
				arg_261_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1148ui_story"].transform.position).z)
				arg_261_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["1148ui_story"].transform.localEulerAngles = arg_261_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 then
				arg_261_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_261_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1148ui_story"].transform.position).z)
				arg_261_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["1148ui_story"].transform.localEulerAngles = arg_261_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_264_1 = arg_261_1.actors_["1084ui_story"].transform

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos1084ui_story = var_264_1.localPosition
			end

			local var_264_2 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_2 then
				var_264_1.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_261_1.time_ - 0) / var_264_2)
				var_264_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_264_1.position).x, (manager.ui.mainCamera.transform.position - var_264_1.position).y, (manager.ui.mainCamera.transform.position - var_264_1.position).z)
				var_264_1.localEulerAngles.z = 0
				var_264_1.localEulerAngles.x = 0
				var_264_1.localEulerAngles = var_264_1.localEulerAngles
			end

			if arg_261_1.time_ >= 0 + var_264_2 and arg_261_1.time_ < 0 + var_264_2 + arg_264_0 then
				var_264_1.localPosition = Vector3.New(0, 100, 0)
				var_264_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_264_1.position).x, (manager.ui.mainCamera.transform.position - var_264_1.position).y, (manager.ui.mainCamera.transform.position - var_264_1.position).z)
				var_264_1.localEulerAngles.z = 0
				var_264_1.localEulerAngles.x = 0
				var_264_1.localEulerAngles = var_264_1.localEulerAngles
			end

			local var_264_3 = 0
			local var_264_4 = 0.425

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_3 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_5 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(1106704064).content)

				arg_261_1.text_.text = var_264_5

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_7 = 17 <= 0 and var_264_4 or var_264_4 * (utf8.len(var_264_5) / 17)

				if (17 <= 0 and var_264_4 or var_264_4 * (utf8.len(var_264_5) / 17)) > 0 and var_264_4 < var_264_7 then
					arg_261_1.talkMaxDuration = var_264_7

					if var_264_7 + var_264_3 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_7 + var_264_3
					end
				end

				arg_261_1.text_.text = var_264_5
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_8 = math.max(var_264_4, arg_261_1.talkMaxDuration)

			if var_264_3 <= arg_261_1.time_ and arg_261_1.time_ < var_264_3 + var_264_8 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_3) / var_264_8

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_3 + var_264_8 and arg_261_1.time_ < var_264_3 + var_264_8 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play1106704065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 1106704065
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play1106704066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0.5

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, true)
				arg_265_1.iconController_:SetSelectedState("hero")

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_1 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(1106704065).content)

				arg_265_1.text_.text = var_268_1

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_3 = 20 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_1) / 20)

				if (20 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_1) / 20)) > 0 and var_268_0 < var_268_3 then
					arg_265_1.talkMaxDuration = var_268_3

					if var_268_3 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_3 + 0
					end
				end

				arg_265_1.text_.text = var_268_1
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_4 = math.max(var_268_0, arg_265_1.talkMaxDuration)

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_4 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - 0) / var_268_4

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= 0 + var_268_4 and arg_265_1.time_ < 0 + var_268_4 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play1106704066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 1106704066
		arg_269_1.duration_ = 6.63

		local var_269_0 = {
			zh = 3.1,
			ja = 6.633
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play1106704067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos1148ui_story = arg_269_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_272_0 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 then
				arg_269_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_269_1.time_ - 0) / var_272_0)
				arg_269_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1148ui_story"].transform.position).z)
				arg_269_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["1148ui_story"].transform.localEulerAngles = arg_269_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 then
				arg_269_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_269_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1148ui_story"].transform.position).z)
				arg_269_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["1148ui_story"].transform.localEulerAngles = arg_269_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_272_1 = arg_269_1.actors_["1148ui_story"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect1148ui_story == nil then
				arg_269_1.var_.characterEffect1148ui_story = var_272_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_2 = 0.2

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_2 and not isNil(var_272_1) then
				if arg_269_1.var_.characterEffect1148ui_story and not isNil(var_272_1) then
					arg_269_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= 0 + var_272_2 and arg_269_1.time_ < 0 + var_272_2 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect1148ui_story then
				arg_269_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action7_1")
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_272_4 = 0
			local var_272_5 = 0.3

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_4 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_6 = arg_269_1:GetWordFromCfg(1106704066)
				local var_272_7 = arg_269_1:FormatText(var_272_6.content)

				arg_269_1.text_.text = var_272_7

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_9 = 12 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_7) / 12)

				if (12 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_7) / 12)) > 0 and var_272_5 < var_272_9 then
					arg_269_1.talkMaxDuration = var_272_9

					if var_272_9 + var_272_4 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_9 + var_272_4
					end
				end

				arg_269_1.text_.text = var_272_7
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704066", "story_v_side_new_1106704.awb") ~= 0 then
					local var_272_10 = manager.audio:GetVoiceLength("story_v_side_new_1106704", "1106704066", "story_v_side_new_1106704.awb") / 1000

					if var_272_10 + var_272_4 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_10 + var_272_4
					end

					if var_272_6.prefab_name ~= "" and arg_269_1.actors_[var_272_6.prefab_name] ~= nil then
						local var_272_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_6.prefab_name].transform, "story_v_side_new_1106704", "1106704066", "story_v_side_new_1106704.awb")

						arg_269_1:RecordAudio("1106704066", var_272_11)
						arg_269_1:RecordAudio("1106704066", var_272_11)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_side_new_1106704", "1106704066", "story_v_side_new_1106704.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_side_new_1106704", "1106704066", "story_v_side_new_1106704.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_12 = math.max(var_272_5, arg_269_1.talkMaxDuration)

			if var_272_4 <= arg_269_1.time_ and arg_269_1.time_ < var_272_4 + var_272_12 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_4) / var_272_12

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_4 + var_272_12 and arg_269_1.time_ < var_272_4 + var_272_12 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play1106704067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 1106704067
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play1106704068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos1148ui_story = arg_273_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_276_0 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 then
				arg_273_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_273_1.time_ - 0) / var_276_0)
				arg_273_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1148ui_story"].transform.position).z)
				arg_273_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["1148ui_story"].transform.localEulerAngles = arg_273_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 then
				arg_273_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_273_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1148ui_story"].transform.position).z)
				arg_273_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["1148ui_story"].transform.localEulerAngles = arg_273_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_276_1 = 0
			local var_276_2 = 0.275

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_3 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(1106704067).content)

				arg_273_1.text_.text = var_276_3

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_5 = 11 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_3) / 11)

				if (11 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_3) / 11)) > 0 and var_276_2 < var_276_5 then
					arg_273_1.talkMaxDuration = var_276_5

					if var_276_5 + var_276_1 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_5 + var_276_1
					end
				end

				arg_273_1.text_.text = var_276_3
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_6 = math.max(var_276_2, arg_273_1.talkMaxDuration)

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_6 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_1) / var_276_6

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_1 + var_276_6 and arg_273_1.time_ < var_276_1 + var_276_6 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play1106704068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 1106704068
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
			arg_277_1.auto_ = false
		end

		function arg_277_1.playNext_(arg_279_0)
			arg_277_1.onStoryFinished_()
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 1.625

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, false)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_1 = arg_277_1:FormatText(arg_277_1:GetWordFromCfg(1106704068).content)

				arg_277_1.text_.text = var_280_1

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_3 = 65 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_1) / 65)

				if (65 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_1) / 65)) > 0 and var_280_0 < var_280_3 then
					arg_277_1.talkMaxDuration = var_280_3

					if var_280_3 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_3 + 0
					end
				end

				arg_277_1.text_.text = var_280_1
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_4 = math.max(var_280_0, arg_277_1.talkMaxDuration)

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_4 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - 0) / var_280_4

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= 0 + var_280_4 and arg_277_1.time_ < 0 + var_280_4 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST24",
		"TextureConfig/Background/ST25",
		"TextureConfig/Background/R6701",
		"TextureConfig/Background/ST03"
	},
	voices = {
		"story_v_side_new_1106704.awb"
	}
}
