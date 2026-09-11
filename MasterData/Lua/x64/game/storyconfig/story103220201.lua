return {
	Play322021001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 322021001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play322021002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST73a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST73a")
				var_4_0.name = "ST73a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST73a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST73a

				arg_1_1.bgs_.ST73a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST73a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 2

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_11 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_11

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_11
						arg_1_1.bgmTxt2_.text = var_4_11
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

			if 0.4 < arg_1_1.time_ and arg_1_1.time_ <= 0.4 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_5_story_serious", "bgm_activity_4_5_story_serious", "bgm_activity_4_5_story_serious.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_4_5_story_serious", "bgm_activity_4_5_story_serious")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_14 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_14

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_14
						arg_1_1.bgmTxt2_.text = var_4_14
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

			if 0.166666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.166666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_lab", "")
			end

			if 0.401 < arg_1_1.time_ and arg_1_1.time_ <= 0.401 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_5_story_serious", "init_story", "bgm_activity_4_5_story_serious.awb")

				local var_4_18 = manager.audio:GetAudioName("bgm_activity_4_5_story_serious", "init_story")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_18 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_18

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_18
						arg_1_1.bgmTxt2_.text = var_4_18
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_19 = 2
			local var_4_20 = 0.05

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_19 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_21 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_21:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_22 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(322021001).content)

				arg_1_1.text_.text = var_4_22

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_24 = 2 <= 0 and var_4_20 or var_4_20 * (utf8.len(var_4_22) / 2)

				if (2 <= 0 and var_4_20 or var_4_20 * (utf8.len(var_4_22) / 2)) > 0 and var_4_20 < var_4_24 then
					arg_1_1.talkMaxDuration = var_4_24
					var_4_19 = var_4_19 + 0.3

					if var_4_24 + var_4_19 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_24 + var_4_19
					end
				end

				arg_1_1.text_.text = var_4_22
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_25 = var_4_19 + 0.3
			local var_4_26 = math.max(var_4_20, arg_1_1.talkMaxDuration)

			if var_4_19 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_25 + var_4_26 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_25) / var_4_26

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_25 + var_4_26 and arg_1_1.time_ < var_4_25 + var_4_26 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play322021002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 322021002
		arg_10_1.duration_ = 5

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play322021003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_9000

			if 0.1 < arg_10_1.time_ and arg_10_1.time_ <= 0.1 + arg_13_0 then
				arg_10_1:AudioAction("play", "effect", "se_story_145", "se_story_145_gold", "")
			end

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				local var_13_1 = arg_10_1.var_.effect1002

				if not arg_10_1.var_.effect1002 then
					var_13_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ball_in_keep"), manager.ui.mainCamera.transform)
					var_13_1.name = "1002"
					arg_10_1.var_.effect1002 = var_13_1
				else
					var_13_1.transform:SetParent(var_13_9000)
				end

				var_13_1.transform.localPosition = Vector3.New(0, 0, 0)
				var_13_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_13_3 = 0
			local var_13_4 = 1.075

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_3 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, false)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_5 = arg_10_1:FormatText(arg_10_1:GetWordFromCfg(322021002).content)

				arg_10_1.text_.text = var_13_5

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_7 = 43 <= 0 and var_13_4 or var_13_4 * (utf8.len(var_13_5) / 43)

				if (43 <= 0 and var_13_4 or var_13_4 * (utf8.len(var_13_5) / 43)) > 0 and var_13_4 < var_13_7 then
					arg_10_1.talkMaxDuration = var_13_7

					if var_13_7 + var_13_3 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_7 + var_13_3
					end
				end

				arg_10_1.text_.text = var_13_5
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)
				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_8 = math.max(var_13_4, arg_10_1.talkMaxDuration)

			if var_13_3 <= arg_10_1.time_ and arg_10_1.time_ < var_13_3 + var_13_8 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_3) / var_13_8

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_3 + var_13_8 and arg_10_1.time_ < var_13_3 + var_13_8 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play322021003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 322021003
		arg_14_1.duration_ = 5

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play322021004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 1.55

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, false)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_1 = arg_14_1:FormatText(arg_14_1:GetWordFromCfg(322021003).content)

				arg_14_1.text_.text = var_17_1

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_3 = 62 <= 0 and var_17_0 or var_17_0 * (utf8.len(var_17_1) / 62)

				if (62 <= 0 and var_17_0 or var_17_0 * (utf8.len(var_17_1) / 62)) > 0 and var_17_0 < var_17_3 then
					arg_14_1.talkMaxDuration = var_17_3

					if var_17_3 + 0 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_3 + 0
					end
				end

				arg_14_1.text_.text = var_17_1
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)
				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_4 = math.max(var_17_0, arg_14_1.talkMaxDuration)

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_4 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - 0) / var_17_4

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= 0 + var_17_4 and arg_14_1.time_ < 0 + var_17_4 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play322021004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 322021004
		arg_18_1.duration_ = 2.3

		local var_18_0 = {
			zh = 1.999999999999,
			ja = 2.3
		}
		local var_18_1 = manager.audio:GetLocalizationFlag()

		if var_18_0[var_18_1] ~= nil then
			arg_18_1.duration_ = var_18_0[var_18_1]
		end

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play322021005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			if arg_18_1.actors_["10104ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10104ui_story"))) then
				local var_21_0 = Object.Instantiate(Asset.Load("Char/" .. "10104ui_story"), arg_18_1.stage_.transform)

				var_21_0.name = "10104ui_story"
				var_21_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_18_1.actors_["10104ui_story"] = var_21_0

				local var_21_1 = var_21_0:GetComponentInChildren(typeof(CharacterEffect))

				var_21_1.enabled = true

				local var_21_2 = GameObjectTools.GetOrAddComponent(var_21_0, typeof(DynamicBoneHelper))

				if var_21_2 then
					var_21_2:EnableDynamicBone(false)
				end

				arg_18_1:ShowWeapon(var_21_1.transform, false)

				arg_18_1.var_["10104ui_story" .. "Animator"] = var_21_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_18_1.var_["10104ui_story" .. "Animator"].applyRootMotion = true
				arg_18_1.var_["10104ui_story" .. "LipSync"] = var_21_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_21_3 = arg_18_1.actors_["10104ui_story"].transform

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1.var_.moveOldPos10104ui_story = var_21_3.localPosition
			end

			local var_21_4 = 0.001

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_4 then
				var_21_3.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_18_1.time_ - 0) / var_21_4)
				var_21_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_21_3.position).x, (manager.ui.mainCamera.transform.position - var_21_3.position).y, (manager.ui.mainCamera.transform.position - var_21_3.position).z)
				var_21_3.localEulerAngles.z = 0
				var_21_3.localEulerAngles.x = 0
				var_21_3.localEulerAngles = var_21_3.localEulerAngles
			end

			if arg_18_1.time_ >= 0 + var_21_4 and arg_18_1.time_ < 0 + var_21_4 + arg_21_0 then
				var_21_3.localPosition = Vector3.New(0.02, -1.12, -5.99)
				var_21_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_21_3.position).x, (manager.ui.mainCamera.transform.position - var_21_3.position).y, (manager.ui.mainCamera.transform.position - var_21_3.position).z)
				var_21_3.localEulerAngles.z = 0
				var_21_3.localEulerAngles.x = 0
				var_21_3.localEulerAngles = var_21_3.localEulerAngles
			end

			local var_21_5 = arg_18_1.actors_["10104ui_story"]

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 and not isNil(var_21_5) and arg_18_1.var_.characterEffect10104ui_story == nil then
				arg_18_1.var_.characterEffect10104ui_story = var_21_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_21_6 = 0.200000002980232

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_6 and not isNil(var_21_5) then
				if arg_18_1.var_.characterEffect10104ui_story and not isNil(var_21_5) then
					arg_18_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_18_1.time_ >= 0 + var_21_6 and arg_18_1.time_ < 0 + var_21_6 + arg_21_0 and not isNil(var_21_5) and arg_18_1.var_.characterEffect10104ui_story then
				arg_18_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				if arg_18_1.var_.effect1002 then
					Object.Destroy(arg_18_1.var_.effect1002)

					arg_18_1.var_.effect1002 = nil
				end
			end

			local var_21_9 = 0
			local var_21_10 = 0.175

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_9 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				arg_18_1.leftNameTxt_.text = arg_18_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_11 = arg_18_1:GetWordFromCfg(322021004)
				local var_21_12 = arg_18_1:FormatText(var_21_11.content)

				arg_18_1.text_.text = var_21_12

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_14 = 7 <= 0 and var_21_10 or var_21_10 * (utf8.len(var_21_12) / 7)

				if (7 <= 0 and var_21_10 or var_21_10 * (utf8.len(var_21_12) / 7)) > 0 and var_21_10 < var_21_14 then
					arg_18_1.talkMaxDuration = var_21_14

					if var_21_14 + var_21_9 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_14 + var_21_9
					end
				end

				arg_18_1.text_.text = var_21_12
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021004", "story_v_out_322021.awb") ~= 0 then
					local var_21_15 = manager.audio:GetVoiceLength("story_v_out_322021", "322021004", "story_v_out_322021.awb") / 1000

					if var_21_15 + var_21_9 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_15 + var_21_9
					end

					if var_21_11.prefab_name ~= "" and arg_18_1.actors_[var_21_11.prefab_name] ~= nil then
						local var_21_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_11.prefab_name].transform, "story_v_out_322021", "322021004", "story_v_out_322021.awb")

						arg_18_1:RecordAudio("322021004", var_21_16)
						arg_18_1:RecordAudio("322021004", var_21_16)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_322021", "322021004", "story_v_out_322021.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_322021", "322021004", "story_v_out_322021.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_17 = math.max(var_21_10, arg_18_1.talkMaxDuration)

			if var_21_9 <= arg_18_1.time_ and arg_18_1.time_ < var_21_9 + var_21_17 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_9) / var_21_17

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_9 + var_21_17 and arg_18_1.time_ < var_21_9 + var_21_17 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_18_1:InitPlayNodeList()
	end,
	Play322021005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 322021005
		arg_22_1.duration_ = 5

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play322021006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 and not isNil(arg_22_1.actors_["10104ui_story"]) and arg_22_1.var_.characterEffect10104ui_story == nil then
				arg_22_1.var_.characterEffect10104ui_story = arg_22_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_25_0 = 0.200000002980232

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_0 and not isNil(arg_22_1.actors_["10104ui_story"]) then
				if arg_22_1.var_.characterEffect10104ui_story and not isNil(arg_22_1.actors_["10104ui_story"]) then
					arg_22_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_22_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_22_1.time_ - 0) / var_25_0)
				end
			end

			if arg_22_1.time_ >= 0 + var_25_0 and arg_22_1.time_ < 0 + var_25_0 + arg_25_0 and not isNil(arg_22_1.actors_["10104ui_story"]) and arg_22_1.var_.characterEffect10104ui_story then
				arg_22_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_22_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_25_1 = 0
			local var_25_2 = 0.35

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_1 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				arg_22_1.leftNameTxt_.text = arg_22_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, true)
				arg_22_1.iconController_:SetSelectedState("hero")

				arg_22_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_22_1.callingController_:SetSelectedState("normal")

				arg_22_1.keyicon_.color = Color.New(1, 1, 1)
				arg_22_1.icon_.color = Color.New(1, 1, 1)

				local var_25_3 = arg_22_1:FormatText(arg_22_1:GetWordFromCfg(322021005).content)

				arg_22_1.text_.text = var_25_3

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_5 = 14 <= 0 and var_25_2 or var_25_2 * (utf8.len(var_25_3) / 14)

				if (14 <= 0 and var_25_2 or var_25_2 * (utf8.len(var_25_3) / 14)) > 0 and var_25_2 < var_25_5 then
					arg_22_1.talkMaxDuration = var_25_5

					if var_25_5 + var_25_1 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_5 + var_25_1
					end
				end

				arg_22_1.text_.text = var_25_3
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)
				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_6 = math.max(var_25_2, arg_22_1.talkMaxDuration)

			if var_25_1 <= arg_22_1.time_ and arg_22_1.time_ < var_25_1 + var_25_6 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_1) / var_25_6

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_1 + var_25_6 and arg_22_1.time_ < var_25_1 + var_25_6 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play322021006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 322021006
		arg_26_1.duration_ = 6.57

		local var_26_0 = {
			zh = 4.066,
			ja = 6.566
		}
		local var_26_1 = manager.audio:GetLocalizationFlag()

		if var_26_0[var_26_1] ~= nil then
			arg_26_1.duration_ = var_26_0[var_26_1]
		end

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play322021007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			if arg_26_1.actors_["1061ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1061ui_story"))) then
				local var_29_0 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_26_1.stage_.transform)

				var_29_0.name = "1061ui_story"
				var_29_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_26_1.actors_["1061ui_story"] = var_29_0

				local var_29_1 = var_29_0:GetComponentInChildren(typeof(CharacterEffect))

				var_29_1.enabled = true

				local var_29_2 = GameObjectTools.GetOrAddComponent(var_29_0, typeof(DynamicBoneHelper))

				if var_29_2 then
					var_29_2:EnableDynamicBone(false)
				end

				arg_26_1:ShowWeapon(var_29_1.transform, false)

				arg_26_1.var_["1061ui_story" .. "Animator"] = var_29_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_26_1.var_["1061ui_story" .. "Animator"].applyRootMotion = true
				arg_26_1.var_["1061ui_story" .. "LipSync"] = var_29_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_29_3 = arg_26_1.actors_["1061ui_story"].transform

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.var_.moveOldPos1061ui_story = var_29_3.localPosition

				arg_26_1:ShowWeapon(arg_26_1.var_["1061ui_story" .. "Animator"].transform, false)
			end

			local var_29_4 = 0.001

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_4 then
				var_29_3.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPos1061ui_story, Vector3.New(0.7, -1.18, -6.15), (arg_26_1.time_ - 0) / var_29_4)
				var_29_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_29_3.position).x, (manager.ui.mainCamera.transform.position - var_29_3.position).y, (manager.ui.mainCamera.transform.position - var_29_3.position).z)
				var_29_3.localEulerAngles.z = 0
				var_29_3.localEulerAngles.x = 0
				var_29_3.localEulerAngles = var_29_3.localEulerAngles
			end

			if arg_26_1.time_ >= 0 + var_29_4 and arg_26_1.time_ < 0 + var_29_4 + arg_29_0 then
				var_29_3.localPosition = Vector3.New(0.7, -1.18, -6.15)
				var_29_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_29_3.position).x, (manager.ui.mainCamera.transform.position - var_29_3.position).y, (manager.ui.mainCamera.transform.position - var_29_3.position).z)
				var_29_3.localEulerAngles.z = 0
				var_29_3.localEulerAngles.x = 0
				var_29_3.localEulerAngles = var_29_3.localEulerAngles
			end

			local var_29_5 = arg_26_1.actors_["10104ui_story"].transform

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.var_.moveOldPos10104ui_story = var_29_5.localPosition
			end

			local var_29_6 = 0.001

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_6 then
				var_29_5.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPos10104ui_story, Vector3.New(-0.88, -1.12, -5.99), (arg_26_1.time_ - 0) / var_29_6)
				var_29_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_29_5.position).x, (manager.ui.mainCamera.transform.position - var_29_5.position).y, (manager.ui.mainCamera.transform.position - var_29_5.position).z)
				var_29_5.localEulerAngles.z = 0
				var_29_5.localEulerAngles.x = 0
				var_29_5.localEulerAngles = var_29_5.localEulerAngles
			end

			if arg_26_1.time_ >= 0 + var_29_6 and arg_26_1.time_ < 0 + var_29_6 + arg_29_0 then
				var_29_5.localPosition = Vector3.New(-0.88, -1.12, -5.99)
				var_29_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_29_5.position).x, (manager.ui.mainCamera.transform.position - var_29_5.position).y, (manager.ui.mainCamera.transform.position - var_29_5.position).z)
				var_29_5.localEulerAngles.z = 0
				var_29_5.localEulerAngles.x = 0
				var_29_5.localEulerAngles = var_29_5.localEulerAngles
			end

			local var_29_7 = arg_26_1.actors_["1061ui_story"]

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 and not isNil(var_29_7) and arg_26_1.var_.characterEffect1061ui_story == nil then
				arg_26_1.var_.characterEffect1061ui_story = var_29_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_8 = 0.200000002980232

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_8 and not isNil(var_29_7) then
				if arg_26_1.var_.characterEffect1061ui_story and not isNil(var_29_7) then
					arg_26_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_26_1.time_ >= 0 + var_29_8 and arg_26_1.time_ < 0 + var_29_8 + arg_29_0 and not isNil(var_29_7) and arg_26_1.var_.characterEffect1061ui_story then
				arg_26_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_1")
			end

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_29_10 = 0
			local var_29_11 = 0.425

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_10 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_12 = arg_26_1:GetWordFromCfg(322021006)
				local var_29_13 = arg_26_1:FormatText(var_29_12.content)

				arg_26_1.text_.text = var_29_13

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_15 = 17 <= 0 and var_29_11 or var_29_11 * (utf8.len(var_29_13) / 17)

				if (17 <= 0 and var_29_11 or var_29_11 * (utf8.len(var_29_13) / 17)) > 0 and var_29_11 < var_29_15 then
					arg_26_1.talkMaxDuration = var_29_15

					if var_29_15 + var_29_10 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_15 + var_29_10
					end
				end

				arg_26_1.text_.text = var_29_13
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021006", "story_v_out_322021.awb") ~= 0 then
					local var_29_16 = manager.audio:GetVoiceLength("story_v_out_322021", "322021006", "story_v_out_322021.awb") / 1000

					if var_29_16 + var_29_10 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_16 + var_29_10
					end

					if var_29_12.prefab_name ~= "" and arg_26_1.actors_[var_29_12.prefab_name] ~= nil then
						local var_29_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_12.prefab_name].transform, "story_v_out_322021", "322021006", "story_v_out_322021.awb")

						arg_26_1:RecordAudio("322021006", var_29_17)
						arg_26_1:RecordAudio("322021006", var_29_17)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_322021", "322021006", "story_v_out_322021.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_322021", "322021006", "story_v_out_322021.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_18 = math.max(var_29_11, arg_26_1.talkMaxDuration)

			if var_29_10 <= arg_26_1.time_ and arg_26_1.time_ < var_29_10 + var_29_18 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_10) / var_29_18

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_10 + var_29_18 and arg_26_1.time_ < var_29_10 + var_29_18 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_26_1:InitPlayNodeList()
	end,
	Play322021007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 322021007
		arg_30_1.duration_ = 1

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"

			SetActive(arg_30_1.choicesGo_, true)

			for iter_31_0, iter_31_1 in ipairs(arg_30_1.choices_) do
				SetActive(iter_31_1.go, iter_31_0 <= 3)
			end

			arg_30_1.choices_[1].txt.text = arg_30_1:FormatText(StoryChoiceCfg[1401].name)
			arg_30_1.choices_[2].txt.text = arg_30_1:FormatText(StoryChoiceCfg[1402].name)
			arg_30_1.choices_[3].txt.text = arg_30_1:FormatText(StoryChoiceCfg[1403].name)
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play322021008(arg_30_1)
			end

			if arg_32_0 == 2 then
				arg_30_0:Play322021009(arg_30_1)
			end

			if arg_32_0 == 3 then
				arg_30_0:Play322021010(arg_30_1)
			end

			arg_30_1:RecordChoiceLog(322021007, 1401, 1402, 1403)
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 and not isNil(arg_30_1.actors_["1061ui_story"]) and arg_30_1.var_.characterEffect1061ui_story == nil then
				arg_30_1.var_.characterEffect1061ui_story = arg_30_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_0 = 0.200000002980232

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_0 and not isNil(arg_30_1.actors_["1061ui_story"]) then
				if arg_30_1.var_.characterEffect1061ui_story and not isNil(arg_30_1.actors_["1061ui_story"]) then
					arg_30_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_30_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_30_1.time_ - 0) / var_33_0)
				end
			end

			if arg_30_1.time_ >= 0 + var_33_0 and arg_30_1.time_ < 0 + var_33_0 + arg_33_0 and not isNil(arg_30_1.actors_["1061ui_story"]) and arg_30_1.var_.characterEffect1061ui_story then
				arg_30_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_30_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play322021008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 322021008
		arg_34_1.duration_ = 7.4

		local var_34_0 = {
			zh = 4.866,
			ja = 7.4
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play322021011(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 and not isNil(arg_34_1.actors_["1061ui_story"]) and arg_34_1.var_.characterEffect1061ui_story == nil then
				arg_34_1.var_.characterEffect1061ui_story = arg_34_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_0 = 0.200000002980232

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_0 and not isNil(arg_34_1.actors_["1061ui_story"]) then
				if arg_34_1.var_.characterEffect1061ui_story and not isNil(arg_34_1.actors_["1061ui_story"]) then
					arg_34_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_34_1.time_ >= 0 + var_37_0 and arg_34_1.time_ < 0 + var_37_0 + arg_37_0 and not isNil(arg_34_1.actors_["1061ui_story"]) and arg_34_1.var_.characterEffect1061ui_story then
				arg_34_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_2")
			end

			local var_37_2 = 0
			local var_37_3 = 0.575

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_2 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_4 = arg_34_1:GetWordFromCfg(322021008)
				local var_37_5 = arg_34_1:FormatText(var_37_4.content)

				arg_34_1.text_.text = var_37_5

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_7 = 23 <= 0 and var_37_3 or var_37_3 * (utf8.len(var_37_5) / 23)

				if (23 <= 0 and var_37_3 or var_37_3 * (utf8.len(var_37_5) / 23)) > 0 and var_37_3 < var_37_7 then
					arg_34_1.talkMaxDuration = var_37_7

					if var_37_7 + var_37_2 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_7 + var_37_2
					end
				end

				arg_34_1.text_.text = var_37_5
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021008", "story_v_out_322021.awb") ~= 0 then
					local var_37_8 = manager.audio:GetVoiceLength("story_v_out_322021", "322021008", "story_v_out_322021.awb") / 1000

					if var_37_8 + var_37_2 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_8 + var_37_2
					end

					if var_37_4.prefab_name ~= "" and arg_34_1.actors_[var_37_4.prefab_name] ~= nil then
						local var_37_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_4.prefab_name].transform, "story_v_out_322021", "322021008", "story_v_out_322021.awb")

						arg_34_1:RecordAudio("322021008", var_37_9)
						arg_34_1:RecordAudio("322021008", var_37_9)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_322021", "322021008", "story_v_out_322021.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_322021", "322021008", "story_v_out_322021.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_10 = math.max(var_37_3, arg_34_1.talkMaxDuration)

			if var_37_2 <= arg_34_1.time_ and arg_34_1.time_ < var_37_2 + var_37_10 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_2) / var_37_10

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_2 + var_37_10 and arg_34_1.time_ < var_37_2 + var_37_10 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play322021011 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 322021011
		arg_38_1.duration_ = 14.07

		local var_38_0 = {
			zh = 8.4,
			ja = 14.066
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play322021012(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(arg_38_1.actors_["10104ui_story"]) and arg_38_1.var_.characterEffect10104ui_story == nil then
				arg_38_1.var_.characterEffect10104ui_story = arg_38_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_0 = 0.200000002980232

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_0 and not isNil(arg_38_1.actors_["10104ui_story"]) then
				if arg_38_1.var_.characterEffect10104ui_story and not isNil(arg_38_1.actors_["10104ui_story"]) then
					arg_38_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_38_1.time_ >= 0 + var_41_0 and arg_38_1.time_ < 0 + var_41_0 + arg_41_0 and not isNil(arg_38_1.actors_["10104ui_story"]) and arg_38_1.var_.characterEffect10104ui_story then
				arg_38_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_41_2 = arg_38_1.actors_["1061ui_story"]

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(var_41_2) and arg_38_1.var_.characterEffect1061ui_story == nil then
				arg_38_1.var_.characterEffect1061ui_story = var_41_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_3 = 0.200000002980232

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_3 and not isNil(var_41_2) then
				if arg_38_1.var_.characterEffect1061ui_story and not isNil(var_41_2) then
					arg_38_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_38_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_38_1.time_ - 0) / var_41_3)
				end
			end

			if arg_38_1.time_ >= 0 + var_41_3 and arg_38_1.time_ < 0 + var_41_3 + arg_41_0 and not isNil(var_41_2) and arg_38_1.var_.characterEffect1061ui_story then
				arg_38_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_38_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action6_1")
			end

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_41_4 = 0
			local var_41_5 = 0.95

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_4 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_6 = arg_38_1:GetWordFromCfg(322021011)
				local var_41_7 = arg_38_1:FormatText(var_41_6.content)

				arg_38_1.text_.text = var_41_7

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_9 = 38 <= 0 and var_41_5 or var_41_5 * (utf8.len(var_41_7) / 38)

				if (38 <= 0 and var_41_5 or var_41_5 * (utf8.len(var_41_7) / 38)) > 0 and var_41_5 < var_41_9 then
					arg_38_1.talkMaxDuration = var_41_9

					if var_41_9 + var_41_4 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_9 + var_41_4
					end
				end

				arg_38_1.text_.text = var_41_7
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021011", "story_v_out_322021.awb") ~= 0 then
					local var_41_10 = manager.audio:GetVoiceLength("story_v_out_322021", "322021011", "story_v_out_322021.awb") / 1000

					if var_41_10 + var_41_4 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_10 + var_41_4
					end

					if var_41_6.prefab_name ~= "" and arg_38_1.actors_[var_41_6.prefab_name] ~= nil then
						local var_41_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_6.prefab_name].transform, "story_v_out_322021", "322021011", "story_v_out_322021.awb")

						arg_38_1:RecordAudio("322021011", var_41_11)
						arg_38_1:RecordAudio("322021011", var_41_11)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_322021", "322021011", "story_v_out_322021.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_322021", "322021011", "story_v_out_322021.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_12 = math.max(var_41_5, arg_38_1.talkMaxDuration)

			if var_41_4 <= arg_38_1.time_ and arg_38_1.time_ < var_41_4 + var_41_12 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_4) / var_41_12

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_4 + var_41_12 and arg_38_1.time_ < var_41_4 + var_41_12 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play322021012 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 322021012
		arg_42_1.duration_ = 5

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play322021013(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.var_.moveOldPos10104ui_story = arg_42_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_45_0 = 0.001

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_0 then
				arg_42_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_42_1.time_ - 0) / var_45_0)
				arg_42_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_42_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_42_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_42_1.actors_["10104ui_story"].transform.position).z)
				arg_42_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_42_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_42_1.actors_["10104ui_story"].transform.localEulerAngles = arg_42_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_42_1.time_ >= 0 + var_45_0 and arg_42_1.time_ < 0 + var_45_0 + arg_45_0 then
				arg_42_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_42_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_42_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_42_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_42_1.actors_["10104ui_story"].transform.position).z)
				arg_42_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_42_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_42_1.actors_["10104ui_story"].transform.localEulerAngles = arg_42_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_45_1 = arg_42_1.actors_["1061ui_story"].transform

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.var_.moveOldPos1061ui_story = var_45_1.localPosition
			end

			local var_45_2 = 0.001

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_2 then
				var_45_1.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_42_1.time_ - 0) / var_45_2)
				var_45_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_45_1.position).x, (manager.ui.mainCamera.transform.position - var_45_1.position).y, (manager.ui.mainCamera.transform.position - var_45_1.position).z)
				var_45_1.localEulerAngles.z = 0
				var_45_1.localEulerAngles.x = 0
				var_45_1.localEulerAngles = var_45_1.localEulerAngles
			end

			if arg_42_1.time_ >= 0 + var_45_2 and arg_42_1.time_ < 0 + var_45_2 + arg_45_0 then
				var_45_1.localPosition = Vector3.New(0, 100, 0)
				var_45_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_45_1.position).x, (manager.ui.mainCamera.transform.position - var_45_1.position).y, (manager.ui.mainCamera.transform.position - var_45_1.position).z)
				var_45_1.localEulerAngles.z = 0
				var_45_1.localEulerAngles.x = 0
				var_45_1.localEulerAngles = var_45_1.localEulerAngles
			end

			local var_45_3 = 0
			local var_45_4 = 1.15

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_3 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, false)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_5 = arg_42_1:FormatText(arg_42_1:GetWordFromCfg(322021012).content)

				arg_42_1.text_.text = var_45_5

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_7 = 46 <= 0 and var_45_4 or var_45_4 * (utf8.len(var_45_5) / 46)

				if (46 <= 0 and var_45_4 or var_45_4 * (utf8.len(var_45_5) / 46)) > 0 and var_45_4 < var_45_7 then
					arg_42_1.talkMaxDuration = var_45_7

					if var_45_7 + var_45_3 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_7 + var_45_3
					end
				end

				arg_42_1.text_.text = var_45_5
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_8 = math.max(var_45_4, arg_42_1.talkMaxDuration)

			if var_45_3 <= arg_42_1.time_ and arg_42_1.time_ < var_45_3 + var_45_8 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_3) / var_45_8

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_3 + var_45_8 and arg_42_1.time_ < var_45_3 + var_45_8 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_42_1:InitPlayNodeList()
	end,
	Play322021013 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 322021013
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play322021014(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 0.35

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, true)
				arg_46_1.iconController_:SetSelectedState("hero")

				arg_46_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_46_1.callingController_:SetSelectedState("normal")

				arg_46_1.keyicon_.color = Color.New(1, 1, 1)
				arg_46_1.icon_.color = Color.New(1, 1, 1)

				local var_49_1 = arg_46_1:FormatText(arg_46_1:GetWordFromCfg(322021013).content)

				arg_46_1.text_.text = var_49_1

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_3 = 14 <= 0 and var_49_0 or var_49_0 * (utf8.len(var_49_1) / 14)

				if (14 <= 0 and var_49_0 or var_49_0 * (utf8.len(var_49_1) / 14)) > 0 and var_49_0 < var_49_3 then
					arg_46_1.talkMaxDuration = var_49_3

					if var_49_3 + 0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_3 + 0
					end
				end

				arg_46_1.text_.text = var_49_1
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_4 = math.max(var_49_0, arg_46_1.talkMaxDuration)

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_4 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - 0) / var_49_4

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= 0 + var_49_4 and arg_46_1.time_ < 0 + var_49_4 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play322021014 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 322021014
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play322021015(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 0.775

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, true)
				arg_50_1.iconController_:SetSelectedState("hero")

				arg_50_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_50_1.callingController_:SetSelectedState("normal")

				arg_50_1.keyicon_.color = Color.New(1, 1, 1)
				arg_50_1.icon_.color = Color.New(1, 1, 1)

				local var_53_1 = arg_50_1:FormatText(arg_50_1:GetWordFromCfg(322021014).content)

				arg_50_1.text_.text = var_53_1

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_3 = 31 <= 0 and var_53_0 or var_53_0 * (utf8.len(var_53_1) / 31)

				if (31 <= 0 and var_53_0 or var_53_0 * (utf8.len(var_53_1) / 31)) > 0 and var_53_0 < var_53_3 then
					arg_50_1.talkMaxDuration = var_53_3

					if var_53_3 + 0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_3 + 0
					end
				end

				arg_50_1.text_.text = var_53_1
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_4 = math.max(var_53_0, arg_50_1.talkMaxDuration)

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_4 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - 0) / var_53_4

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= 0 + var_53_4 and arg_50_1.time_ < 0 + var_53_4 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play322021015 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 322021015
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play322021016(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 0.625

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, true)
				arg_54_1.iconController_:SetSelectedState("hero")

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(1, 1, 1)
				arg_54_1.icon_.color = Color.New(1, 1, 1)

				local var_57_1 = arg_54_1:FormatText(arg_54_1:GetWordFromCfg(322021015).content)

				arg_54_1.text_.text = var_57_1

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_3 = 25 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_1) / 25)

				if (25 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_1) / 25)) > 0 and var_57_0 < var_57_3 then
					arg_54_1.talkMaxDuration = var_57_3

					if var_57_3 + 0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_3 + 0
					end
				end

				arg_54_1.text_.text = var_57_1
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_4 = math.max(var_57_0, arg_54_1.talkMaxDuration)

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_4 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - 0) / var_57_4

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= 0 + var_57_4 and arg_54_1.time_ < 0 + var_57_4 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play322021016 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 322021016
		arg_58_1.duration_ = 4.77

		local var_58_0 = {
			zh = 2.2,
			ja = 4.766
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play322021017(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.var_.moveOldPos10104ui_story = arg_58_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_61_0 = 0.001

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 then
				arg_58_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_58_1.time_ - 0) / var_61_0)
				arg_58_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_58_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_58_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_58_1.actors_["10104ui_story"].transform.position).z)
				arg_58_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_58_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_58_1.actors_["10104ui_story"].transform.localEulerAngles = arg_58_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 then
				arg_58_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_58_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_58_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_58_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_58_1.actors_["10104ui_story"].transform.position).z)
				arg_58_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_58_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_58_1.actors_["10104ui_story"].transform.localEulerAngles = arg_58_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_61_1 = arg_58_1.actors_["10104ui_story"]

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(var_61_1) and arg_58_1.var_.characterEffect10104ui_story == nil then
				arg_58_1.var_.characterEffect10104ui_story = var_61_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_2 = 0.200000002980232

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_2 and not isNil(var_61_1) then
				if arg_58_1.var_.characterEffect10104ui_story and not isNil(var_61_1) then
					arg_58_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= 0 + var_61_2 and arg_58_1.time_ < 0 + var_61_2 + arg_61_0 and not isNil(var_61_1) and arg_58_1.var_.characterEffect10104ui_story then
				arg_58_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action6_2")
			end

			local var_61_4 = 0
			local var_61_5 = 0.25

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_4 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_6 = arg_58_1:GetWordFromCfg(322021016)
				local var_61_7 = arg_58_1:FormatText(var_61_6.content)

				arg_58_1.text_.text = var_61_7

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_9 = 10 <= 0 and var_61_5 or var_61_5 * (utf8.len(var_61_7) / 10)

				if (10 <= 0 and var_61_5 or var_61_5 * (utf8.len(var_61_7) / 10)) > 0 and var_61_5 < var_61_9 then
					arg_58_1.talkMaxDuration = var_61_9

					if var_61_9 + var_61_4 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_9 + var_61_4
					end
				end

				arg_58_1.text_.text = var_61_7
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021016", "story_v_out_322021.awb") ~= 0 then
					local var_61_10 = manager.audio:GetVoiceLength("story_v_out_322021", "322021016", "story_v_out_322021.awb") / 1000

					if var_61_10 + var_61_4 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_10 + var_61_4
					end

					if var_61_6.prefab_name ~= "" and arg_58_1.actors_[var_61_6.prefab_name] ~= nil then
						local var_61_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_6.prefab_name].transform, "story_v_out_322021", "322021016", "story_v_out_322021.awb")

						arg_58_1:RecordAudio("322021016", var_61_11)
						arg_58_1:RecordAudio("322021016", var_61_11)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_322021", "322021016", "story_v_out_322021.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_322021", "322021016", "story_v_out_322021.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_12 = math.max(var_61_5, arg_58_1.talkMaxDuration)

			if var_61_4 <= arg_58_1.time_ and arg_58_1.time_ < var_61_4 + var_61_12 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_4) / var_61_12

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_4 + var_61_12 and arg_58_1.time_ < var_61_4 + var_61_12 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_58_1:InitPlayNodeList()
	end,
	Play322021017 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 322021017
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play322021018(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(arg_62_1.actors_["10104ui_story"]) and arg_62_1.var_.characterEffect10104ui_story == nil then
				arg_62_1.var_.characterEffect10104ui_story = arg_62_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_0 = 0.200000002980232

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_0 and not isNil(arg_62_1.actors_["10104ui_story"]) then
				if arg_62_1.var_.characterEffect10104ui_story and not isNil(arg_62_1.actors_["10104ui_story"]) then
					arg_62_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_62_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_62_1.time_ - 0) / var_65_0)
				end
			end

			if arg_62_1.time_ >= 0 + var_65_0 and arg_62_1.time_ < 0 + var_65_0 + arg_65_0 and not isNil(arg_62_1.actors_["10104ui_story"]) and arg_62_1.var_.characterEffect10104ui_story then
				arg_62_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_62_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_65_1 = 0
			local var_65_2 = 0.65

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_3 = arg_62_1:FormatText(arg_62_1:GetWordFromCfg(322021017).content)

				arg_62_1.text_.text = var_65_3

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_5 = 26 <= 0 and var_65_2 or var_65_2 * (utf8.len(var_65_3) / 26)

				if (26 <= 0 and var_65_2 or var_65_2 * (utf8.len(var_65_3) / 26)) > 0 and var_65_2 < var_65_5 then
					arg_62_1.talkMaxDuration = var_65_5

					if var_65_5 + var_65_1 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_5 + var_65_1
					end
				end

				arg_62_1.text_.text = var_65_3
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_6 = math.max(var_65_2, arg_62_1.talkMaxDuration)

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_6 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_1) / var_65_6

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_1 + var_65_6 and arg_62_1.time_ < var_65_1 + var_65_6 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play322021018 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 322021018
		arg_66_1.duration_ = 12.53

		local var_66_0 = {
			zh = 9.166,
			ja = 12.533
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play322021019(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if arg_66_1.bgs_.ST61a == nil then
				local var_69_0 = Object.Instantiate(arg_66_1.paintGo_)

				var_69_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST61a")
				var_69_0.name = "ST61a"
				var_69_0.transform.parent = arg_66_1.stage_.transform
				var_69_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_66_1.bgs_.ST61a = var_69_0
			end

			if 2.00000000298023 < arg_66_1.time_ and arg_66_1.time_ <= 2.00000000298023 + arg_69_0 then
				local var_69_1 = arg_66_1.bgs_.ST61a

				arg_66_1.bgs_.ST61a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_69_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_69_2 = var_69_1:GetComponent("SpriteRenderer")

				if var_69_2 and var_69_2.sprite then
					local var_69_3 = 2 * (var_69_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_69_1.transform.localScale = Vector3.New(var_69_3 / var_69_2.sprite.bounds.size.y < var_69_3 * manager.ui.mainCameraCom_.aspect / var_69_2.sprite.bounds.size.x and var_69_3 * manager.ui.mainCameraCom_.aspect / var_69_2.sprite.bounds.size.x or var_69_3 / var_69_2.sprite.bounds.size.y, var_69_3 / var_69_2.sprite.bounds.size.y < var_69_3 * manager.ui.mainCameraCom_.aspect / var_69_2.sprite.bounds.size.x and var_69_3 * manager.ui.mainCameraCom_.aspect / var_69_2.sprite.bounds.size.x or var_69_3 / var_69_2.sprite.bounds.size.y, 0)
				end

				for iter_69_0, iter_69_1 in pairs(arg_66_1.bgs_) do
					if iter_69_0 ~= "ST61a" then
						iter_69_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_69_4 = 4.00000000298023

			if 4.00000000298023 < arg_66_1.time_ and arg_66_1.time_ <= var_69_4 + arg_69_0 then
				arg_66_1.allBtn_.enabled = false
			end

			if arg_66_1.time_ >= var_69_4 + 0.3 and arg_66_1.time_ < var_69_4 + 0.3 + arg_69_0 then
				arg_66_1.allBtn_.enabled = true
			end

			local var_69_5 = 0

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_5 + arg_69_0 then
				arg_66_1.mask_.enabled = true
				arg_66_1.mask_.raycastTarget = true

				arg_66_1:SetGaussion(false)
			end

			local var_69_6 = 2

			if var_69_5 <= arg_66_1.time_ and arg_66_1.time_ < var_69_5 + var_69_6 then
				local var_69_7 = Color.New(0, 0, 0)

				var_69_7.a = Mathf.Lerp(0, 1, (arg_66_1.time_ - var_69_5) / var_69_6)
				arg_66_1.mask_.color = var_69_7
			end

			if arg_66_1.time_ >= var_69_5 + var_69_6 and arg_66_1.time_ < var_69_5 + var_69_6 + arg_69_0 then
				local var_69_8 = Color.New(0, 0, 0)

				var_69_8.a = 1
				arg_66_1.mask_.color = var_69_8
			end

			local var_69_9 = 2

			if 2 < arg_66_1.time_ and arg_66_1.time_ <= var_69_9 + arg_69_0 then
				arg_66_1.mask_.enabled = true
				arg_66_1.mask_.raycastTarget = true

				arg_66_1:SetGaussion(false)
			end

			local var_69_10 = 2

			if var_69_9 <= arg_66_1.time_ and arg_66_1.time_ < var_69_9 + var_69_10 then
				local var_69_11 = Color.New(0, 0, 0)

				var_69_11.a = Mathf.Lerp(1, 0, (arg_66_1.time_ - var_69_9) / var_69_10)
				arg_66_1.mask_.color = var_69_11
			end

			if arg_66_1.time_ >= var_69_9 + var_69_10 and arg_66_1.time_ < var_69_9 + var_69_10 + arg_69_0 then
				local var_69_12 = Color.New(0, 0, 0)

				arg_66_1.mask_.enabled = false
				var_69_12.a = 0
				arg_66_1.mask_.color = var_69_12
			end

			local var_69_13 = arg_66_1.actors_["10104ui_story"].transform

			if 1.96599999815226 < arg_66_1.time_ and arg_66_1.time_ <= 1.96599999815226 + arg_69_0 then
				arg_66_1.var_.moveOldPos10104ui_story = var_69_13.localPosition
			end

			local var_69_14 = 0.001

			if 1.96599999815226 <= arg_66_1.time_ and arg_66_1.time_ < 1.96599999815226 + var_69_14 then
				var_69_13.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_66_1.time_ - 1.96599999815226) / var_69_14)
				var_69_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_13.position).x, (manager.ui.mainCamera.transform.position - var_69_13.position).y, (manager.ui.mainCamera.transform.position - var_69_13.position).z)
				var_69_13.localEulerAngles.z = 0
				var_69_13.localEulerAngles.x = 0
				var_69_13.localEulerAngles = var_69_13.localEulerAngles
			end

			if arg_66_1.time_ >= 1.96599999815226 + var_69_14 and arg_66_1.time_ < 1.96599999815226 + var_69_14 + arg_69_0 then
				var_69_13.localPosition = Vector3.New(0, 100, 0)
				var_69_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_13.position).x, (manager.ui.mainCamera.transform.position - var_69_13.position).y, (manager.ui.mainCamera.transform.position - var_69_13.position).z)
				var_69_13.localEulerAngles.z = 0
				var_69_13.localEulerAngles.x = 0
				var_69_13.localEulerAngles = var_69_13.localEulerAngles
			end

			local var_69_15 = "1020ui_story"

			if arg_66_1.actors_["1020ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1020ui_story"))) then
				local var_69_16 = Object.Instantiate(Asset.Load("Char/" .. "1020ui_story"), arg_66_1.stage_.transform)

				var_69_16.name = var_69_15
				var_69_16.transform.localPosition = Vector3.New(0, 100, 0)
				arg_66_1.actors_[var_69_15] = var_69_16

				local var_69_17 = var_69_16:GetComponentInChildren(typeof(CharacterEffect))

				var_69_17.enabled = true

				local var_69_18 = GameObjectTools.GetOrAddComponent(var_69_16, typeof(DynamicBoneHelper))

				if var_69_18 then
					var_69_18:EnableDynamicBone(false)
				end

				arg_66_1:ShowWeapon(var_69_17.transform, false)

				arg_66_1.var_[var_69_15 .. "Animator"] = var_69_17.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_66_1.var_[var_69_15 .. "Animator"].applyRootMotion = true
				arg_66_1.var_[var_69_15 .. "LipSync"] = var_69_17.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_69_19 = arg_66_1.actors_["1020ui_story"].transform

			if 3.8 < arg_66_1.time_ and arg_66_1.time_ <= 3.8 + arg_69_0 then
				arg_66_1.var_.moveOldPos1020ui_story = var_69_19.localPosition
			end

			local var_69_20 = 0.001

			if 3.8 <= arg_66_1.time_ and arg_66_1.time_ < 3.8 + var_69_20 then
				var_69_19.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_66_1.time_ - 3.8) / var_69_20)
				var_69_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_19.position).x, (manager.ui.mainCamera.transform.position - var_69_19.position).y, (manager.ui.mainCamera.transform.position - var_69_19.position).z)
				var_69_19.localEulerAngles.z = 0
				var_69_19.localEulerAngles.x = 0
				var_69_19.localEulerAngles = var_69_19.localEulerAngles
			end

			if arg_66_1.time_ >= 3.8 + var_69_20 and arg_66_1.time_ < 3.8 + var_69_20 + arg_69_0 then
				var_69_19.localPosition = Vector3.New(0, -0.85, -6.25)
				var_69_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_19.position).x, (manager.ui.mainCamera.transform.position - var_69_19.position).y, (manager.ui.mainCamera.transform.position - var_69_19.position).z)
				var_69_19.localEulerAngles.z = 0
				var_69_19.localEulerAngles.x = 0
				var_69_19.localEulerAngles = var_69_19.localEulerAngles
			end

			local var_69_21 = arg_66_1.actors_["1020ui_story"]

			if 3.8 < arg_66_1.time_ and arg_66_1.time_ <= 3.8 + arg_69_0 and not isNil(var_69_21) and arg_66_1.var_.characterEffect1020ui_story == nil then
				arg_66_1.var_.characterEffect1020ui_story = var_69_21:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_22 = 0.200000002980232

			if 3.8 <= arg_66_1.time_ and arg_66_1.time_ < 3.8 + var_69_22 and not isNil(var_69_21) then
				if arg_66_1.var_.characterEffect1020ui_story and not isNil(var_69_21) then
					arg_66_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= 3.8 + var_69_22 and arg_66_1.time_ < 3.8 + var_69_22 + arg_69_0 and not isNil(var_69_21) and arg_66_1.var_.characterEffect1020ui_story then
				arg_66_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 3.8 < arg_66_1.time_ and arg_66_1.time_ <= 3.8 + arg_69_0 then
				arg_66_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			if 3.8 < arg_66_1.time_ and arg_66_1.time_ <= 3.8 + arg_69_0 then
				arg_66_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0.233333333333333 < arg_66_1.time_ and arg_66_1.time_ <= 0.233333333333333 + arg_69_0 then
				arg_66_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_lab", "")
			end

			if 1.53333333333333 < arg_66_1.time_ and arg_66_1.time_ <= 1.53333333333333 + arg_69_0 then
				arg_66_1:AudioAction("play", "effect", "se_story_141", "se_story_141_amb_street_night02", "")
			end

			local var_69_26 = 2

			arg_66_1.isInRecall_ = false

			if var_69_26 < arg_66_1.time_ and arg_66_1.time_ <= var_69_26 + arg_69_0 then
				arg_66_1.screenFilterGo_:SetActive(true)

				arg_66_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_69_2, iter_69_3 in pairs(arg_66_1.actors_) do
					for iter_69_4, iter_69_5 in ipairs((iter_69_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_69_5.color = iter_69_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_69_27 = 0.0166666666666667

			if var_69_26 <= arg_66_1.time_ and arg_66_1.time_ < var_69_26 + var_69_27 then
				arg_66_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_66_1.time_ - var_69_26) / var_69_27)
			end

			if arg_66_1.time_ >= var_69_26 + var_69_27 and arg_66_1.time_ < var_69_26 + var_69_27 + arg_69_0 then
				arg_66_1.screenFilterEffect_.weight = 1
			end

			if arg_66_1.frameCnt_ <= 1 then
				arg_66_1.dialog_:SetActive(false)
			end

			local var_69_28 = 4
			local var_69_29 = 0.65

			if 4 < arg_66_1.time_ and arg_66_1.time_ <= var_69_28 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0

				arg_66_1.dialog_:SetActive(true)

				arg_66_1.dialogCg_.alpha = 0

				local var_69_30 = LeanTween.value(arg_66_1.dialog_, 0, 1, 0.3)

				var_69_30:setOnUpdate(LuaHelper.FloatAction(function(arg_70_0)
					arg_66_1.dialogCg_.alpha = arg_70_0
				end))
				var_69_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_66_1.dialog_)
					var_69_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_66_1.duration_ = arg_66_1.duration_ + 0.3

				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_31 = arg_66_1:GetWordFromCfg(322021018)
				local var_69_32 = arg_66_1:FormatText(var_69_31.content)

				arg_66_1.text_.text = var_69_32

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_34 = 26 <= 0 and var_69_29 or var_69_29 * (utf8.len(var_69_32) / 26)

				if (26 <= 0 and var_69_29 or var_69_29 * (utf8.len(var_69_32) / 26)) > 0 and var_69_29 < var_69_34 then
					arg_66_1.talkMaxDuration = var_69_34
					var_69_28 = var_69_28 + 0.3

					if var_69_34 + var_69_28 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_34 + var_69_28
					end
				end

				arg_66_1.text_.text = var_69_32
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021018", "story_v_out_322021.awb") ~= 0 then
					local var_69_35 = manager.audio:GetVoiceLength("story_v_out_322021", "322021018", "story_v_out_322021.awb") / 1000

					if var_69_35 + var_69_28 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_35 + var_69_28
					end

					if var_69_31.prefab_name ~= "" and arg_66_1.actors_[var_69_31.prefab_name] ~= nil then
						local var_69_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_31.prefab_name].transform, "story_v_out_322021", "322021018", "story_v_out_322021.awb")

						arg_66_1:RecordAudio("322021018", var_69_36)
						arg_66_1:RecordAudio("322021018", var_69_36)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_322021", "322021018", "story_v_out_322021.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_322021", "322021018", "story_v_out_322021.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_37 = var_69_28 + 0.3
			local var_69_38 = math.max(var_69_29, arg_66_1.talkMaxDuration)

			if var_69_28 + 0.3 <= arg_66_1.time_ and arg_66_1.time_ < var_69_37 + var_69_38 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_37) / var_69_38

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_37 + var_69_38 and arg_66_1.time_ < var_69_37 + var_69_38 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play322021019 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 322021019
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play322021020(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(arg_72_1.actors_["1020ui_story"]) and arg_72_1.var_.characterEffect1020ui_story == nil then
				arg_72_1.var_.characterEffect1020ui_story = arg_72_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_0 = 0.200000002980232

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 and not isNil(arg_72_1.actors_["1020ui_story"]) then
				if arg_72_1.var_.characterEffect1020ui_story and not isNil(arg_72_1.actors_["1020ui_story"]) then
					arg_72_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_72_1.time_ - 0) / var_75_0)
				end
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 and not isNil(arg_72_1.actors_["1020ui_story"]) and arg_72_1.var_.characterEffect1020ui_story then
				arg_72_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_75_1 = 0
			local var_75_2 = 0.675

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_3 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(322021019).content)

				arg_72_1.text_.text = var_75_3

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_5 = 27 <= 0 and var_75_2 or var_75_2 * (utf8.len(var_75_3) / 27)

				if (27 <= 0 and var_75_2 or var_75_2 * (utf8.len(var_75_3) / 27)) > 0 and var_75_2 < var_75_5 then
					arg_72_1.talkMaxDuration = var_75_5

					if var_75_5 + var_75_1 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_5 + var_75_1
					end
				end

				arg_72_1.text_.text = var_75_3
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_6 = math.max(var_75_2, arg_72_1.talkMaxDuration)

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_6 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_1) / var_75_6

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_1 + var_75_6 and arg_72_1.time_ < var_75_1 + var_75_6 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play322021020 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 322021020
		arg_76_1.duration_ = 9

		local var_76_0 = {
			zh = 8,
			ja = 9
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play322021021(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(arg_76_1.actors_["1020ui_story"]) and arg_76_1.var_.characterEffect1020ui_story == nil then
				arg_76_1.var_.characterEffect1020ui_story = arg_76_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_0 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 and not isNil(arg_76_1.actors_["1020ui_story"]) then
				if arg_76_1.var_.characterEffect1020ui_story and not isNil(arg_76_1.actors_["1020ui_story"]) then
					arg_76_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["1020ui_story"]) and arg_76_1.var_.characterEffect1020ui_story then
				arg_76_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_1")
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_79_2 = 0
			local var_79_3 = 0.775

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_2 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_4 = arg_76_1:GetWordFromCfg(322021020)
				local var_79_5 = arg_76_1:FormatText(var_79_4.content)

				arg_76_1.text_.text = var_79_5

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_7 = 31 <= 0 and var_79_3 or var_79_3 * (utf8.len(var_79_5) / 31)

				if (31 <= 0 and var_79_3 or var_79_3 * (utf8.len(var_79_5) / 31)) > 0 and var_79_3 < var_79_7 then
					arg_76_1.talkMaxDuration = var_79_7

					if var_79_7 + var_79_2 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_7 + var_79_2
					end
				end

				arg_76_1.text_.text = var_79_5
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021020", "story_v_out_322021.awb") ~= 0 then
					local var_79_8 = manager.audio:GetVoiceLength("story_v_out_322021", "322021020", "story_v_out_322021.awb") / 1000

					if var_79_8 + var_79_2 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_8 + var_79_2
					end

					if var_79_4.prefab_name ~= "" and arg_76_1.actors_[var_79_4.prefab_name] ~= nil then
						local var_79_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_4.prefab_name].transform, "story_v_out_322021", "322021020", "story_v_out_322021.awb")

						arg_76_1:RecordAudio("322021020", var_79_9)
						arg_76_1:RecordAudio("322021020", var_79_9)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_322021", "322021020", "story_v_out_322021.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_322021", "322021020", "story_v_out_322021.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_10 = math.max(var_79_3, arg_76_1.talkMaxDuration)

			if var_79_2 <= arg_76_1.time_ and arg_76_1.time_ < var_79_2 + var_79_10 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_2) / var_79_10

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_2 + var_79_10 and arg_76_1.time_ < var_79_2 + var_79_10 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play322021021 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 322021021
		arg_80_1.duration_ = 9

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play322021022(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 2 < arg_80_1.time_ and arg_80_1.time_ <= 2 + arg_83_0 then
				local var_83_0 = arg_80_1.bgs_.ST73a

				arg_80_1.bgs_.ST73a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_83_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_83_1 = var_83_0:GetComponent("SpriteRenderer")

				if var_83_1 and var_83_1.sprite then
					local var_83_2 = 2 * (var_83_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_83_0.transform.localScale = Vector3.New(var_83_2 / var_83_1.sprite.bounds.size.y < var_83_2 * manager.ui.mainCameraCom_.aspect / var_83_1.sprite.bounds.size.x and var_83_2 * manager.ui.mainCameraCom_.aspect / var_83_1.sprite.bounds.size.x or var_83_2 / var_83_1.sprite.bounds.size.y, var_83_2 / var_83_1.sprite.bounds.size.y < var_83_2 * manager.ui.mainCameraCom_.aspect / var_83_1.sprite.bounds.size.x and var_83_2 * manager.ui.mainCameraCom_.aspect / var_83_1.sprite.bounds.size.x or var_83_2 / var_83_1.sprite.bounds.size.y, 0)
				end

				for iter_83_0, iter_83_1 in pairs(arg_80_1.bgs_) do
					if iter_83_0 ~= "ST73a" then
						iter_83_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_83_3 = 3.999999999999

			if 3.999999999999 < arg_80_1.time_ and arg_80_1.time_ <= var_83_3 + arg_83_0 then
				arg_80_1.allBtn_.enabled = false
			end

			if arg_80_1.time_ >= var_83_3 + 0.3 and arg_80_1.time_ < var_83_3 + 0.3 + arg_83_0 then
				arg_80_1.allBtn_.enabled = true
			end

			local var_83_4 = 0

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_4 + arg_83_0 then
				arg_80_1.mask_.enabled = true
				arg_80_1.mask_.raycastTarget = true

				arg_80_1:SetGaussion(false)
			end

			local var_83_5 = 2

			if var_83_4 <= arg_80_1.time_ and arg_80_1.time_ < var_83_4 + var_83_5 then
				local var_83_6 = Color.New(0, 0, 0)

				var_83_6.a = Mathf.Lerp(0, 1, (arg_80_1.time_ - var_83_4) / var_83_5)
				arg_80_1.mask_.color = var_83_6
			end

			if arg_80_1.time_ >= var_83_4 + var_83_5 and arg_80_1.time_ < var_83_4 + var_83_5 + arg_83_0 then
				local var_83_7 = Color.New(0, 0, 0)

				var_83_7.a = 1
				arg_80_1.mask_.color = var_83_7
			end

			local var_83_8 = 2

			if 2 < arg_80_1.time_ and arg_80_1.time_ <= var_83_8 + arg_83_0 then
				arg_80_1.mask_.enabled = true
				arg_80_1.mask_.raycastTarget = true

				arg_80_1:SetGaussion(false)
			end

			local var_83_9 = 2

			if var_83_8 <= arg_80_1.time_ and arg_80_1.time_ < var_83_8 + var_83_9 then
				local var_83_10 = Color.New(0, 0, 0)

				var_83_10.a = Mathf.Lerp(1, 0, (arg_80_1.time_ - var_83_8) / var_83_9)
				arg_80_1.mask_.color = var_83_10
			end

			if arg_80_1.time_ >= var_83_8 + var_83_9 and arg_80_1.time_ < var_83_8 + var_83_9 + arg_83_0 then
				local var_83_11 = Color.New(0, 0, 0)

				arg_80_1.mask_.enabled = false
				var_83_11.a = 0
				arg_80_1.mask_.color = var_83_11
			end

			local var_83_12 = arg_80_1.actors_["1020ui_story"].transform

			if 2 < arg_80_1.time_ and arg_80_1.time_ <= 2 + arg_83_0 then
				arg_80_1.var_.moveOldPos1020ui_story = var_83_12.localPosition
			end

			local var_83_13 = 0.001

			if 2 <= arg_80_1.time_ and arg_80_1.time_ < 2 + var_83_13 then
				var_83_12.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_80_1.time_ - 2) / var_83_13)
				var_83_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_12.position).x, (manager.ui.mainCamera.transform.position - var_83_12.position).y, (manager.ui.mainCamera.transform.position - var_83_12.position).z)
				var_83_12.localEulerAngles.z = 0
				var_83_12.localEulerAngles.x = 0
				var_83_12.localEulerAngles = var_83_12.localEulerAngles
			end

			if arg_80_1.time_ >= 2 + var_83_13 and arg_80_1.time_ < 2 + var_83_13 + arg_83_0 then
				var_83_12.localPosition = Vector3.New(0, 100, 0)
				var_83_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_12.position).x, (manager.ui.mainCamera.transform.position - var_83_12.position).y, (manager.ui.mainCamera.transform.position - var_83_12.position).z)
				var_83_12.localEulerAngles.z = 0
				var_83_12.localEulerAngles.x = 0
				var_83_12.localEulerAngles = var_83_12.localEulerAngles
			end

			local var_83_14 = 2

			arg_80_1.isInRecall_ = false

			if var_83_14 < arg_80_1.time_ and arg_80_1.time_ <= var_83_14 + arg_83_0 then
				arg_80_1.screenFilterGo_:SetActive(false)

				for iter_83_2, iter_83_3 in pairs(arg_80_1.actors_) do
					for iter_83_4, iter_83_5 in ipairs((iter_83_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_83_5.color = iter_83_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_83_15 = 0.0166666666666667

			if var_83_14 <= arg_80_1.time_ and arg_80_1.time_ < var_83_14 + var_83_15 then
				arg_80_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_80_1.time_ - var_83_14) / var_83_15)
			end

			if arg_80_1.time_ >= var_83_14 + var_83_15 and arg_80_1.time_ < var_83_14 + var_83_15 + arg_83_0 then
				arg_80_1.screenFilterEffect_.weight = 0
			end

			if 0.233333333333333 < arg_80_1.time_ and arg_80_1.time_ <= 0.233333333333333 + arg_83_0 then
				arg_80_1:AudioAction("stop", "effect", "se_story_141", "se_story_141_amb_street_night02", "")
			end

			if 1.53333333333333 < arg_80_1.time_ and arg_80_1.time_ <= 1.53333333333333 + arg_83_0 then
				arg_80_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_lab", "")
			end

			if arg_80_1.frameCnt_ <= 1 then
				arg_80_1.dialog_:SetActive(false)
			end

			local var_83_18 = 3.999999999999
			local var_83_19 = 0.55

			if 3.999999999999 < arg_80_1.time_ and arg_80_1.time_ <= var_83_18 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0

				arg_80_1.dialog_:SetActive(true)

				arg_80_1.dialogCg_.alpha = 0

				local var_83_20 = LeanTween.value(arg_80_1.dialog_, 0, 1, 0.3)

				var_83_20:setOnUpdate(LuaHelper.FloatAction(function(arg_84_0)
					arg_80_1.dialogCg_.alpha = arg_84_0
				end))
				var_83_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_80_1.dialog_)
					var_83_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_80_1.duration_ = arg_80_1.duration_ + 0.3

				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_21 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(322021021).content)

				arg_80_1.text_.text = var_83_21

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_23 = 22 <= 0 and var_83_19 or var_83_19 * (utf8.len(var_83_21) / 22)

				if (22 <= 0 and var_83_19 or var_83_19 * (utf8.len(var_83_21) / 22)) > 0 and var_83_19 < var_83_23 then
					arg_80_1.talkMaxDuration = var_83_23
					var_83_18 = var_83_18 + 0.3

					if var_83_23 + var_83_18 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_23 + var_83_18
					end
				end

				arg_80_1.text_.text = var_83_21
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_24 = var_83_18 + 0.3
			local var_83_25 = math.max(var_83_19, arg_80_1.talkMaxDuration)

			if var_83_18 + 0.3 <= arg_80_1.time_ and arg_80_1.time_ < var_83_24 + var_83_25 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_24) / var_83_25

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_24 + var_83_25 and arg_80_1.time_ < var_83_24 + var_83_25 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play322021022 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 322021022
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play322021023(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 1.225

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, true)
				arg_86_1.iconController_:SetSelectedState("hero")

				arg_86_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_86_1.callingController_:SetSelectedState("normal")

				arg_86_1.keyicon_.color = Color.New(1, 1, 1)
				arg_86_1.icon_.color = Color.New(1, 1, 1)

				local var_89_1 = arg_86_1:FormatText(arg_86_1:GetWordFromCfg(322021022).content)

				arg_86_1.text_.text = var_89_1

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_3 = 49 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_1) / 49)

				if (49 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_1) / 49)) > 0 and var_89_0 < var_89_3 then
					arg_86_1.talkMaxDuration = var_89_3

					if var_89_3 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_3 + 0
					end
				end

				arg_86_1.text_.text = var_89_1
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_4 = math.max(var_89_0, arg_86_1.talkMaxDuration)

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_4 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - 0) / var_89_4

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= 0 + var_89_4 and arg_86_1.time_ < 0 + var_89_4 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play322021023 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 322021023
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play322021024(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 1.325

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_1 = arg_90_1:FormatText(arg_90_1:GetWordFromCfg(322021023).content)

				arg_90_1.text_.text = var_93_1

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_3 = 53 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_1) / 53)

				if (53 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_1) / 53)) > 0 and var_93_0 < var_93_3 then
					arg_90_1.talkMaxDuration = var_93_3

					if var_93_3 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_3 + 0
					end
				end

				arg_90_1.text_.text = var_93_1
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_4 = math.max(var_93_0, arg_90_1.talkMaxDuration)

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_4 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - 0) / var_93_4

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= 0 + var_93_4 and arg_90_1.time_ < 0 + var_93_4 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play322021024 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 322021024
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play322021025(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0.325

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, true)
				arg_94_1.iconController_:SetSelectedState("hero")

				arg_94_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_94_1.callingController_:SetSelectedState("normal")

				arg_94_1.keyicon_.color = Color.New(1, 1, 1)
				arg_94_1.icon_.color = Color.New(1, 1, 1)

				local var_97_1 = arg_94_1:FormatText(arg_94_1:GetWordFromCfg(322021024).content)

				arg_94_1.text_.text = var_97_1

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_3 = 13 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_1) / 13)

				if (13 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_1) / 13)) > 0 and var_97_0 < var_97_3 then
					arg_94_1.talkMaxDuration = var_97_3

					if var_97_3 + 0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_3 + 0
					end
				end

				arg_94_1.text_.text = var_97_1
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_4 = math.max(var_97_0, arg_94_1.talkMaxDuration)

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_4 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - 0) / var_97_4

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= 0 + var_97_4 and arg_94_1.time_ < 0 + var_97_4 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play322021025 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 322021025
		arg_98_1.duration_ = 2

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play322021026(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos10104ui_story = arg_98_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_101_0 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_0 then
				arg_98_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_98_1.time_ - 0) / var_101_0)
				arg_98_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_98_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["10104ui_story"].transform.position).z)
				arg_98_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_98_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_98_1.actors_["10104ui_story"].transform.localEulerAngles = arg_98_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 then
				arg_98_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_98_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_98_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["10104ui_story"].transform.position).z)
				arg_98_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_98_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_98_1.actors_["10104ui_story"].transform.localEulerAngles = arg_98_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_101_1 = arg_98_1.actors_["10104ui_story"]

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(var_101_1) and arg_98_1.var_.characterEffect10104ui_story == nil then
				arg_98_1.var_.characterEffect10104ui_story = var_101_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_2 = 0.200000002980232

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_2 and not isNil(var_101_1) then
				if arg_98_1.var_.characterEffect10104ui_story and not isNil(var_101_1) then
					arg_98_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= 0 + var_101_2 and arg_98_1.time_ < 0 + var_101_2 + arg_101_0 and not isNil(var_101_1) and arg_98_1.var_.characterEffect10104ui_story then
				arg_98_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			local var_101_4 = 0
			local var_101_5 = 0.05

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_4 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_6 = arg_98_1:GetWordFromCfg(322021025)
				local var_101_7 = arg_98_1:FormatText(var_101_6.content)

				arg_98_1.text_.text = var_101_7

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_9 = 2 <= 0 and var_101_5 or var_101_5 * (utf8.len(var_101_7) / 2)

				if (2 <= 0 and var_101_5 or var_101_5 * (utf8.len(var_101_7) / 2)) > 0 and var_101_5 < var_101_9 then
					arg_98_1.talkMaxDuration = var_101_9

					if var_101_9 + var_101_4 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_9 + var_101_4
					end
				end

				arg_98_1.text_.text = var_101_7
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021025", "story_v_out_322021.awb") ~= 0 then
					local var_101_10 = manager.audio:GetVoiceLength("story_v_out_322021", "322021025", "story_v_out_322021.awb") / 1000

					if var_101_10 + var_101_4 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_10 + var_101_4
					end

					if var_101_6.prefab_name ~= "" and arg_98_1.actors_[var_101_6.prefab_name] ~= nil then
						local var_101_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_6.prefab_name].transform, "story_v_out_322021", "322021025", "story_v_out_322021.awb")

						arg_98_1:RecordAudio("322021025", var_101_11)
						arg_98_1:RecordAudio("322021025", var_101_11)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_322021", "322021025", "story_v_out_322021.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_322021", "322021025", "story_v_out_322021.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_12 = math.max(var_101_5, arg_98_1.talkMaxDuration)

			if var_101_4 <= arg_98_1.time_ and arg_98_1.time_ < var_101_4 + var_101_12 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_4) / var_101_12

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_4 + var_101_12 and arg_98_1.time_ < var_101_4 + var_101_12 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play322021026 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 322021026
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play322021027(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(arg_102_1.actors_["10104ui_story"]) and arg_102_1.var_.characterEffect10104ui_story == nil then
				arg_102_1.var_.characterEffect10104ui_story = arg_102_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_0 = 0.200000002980232

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 and not isNil(arg_102_1.actors_["10104ui_story"]) then
				if arg_102_1.var_.characterEffect10104ui_story and not isNil(arg_102_1.actors_["10104ui_story"]) then
					arg_102_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_102_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_102_1.time_ - 0) / var_105_0)
				end
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 and not isNil(arg_102_1.actors_["10104ui_story"]) and arg_102_1.var_.characterEffect10104ui_story then
				arg_102_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_102_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_105_1 = 0
			local var_105_2 = 1

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_102_1.callingController_:SetSelectedState("normal")

				arg_102_1.keyicon_.color = Color.New(1, 1, 1)
				arg_102_1.icon_.color = Color.New(1, 1, 1)

				local var_105_3 = arg_102_1:FormatText(arg_102_1:GetWordFromCfg(322021026).content)

				arg_102_1.text_.text = var_105_3

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_5 = 40 <= 0 and var_105_2 or var_105_2 * (utf8.len(var_105_3) / 40)

				if (40 <= 0 and var_105_2 or var_105_2 * (utf8.len(var_105_3) / 40)) > 0 and var_105_2 < var_105_5 then
					arg_102_1.talkMaxDuration = var_105_5

					if var_105_5 + var_105_1 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_5 + var_105_1
					end
				end

				arg_102_1.text_.text = var_105_3
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_6 = math.max(var_105_2, arg_102_1.talkMaxDuration)

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_6 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_1) / var_105_6

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_1 + var_105_6 and arg_102_1.time_ < var_105_1 + var_105_6 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play322021027 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 322021027
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play322021028(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 1.15

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, true)
				arg_106_1.iconController_:SetSelectedState("hero")

				arg_106_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_106_1.callingController_:SetSelectedState("normal")

				arg_106_1.keyicon_.color = Color.New(1, 1, 1)
				arg_106_1.icon_.color = Color.New(1, 1, 1)

				local var_109_1 = arg_106_1:FormatText(arg_106_1:GetWordFromCfg(322021027).content)

				arg_106_1.text_.text = var_109_1

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_3 = 46 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_1) / 46)

				if (46 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_1) / 46)) > 0 and var_109_0 < var_109_3 then
					arg_106_1.talkMaxDuration = var_109_3

					if var_109_3 + 0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_3 + 0
					end
				end

				arg_106_1.text_.text = var_109_1
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_4 = math.max(var_109_0, arg_106_1.talkMaxDuration)

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_4 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - 0) / var_109_4

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= 0 + var_109_4 and arg_106_1.time_ < 0 + var_109_4 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play322021028 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 322021028
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play322021029(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.var_.moveOldPos10104ui_story = arg_110_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_113_0 = 0.001

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_0 then
				arg_110_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_110_1.time_ - 0) / var_113_0)
				arg_110_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_110_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["10104ui_story"].transform.position).z)
				arg_110_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_110_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_110_1.actors_["10104ui_story"].transform.localEulerAngles = arg_110_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_110_1.time_ >= 0 + var_113_0 and arg_110_1.time_ < 0 + var_113_0 + arg_113_0 then
				arg_110_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_110_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_110_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["10104ui_story"].transform.position).z)
				arg_110_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_110_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_110_1.actors_["10104ui_story"].transform.localEulerAngles = arg_110_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_113_1 = 0
			local var_113_2 = 1.375

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, false)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_3 = arg_110_1:FormatText(arg_110_1:GetWordFromCfg(322021028).content)

				arg_110_1.text_.text = var_113_3

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_5 = 55 <= 0 and var_113_2 or var_113_2 * (utf8.len(var_113_3) / 55)

				if (55 <= 0 and var_113_2 or var_113_2 * (utf8.len(var_113_3) / 55)) > 0 and var_113_2 < var_113_5 then
					arg_110_1.talkMaxDuration = var_113_5

					if var_113_5 + var_113_1 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_5 + var_113_1
					end
				end

				arg_110_1.text_.text = var_113_3
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_6 = math.max(var_113_2, arg_110_1.talkMaxDuration)

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_6 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_1) / var_113_6

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_1 + var_113_6 and arg_110_1.time_ < var_113_1 + var_113_6 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play322021029 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 322021029
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play322021030(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 1.075

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_1 = arg_114_1:FormatText(arg_114_1:GetWordFromCfg(322021029).content)

				arg_114_1.text_.text = var_117_1

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_3 = 43 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_1) / 43)

				if (43 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_1) / 43)) > 0 and var_117_0 < var_117_3 then
					arg_114_1.talkMaxDuration = var_117_3

					if var_117_3 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_3 + 0
					end
				end

				arg_114_1.text_.text = var_117_1
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_4 = math.max(var_117_0, arg_114_1.talkMaxDuration)

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_4 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - 0) / var_117_4

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= 0 + var_117_4 and arg_114_1.time_ < 0 + var_117_4 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play322021030 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 322021030
		arg_118_1.duration_ = 11.03

		local var_118_0 = {
			zh = 6.166,
			ja = 11.033
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play322021031(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.var_.moveOldPos10104ui_story = arg_118_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_121_0 = 0.001

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 then
				arg_118_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_118_1.time_ - 0) / var_121_0)
				arg_118_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_118_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["10104ui_story"].transform.position).z)
				arg_118_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_118_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_118_1.actors_["10104ui_story"].transform.localEulerAngles = arg_118_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 then
				arg_118_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_118_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_118_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["10104ui_story"].transform.position).z)
				arg_118_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_118_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_118_1.actors_["10104ui_story"].transform.localEulerAngles = arg_118_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_121_1 = arg_118_1.actors_["10104ui_story"]

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(var_121_1) and arg_118_1.var_.characterEffect10104ui_story == nil then
				arg_118_1.var_.characterEffect10104ui_story = var_121_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_2 = 0.200000002980232

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_2 and not isNil(var_121_1) then
				if arg_118_1.var_.characterEffect10104ui_story and not isNil(var_121_1) then
					arg_118_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= 0 + var_121_2 and arg_118_1.time_ < 0 + var_121_2 + arg_121_0 and not isNil(var_121_1) and arg_118_1.var_.characterEffect10104ui_story then
				arg_118_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action2_1")
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_121_4 = 0
			local var_121_5 = 0.85

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_4 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_6 = arg_118_1:GetWordFromCfg(322021030)
				local var_121_7 = arg_118_1:FormatText(var_121_6.content)

				arg_118_1.text_.text = var_121_7

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_9 = 34 <= 0 and var_121_5 or var_121_5 * (utf8.len(var_121_7) / 34)

				if (34 <= 0 and var_121_5 or var_121_5 * (utf8.len(var_121_7) / 34)) > 0 and var_121_5 < var_121_9 then
					arg_118_1.talkMaxDuration = var_121_9

					if var_121_9 + var_121_4 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_9 + var_121_4
					end
				end

				arg_118_1.text_.text = var_121_7
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021030", "story_v_out_322021.awb") ~= 0 then
					local var_121_10 = manager.audio:GetVoiceLength("story_v_out_322021", "322021030", "story_v_out_322021.awb") / 1000

					if var_121_10 + var_121_4 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_10 + var_121_4
					end

					if var_121_6.prefab_name ~= "" and arg_118_1.actors_[var_121_6.prefab_name] ~= nil then
						local var_121_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_6.prefab_name].transform, "story_v_out_322021", "322021030", "story_v_out_322021.awb")

						arg_118_1:RecordAudio("322021030", var_121_11)
						arg_118_1:RecordAudio("322021030", var_121_11)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_322021", "322021030", "story_v_out_322021.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_322021", "322021030", "story_v_out_322021.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_12 = math.max(var_121_5, arg_118_1.talkMaxDuration)

			if var_121_4 <= arg_118_1.time_ and arg_118_1.time_ < var_121_4 + var_121_12 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_4) / var_121_12

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_4 + var_121_12 and arg_118_1.time_ < var_121_4 + var_121_12 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_118_1:InitPlayNodeList()
	end,
	Play322021031 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 322021031
		arg_122_1.duration_ = 10.67

		local var_122_0 = {
			zh = 8.933,
			ja = 10.666
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play322021032(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action2_2")
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_125_0 = 0
			local var_125_1 = 0.9

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_0 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_2 = arg_122_1:GetWordFromCfg(322021031)
				local var_125_3 = arg_122_1:FormatText(var_125_2.content)

				arg_122_1.text_.text = var_125_3

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_5 = 36 <= 0 and var_125_1 or var_125_1 * (utf8.len(var_125_3) / 36)

				if (36 <= 0 and var_125_1 or var_125_1 * (utf8.len(var_125_3) / 36)) > 0 and var_125_1 < var_125_5 then
					arg_122_1.talkMaxDuration = var_125_5

					if var_125_5 + var_125_0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_5 + var_125_0
					end
				end

				arg_122_1.text_.text = var_125_3
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021031", "story_v_out_322021.awb") ~= 0 then
					local var_125_6 = manager.audio:GetVoiceLength("story_v_out_322021", "322021031", "story_v_out_322021.awb") / 1000

					if var_125_6 + var_125_0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_6 + var_125_0
					end

					if var_125_2.prefab_name ~= "" and arg_122_1.actors_[var_125_2.prefab_name] ~= nil then
						local var_125_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_2.prefab_name].transform, "story_v_out_322021", "322021031", "story_v_out_322021.awb")

						arg_122_1:RecordAudio("322021031", var_125_7)
						arg_122_1:RecordAudio("322021031", var_125_7)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_322021", "322021031", "story_v_out_322021.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_322021", "322021031", "story_v_out_322021.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_8 = math.max(var_125_1, arg_122_1.talkMaxDuration)

			if var_125_0 <= arg_122_1.time_ and arg_122_1.time_ < var_125_0 + var_125_8 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_0) / var_125_8

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_0 + var_125_8 and arg_122_1.time_ < var_125_0 + var_125_8 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play322021032 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 322021032
		arg_126_1.duration_ = 5.53

		local var_126_0 = {
			zh = 3,
			ja = 5.533
		}
		local var_126_1 = manager.audio:GetLocalizationFlag()

		if var_126_0[var_126_1] ~= nil then
			arg_126_1.duration_ = var_126_0[var_126_1]
		end

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play322021033(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos1061ui_story = arg_126_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_129_0 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_0 then
				arg_126_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1061ui_story, Vector3.New(0.7, -1.18, -6.15), (arg_126_1.time_ - 0) / var_129_0)
				arg_126_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_126_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["1061ui_story"].transform.position).z)
				arg_126_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_126_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_126_1.actors_["1061ui_story"].transform.localEulerAngles = arg_126_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_126_1.time_ >= 0 + var_129_0 and arg_126_1.time_ < 0 + var_129_0 + arg_129_0 then
				arg_126_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0.7, -1.18, -6.15)
				arg_126_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_126_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["1061ui_story"].transform.position).z)
				arg_126_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_126_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_126_1.actors_["1061ui_story"].transform.localEulerAngles = arg_126_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_129_1 = arg_126_1.actors_["10104ui_story"].transform

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos10104ui_story = var_129_1.localPosition
			end

			local var_129_2 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_2 then
				var_129_1.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos10104ui_story, Vector3.New(-0.88, -1.12, -5.99), (arg_126_1.time_ - 0) / var_129_2)
				var_129_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_1.position).x, (manager.ui.mainCamera.transform.position - var_129_1.position).y, (manager.ui.mainCamera.transform.position - var_129_1.position).z)
				var_129_1.localEulerAngles.z = 0
				var_129_1.localEulerAngles.x = 0
				var_129_1.localEulerAngles = var_129_1.localEulerAngles
			end

			if arg_126_1.time_ >= 0 + var_129_2 and arg_126_1.time_ < 0 + var_129_2 + arg_129_0 then
				var_129_1.localPosition = Vector3.New(-0.88, -1.12, -5.99)
				var_129_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_1.position).x, (manager.ui.mainCamera.transform.position - var_129_1.position).y, (manager.ui.mainCamera.transform.position - var_129_1.position).z)
				var_129_1.localEulerAngles.z = 0
				var_129_1.localEulerAngles.x = 0
				var_129_1.localEulerAngles = var_129_1.localEulerAngles
			end

			local var_129_3 = arg_126_1.actors_["1061ui_story"]

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(var_129_3) and arg_126_1.var_.characterEffect1061ui_story == nil then
				arg_126_1.var_.characterEffect1061ui_story = var_129_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_4 = 0.200000002980232

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_4 and not isNil(var_129_3) then
				if arg_126_1.var_.characterEffect1061ui_story and not isNil(var_129_3) then
					arg_126_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= 0 + var_129_4 and arg_126_1.time_ < 0 + var_129_4 + arg_129_0 and not isNil(var_129_3) and arg_126_1.var_.characterEffect1061ui_story then
				arg_126_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_129_6 = arg_126_1.actors_["10104ui_story"]

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(var_129_6) and arg_126_1.var_.characterEffect10104ui_story == nil then
				arg_126_1.var_.characterEffect10104ui_story = var_129_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_7 = 0.200000002980232

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_7 and not isNil(var_129_6) then
				if arg_126_1.var_.characterEffect10104ui_story and not isNil(var_129_6) then
					arg_126_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_126_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_126_1.time_ - 0) / var_129_7)
				end
			end

			if arg_126_1.time_ >= 0 + var_129_7 and arg_126_1.time_ < 0 + var_129_7 + arg_129_0 and not isNil(var_129_6) and arg_126_1.var_.characterEffect10104ui_story then
				arg_126_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_126_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_129_8 = 0
			local var_129_9 = 0.325

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_8 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_10 = arg_126_1:GetWordFromCfg(322021032)
				local var_129_11 = arg_126_1:FormatText(var_129_10.content)

				arg_126_1.text_.text = var_129_11

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_13 = 13 <= 0 and var_129_9 or var_129_9 * (utf8.len(var_129_11) / 13)

				if (13 <= 0 and var_129_9 or var_129_9 * (utf8.len(var_129_11) / 13)) > 0 and var_129_9 < var_129_13 then
					arg_126_1.talkMaxDuration = var_129_13

					if var_129_13 + var_129_8 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_13 + var_129_8
					end
				end

				arg_126_1.text_.text = var_129_11
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021032", "story_v_out_322021.awb") ~= 0 then
					local var_129_14 = manager.audio:GetVoiceLength("story_v_out_322021", "322021032", "story_v_out_322021.awb") / 1000

					if var_129_14 + var_129_8 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_14 + var_129_8
					end

					if var_129_10.prefab_name ~= "" and arg_126_1.actors_[var_129_10.prefab_name] ~= nil then
						local var_129_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_10.prefab_name].transform, "story_v_out_322021", "322021032", "story_v_out_322021.awb")

						arg_126_1:RecordAudio("322021032", var_129_15)
						arg_126_1:RecordAudio("322021032", var_129_15)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_322021", "322021032", "story_v_out_322021.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_322021", "322021032", "story_v_out_322021.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_16 = math.max(var_129_9, arg_126_1.talkMaxDuration)

			if var_129_8 <= arg_126_1.time_ and arg_126_1.time_ < var_129_8 + var_129_16 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_8) / var_129_16

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_8 + var_129_16 and arg_126_1.time_ < var_129_8 + var_129_16 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play322021033 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 322021033
		arg_130_1.duration_ = 12.93

		local var_130_0 = {
			zh = 8.333,
			ja = 12.933
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play322021034(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action5_1")
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_133_0 = 0
			local var_133_1 = 1.15

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_2 = arg_130_1:GetWordFromCfg(322021033)
				local var_133_3 = arg_130_1:FormatText(var_133_2.content)

				arg_130_1.text_.text = var_133_3

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_5 = 46 <= 0 and var_133_1 or var_133_1 * (utf8.len(var_133_3) / 46)

				if (46 <= 0 and var_133_1 or var_133_1 * (utf8.len(var_133_3) / 46)) > 0 and var_133_1 < var_133_5 then
					arg_130_1.talkMaxDuration = var_133_5

					if var_133_5 + var_133_0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_5 + var_133_0
					end
				end

				arg_130_1.text_.text = var_133_3
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021033", "story_v_out_322021.awb") ~= 0 then
					local var_133_6 = manager.audio:GetVoiceLength("story_v_out_322021", "322021033", "story_v_out_322021.awb") / 1000

					if var_133_6 + var_133_0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_6 + var_133_0
					end

					if var_133_2.prefab_name ~= "" and arg_130_1.actors_[var_133_2.prefab_name] ~= nil then
						local var_133_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_2.prefab_name].transform, "story_v_out_322021", "322021033", "story_v_out_322021.awb")

						arg_130_1:RecordAudio("322021033", var_133_7)
						arg_130_1:RecordAudio("322021033", var_133_7)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_322021", "322021033", "story_v_out_322021.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_322021", "322021033", "story_v_out_322021.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_8 = math.max(var_133_1, arg_130_1.talkMaxDuration)

			if var_133_0 <= arg_130_1.time_ and arg_130_1.time_ < var_133_0 + var_133_8 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_0) / var_133_8

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_0 + var_133_8 and arg_130_1.time_ < var_133_0 + var_133_8 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play322021034 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 322021034
		arg_134_1.duration_ = 2.93

		local var_134_0 = {
			zh = 1.999999999999,
			ja = 2.933
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play322021035(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.var_.moveOldPos10104ui_story = arg_134_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_137_0 = 0.001

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 then
				arg_134_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos10104ui_story, Vector3.New(-0.88, -1.12, -5.99), (arg_134_1.time_ - 0) / var_137_0)
				arg_134_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_134_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["10104ui_story"].transform.position).z)
				arg_134_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_134_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_134_1.actors_["10104ui_story"].transform.localEulerAngles = arg_134_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 then
				arg_134_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(-0.88, -1.12, -5.99)
				arg_134_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_134_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["10104ui_story"].transform.position).z)
				arg_134_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_134_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_134_1.actors_["10104ui_story"].transform.localEulerAngles = arg_134_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_137_1 = arg_134_1.actors_["10104ui_story"]

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(var_137_1) and arg_134_1.var_.characterEffect10104ui_story == nil then
				arg_134_1.var_.characterEffect10104ui_story = var_137_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_2 = 0.200000002980232

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_2 and not isNil(var_137_1) then
				if arg_134_1.var_.characterEffect10104ui_story and not isNil(var_137_1) then
					arg_134_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= 0 + var_137_2 and arg_134_1.time_ < 0 + var_137_2 + arg_137_0 and not isNil(var_137_1) and arg_134_1.var_.characterEffect10104ui_story then
				arg_134_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_137_4 = arg_134_1.actors_["1061ui_story"]

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(var_137_4) and arg_134_1.var_.characterEffect1061ui_story == nil then
				arg_134_1.var_.characterEffect1061ui_story = var_137_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_5 = 0.200000002980232

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_5 and not isNil(var_137_4) then
				if arg_134_1.var_.characterEffect1061ui_story and not isNil(var_137_4) then
					arg_134_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_134_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_134_1.time_ - 0) / var_137_5)
				end
			end

			if arg_134_1.time_ >= 0 + var_137_5 and arg_134_1.time_ < 0 + var_137_5 + arg_137_0 and not isNil(var_137_4) and arg_134_1.var_.characterEffect1061ui_story then
				arg_134_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_134_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action6_1")
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_137_6 = 0
			local var_137_7 = 0.225

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_6 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_8 = arg_134_1:GetWordFromCfg(322021034)
				local var_137_9 = arg_134_1:FormatText(var_137_8.content)

				arg_134_1.text_.text = var_137_9

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_11 = 9 <= 0 and var_137_7 or var_137_7 * (utf8.len(var_137_9) / 9)

				if (9 <= 0 and var_137_7 or var_137_7 * (utf8.len(var_137_9) / 9)) > 0 and var_137_7 < var_137_11 then
					arg_134_1.talkMaxDuration = var_137_11

					if var_137_11 + var_137_6 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_11 + var_137_6
					end
				end

				arg_134_1.text_.text = var_137_9
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021034", "story_v_out_322021.awb") ~= 0 then
					local var_137_12 = manager.audio:GetVoiceLength("story_v_out_322021", "322021034", "story_v_out_322021.awb") / 1000

					if var_137_12 + var_137_6 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_12 + var_137_6
					end

					if var_137_8.prefab_name ~= "" and arg_134_1.actors_[var_137_8.prefab_name] ~= nil then
						local var_137_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_8.prefab_name].transform, "story_v_out_322021", "322021034", "story_v_out_322021.awb")

						arg_134_1:RecordAudio("322021034", var_137_13)
						arg_134_1:RecordAudio("322021034", var_137_13)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_322021", "322021034", "story_v_out_322021.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_322021", "322021034", "story_v_out_322021.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_14 = math.max(var_137_7, arg_134_1.talkMaxDuration)

			if var_137_6 <= arg_134_1.time_ and arg_134_1.time_ < var_137_6 + var_137_14 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_6) / var_137_14

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_6 + var_137_14 and arg_134_1.time_ < var_137_6 + var_137_14 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_134_1:InitPlayNodeList()
	end,
	Play322021035 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 322021035
		arg_138_1.duration_ = 7.6

		local var_138_0 = {
			zh = 4.9,
			ja = 7.6
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play322021036(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(arg_138_1.actors_["1061ui_story"]) and arg_138_1.var_.characterEffect1061ui_story == nil then
				arg_138_1.var_.characterEffect1061ui_story = arg_138_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_0 = 0.200000002980232

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 and not isNil(arg_138_1.actors_["1061ui_story"]) then
				if arg_138_1.var_.characterEffect1061ui_story and not isNil(arg_138_1.actors_["1061ui_story"]) then
					arg_138_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 and not isNil(arg_138_1.actors_["1061ui_story"]) and arg_138_1.var_.characterEffect1061ui_story then
				arg_138_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_141_2 = arg_138_1.actors_["10104ui_story"]

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(var_141_2) and arg_138_1.var_.characterEffect10104ui_story == nil then
				arg_138_1.var_.characterEffect10104ui_story = var_141_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_3 = 0.200000002980232

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_3 and not isNil(var_141_2) then
				if arg_138_1.var_.characterEffect10104ui_story and not isNil(var_141_2) then
					arg_138_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_138_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_138_1.time_ - 0) / var_141_3)
				end
			end

			if arg_138_1.time_ >= 0 + var_141_3 and arg_138_1.time_ < 0 + var_141_3 + arg_141_0 and not isNil(var_141_2) and arg_138_1.var_.characterEffect10104ui_story then
				arg_138_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_138_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action5_2")
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_141_4 = 0
			local var_141_5 = 0.65

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_4 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_6 = arg_138_1:GetWordFromCfg(322021035)
				local var_141_7 = arg_138_1:FormatText(var_141_6.content)

				arg_138_1.text_.text = var_141_7

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_9 = 26 <= 0 and var_141_5 or var_141_5 * (utf8.len(var_141_7) / 26)

				if (26 <= 0 and var_141_5 or var_141_5 * (utf8.len(var_141_7) / 26)) > 0 and var_141_5 < var_141_9 then
					arg_138_1.talkMaxDuration = var_141_9

					if var_141_9 + var_141_4 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_9 + var_141_4
					end
				end

				arg_138_1.text_.text = var_141_7
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021035", "story_v_out_322021.awb") ~= 0 then
					local var_141_10 = manager.audio:GetVoiceLength("story_v_out_322021", "322021035", "story_v_out_322021.awb") / 1000

					if var_141_10 + var_141_4 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_10 + var_141_4
					end

					if var_141_6.prefab_name ~= "" and arg_138_1.actors_[var_141_6.prefab_name] ~= nil then
						local var_141_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_6.prefab_name].transform, "story_v_out_322021", "322021035", "story_v_out_322021.awb")

						arg_138_1:RecordAudio("322021035", var_141_11)
						arg_138_1:RecordAudio("322021035", var_141_11)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_322021", "322021035", "story_v_out_322021.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_322021", "322021035", "story_v_out_322021.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_12 = math.max(var_141_5, arg_138_1.talkMaxDuration)

			if var_141_4 <= arg_138_1.time_ and arg_138_1.time_ < var_141_4 + var_141_12 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_4) / var_141_12

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_4 + var_141_12 and arg_138_1.time_ < var_141_4 + var_141_12 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play322021036 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 322021036
		arg_142_1.duration_ = 11.6

		local var_142_0 = {
			zh = 8.4,
			ja = 11.6
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play322021037(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(arg_142_1.actors_["10104ui_story"]) and arg_142_1.var_.characterEffect10104ui_story == nil then
				arg_142_1.var_.characterEffect10104ui_story = arg_142_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_0 = 0.200000002980232

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_0 and not isNil(arg_142_1.actors_["10104ui_story"]) then
				if arg_142_1.var_.characterEffect10104ui_story and not isNil(arg_142_1.actors_["10104ui_story"]) then
					arg_142_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= 0 + var_145_0 and arg_142_1.time_ < 0 + var_145_0 + arg_145_0 and not isNil(arg_142_1.actors_["10104ui_story"]) and arg_142_1.var_.characterEffect10104ui_story then
				arg_142_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_145_2 = arg_142_1.actors_["1061ui_story"]

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(var_145_2) and arg_142_1.var_.characterEffect1061ui_story == nil then
				arg_142_1.var_.characterEffect1061ui_story = var_145_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_3 = 0.200000002980232

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_3 and not isNil(var_145_2) then
				if arg_142_1.var_.characterEffect1061ui_story and not isNil(var_145_2) then
					arg_142_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_142_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_142_1.time_ - 0) / var_145_3)
				end
			end

			if arg_142_1.time_ >= 0 + var_145_3 and arg_142_1.time_ < 0 + var_145_3 + arg_145_0 and not isNil(var_145_2) and arg_142_1.var_.characterEffect1061ui_story then
				arg_142_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_142_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action6_2")
			end

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_145_4 = 0
			local var_145_5 = 0.825

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_4 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_6 = arg_142_1:GetWordFromCfg(322021036)
				local var_145_7 = arg_142_1:FormatText(var_145_6.content)

				arg_142_1.text_.text = var_145_7

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_9 = 33 <= 0 and var_145_5 or var_145_5 * (utf8.len(var_145_7) / 33)

				if (33 <= 0 and var_145_5 or var_145_5 * (utf8.len(var_145_7) / 33)) > 0 and var_145_5 < var_145_9 then
					arg_142_1.talkMaxDuration = var_145_9

					if var_145_9 + var_145_4 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_9 + var_145_4
					end
				end

				arg_142_1.text_.text = var_145_7
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021036", "story_v_out_322021.awb") ~= 0 then
					local var_145_10 = manager.audio:GetVoiceLength("story_v_out_322021", "322021036", "story_v_out_322021.awb") / 1000

					if var_145_10 + var_145_4 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_10 + var_145_4
					end

					if var_145_6.prefab_name ~= "" and arg_142_1.actors_[var_145_6.prefab_name] ~= nil then
						local var_145_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_6.prefab_name].transform, "story_v_out_322021", "322021036", "story_v_out_322021.awb")

						arg_142_1:RecordAudio("322021036", var_145_11)
						arg_142_1:RecordAudio("322021036", var_145_11)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_322021", "322021036", "story_v_out_322021.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_322021", "322021036", "story_v_out_322021.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_12 = math.max(var_145_5, arg_142_1.talkMaxDuration)

			if var_145_4 <= arg_142_1.time_ and arg_142_1.time_ < var_145_4 + var_145_12 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_4) / var_145_12

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_4 + var_145_12 and arg_142_1.time_ < var_145_4 + var_145_12 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play322021037 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 322021037
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play322021038(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_9000

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.var_.moveOldPos10104ui_story = arg_146_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_149_0 = 0.001

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_0 then
				arg_146_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_146_1.time_ - 0) / var_149_0)
				arg_146_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_146_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["10104ui_story"].transform.position).z)
				arg_146_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_146_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_146_1.actors_["10104ui_story"].transform.localEulerAngles = arg_146_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_146_1.time_ >= 0 + var_149_0 and arg_146_1.time_ < 0 + var_149_0 + arg_149_0 then
				arg_146_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_146_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_146_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["10104ui_story"].transform.position).z)
				arg_146_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_146_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_146_1.actors_["10104ui_story"].transform.localEulerAngles = arg_146_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_149_1 = arg_146_1.actors_["1061ui_story"].transform

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.var_.moveOldPos1061ui_story = var_149_1.localPosition
			end

			local var_149_2 = 0.001

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_2 then
				var_149_1.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_146_1.time_ - 0) / var_149_2)
				var_149_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_149_1.position).x, (manager.ui.mainCamera.transform.position - var_149_1.position).y, (manager.ui.mainCamera.transform.position - var_149_1.position).z)
				var_149_1.localEulerAngles.z = 0
				var_149_1.localEulerAngles.x = 0
				var_149_1.localEulerAngles = var_149_1.localEulerAngles
			end

			if arg_146_1.time_ >= 0 + var_149_2 and arg_146_1.time_ < 0 + var_149_2 + arg_149_0 then
				var_149_1.localPosition = Vector3.New(0, 100, 0)
				var_149_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_149_1.position).x, (manager.ui.mainCamera.transform.position - var_149_1.position).y, (manager.ui.mainCamera.transform.position - var_149_1.position).z)
				var_149_1.localEulerAngles.z = 0
				var_149_1.localEulerAngles.x = 0
				var_149_1.localEulerAngles = var_149_1.localEulerAngles
			end

			if 0.1 < arg_146_1.time_ and arg_146_1.time_ <= 0.1 + arg_149_0 then
				arg_146_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_knockcar", "")
			end

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				local var_149_4 = arg_146_1.var_.effect1037

				if not arg_146_1.var_.effect1037 then
					var_149_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ball_in_keep"), manager.ui.mainCamera.transform)
					var_149_4.name = "1037"
					arg_146_1.var_.effect1037 = var_149_4
				else
					var_149_4.transform:SetParent(var_149_9000)
				end

				var_149_4.transform.localPosition = Vector3.New(0, 0, 0)
				var_149_4.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_149_6 = 0
			local var_149_7 = 1.6

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_6 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, false)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_8 = arg_146_1:FormatText(arg_146_1:GetWordFromCfg(322021037).content)

				arg_146_1.text_.text = var_149_8

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_10 = 64 <= 0 and var_149_7 or var_149_7 * (utf8.len(var_149_8) / 64)

				if (64 <= 0 and var_149_7 or var_149_7 * (utf8.len(var_149_8) / 64)) > 0 and var_149_7 < var_149_10 then
					arg_146_1.talkMaxDuration = var_149_10

					if var_149_10 + var_149_6 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_10 + var_149_6
					end
				end

				arg_146_1.text_.text = var_149_8
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_11 = math.max(var_149_7, arg_146_1.talkMaxDuration)

			if var_149_6 <= arg_146_1.time_ and arg_146_1.time_ < var_149_6 + var_149_11 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_6) / var_149_11

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_6 + var_149_11 and arg_146_1.time_ < var_149_6 + var_149_11 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_146_1:InitPlayNodeList()
	end,
	Play322021038 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 322021038
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play322021039(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0.65

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, true)
				arg_150_1.iconController_:SetSelectedState("hero")

				arg_150_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_150_1.callingController_:SetSelectedState("normal")

				arg_150_1.keyicon_.color = Color.New(1, 1, 1)
				arg_150_1.icon_.color = Color.New(1, 1, 1)

				local var_153_1 = arg_150_1:FormatText(arg_150_1:GetWordFromCfg(322021038).content)

				arg_150_1.text_.text = var_153_1

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_3 = 26 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_1) / 26)

				if (26 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_1) / 26)) > 0 and var_153_0 < var_153_3 then
					arg_150_1.talkMaxDuration = var_153_3

					if var_153_3 + 0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_3 + 0
					end
				end

				arg_150_1.text_.text = var_153_1
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_4 = math.max(var_153_0, arg_150_1.talkMaxDuration)

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_4 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - 0) / var_153_4

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= 0 + var_153_4 and arg_150_1.time_ < 0 + var_153_4 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play322021039 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 322021039
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play322021040(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 1.3

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, true)
				arg_154_1.iconController_:SetSelectedState("hero")

				arg_154_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_154_1.callingController_:SetSelectedState("normal")

				arg_154_1.keyicon_.color = Color.New(1, 1, 1)
				arg_154_1.icon_.color = Color.New(1, 1, 1)

				local var_157_1 = arg_154_1:FormatText(arg_154_1:GetWordFromCfg(322021039).content)

				arg_154_1.text_.text = var_157_1

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_3 = 52 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_1) / 52)

				if (52 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_1) / 52)) > 0 and var_157_0 < var_157_3 then
					arg_154_1.talkMaxDuration = var_157_3

					if var_157_3 + 0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_3 + 0
					end
				end

				arg_154_1.text_.text = var_157_1
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_4 = math.max(var_157_0, arg_154_1.talkMaxDuration)

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_4 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - 0) / var_157_4

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= 0 + var_157_4 and arg_154_1.time_ < 0 + var_157_4 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play322021040 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 322021040
		arg_158_1.duration_ = 2

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play322021041(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.var_.moveOldPos1061ui_story = arg_158_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_161_0 = 0.001

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_0 then
				arg_158_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_158_1.time_ - 0) / var_161_0)
				arg_158_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_158_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_158_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_158_1.actors_["1061ui_story"].transform.position).z)
				arg_158_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_158_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_158_1.actors_["1061ui_story"].transform.localEulerAngles = arg_158_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_158_1.time_ >= 0 + var_161_0 and arg_158_1.time_ < 0 + var_161_0 + arg_161_0 then
				arg_158_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_158_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_158_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_158_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_158_1.actors_["1061ui_story"].transform.position).z)
				arg_158_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_158_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_158_1.actors_["1061ui_story"].transform.localEulerAngles = arg_158_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_161_1 = arg_158_1.actors_["1061ui_story"]

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(var_161_1) and arg_158_1.var_.characterEffect1061ui_story == nil then
				arg_158_1.var_.characterEffect1061ui_story = var_161_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_2 = 0.200000002980232

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_2 and not isNil(var_161_1) then
				if arg_158_1.var_.characterEffect1061ui_story and not isNil(var_161_1) then
					arg_158_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_158_1.time_ >= 0 + var_161_2 and arg_158_1.time_ < 0 + var_161_2 + arg_161_0 and not isNil(var_161_1) and arg_158_1.var_.characterEffect1061ui_story then
				arg_158_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				if arg_158_1.var_.effect1037 then
					Object.Destroy(arg_158_1.var_.effect1037)

					arg_158_1.var_.effect1037 = nil
				end
			end

			local var_161_5 = 0
			local var_161_6 = 0.175

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_5 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_7 = arg_158_1:GetWordFromCfg(322021040)
				local var_161_8 = arg_158_1:FormatText(var_161_7.content)

				arg_158_1.text_.text = var_161_8

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_10 = 7 <= 0 and var_161_6 or var_161_6 * (utf8.len(var_161_8) / 7)

				if (7 <= 0 and var_161_6 or var_161_6 * (utf8.len(var_161_8) / 7)) > 0 and var_161_6 < var_161_10 then
					arg_158_1.talkMaxDuration = var_161_10

					if var_161_10 + var_161_5 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_10 + var_161_5
					end
				end

				arg_158_1.text_.text = var_161_8
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021040", "story_v_out_322021.awb") ~= 0 then
					local var_161_11 = manager.audio:GetVoiceLength("story_v_out_322021", "322021040", "story_v_out_322021.awb") / 1000

					if var_161_11 + var_161_5 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_11 + var_161_5
					end

					if var_161_7.prefab_name ~= "" and arg_158_1.actors_[var_161_7.prefab_name] ~= nil then
						local var_161_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_7.prefab_name].transform, "story_v_out_322021", "322021040", "story_v_out_322021.awb")

						arg_158_1:RecordAudio("322021040", var_161_12)
						arg_158_1:RecordAudio("322021040", var_161_12)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_322021", "322021040", "story_v_out_322021.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_322021", "322021040", "story_v_out_322021.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_13 = math.max(var_161_6, arg_158_1.talkMaxDuration)

			if var_161_5 <= arg_158_1.time_ and arg_158_1.time_ < var_161_5 + var_161_13 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_5) / var_161_13

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_5 + var_161_13 and arg_158_1.time_ < var_161_5 + var_161_13 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_158_1:InitPlayNodeList()
	end,
	Play322021041 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 322021041
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play322021042(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(arg_162_1.actors_["1061ui_story"]) and arg_162_1.var_.characterEffect1061ui_story == nil then
				arg_162_1.var_.characterEffect1061ui_story = arg_162_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_0 = 0.200000002980232

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_0 and not isNil(arg_162_1.actors_["1061ui_story"]) then
				if arg_162_1.var_.characterEffect1061ui_story and not isNil(arg_162_1.actors_["1061ui_story"]) then
					arg_162_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_162_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_162_1.time_ - 0) / var_165_0)
				end
			end

			if arg_162_1.time_ >= 0 + var_165_0 and arg_162_1.time_ < 0 + var_165_0 + arg_165_0 and not isNil(arg_162_1.actors_["1061ui_story"]) and arg_162_1.var_.characterEffect1061ui_story then
				arg_162_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_162_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_165_1 = 0
			local var_165_2 = 0.45

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, true)
				arg_162_1.iconController_:SetSelectedState("hero")

				arg_162_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_162_1.callingController_:SetSelectedState("normal")

				arg_162_1.keyicon_.color = Color.New(1, 1, 1)
				arg_162_1.icon_.color = Color.New(1, 1, 1)

				local var_165_3 = arg_162_1:FormatText(arg_162_1:GetWordFromCfg(322021041).content)

				arg_162_1.text_.text = var_165_3

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_5 = 18 <= 0 and var_165_2 or var_165_2 * (utf8.len(var_165_3) / 18)

				if (18 <= 0 and var_165_2 or var_165_2 * (utf8.len(var_165_3) / 18)) > 0 and var_165_2 < var_165_5 then
					arg_162_1.talkMaxDuration = var_165_5

					if var_165_5 + var_165_1 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_5 + var_165_1
					end
				end

				arg_162_1.text_.text = var_165_3
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_6 = math.max(var_165_2, arg_162_1.talkMaxDuration)

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_6 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_1) / var_165_6

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_1 + var_165_6 and arg_162_1.time_ < var_165_1 + var_165_6 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play322021042 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 322021042
		arg_166_1.duration_ = 2

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play322021043(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.var_.moveOldPos1061ui_story = arg_166_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_169_0 = 0.001

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_0 then
				arg_166_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_166_1.time_ - 0) / var_169_0)
				arg_166_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_166_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["1061ui_story"].transform.position).z)
				arg_166_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_166_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_166_1.actors_["1061ui_story"].transform.localEulerAngles = arg_166_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_166_1.time_ >= 0 + var_169_0 and arg_166_1.time_ < 0 + var_169_0 + arg_169_0 then
				arg_166_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_166_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_166_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["1061ui_story"].transform.position).z)
				arg_166_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_166_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_166_1.actors_["1061ui_story"].transform.localEulerAngles = arg_166_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_169_1 = "1284ui_story"

			if arg_166_1.actors_["1284ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1284ui_story"))) then
				local var_169_2 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_166_1.stage_.transform)

				var_169_2.name = var_169_1
				var_169_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_166_1.actors_[var_169_1] = var_169_2

				local var_169_3 = var_169_2:GetComponentInChildren(typeof(CharacterEffect))

				var_169_3.enabled = true

				local var_169_4 = GameObjectTools.GetOrAddComponent(var_169_2, typeof(DynamicBoneHelper))

				if var_169_4 then
					var_169_4:EnableDynamicBone(false)
				end

				arg_166_1:ShowWeapon(var_169_3.transform, false)

				arg_166_1.var_[var_169_1 .. "Animator"] = var_169_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_166_1.var_[var_169_1 .. "Animator"].applyRootMotion = true
				arg_166_1.var_[var_169_1 .. "LipSync"] = var_169_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_169_5 = arg_166_1.actors_["1284ui_story"].transform

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.var_.moveOldPos1284ui_story = var_169_5.localPosition

				arg_166_1:ShowWeapon(arg_166_1.var_["1284ui_story" .. "Animator"].transform, false)
			end

			local var_169_6 = 0.001

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_6 then
				var_169_5.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1284ui_story, Vector3.New(0, -0.985, -6.22), (arg_166_1.time_ - 0) / var_169_6)
				var_169_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_169_5.position).x, (manager.ui.mainCamera.transform.position - var_169_5.position).y, (manager.ui.mainCamera.transform.position - var_169_5.position).z)
				var_169_5.localEulerAngles.z = 0
				var_169_5.localEulerAngles.x = 0
				var_169_5.localEulerAngles = var_169_5.localEulerAngles
			end

			if arg_166_1.time_ >= 0 + var_169_6 and arg_166_1.time_ < 0 + var_169_6 + arg_169_0 then
				var_169_5.localPosition = Vector3.New(0, -0.985, -6.22)
				var_169_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_169_5.position).x, (manager.ui.mainCamera.transform.position - var_169_5.position).y, (manager.ui.mainCamera.transform.position - var_169_5.position).z)
				var_169_5.localEulerAngles.z = 0
				var_169_5.localEulerAngles.x = 0
				var_169_5.localEulerAngles = var_169_5.localEulerAngles
			end

			local var_169_7 = arg_166_1.actors_["1284ui_story"]

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(var_169_7) and arg_166_1.var_.characterEffect1284ui_story == nil then
				arg_166_1.var_.characterEffect1284ui_story = var_169_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_8 = 0.200000002980232

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_8 and not isNil(var_169_7) then
				if arg_166_1.var_.characterEffect1284ui_story and not isNil(var_169_7) then
					arg_166_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_166_1.time_ >= 0 + var_169_8 and arg_166_1.time_ < 0 + var_169_8 + arg_169_0 and not isNil(var_169_7) and arg_166_1.var_.characterEffect1284ui_story then
				arg_166_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action3_1")
			end

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_169_10 = 0
			local var_169_11 = 0.15

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_10 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_12 = arg_166_1:GetWordFromCfg(322021042)
				local var_169_13 = arg_166_1:FormatText(var_169_12.content)

				arg_166_1.text_.text = var_169_13

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_15 = 6 <= 0 and var_169_11 or var_169_11 * (utf8.len(var_169_13) / 6)

				if (6 <= 0 and var_169_11 or var_169_11 * (utf8.len(var_169_13) / 6)) > 0 and var_169_11 < var_169_15 then
					arg_166_1.talkMaxDuration = var_169_15

					if var_169_15 + var_169_10 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_15 + var_169_10
					end
				end

				arg_166_1.text_.text = var_169_13
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021042", "story_v_out_322021.awb") ~= 0 then
					local var_169_16 = manager.audio:GetVoiceLength("story_v_out_322021", "322021042", "story_v_out_322021.awb") / 1000

					if var_169_16 + var_169_10 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_16 + var_169_10
					end

					if var_169_12.prefab_name ~= "" and arg_166_1.actors_[var_169_12.prefab_name] ~= nil then
						local var_169_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_12.prefab_name].transform, "story_v_out_322021", "322021042", "story_v_out_322021.awb")

						arg_166_1:RecordAudio("322021042", var_169_17)
						arg_166_1:RecordAudio("322021042", var_169_17)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_322021", "322021042", "story_v_out_322021.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_322021", "322021042", "story_v_out_322021.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_18 = math.max(var_169_11, arg_166_1.talkMaxDuration)

			if var_169_10 <= arg_166_1.time_ and arg_166_1.time_ < var_169_10 + var_169_18 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_10) / var_169_18

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_10 + var_169_18 and arg_166_1.time_ < var_169_10 + var_169_18 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play322021043 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 322021043
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play322021044(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.var_.moveOldPos1284ui_story = arg_170_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_173_0 = 0.001

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_0 then
				arg_170_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_170_1.time_ - 0) / var_173_0)
				arg_170_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_170_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1284ui_story"].transform.position).z)
				arg_170_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_170_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_170_1.actors_["1284ui_story"].transform.localEulerAngles = arg_170_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_170_1.time_ >= 0 + var_173_0 and arg_170_1.time_ < 0 + var_173_0 + arg_173_0 then
				arg_170_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_170_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_170_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1284ui_story"].transform.position).z)
				arg_170_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_170_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_170_1.actors_["1284ui_story"].transform.localEulerAngles = arg_170_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_173_1 = 0
			local var_173_2 = 1.625

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, false)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_3 = arg_170_1:FormatText(arg_170_1:GetWordFromCfg(322021043).content)

				arg_170_1.text_.text = var_173_3

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_5 = 65 <= 0 and var_173_2 or var_173_2 * (utf8.len(var_173_3) / 65)

				if (65 <= 0 and var_173_2 or var_173_2 * (utf8.len(var_173_3) / 65)) > 0 and var_173_2 < var_173_5 then
					arg_170_1.talkMaxDuration = var_173_5

					if var_173_5 + var_173_1 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_5 + var_173_1
					end
				end

				arg_170_1.text_.text = var_173_3
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_6 = math.max(var_173_2, arg_170_1.talkMaxDuration)

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_6 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_1) / var_173_6

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_1 + var_173_6 and arg_170_1.time_ < var_173_1 + var_173_6 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_170_1:InitPlayNodeList()
	end,
	Play322021044 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 322021044
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play322021045(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = 0.225

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, true)
				arg_174_1.iconController_:SetSelectedState("hero")

				arg_174_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_174_1.callingController_:SetSelectedState("normal")

				arg_174_1.keyicon_.color = Color.New(1, 1, 1)
				arg_174_1.icon_.color = Color.New(1, 1, 1)

				local var_177_1 = arg_174_1:FormatText(arg_174_1:GetWordFromCfg(322021044).content)

				arg_174_1.text_.text = var_177_1

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_3 = 9 <= 0 and var_177_0 or var_177_0 * (utf8.len(var_177_1) / 9)

				if (9 <= 0 and var_177_0 or var_177_0 * (utf8.len(var_177_1) / 9)) > 0 and var_177_0 < var_177_3 then
					arg_174_1.talkMaxDuration = var_177_3

					if var_177_3 + 0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_3 + 0
					end
				end

				arg_174_1.text_.text = var_177_1
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_4 = math.max(var_177_0, arg_174_1.talkMaxDuration)

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_4 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - 0) / var_177_4

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= 0 + var_177_4 and arg_174_1.time_ < 0 + var_177_4 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play322021045 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 322021045
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play322021046(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 1.275

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, false)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_1 = arg_178_1:FormatText(arg_178_1:GetWordFromCfg(322021045).content)

				arg_178_1.text_.text = var_181_1

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_3 = 51 <= 0 and var_181_0 or var_181_0 * (utf8.len(var_181_1) / 51)

				if (51 <= 0 and var_181_0 or var_181_0 * (utf8.len(var_181_1) / 51)) > 0 and var_181_0 < var_181_3 then
					arg_178_1.talkMaxDuration = var_181_3

					if var_181_3 + 0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_3 + 0
					end
				end

				arg_178_1.text_.text = var_181_1
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_4 = math.max(var_181_0, arg_178_1.talkMaxDuration)

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_4 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - 0) / var_181_4

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= 0 + var_181_4 and arg_178_1.time_ < 0 + var_181_4 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play322021046 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 322021046
		arg_182_1.duration_ = 6.03

		local var_182_0 = {
			zh = 4.3,
			ja = 6.033
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play322021047(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.var_.moveOldPos1284ui_story = arg_182_1.actors_["1284ui_story"].transform.localPosition

				arg_182_1:ShowWeapon(arg_182_1.var_["1284ui_story" .. "Animator"].transform, false)
			end

			local var_185_0 = 0.001

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 then
				arg_182_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos1284ui_story, Vector3.New(0, -0.985, -6.22), (arg_182_1.time_ - 0) / var_185_0)
				arg_182_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_182_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["1284ui_story"].transform.position).z)
				arg_182_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_182_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_182_1.actors_["1284ui_story"].transform.localEulerAngles = arg_182_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 then
				arg_182_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.22)
				arg_182_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_182_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["1284ui_story"].transform.position).z)
				arg_182_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_182_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_182_1.actors_["1284ui_story"].transform.localEulerAngles = arg_182_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_185_1 = arg_182_1.actors_["1284ui_story"]

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(var_185_1) and arg_182_1.var_.characterEffect1284ui_story == nil then
				arg_182_1.var_.characterEffect1284ui_story = var_185_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_2 = 0.200000002980232

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_2 and not isNil(var_185_1) then
				if arg_182_1.var_.characterEffect1284ui_story and not isNil(var_185_1) then
					arg_182_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_182_1.time_ >= 0 + var_185_2 and arg_182_1.time_ < 0 + var_185_2 + arg_185_0 and not isNil(var_185_1) and arg_182_1.var_.characterEffect1284ui_story then
				arg_182_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action5_1")
			end

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_185_4 = 0
			local var_185_5 = 0.375

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_4 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_6 = arg_182_1:GetWordFromCfg(322021046)
				local var_185_7 = arg_182_1:FormatText(var_185_6.content)

				arg_182_1.text_.text = var_185_7

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_9 = 15 <= 0 and var_185_5 or var_185_5 * (utf8.len(var_185_7) / 15)

				if (15 <= 0 and var_185_5 or var_185_5 * (utf8.len(var_185_7) / 15)) > 0 and var_185_5 < var_185_9 then
					arg_182_1.talkMaxDuration = var_185_9

					if var_185_9 + var_185_4 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_9 + var_185_4
					end
				end

				arg_182_1.text_.text = var_185_7
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021046", "story_v_out_322021.awb") ~= 0 then
					local var_185_10 = manager.audio:GetVoiceLength("story_v_out_322021", "322021046", "story_v_out_322021.awb") / 1000

					if var_185_10 + var_185_4 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_10 + var_185_4
					end

					if var_185_6.prefab_name ~= "" and arg_182_1.actors_[var_185_6.prefab_name] ~= nil then
						local var_185_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_6.prefab_name].transform, "story_v_out_322021", "322021046", "story_v_out_322021.awb")

						arg_182_1:RecordAudio("322021046", var_185_11)
						arg_182_1:RecordAudio("322021046", var_185_11)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_322021", "322021046", "story_v_out_322021.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_322021", "322021046", "story_v_out_322021.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_12 = math.max(var_185_5, arg_182_1.talkMaxDuration)

			if var_185_4 <= arg_182_1.time_ and arg_182_1.time_ < var_185_4 + var_185_12 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_4) / var_185_12

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_4 + var_185_12 and arg_182_1.time_ < var_185_4 + var_185_12 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_182_1:InitPlayNodeList()
	end,
	Play322021047 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 322021047
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play322021048(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(arg_186_1.actors_["1284ui_story"]) and arg_186_1.var_.characterEffect1284ui_story == nil then
				arg_186_1.var_.characterEffect1284ui_story = arg_186_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_0 = 0.200000002980232

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 and not isNil(arg_186_1.actors_["1284ui_story"]) then
				if arg_186_1.var_.characterEffect1284ui_story and not isNil(arg_186_1.actors_["1284ui_story"]) then
					arg_186_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_186_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_186_1.time_ - 0) / var_189_0)
				end
			end

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 and not isNil(arg_186_1.actors_["1284ui_story"]) and arg_186_1.var_.characterEffect1284ui_story then
				arg_186_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_186_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			local var_189_1 = 0
			local var_189_2 = 0.7

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, true)
				arg_186_1.iconController_:SetSelectedState("hero")

				arg_186_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_186_1.callingController_:SetSelectedState("normal")

				arg_186_1.keyicon_.color = Color.New(1, 1, 1)
				arg_186_1.icon_.color = Color.New(1, 1, 1)

				local var_189_3 = arg_186_1:FormatText(arg_186_1:GetWordFromCfg(322021047).content)

				arg_186_1.text_.text = var_189_3

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_5 = 28 <= 0 and var_189_2 or var_189_2 * (utf8.len(var_189_3) / 28)

				if (28 <= 0 and var_189_2 or var_189_2 * (utf8.len(var_189_3) / 28)) > 0 and var_189_2 < var_189_5 then
					arg_186_1.talkMaxDuration = var_189_5

					if var_189_5 + var_189_1 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_5 + var_189_1
					end
				end

				arg_186_1.text_.text = var_189_3
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_6 = math.max(var_189_2, arg_186_1.talkMaxDuration)

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_6 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_1) / var_189_6

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_1 + var_189_6 and arg_186_1.time_ < var_189_1 + var_189_6 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play322021048 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 322021048
		arg_190_1.duration_ = 4.23

		local var_190_0 = {
			zh = 4.233,
			ja = 3.7
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play322021049(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(arg_190_1.actors_["1284ui_story"]) and arg_190_1.var_.characterEffect1284ui_story == nil then
				arg_190_1.var_.characterEffect1284ui_story = arg_190_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_0 = 0.200000002980232

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 and not isNil(arg_190_1.actors_["1284ui_story"]) then
				if arg_190_1.var_.characterEffect1284ui_story and not isNil(arg_190_1.actors_["1284ui_story"]) then
					arg_190_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 and not isNil(arg_190_1.actors_["1284ui_story"]) and arg_190_1.var_.characterEffect1284ui_story then
				arg_190_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action5_2")
			end

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_193_2 = 0
			local var_193_3 = 0.175

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_2 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_4 = arg_190_1:GetWordFromCfg(322021048)
				local var_193_5 = arg_190_1:FormatText(var_193_4.content)

				arg_190_1.text_.text = var_193_5

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_7 = 7 <= 0 and var_193_3 or var_193_3 * (utf8.len(var_193_5) / 7)

				if (7 <= 0 and var_193_3 or var_193_3 * (utf8.len(var_193_5) / 7)) > 0 and var_193_3 < var_193_7 then
					arg_190_1.talkMaxDuration = var_193_7

					if var_193_7 + var_193_2 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_7 + var_193_2
					end
				end

				arg_190_1.text_.text = var_193_5
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021048", "story_v_out_322021.awb") ~= 0 then
					local var_193_8 = manager.audio:GetVoiceLength("story_v_out_322021", "322021048", "story_v_out_322021.awb") / 1000

					if var_193_8 + var_193_2 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_8 + var_193_2
					end

					if var_193_4.prefab_name ~= "" and arg_190_1.actors_[var_193_4.prefab_name] ~= nil then
						local var_193_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_4.prefab_name].transform, "story_v_out_322021", "322021048", "story_v_out_322021.awb")

						arg_190_1:RecordAudio("322021048", var_193_9)
						arg_190_1:RecordAudio("322021048", var_193_9)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_322021", "322021048", "story_v_out_322021.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_322021", "322021048", "story_v_out_322021.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_10 = math.max(var_193_3, arg_190_1.talkMaxDuration)

			if var_193_2 <= arg_190_1.time_ and arg_190_1.time_ < var_193_2 + var_193_10 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_2) / var_193_10

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_2 + var_193_10 and arg_190_1.time_ < var_193_2 + var_193_10 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play322021049 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 322021049
		arg_194_1.duration_ = 10.6

		local var_194_0 = {
			zh = 9.233,
			ja = 10.6
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play322021050(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if arg_194_1.actors_["1211ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1211ui_story"))) then
				local var_197_0 = Object.Instantiate(Asset.Load("Char/" .. "1211ui_story"), arg_194_1.stage_.transform)

				var_197_0.name = "1211ui_story"
				var_197_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_194_1.actors_["1211ui_story"] = var_197_0

				local var_197_1 = var_197_0:GetComponentInChildren(typeof(CharacterEffect))

				var_197_1.enabled = true

				local var_197_2 = GameObjectTools.GetOrAddComponent(var_197_0, typeof(DynamicBoneHelper))

				if var_197_2 then
					var_197_2:EnableDynamicBone(false)
				end

				arg_194_1:ShowWeapon(var_197_1.transform, false)

				arg_194_1.var_["1211ui_story" .. "Animator"] = var_197_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_194_1.var_["1211ui_story" .. "Animator"].applyRootMotion = true
				arg_194_1.var_["1211ui_story" .. "LipSync"] = var_197_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_197_3 = arg_194_1.actors_["1211ui_story"].transform

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.var_.moveOldPos1211ui_story = var_197_3.localPosition

				arg_194_1:ShowWeapon(arg_194_1.var_["1211ui_story" .. "Animator"].transform, false)
			end

			local var_197_4 = 0.001

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_4 then
				var_197_3.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos1211ui_story, Vector3.New(0.7, -0.67, -6.07), (arg_194_1.time_ - 0) / var_197_4)
				var_197_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_197_3.position).x, (manager.ui.mainCamera.transform.position - var_197_3.position).y, (manager.ui.mainCamera.transform.position - var_197_3.position).z)
				var_197_3.localEulerAngles.z = 0
				var_197_3.localEulerAngles.x = 0
				var_197_3.localEulerAngles = var_197_3.localEulerAngles
			end

			if arg_194_1.time_ >= 0 + var_197_4 and arg_194_1.time_ < 0 + var_197_4 + arg_197_0 then
				var_197_3.localPosition = Vector3.New(0.7, -0.67, -6.07)
				var_197_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_197_3.position).x, (manager.ui.mainCamera.transform.position - var_197_3.position).y, (manager.ui.mainCamera.transform.position - var_197_3.position).z)
				var_197_3.localEulerAngles.z = 0
				var_197_3.localEulerAngles.x = 0
				var_197_3.localEulerAngles = var_197_3.localEulerAngles
			end

			local var_197_5 = arg_194_1.actors_["1284ui_story"].transform

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.var_.moveOldPos1284ui_story = var_197_5.localPosition
			end

			local var_197_6 = 0.001

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_6 then
				var_197_5.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos1284ui_story, Vector3.New(-0.7, -0.985, -6.22), (arg_194_1.time_ - 0) / var_197_6)
				var_197_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_197_5.position).x, (manager.ui.mainCamera.transform.position - var_197_5.position).y, (manager.ui.mainCamera.transform.position - var_197_5.position).z)
				var_197_5.localEulerAngles.z = 0
				var_197_5.localEulerAngles.x = 0
				var_197_5.localEulerAngles = var_197_5.localEulerAngles
			end

			if arg_194_1.time_ >= 0 + var_197_6 and arg_194_1.time_ < 0 + var_197_6 + arg_197_0 then
				var_197_5.localPosition = Vector3.New(-0.7, -0.985, -6.22)
				var_197_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_197_5.position).x, (manager.ui.mainCamera.transform.position - var_197_5.position).y, (manager.ui.mainCamera.transform.position - var_197_5.position).z)
				var_197_5.localEulerAngles.z = 0
				var_197_5.localEulerAngles.x = 0
				var_197_5.localEulerAngles = var_197_5.localEulerAngles
			end

			local var_197_7 = arg_194_1.actors_["1211ui_story"]

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(var_197_7) and arg_194_1.var_.characterEffect1211ui_story == nil then
				arg_194_1.var_.characterEffect1211ui_story = var_197_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_8 = 0.200000002980232

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_8 and not isNil(var_197_7) then
				if arg_194_1.var_.characterEffect1211ui_story and not isNil(var_197_7) then
					arg_194_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= 0 + var_197_8 and arg_194_1.time_ < 0 + var_197_8 + arg_197_0 and not isNil(var_197_7) and arg_194_1.var_.characterEffect1211ui_story then
				arg_194_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_197_10 = arg_194_1.actors_["1284ui_story"]

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(var_197_10) and arg_194_1.var_.characterEffect1284ui_story == nil then
				arg_194_1.var_.characterEffect1284ui_story = var_197_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_11 = 0.200000002980232

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_11 and not isNil(var_197_10) then
				if arg_194_1.var_.characterEffect1284ui_story and not isNil(var_197_10) then
					arg_194_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_194_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_194_1.time_ - 0) / var_197_11)
				end
			end

			if arg_194_1.time_ >= 0 + var_197_11 and arg_194_1.time_ < 0 + var_197_11 + arg_197_0 and not isNil(var_197_10) and arg_194_1.var_.characterEffect1284ui_story then
				arg_194_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_194_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_197_12 = 0
			local var_197_13 = 1.075

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_12 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_14 = arg_194_1:GetWordFromCfg(322021049)
				local var_197_15 = arg_194_1:FormatText(var_197_14.content)

				arg_194_1.text_.text = var_197_15

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_17 = 43 <= 0 and var_197_13 or var_197_13 * (utf8.len(var_197_15) / 43)

				if (43 <= 0 and var_197_13 or var_197_13 * (utf8.len(var_197_15) / 43)) > 0 and var_197_13 < var_197_17 then
					arg_194_1.talkMaxDuration = var_197_17

					if var_197_17 + var_197_12 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_17 + var_197_12
					end
				end

				arg_194_1.text_.text = var_197_15
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021049", "story_v_out_322021.awb") ~= 0 then
					local var_197_18 = manager.audio:GetVoiceLength("story_v_out_322021", "322021049", "story_v_out_322021.awb") / 1000

					if var_197_18 + var_197_12 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_18 + var_197_12
					end

					if var_197_14.prefab_name ~= "" and arg_194_1.actors_[var_197_14.prefab_name] ~= nil then
						local var_197_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_14.prefab_name].transform, "story_v_out_322021", "322021049", "story_v_out_322021.awb")

						arg_194_1:RecordAudio("322021049", var_197_19)
						arg_194_1:RecordAudio("322021049", var_197_19)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_322021", "322021049", "story_v_out_322021.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_322021", "322021049", "story_v_out_322021.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_20 = math.max(var_197_13, arg_194_1.talkMaxDuration)

			if var_197_12 <= arg_194_1.time_ and arg_194_1.time_ < var_197_12 + var_197_20 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_12) / var_197_20

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_12 + var_197_20 and arg_194_1.time_ < var_197_12 + var_197_20 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_194_1:InitPlayNodeList()
	end,
	Play322021050 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 322021050
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play322021051(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(arg_198_1.actors_["1211ui_story"]) and arg_198_1.var_.characterEffect1211ui_story == nil then
				arg_198_1.var_.characterEffect1211ui_story = arg_198_1.actors_["1211ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_0 = 0.200000002980232

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 and not isNil(arg_198_1.actors_["1211ui_story"]) then
				if arg_198_1.var_.characterEffect1211ui_story and not isNil(arg_198_1.actors_["1211ui_story"]) then
					arg_198_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_198_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_198_1.time_ - 0) / var_201_0)
				end
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 and not isNil(arg_198_1.actors_["1211ui_story"]) and arg_198_1.var_.characterEffect1211ui_story then
				arg_198_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_198_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			local var_201_1 = 0
			local var_201_2 = 1.25

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, true)
				arg_198_1.iconController_:SetSelectedState("hero")

				arg_198_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_198_1.callingController_:SetSelectedState("normal")

				arg_198_1.keyicon_.color = Color.New(1, 1, 1)
				arg_198_1.icon_.color = Color.New(1, 1, 1)

				local var_201_3 = arg_198_1:FormatText(arg_198_1:GetWordFromCfg(322021050).content)

				arg_198_1.text_.text = var_201_3

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_5 = 50 <= 0 and var_201_2 or var_201_2 * (utf8.len(var_201_3) / 50)

				if (50 <= 0 and var_201_2 or var_201_2 * (utf8.len(var_201_3) / 50)) > 0 and var_201_2 < var_201_5 then
					arg_198_1.talkMaxDuration = var_201_5

					if var_201_5 + var_201_1 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_5 + var_201_1
					end
				end

				arg_198_1.text_.text = var_201_3
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_6 = math.max(var_201_2, arg_198_1.talkMaxDuration)

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_6 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_1) / var_201_6

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_1 + var_201_6 and arg_198_1.time_ < var_201_1 + var_201_6 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play322021051 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 322021051
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play322021052(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = 1.075

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, true)
				arg_202_1.iconController_:SetSelectedState("hero")

				arg_202_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_202_1.callingController_:SetSelectedState("normal")

				arg_202_1.keyicon_.color = Color.New(1, 1, 1)
				arg_202_1.icon_.color = Color.New(1, 1, 1)

				local var_205_1 = arg_202_1:FormatText(arg_202_1:GetWordFromCfg(322021051).content)

				arg_202_1.text_.text = var_205_1

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_3 = 43 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_1) / 43)

				if (43 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_1) / 43)) > 0 and var_205_0 < var_205_3 then
					arg_202_1.talkMaxDuration = var_205_3

					if var_205_3 + 0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_3 + 0
					end
				end

				arg_202_1.text_.text = var_205_1
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_4 = math.max(var_205_0, arg_202_1.talkMaxDuration)

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_4 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - 0) / var_205_4

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= 0 + var_205_4 and arg_202_1.time_ < 0 + var_205_4 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play322021052 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 322021052
		arg_206_1.duration_ = 4.6

		local var_206_0 = {
			zh = 4.133,
			ja = 4.6
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play322021053(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.var_.moveOldPos1061ui_story = arg_206_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_209_0 = 0.001

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_0 then
				arg_206_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_206_1.time_ - 0) / var_209_0)
				arg_206_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_206_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1061ui_story"].transform.position).z)
				arg_206_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_206_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_206_1.actors_["1061ui_story"].transform.localEulerAngles = arg_206_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_206_1.time_ >= 0 + var_209_0 and arg_206_1.time_ < 0 + var_209_0 + arg_209_0 then
				arg_206_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_206_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_206_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1061ui_story"].transform.position).z)
				arg_206_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_206_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_206_1.actors_["1061ui_story"].transform.localEulerAngles = arg_206_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_209_1 = arg_206_1.actors_["1284ui_story"].transform

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.var_.moveOldPos1284ui_story = var_209_1.localPosition
			end

			local var_209_2 = 0.001

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_2 then
				var_209_1.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_206_1.time_ - 0) / var_209_2)
				var_209_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_209_1.position).x, (manager.ui.mainCamera.transform.position - var_209_1.position).y, (manager.ui.mainCamera.transform.position - var_209_1.position).z)
				var_209_1.localEulerAngles.z = 0
				var_209_1.localEulerAngles.x = 0
				var_209_1.localEulerAngles = var_209_1.localEulerAngles
			end

			if arg_206_1.time_ >= 0 + var_209_2 and arg_206_1.time_ < 0 + var_209_2 + arg_209_0 then
				var_209_1.localPosition = Vector3.New(0, 100, 0)
				var_209_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_209_1.position).x, (manager.ui.mainCamera.transform.position - var_209_1.position).y, (manager.ui.mainCamera.transform.position - var_209_1.position).z)
				var_209_1.localEulerAngles.z = 0
				var_209_1.localEulerAngles.x = 0
				var_209_1.localEulerAngles = var_209_1.localEulerAngles
			end

			local var_209_3 = arg_206_1.actors_["1211ui_story"].transform

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.var_.moveOldPos1211ui_story = var_209_3.localPosition
			end

			local var_209_4 = 0.001

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_4 then
				var_209_3.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_206_1.time_ - 0) / var_209_4)
				var_209_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_209_3.position).x, (manager.ui.mainCamera.transform.position - var_209_3.position).y, (manager.ui.mainCamera.transform.position - var_209_3.position).z)
				var_209_3.localEulerAngles.z = 0
				var_209_3.localEulerAngles.x = 0
				var_209_3.localEulerAngles = var_209_3.localEulerAngles
			end

			if arg_206_1.time_ >= 0 + var_209_4 and arg_206_1.time_ < 0 + var_209_4 + arg_209_0 then
				var_209_3.localPosition = Vector3.New(0, 100, 0)
				var_209_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_209_3.position).x, (manager.ui.mainCamera.transform.position - var_209_3.position).y, (manager.ui.mainCamera.transform.position - var_209_3.position).z)
				var_209_3.localEulerAngles.z = 0
				var_209_3.localEulerAngles.x = 0
				var_209_3.localEulerAngles = var_209_3.localEulerAngles
			end

			local var_209_5 = arg_206_1.actors_["1061ui_story"]

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(var_209_5) and arg_206_1.var_.characterEffect1061ui_story == nil then
				arg_206_1.var_.characterEffect1061ui_story = var_209_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_6 = 0.200000002980232

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_6 and not isNil(var_209_5) then
				if arg_206_1.var_.characterEffect1061ui_story and not isNil(var_209_5) then
					arg_206_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_206_1.time_ >= 0 + var_209_6 and arg_206_1.time_ < 0 + var_209_6 + arg_209_0 and not isNil(var_209_5) and arg_206_1.var_.characterEffect1061ui_story then
				arg_206_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_209_8 = 0
			local var_209_9 = 0.475

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_8 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_10 = arg_206_1:GetWordFromCfg(322021052)
				local var_209_11 = arg_206_1:FormatText(var_209_10.content)

				arg_206_1.text_.text = var_209_11

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_13 = 19 <= 0 and var_209_9 or var_209_9 * (utf8.len(var_209_11) / 19)

				if (19 <= 0 and var_209_9 or var_209_9 * (utf8.len(var_209_11) / 19)) > 0 and var_209_9 < var_209_13 then
					arg_206_1.talkMaxDuration = var_209_13

					if var_209_13 + var_209_8 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_13 + var_209_8
					end
				end

				arg_206_1.text_.text = var_209_11
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021052", "story_v_out_322021.awb") ~= 0 then
					local var_209_14 = manager.audio:GetVoiceLength("story_v_out_322021", "322021052", "story_v_out_322021.awb") / 1000

					if var_209_14 + var_209_8 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_14 + var_209_8
					end

					if var_209_10.prefab_name ~= "" and arg_206_1.actors_[var_209_10.prefab_name] ~= nil then
						local var_209_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_10.prefab_name].transform, "story_v_out_322021", "322021052", "story_v_out_322021.awb")

						arg_206_1:RecordAudio("322021052", var_209_15)
						arg_206_1:RecordAudio("322021052", var_209_15)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_322021", "322021052", "story_v_out_322021.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_322021", "322021052", "story_v_out_322021.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_16 = math.max(var_209_9, arg_206_1.talkMaxDuration)

			if var_209_8 <= arg_206_1.time_ and arg_206_1.time_ < var_209_8 + var_209_16 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_8) / var_209_16

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_8 + var_209_16 and arg_206_1.time_ < var_209_8 + var_209_16 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_206_1:InitPlayNodeList()
	end,
	Play322021053 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 322021053
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play322021054(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.var_.moveOldPos1061ui_story = arg_210_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_213_0 = 0.001

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 then
				arg_210_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_210_1.time_ - 0) / var_213_0)
				arg_210_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_210_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["1061ui_story"].transform.position).z)
				arg_210_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_210_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_210_1.actors_["1061ui_story"].transform.localEulerAngles = arg_210_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 then
				arg_210_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_210_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_210_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["1061ui_story"].transform.position).z)
				arg_210_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_210_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_210_1.actors_["1061ui_story"].transform.localEulerAngles = arg_210_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_213_1 = 0
			local var_213_2 = 0.475

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, true)
				arg_210_1.iconController_:SetSelectedState("hero")

				arg_210_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_210_1.callingController_:SetSelectedState("normal")

				arg_210_1.keyicon_.color = Color.New(1, 1, 1)
				arg_210_1.icon_.color = Color.New(1, 1, 1)

				local var_213_3 = arg_210_1:FormatText(arg_210_1:GetWordFromCfg(322021053).content)

				arg_210_1.text_.text = var_213_3

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_5 = 19 <= 0 and var_213_2 or var_213_2 * (utf8.len(var_213_3) / 19)

				if (19 <= 0 and var_213_2 or var_213_2 * (utf8.len(var_213_3) / 19)) > 0 and var_213_2 < var_213_5 then
					arg_210_1.talkMaxDuration = var_213_5

					if var_213_5 + var_213_1 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_5 + var_213_1
					end
				end

				arg_210_1.text_.text = var_213_3
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_6 = math.max(var_213_2, arg_210_1.talkMaxDuration)

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_6 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_1) / var_213_6

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_1 + var_213_6 and arg_210_1.time_ < var_213_1 + var_213_6 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_210_1:InitPlayNodeList()
	end,
	Play322021054 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 322021054
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play322021055(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0.975

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_1 = arg_214_1:FormatText(arg_214_1:GetWordFromCfg(322021054).content)

				arg_214_1.text_.text = var_217_1

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_3 = 39 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_1) / 39)

				if (39 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_1) / 39)) > 0 and var_217_0 < var_217_3 then
					arg_214_1.talkMaxDuration = var_217_3

					if var_217_3 + 0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_3 + 0
					end
				end

				arg_214_1.text_.text = var_217_1
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_4 = math.max(var_217_0, arg_214_1.talkMaxDuration)

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_4 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - 0) / var_217_4

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= 0 + var_217_4 and arg_214_1.time_ < 0 + var_217_4 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play322021055 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 322021055
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play322021056(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 0.95

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, true)
				arg_218_1.iconController_:SetSelectedState("hero")

				arg_218_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_218_1.callingController_:SetSelectedState("normal")

				arg_218_1.keyicon_.color = Color.New(1, 1, 1)
				arg_218_1.icon_.color = Color.New(1, 1, 1)

				local var_221_1 = arg_218_1:FormatText(arg_218_1:GetWordFromCfg(322021055).content)

				arg_218_1.text_.text = var_221_1

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_3 = 38 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_1) / 38)

				if (38 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_1) / 38)) > 0 and var_221_0 < var_221_3 then
					arg_218_1.talkMaxDuration = var_221_3

					if var_221_3 + 0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_3 + 0
					end
				end

				arg_218_1.text_.text = var_221_1
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_4 = math.max(var_221_0, arg_218_1.talkMaxDuration)

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_4 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - 0) / var_221_4

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= 0 + var_221_4 and arg_218_1.time_ < 0 + var_221_4 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play322021056 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 322021056
		arg_222_1.duration_ = 4.3

		local var_222_0 = {
			zh = 2.7,
			ja = 4.3
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play322021057(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.var_.moveOldPos1211ui_story = arg_222_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_225_0 = 0.001

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_0 then
				arg_222_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos1211ui_story, Vector3.New(0, -0.67, -6.07), (arg_222_1.time_ - 0) / var_225_0)
				arg_222_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_222_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["1211ui_story"].transform.position).z)
				arg_222_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_222_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_222_1.actors_["1211ui_story"].transform.localEulerAngles = arg_222_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_222_1.time_ >= 0 + var_225_0 and arg_222_1.time_ < 0 + var_225_0 + arg_225_0 then
				arg_222_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(0, -0.67, -6.07)
				arg_222_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_222_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["1211ui_story"].transform.position).z)
				arg_222_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_222_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_222_1.actors_["1211ui_story"].transform.localEulerAngles = arg_222_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_225_1 = arg_222_1.actors_["1211ui_story"]

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(var_225_1) and arg_222_1.var_.characterEffect1211ui_story == nil then
				arg_222_1.var_.characterEffect1211ui_story = var_225_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_2 = 0.200000002980232

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_2 and not isNil(var_225_1) then
				if arg_222_1.var_.characterEffect1211ui_story and not isNil(var_225_1) then
					arg_222_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_222_1.time_ >= 0 + var_225_2 and arg_222_1.time_ < 0 + var_225_2 + arg_225_0 and not isNil(var_225_1) and arg_222_1.var_.characterEffect1211ui_story then
				arg_222_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action6_1")
			end

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileD", "EmotionTimelineAnimator")
			end

			local var_225_4 = 0
			local var_225_5 = 0.225

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_4 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_6 = arg_222_1:GetWordFromCfg(322021056)
				local var_225_7 = arg_222_1:FormatText(var_225_6.content)

				arg_222_1.text_.text = var_225_7

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_9 = 9 <= 0 and var_225_5 or var_225_5 * (utf8.len(var_225_7) / 9)

				if (9 <= 0 and var_225_5 or var_225_5 * (utf8.len(var_225_7) / 9)) > 0 and var_225_5 < var_225_9 then
					arg_222_1.talkMaxDuration = var_225_9

					if var_225_9 + var_225_4 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_9 + var_225_4
					end
				end

				arg_222_1.text_.text = var_225_7
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021056", "story_v_out_322021.awb") ~= 0 then
					local var_225_10 = manager.audio:GetVoiceLength("story_v_out_322021", "322021056", "story_v_out_322021.awb") / 1000

					if var_225_10 + var_225_4 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_10 + var_225_4
					end

					if var_225_6.prefab_name ~= "" and arg_222_1.actors_[var_225_6.prefab_name] ~= nil then
						local var_225_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_6.prefab_name].transform, "story_v_out_322021", "322021056", "story_v_out_322021.awb")

						arg_222_1:RecordAudio("322021056", var_225_11)
						arg_222_1:RecordAudio("322021056", var_225_11)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_322021", "322021056", "story_v_out_322021.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_322021", "322021056", "story_v_out_322021.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_12 = math.max(var_225_5, arg_222_1.talkMaxDuration)

			if var_225_4 <= arg_222_1.time_ and arg_222_1.time_ < var_225_4 + var_225_12 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_4) / var_225_12

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_4 + var_225_12 and arg_222_1.time_ < var_225_4 + var_225_12 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_222_1:InitPlayNodeList()
	end,
	Play322021057 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 322021057
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play322021058(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.var_.moveOldPos1211ui_story = arg_226_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_229_0 = 0.001

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_0 then
				arg_226_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_226_1.time_ - 0) / var_229_0)
				arg_226_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_226_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["1211ui_story"].transform.position).z)
				arg_226_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_226_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_226_1.actors_["1211ui_story"].transform.localEulerAngles = arg_226_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_226_1.time_ >= 0 + var_229_0 and arg_226_1.time_ < 0 + var_229_0 + arg_229_0 then
				arg_226_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_226_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_226_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["1211ui_story"].transform.position).z)
				arg_226_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_226_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_226_1.actors_["1211ui_story"].transform.localEulerAngles = arg_226_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_229_1 = 0
			local var_229_2 = 0.725

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, true)
				arg_226_1.iconController_:SetSelectedState("hero")

				arg_226_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_226_1.callingController_:SetSelectedState("normal")

				arg_226_1.keyicon_.color = Color.New(1, 1, 1)
				arg_226_1.icon_.color = Color.New(1, 1, 1)

				local var_229_3 = arg_226_1:FormatText(arg_226_1:GetWordFromCfg(322021057).content)

				arg_226_1.text_.text = var_229_3

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_5 = 29 <= 0 and var_229_2 or var_229_2 * (utf8.len(var_229_3) / 29)

				if (29 <= 0 and var_229_2 or var_229_2 * (utf8.len(var_229_3) / 29)) > 0 and var_229_2 < var_229_5 then
					arg_226_1.talkMaxDuration = var_229_5

					if var_229_5 + var_229_1 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_5 + var_229_1
					end
				end

				arg_226_1.text_.text = var_229_3
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_6 = math.max(var_229_2, arg_226_1.talkMaxDuration)

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_6 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_1) / var_229_6

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_1 + var_229_6 and arg_226_1.time_ < var_229_1 + var_229_6 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_226_1:InitPlayNodeList()
	end,
	Play322021058 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 322021058
		arg_230_1.duration_ = 5

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play322021059(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0.1 < arg_230_1.time_ and arg_230_1.time_ <= 0.1 + arg_233_0 then
				arg_230_1:AudioAction("play", "effect", "se_story_145", "se_story_145_clap", "")
			end

			local var_233_1 = 0
			local var_233_2 = 1.175

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, false)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_3 = arg_230_1:FormatText(arg_230_1:GetWordFromCfg(322021058).content)

				arg_230_1.text_.text = var_233_3

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_5 = 47 <= 0 and var_233_2 or var_233_2 * (utf8.len(var_233_3) / 47)

				if (47 <= 0 and var_233_2 or var_233_2 * (utf8.len(var_233_3) / 47)) > 0 and var_233_2 < var_233_5 then
					arg_230_1.talkMaxDuration = var_233_5

					if var_233_5 + var_233_1 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_5 + var_233_1
					end
				end

				arg_230_1.text_.text = var_233_3
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_6 = math.max(var_233_2, arg_230_1.talkMaxDuration)

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_6 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_1) / var_233_6

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_1 + var_233_6 and arg_230_1.time_ < var_233_1 + var_233_6 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play322021059 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 322021059
		arg_234_1.duration_ = 5

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play322021060(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = 0.25

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, true)
				arg_234_1.iconController_:SetSelectedState("hero")

				arg_234_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_234_1.callingController_:SetSelectedState("normal")

				arg_234_1.keyicon_.color = Color.New(1, 1, 1)
				arg_234_1.icon_.color = Color.New(1, 1, 1)

				local var_237_1 = arg_234_1:FormatText(arg_234_1:GetWordFromCfg(322021059).content)

				arg_234_1.text_.text = var_237_1

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_3 = 10 <= 0 and var_237_0 or var_237_0 * (utf8.len(var_237_1) / 10)

				if (10 <= 0 and var_237_0 or var_237_0 * (utf8.len(var_237_1) / 10)) > 0 and var_237_0 < var_237_3 then
					arg_234_1.talkMaxDuration = var_237_3

					if var_237_3 + 0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_3 + 0
					end
				end

				arg_234_1.text_.text = var_237_1
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_4 = math.max(var_237_0, arg_234_1.talkMaxDuration)

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_4 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - 0) / var_237_4

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= 0 + var_237_4 and arg_234_1.time_ < 0 + var_237_4 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play322021060 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 322021060
		arg_238_1.duration_ = 3.8

		local var_238_0 = {
			zh = 3.433,
			ja = 3.8
		}
		local var_238_1 = manager.audio:GetLocalizationFlag()

		if var_238_0[var_238_1] ~= nil then
			arg_238_1.duration_ = var_238_0[var_238_1]
		end

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play322021061(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.var_.moveOldPos1061ui_story = arg_238_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_241_0 = 0.001

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_0 then
				arg_238_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_238_1.time_ - 0) / var_241_0)
				arg_238_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_238_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["1061ui_story"].transform.position).z)
				arg_238_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_238_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_238_1.actors_["1061ui_story"].transform.localEulerAngles = arg_238_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_238_1.time_ >= 0 + var_241_0 and arg_238_1.time_ < 0 + var_241_0 + arg_241_0 then
				arg_238_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_238_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_238_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["1061ui_story"].transform.position).z)
				arg_238_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_238_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_238_1.actors_["1061ui_story"].transform.localEulerAngles = arg_238_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_241_1 = arg_238_1.actors_["1061ui_story"]

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(var_241_1) and arg_238_1.var_.characterEffect1061ui_story == nil then
				arg_238_1.var_.characterEffect1061ui_story = var_241_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_2 = 0.200000002980232

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_2 and not isNil(var_241_1) then
				if arg_238_1.var_.characterEffect1061ui_story and not isNil(var_241_1) then
					arg_238_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_238_1.time_ >= 0 + var_241_2 and arg_238_1.time_ < 0 + var_241_2 + arg_241_0 and not isNil(var_241_1) and arg_238_1.var_.characterEffect1061ui_story then
				arg_238_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_241_4 = 0
			local var_241_5 = 0.4

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_4 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_6 = arg_238_1:GetWordFromCfg(322021060)
				local var_241_7 = arg_238_1:FormatText(var_241_6.content)

				arg_238_1.text_.text = var_241_7

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_9 = 16 <= 0 and var_241_5 or var_241_5 * (utf8.len(var_241_7) / 16)

				if (16 <= 0 and var_241_5 or var_241_5 * (utf8.len(var_241_7) / 16)) > 0 and var_241_5 < var_241_9 then
					arg_238_1.talkMaxDuration = var_241_9

					if var_241_9 + var_241_4 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_9 + var_241_4
					end
				end

				arg_238_1.text_.text = var_241_7
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021060", "story_v_out_322021.awb") ~= 0 then
					local var_241_10 = manager.audio:GetVoiceLength("story_v_out_322021", "322021060", "story_v_out_322021.awb") / 1000

					if var_241_10 + var_241_4 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_10 + var_241_4
					end

					if var_241_6.prefab_name ~= "" and arg_238_1.actors_[var_241_6.prefab_name] ~= nil then
						local var_241_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_6.prefab_name].transform, "story_v_out_322021", "322021060", "story_v_out_322021.awb")

						arg_238_1:RecordAudio("322021060", var_241_11)
						arg_238_1:RecordAudio("322021060", var_241_11)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_322021", "322021060", "story_v_out_322021.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_322021", "322021060", "story_v_out_322021.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_12 = math.max(var_241_5, arg_238_1.talkMaxDuration)

			if var_241_4 <= arg_238_1.time_ and arg_238_1.time_ < var_241_4 + var_241_12 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_4) / var_241_12

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_4 + var_241_12 and arg_238_1.time_ < var_241_4 + var_241_12 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_238_1:InitPlayNodeList()
	end,
	Play322021061 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 322021061
		arg_242_1.duration_ = 6

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play322021062(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if arg_242_1.bgs_.L14f == nil then
				local var_245_0 = Object.Instantiate(arg_242_1.paintGo_)

				var_245_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L14f")
				var_245_0.name = "L14f"
				var_245_0.transform.parent = arg_242_1.stage_.transform
				var_245_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_242_1.bgs_.L14f = var_245_0
			end

			if 2 < arg_242_1.time_ and arg_242_1.time_ <= 2 + arg_245_0 then
				local var_245_1 = arg_242_1.bgs_.L14f

				arg_242_1.bgs_.L14f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_245_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_245_2 = var_245_1:GetComponent("SpriteRenderer")

				if var_245_2 and var_245_2.sprite then
					local var_245_3 = 2 * (var_245_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_245_1.transform.localScale = Vector3.New(var_245_3 / var_245_2.sprite.bounds.size.y < var_245_3 * manager.ui.mainCameraCom_.aspect / var_245_2.sprite.bounds.size.x and var_245_3 * manager.ui.mainCameraCom_.aspect / var_245_2.sprite.bounds.size.x or var_245_3 / var_245_2.sprite.bounds.size.y, var_245_3 / var_245_2.sprite.bounds.size.y < var_245_3 * manager.ui.mainCameraCom_.aspect / var_245_2.sprite.bounds.size.x and var_245_3 * manager.ui.mainCameraCom_.aspect / var_245_2.sprite.bounds.size.x or var_245_3 / var_245_2.sprite.bounds.size.y, 0)
				end

				for iter_245_0, iter_245_1 in pairs(arg_242_1.bgs_) do
					if iter_245_0 ~= "L14f" then
						iter_245_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_245_4 = 4

			if 4 < arg_242_1.time_ and arg_242_1.time_ <= var_245_4 + arg_245_0 then
				arg_242_1.allBtn_.enabled = false
			end

			if arg_242_1.time_ >= var_245_4 + 0.3 and arg_242_1.time_ < var_245_4 + 0.3 + arg_245_0 then
				arg_242_1.allBtn_.enabled = true
			end

			local var_245_5 = 0

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_5 + arg_245_0 then
				arg_242_1.mask_.enabled = true
				arg_242_1.mask_.raycastTarget = true

				arg_242_1:SetGaussion(false)
			end

			local var_245_6 = 2

			if var_245_5 <= arg_242_1.time_ and arg_242_1.time_ < var_245_5 + var_245_6 then
				local var_245_7 = Color.New(0, 0, 0)

				var_245_7.a = Mathf.Lerp(0, 1, (arg_242_1.time_ - var_245_5) / var_245_6)
				arg_242_1.mask_.color = var_245_7
			end

			if arg_242_1.time_ >= var_245_5 + var_245_6 and arg_242_1.time_ < var_245_5 + var_245_6 + arg_245_0 then
				local var_245_8 = Color.New(0, 0, 0)

				var_245_8.a = 1
				arg_242_1.mask_.color = var_245_8
			end

			local var_245_9 = 2

			if 2 < arg_242_1.time_ and arg_242_1.time_ <= var_245_9 + arg_245_0 then
				arg_242_1.mask_.enabled = true
				arg_242_1.mask_.raycastTarget = true

				arg_242_1:SetGaussion(false)
			end

			local var_245_10 = 2

			if var_245_9 <= arg_242_1.time_ and arg_242_1.time_ < var_245_9 + var_245_10 then
				local var_245_11 = Color.New(0, 0, 0)

				var_245_11.a = Mathf.Lerp(1, 0, (arg_242_1.time_ - var_245_9) / var_245_10)
				arg_242_1.mask_.color = var_245_11
			end

			if arg_242_1.time_ >= var_245_9 + var_245_10 and arg_242_1.time_ < var_245_9 + var_245_10 + arg_245_0 then
				local var_245_12 = Color.New(0, 0, 0)

				arg_242_1.mask_.enabled = false
				var_245_12.a = 0
				arg_242_1.mask_.color = var_245_12
			end

			local var_245_13 = arg_242_1.actors_["1061ui_story"].transform

			if 1.96599999815226 < arg_242_1.time_ and arg_242_1.time_ <= 1.96599999815226 + arg_245_0 then
				arg_242_1.var_.moveOldPos1061ui_story = var_245_13.localPosition
			end

			local var_245_14 = 0.001

			if 1.96599999815226 <= arg_242_1.time_ and arg_242_1.time_ < 1.96599999815226 + var_245_14 then
				var_245_13.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_242_1.time_ - 1.96599999815226) / var_245_14)
				var_245_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_245_13.position).x, (manager.ui.mainCamera.transform.position - var_245_13.position).y, (manager.ui.mainCamera.transform.position - var_245_13.position).z)
				var_245_13.localEulerAngles.z = 0
				var_245_13.localEulerAngles.x = 0
				var_245_13.localEulerAngles = var_245_13.localEulerAngles
			end

			if arg_242_1.time_ >= 1.96599999815226 + var_245_14 and arg_242_1.time_ < 1.96599999815226 + var_245_14 + arg_245_0 then
				var_245_13.localPosition = Vector3.New(0, 100, 0)
				var_245_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_245_13.position).x, (manager.ui.mainCamera.transform.position - var_245_13.position).y, (manager.ui.mainCamera.transform.position - var_245_13.position).z)
				var_245_13.localEulerAngles.z = 0
				var_245_13.localEulerAngles.x = 0
				var_245_13.localEulerAngles = var_245_13.localEulerAngles
			end

			local var_245_15 = "1043ui_story"

			if arg_242_1.actors_["1043ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1043ui_story"))) then
				local var_245_16 = Object.Instantiate(Asset.Load("Char/" .. "1043ui_story"), arg_242_1.stage_.transform)

				var_245_16.name = var_245_15
				var_245_16.transform.localPosition = Vector3.New(0, 100, 0)
				arg_242_1.actors_[var_245_15] = var_245_16

				local var_245_17 = var_245_16:GetComponentInChildren(typeof(CharacterEffect))

				var_245_17.enabled = true

				local var_245_18 = GameObjectTools.GetOrAddComponent(var_245_16, typeof(DynamicBoneHelper))

				if var_245_18 then
					var_245_18:EnableDynamicBone(false)
				end

				arg_242_1:ShowWeapon(var_245_17.transform, false)

				arg_242_1.var_[var_245_15 .. "Animator"] = var_245_17.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_242_1.var_[var_245_15 .. "Animator"].applyRootMotion = true
				arg_242_1.var_[var_245_15 .. "LipSync"] = var_245_17.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_245_19 = arg_242_1.actors_["1043ui_story"]

			if 1.96599999815226 < arg_242_1.time_ and arg_242_1.time_ <= 1.96599999815226 + arg_245_0 and not isNil(var_245_19) and arg_242_1.var_.characterEffect1043ui_story == nil then
				arg_242_1.var_.characterEffect1043ui_story = var_245_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_20 = 0.0166666666666667

			if 1.96599999815226 <= arg_242_1.time_ and arg_242_1.time_ < 1.96599999815226 + var_245_20 and not isNil(var_245_19) then
				if arg_242_1.var_.characterEffect1043ui_story and not isNil(var_245_19) then
					arg_242_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= 1.96599999815226 + var_245_20 and arg_242_1.time_ < 1.96599999815226 + var_245_20 + arg_245_0 and not isNil(var_245_19) and arg_242_1.var_.characterEffect1043ui_story then
				arg_242_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_245_22 = arg_242_1.actors_["1061ui_story"]

			if 1.96599999815226 < arg_242_1.time_ and arg_242_1.time_ <= 1.96599999815226 + arg_245_0 and not isNil(var_245_22) and arg_242_1.var_.characterEffect1061ui_story == nil then
				arg_242_1.var_.characterEffect1061ui_story = var_245_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_23 = 0.034000001847744

			if 1.96599999815226 <= arg_242_1.time_ and arg_242_1.time_ < 1.96599999815226 + var_245_23 and not isNil(var_245_22) then
				if arg_242_1.var_.characterEffect1061ui_story and not isNil(var_245_22) then
					arg_242_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_242_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_242_1.time_ - 1.96599999815226) / var_245_23)
				end
			end

			if arg_242_1.time_ >= 1.96599999815226 + var_245_23 and arg_242_1.time_ < 1.96599999815226 + var_245_23 + arg_245_0 and not isNil(var_245_22) and arg_242_1.var_.characterEffect1061ui_story then
				arg_242_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_242_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0.1 < arg_242_1.time_ and arg_242_1.time_ <= 0.1 + arg_245_0 then
				arg_242_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_lab", "")
			end

			if 1.5 < arg_242_1.time_ and arg_242_1.time_ <= 1.5 + arg_245_0 then
				arg_242_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_construction", "")
			end

			local var_245_26 = arg_242_1.actors_["1043ui_story"].transform

			if 4 < arg_242_1.time_ and arg_242_1.time_ <= 4 + arg_245_0 then
				arg_242_1.var_.moveOldPos1043ui_story = var_245_26.localPosition
			end

			local var_245_27 = 0.001

			if 4 <= arg_242_1.time_ and arg_242_1.time_ < 4 + var_245_27 then
				var_245_26.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos1043ui_story, Vector3.New(0.01, -1.01, -5.73), (arg_242_1.time_ - 4) / var_245_27)
				var_245_26.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_245_26.position).x, (manager.ui.mainCamera.transform.position - var_245_26.position).y, (manager.ui.mainCamera.transform.position - var_245_26.position).z)
				var_245_26.localEulerAngles.z = 0
				var_245_26.localEulerAngles.x = 0
				var_245_26.localEulerAngles = var_245_26.localEulerAngles
			end

			if arg_242_1.time_ >= 4 + var_245_27 and arg_242_1.time_ < 4 + var_245_27 + arg_245_0 then
				var_245_26.localPosition = Vector3.New(0.01, -1.01, -5.73)
				var_245_26.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_245_26.position).x, (manager.ui.mainCamera.transform.position - var_245_26.position).y, (manager.ui.mainCamera.transform.position - var_245_26.position).z)
				var_245_26.localEulerAngles.z = 0
				var_245_26.localEulerAngles.x = 0
				var_245_26.localEulerAngles = var_245_26.localEulerAngles
			end

			local var_245_28 = arg_242_1.actors_["1043ui_story"]

			if 4 < arg_242_1.time_ and arg_242_1.time_ <= 4 + arg_245_0 and not isNil(var_245_28) and arg_242_1.var_.characterEffect1043ui_story == nil then
				arg_242_1.var_.characterEffect1043ui_story = var_245_28:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_29 = 0.200000002980232

			if 4 <= arg_242_1.time_ and arg_242_1.time_ < 4 + var_245_29 and not isNil(var_245_28) then
				if arg_242_1.var_.characterEffect1043ui_story and not isNil(var_245_28) then
					arg_242_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= 4 + var_245_29 and arg_242_1.time_ < 4 + var_245_29 + arg_245_0 and not isNil(var_245_28) and arg_242_1.var_.characterEffect1043ui_story then
				arg_242_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			if 4 < arg_242_1.time_ and arg_242_1.time_ <= 4 + arg_245_0 then
				arg_242_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			if 4 < arg_242_1.time_ and arg_242_1.time_ <= 4 + arg_245_0 then
				arg_242_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 1.5 < arg_242_1.time_ and arg_242_1.time_ <= 1.5 + arg_245_0 then
				arg_242_1:AudioAction("play", "music", "bgm_activity_4_5_story_serious", "battle", "bgm_activity_4_5_story_serious.awb")

				local var_245_33 = manager.audio:GetAudioName("bgm_activity_4_5_story_serious", "battle")

				if "" ~= "" then
					if arg_242_1.bgmTxt_.text ~= var_245_33 and arg_242_1.bgmTxt_.text ~= "" then
						if arg_242_1.bgmTxt2_.text ~= "" then
							arg_242_1.bgmTxt_.text = arg_242_1.bgmTxt2_.text
						end

						arg_242_1.bgmTxt2_.text = var_245_33

						arg_242_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_242_1.bgmTxt_.text = var_245_33
						arg_242_1.bgmTxt2_.text = var_245_33
					end

					if arg_242_1.bgmTimer then
						arg_242_1.bgmTimer:Stop()

						arg_242_1.bgmTimer = nil
					end

					if arg_242_1.settingData.show_music_name == 1 then
						arg_242_1.musicController:SetSelectedState("show")
						arg_242_1.musicAnimator_:Play("open", 0, 0)

						if arg_242_1.settingData.music_time ~= 0 then
							arg_242_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_242_1.settingData.music_time), function()
								if arg_242_1 == nil or isNil(arg_242_1.bgmTxt_) then
									return
								end

								arg_242_1.musicController:SetSelectedState("hide")
								arg_242_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_242_1.frameCnt_ <= 1 then
				arg_242_1.dialog_:SetActive(false)
			end

			local var_245_34 = 4
			local var_245_35 = 0.1

			if 4 < arg_242_1.time_ and arg_242_1.time_ <= var_245_34 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0

				arg_242_1.dialog_:SetActive(true)

				arg_242_1.dialogCg_.alpha = 0

				local var_245_36 = LeanTween.value(arg_242_1.dialog_, 0, 1, 0.3)

				var_245_36:setOnUpdate(LuaHelper.FloatAction(function(arg_247_0)
					arg_242_1.dialogCg_.alpha = arg_247_0
				end))
				var_245_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_242_1.dialog_)
					var_245_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_242_1.duration_ = arg_242_1.duration_ + 0.3

				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_37 = arg_242_1:GetWordFromCfg(322021061)
				local var_245_38 = arg_242_1:FormatText(var_245_37.content)

				arg_242_1.text_.text = var_245_38

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_40 = 4 <= 0 and var_245_35 or var_245_35 * (utf8.len(var_245_38) / 4)

				if (4 <= 0 and var_245_35 or var_245_35 * (utf8.len(var_245_38) / 4)) > 0 and var_245_35 < var_245_40 then
					arg_242_1.talkMaxDuration = var_245_40
					var_245_34 = var_245_34 + 0.3

					if var_245_40 + var_245_34 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_40 + var_245_34
					end
				end

				arg_242_1.text_.text = var_245_38
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021061", "story_v_out_322021.awb") ~= 0 then
					local var_245_41 = manager.audio:GetVoiceLength("story_v_out_322021", "322021061", "story_v_out_322021.awb") / 1000

					if var_245_41 + var_245_34 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_41 + var_245_34
					end

					if var_245_37.prefab_name ~= "" and arg_242_1.actors_[var_245_37.prefab_name] ~= nil then
						local var_245_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_37.prefab_name].transform, "story_v_out_322021", "322021061", "story_v_out_322021.awb")

						arg_242_1:RecordAudio("322021061", var_245_42)
						arg_242_1:RecordAudio("322021061", var_245_42)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_322021", "322021061", "story_v_out_322021.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_322021", "322021061", "story_v_out_322021.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_43 = var_245_34 + 0.3
			local var_245_44 = math.max(var_245_35, arg_242_1.talkMaxDuration)

			if var_245_34 + 0.3 <= arg_242_1.time_ and arg_242_1.time_ < var_245_43 + var_245_44 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_43) / var_245_44

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_43 + var_245_44 and arg_242_1.time_ < var_245_43 + var_245_44 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play322021062 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 322021062
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play322021063(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos1043ui_story = arg_249_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_252_0 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 then
				arg_249_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_249_1.time_ - 0) / var_252_0)
				arg_249_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1043ui_story"].transform.position).z)
				arg_249_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["1043ui_story"].transform.localEulerAngles = arg_249_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 then
				arg_249_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_249_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1043ui_story"].transform.position).z)
				arg_249_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["1043ui_story"].transform.localEulerAngles = arg_249_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_252_1 = 0
			local var_252_2 = 1.575

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, false)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_3 = arg_249_1:FormatText(arg_249_1:GetWordFromCfg(322021062).content)

				arg_249_1.text_.text = var_252_3

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_5 = 63 <= 0 and var_252_2 or var_252_2 * (utf8.len(var_252_3) / 63)

				if (63 <= 0 and var_252_2 or var_252_2 * (utf8.len(var_252_3) / 63)) > 0 and var_252_2 < var_252_5 then
					arg_249_1.talkMaxDuration = var_252_5

					if var_252_5 + var_252_1 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_5 + var_252_1
					end
				end

				arg_249_1.text_.text = var_252_3
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_6 = math.max(var_252_2, arg_249_1.talkMaxDuration)

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_6 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_1) / var_252_6

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_1 + var_252_6 and arg_249_1.time_ < var_252_1 + var_252_6 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_249_1:InitPlayNodeList()
	end,
	Play322021063 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 322021063
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play322021064(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 1.75

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_1 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(322021063).content)

				arg_253_1.text_.text = var_256_1

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_3 = 70 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_1) / 70)

				if (70 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_1) / 70)) > 0 and var_256_0 < var_256_3 then
					arg_253_1.talkMaxDuration = var_256_3

					if var_256_3 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_3 + 0
					end
				end

				arg_253_1.text_.text = var_256_1
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_4 = math.max(var_256_0, arg_253_1.talkMaxDuration)

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_4 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - 0) / var_256_4

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= 0 + var_256_4 and arg_253_1.time_ < 0 + var_256_4 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play322021064 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 322021064
		arg_257_1.duration_ = 5.13

		local var_257_0 = {
			zh = 3.7,
			ja = 5.133
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
				arg_257_0:Play322021065(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if arg_257_1.actors_["404001ui_story"] == nil and not isNil((Asset.Load("Char/" .. "404001ui_story"))) then
				local var_260_0 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_257_1.stage_.transform)

				var_260_0.name = "404001ui_story"
				var_260_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_257_1.actors_["404001ui_story"] = var_260_0

				local var_260_1 = var_260_0:GetComponentInChildren(typeof(CharacterEffect))

				var_260_1.enabled = true

				local var_260_2 = GameObjectTools.GetOrAddComponent(var_260_0, typeof(DynamicBoneHelper))

				if var_260_2 then
					var_260_2:EnableDynamicBone(false)
				end

				arg_257_1:ShowWeapon(var_260_1.transform, false)

				arg_257_1.var_["404001ui_story" .. "Animator"] = var_260_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_257_1.var_["404001ui_story" .. "Animator"].applyRootMotion = true
				arg_257_1.var_["404001ui_story" .. "LipSync"] = var_260_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_260_3 = arg_257_1.actors_["404001ui_story"].transform

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos404001ui_story = var_260_3.localPosition
			end

			local var_260_4 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_4 then
				var_260_3.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos404001ui_story, Vector3.New(-0.8, -1.55, -5.5), (arg_257_1.time_ - 0) / var_260_4)
				var_260_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_260_3.position).x, (manager.ui.mainCamera.transform.position - var_260_3.position).y, (manager.ui.mainCamera.transform.position - var_260_3.position).z)
				var_260_3.localEulerAngles.z = 0
				var_260_3.localEulerAngles.x = 0
				var_260_3.localEulerAngles = var_260_3.localEulerAngles
			end

			if arg_257_1.time_ >= 0 + var_260_4 and arg_257_1.time_ < 0 + var_260_4 + arg_260_0 then
				var_260_3.localPosition = Vector3.New(-0.8, -1.55, -5.5)
				var_260_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_260_3.position).x, (manager.ui.mainCamera.transform.position - var_260_3.position).y, (manager.ui.mainCamera.transform.position - var_260_3.position).z)
				var_260_3.localEulerAngles.z = 0
				var_260_3.localEulerAngles.x = 0
				var_260_3.localEulerAngles = var_260_3.localEulerAngles
			end

			local var_260_5 = arg_257_1.actors_["404001ui_story"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_5) and arg_257_1.var_.characterEffect404001ui_story == nil then
				arg_257_1.var_.characterEffect404001ui_story = var_260_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_6 = 0.200000002980232

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_6 and not isNil(var_260_5) then
				if arg_257_1.var_.characterEffect404001ui_story and not isNil(var_260_5) then
					arg_257_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= 0 + var_260_6 and arg_257_1.time_ < 0 + var_260_6 + arg_260_0 and not isNil(var_260_5) and arg_257_1.var_.characterEffect404001ui_story then
				arg_257_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_1")
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_260_8 = 0
			local var_260_9 = 0.375

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_8 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_10 = arg_257_1:GetWordFromCfg(322021064)
				local var_260_11 = arg_257_1:FormatText(var_260_10.content)

				arg_257_1.text_.text = var_260_11

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_13 = 15 <= 0 and var_260_9 or var_260_9 * (utf8.len(var_260_11) / 15)

				if (15 <= 0 and var_260_9 or var_260_9 * (utf8.len(var_260_11) / 15)) > 0 and var_260_9 < var_260_13 then
					arg_257_1.talkMaxDuration = var_260_13

					if var_260_13 + var_260_8 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_13 + var_260_8
					end
				end

				arg_257_1.text_.text = var_260_11
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021064", "story_v_out_322021.awb") ~= 0 then
					local var_260_14 = manager.audio:GetVoiceLength("story_v_out_322021", "322021064", "story_v_out_322021.awb") / 1000

					if var_260_14 + var_260_8 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_14 + var_260_8
					end

					if var_260_10.prefab_name ~= "" and arg_257_1.actors_[var_260_10.prefab_name] ~= nil then
						local var_260_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_10.prefab_name].transform, "story_v_out_322021", "322021064", "story_v_out_322021.awb")

						arg_257_1:RecordAudio("322021064", var_260_15)
						arg_257_1:RecordAudio("322021064", var_260_15)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_322021", "322021064", "story_v_out_322021.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_322021", "322021064", "story_v_out_322021.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_16 = math.max(var_260_9, arg_257_1.talkMaxDuration)

			if var_260_8 <= arg_257_1.time_ and arg_257_1.time_ < var_260_8 + var_260_16 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_8) / var_260_16

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_8 + var_260_16 and arg_257_1.time_ < var_260_8 + var_260_16 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play322021065 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 322021065
		arg_261_1.duration_ = 10.23

		local var_261_0 = {
			zh = 8.9,
			ja = 10.233
		}
		local var_261_1 = manager.audio:GetLocalizationFlag()

		if var_261_0[var_261_1] ~= nil then
			arg_261_1.duration_ = var_261_0[var_261_1]
		end

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play322021066(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos1043ui_story = arg_261_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_264_0 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 then
				arg_261_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1043ui_story, Vector3.New(0.81, -1.01, -5.73), (arg_261_1.time_ - 0) / var_264_0)
				arg_261_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1043ui_story"].transform.position).z)
				arg_261_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["1043ui_story"].transform.localEulerAngles = arg_261_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 then
				arg_261_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0.81, -1.01, -5.73)
				arg_261_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1043ui_story"].transform.position).z)
				arg_261_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["1043ui_story"].transform.localEulerAngles = arg_261_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_264_1 = arg_261_1.actors_["1043ui_story"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_1) and arg_261_1.var_.characterEffect1043ui_story == nil then
				arg_261_1.var_.characterEffect1043ui_story = var_264_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_2 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_2 and not isNil(var_264_1) then
				if arg_261_1.var_.characterEffect1043ui_story and not isNil(var_264_1) then
					arg_261_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= 0 + var_264_2 and arg_261_1.time_ < 0 + var_264_2 + arg_264_0 and not isNil(var_264_1) and arg_261_1.var_.characterEffect1043ui_story then
				arg_261_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_264_4 = arg_261_1.actors_["404001ui_story"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_4) and arg_261_1.var_.characterEffect404001ui_story == nil then
				arg_261_1.var_.characterEffect404001ui_story = var_264_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_5 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_5 and not isNil(var_264_4) then
				if arg_261_1.var_.characterEffect404001ui_story and not isNil(var_264_4) then
					arg_261_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_261_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_261_1.time_ - 0) / var_264_5)
				end
			end

			if arg_261_1.time_ >= 0 + var_264_5 and arg_261_1.time_ < 0 + var_264_5 + arg_264_0 and not isNil(var_264_4) and arg_261_1.var_.characterEffect404001ui_story then
				arg_261_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_261_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_264_6 = 0
			local var_264_7 = 1.075

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_6 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_8 = arg_261_1:GetWordFromCfg(322021065)
				local var_264_9 = arg_261_1:FormatText(var_264_8.content)

				arg_261_1.text_.text = var_264_9

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_11 = 43 <= 0 and var_264_7 or var_264_7 * (utf8.len(var_264_9) / 43)

				if (43 <= 0 and var_264_7 or var_264_7 * (utf8.len(var_264_9) / 43)) > 0 and var_264_7 < var_264_11 then
					arg_261_1.talkMaxDuration = var_264_11

					if var_264_11 + var_264_6 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_11 + var_264_6
					end
				end

				arg_261_1.text_.text = var_264_9
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021065", "story_v_out_322021.awb") ~= 0 then
					local var_264_12 = manager.audio:GetVoiceLength("story_v_out_322021", "322021065", "story_v_out_322021.awb") / 1000

					if var_264_12 + var_264_6 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_12 + var_264_6
					end

					if var_264_8.prefab_name ~= "" and arg_261_1.actors_[var_264_8.prefab_name] ~= nil then
						local var_264_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_8.prefab_name].transform, "story_v_out_322021", "322021065", "story_v_out_322021.awb")

						arg_261_1:RecordAudio("322021065", var_264_13)
						arg_261_1:RecordAudio("322021065", var_264_13)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_322021", "322021065", "story_v_out_322021.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_322021", "322021065", "story_v_out_322021.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_14 = math.max(var_264_7, arg_261_1.talkMaxDuration)

			if var_264_6 <= arg_261_1.time_ and arg_261_1.time_ < var_264_6 + var_264_14 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_6) / var_264_14

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_6 + var_264_14 and arg_261_1.time_ < var_264_6 + var_264_14 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play322021066 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 322021066
		arg_265_1.duration_ = 9.2

		local var_265_0 = {
			zh = 7.133,
			ja = 9.2
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play322021067(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0.8

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_1 = arg_265_1:GetWordFromCfg(322021066)
				local var_268_2 = arg_265_1:FormatText(var_268_1.content)

				arg_265_1.text_.text = var_268_2

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_4 = 32 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_2) / 32)

				if (32 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_2) / 32)) > 0 and var_268_0 < var_268_4 then
					arg_265_1.talkMaxDuration = var_268_4

					if var_268_4 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_4 + 0
					end
				end

				arg_265_1.text_.text = var_268_2
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021066", "story_v_out_322021.awb") ~= 0 then
					local var_268_5 = manager.audio:GetVoiceLength("story_v_out_322021", "322021066", "story_v_out_322021.awb") / 1000

					if var_268_5 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_5 + 0
					end

					if var_268_1.prefab_name ~= "" and arg_265_1.actors_[var_268_1.prefab_name] ~= nil then
						local var_268_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_1.prefab_name].transform, "story_v_out_322021", "322021066", "story_v_out_322021.awb")

						arg_265_1:RecordAudio("322021066", var_268_6)
						arg_265_1:RecordAudio("322021066", var_268_6)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_322021", "322021066", "story_v_out_322021.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_322021", "322021066", "story_v_out_322021.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_7 = math.max(var_268_0, arg_265_1.talkMaxDuration)

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_7 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - 0) / var_268_7

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= 0 + var_268_7 and arg_265_1.time_ < 0 + var_268_7 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play322021067 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 322021067
		arg_269_1.duration_ = 2.93

		local var_269_0 = {
			zh = 1.999999999999,
			ja = 2.933
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
				arg_269_0:Play322021068(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(arg_269_1.actors_["404001ui_story"]) and arg_269_1.var_.characterEffect404001ui_story == nil then
				arg_269_1.var_.characterEffect404001ui_story = arg_269_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_0 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 and not isNil(arg_269_1.actors_["404001ui_story"]) then
				if arg_269_1.var_.characterEffect404001ui_story and not isNil(arg_269_1.actors_["404001ui_story"]) then
					arg_269_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 and not isNil(arg_269_1.actors_["404001ui_story"]) and arg_269_1.var_.characterEffect404001ui_story then
				arg_269_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_272_2 = arg_269_1.actors_["1043ui_story"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_2) and arg_269_1.var_.characterEffect1043ui_story == nil then
				arg_269_1.var_.characterEffect1043ui_story = var_272_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_3 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_3 and not isNil(var_272_2) then
				if arg_269_1.var_.characterEffect1043ui_story and not isNil(var_272_2) then
					arg_269_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_269_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_269_1.time_ - 0) / var_272_3)
				end
			end

			if arg_269_1.time_ >= 0 + var_272_3 and arg_269_1.time_ < 0 + var_272_3 + arg_272_0 and not isNil(var_272_2) and arg_269_1.var_.characterEffect1043ui_story then
				arg_269_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_269_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_2")
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_272_4 = 0
			local var_272_5 = 0.15

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_4 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_6 = arg_269_1:GetWordFromCfg(322021067)
				local var_272_7 = arg_269_1:FormatText(var_272_6.content)

				arg_269_1.text_.text = var_272_7

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_9 = 6 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_7) / 6)

				if (6 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_7) / 6)) > 0 and var_272_5 < var_272_9 then
					arg_269_1.talkMaxDuration = var_272_9

					if var_272_9 + var_272_4 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_9 + var_272_4
					end
				end

				arg_269_1.text_.text = var_272_7
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021067", "story_v_out_322021.awb") ~= 0 then
					local var_272_10 = manager.audio:GetVoiceLength("story_v_out_322021", "322021067", "story_v_out_322021.awb") / 1000

					if var_272_10 + var_272_4 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_10 + var_272_4
					end

					if var_272_6.prefab_name ~= "" and arg_269_1.actors_[var_272_6.prefab_name] ~= nil then
						local var_272_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_6.prefab_name].transform, "story_v_out_322021", "322021067", "story_v_out_322021.awb")

						arg_269_1:RecordAudio("322021067", var_272_11)
						arg_269_1:RecordAudio("322021067", var_272_11)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_322021", "322021067", "story_v_out_322021.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_322021", "322021067", "story_v_out_322021.awb")
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

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play322021068 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 322021068
		arg_273_1.duration_ = 12.9

		local var_273_0 = {
			zh = 8.366,
			ja = 12.9
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play322021069(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(arg_273_1.actors_["1043ui_story"]) and arg_273_1.var_.characterEffect1043ui_story == nil then
				arg_273_1.var_.characterEffect1043ui_story = arg_273_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_0 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 and not isNil(arg_273_1.actors_["1043ui_story"]) then
				if arg_273_1.var_.characterEffect1043ui_story and not isNil(arg_273_1.actors_["1043ui_story"]) then
					arg_273_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 and not isNil(arg_273_1.actors_["1043ui_story"]) and arg_273_1.var_.characterEffect1043ui_story then
				arg_273_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_276_2 = arg_273_1.actors_["404001ui_story"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_2) and arg_273_1.var_.characterEffect404001ui_story == nil then
				arg_273_1.var_.characterEffect404001ui_story = var_276_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_3 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_3 and not isNil(var_276_2) then
				if arg_273_1.var_.characterEffect404001ui_story and not isNil(var_276_2) then
					arg_273_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_273_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_273_1.time_ - 0) / var_276_3)
				end
			end

			if arg_273_1.time_ >= 0 + var_276_3 and arg_273_1.time_ < 0 + var_276_3 + arg_276_0 and not isNil(var_276_2) and arg_273_1.var_.characterEffect404001ui_story then
				arg_273_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_273_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action5_1")
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_276_4 = 0
			local var_276_5 = 1

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_4 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_6 = arg_273_1:GetWordFromCfg(322021068)
				local var_276_7 = arg_273_1:FormatText(var_276_6.content)

				arg_273_1.text_.text = var_276_7

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_9 = 40 <= 0 and var_276_5 or var_276_5 * (utf8.len(var_276_7) / 40)

				if (40 <= 0 and var_276_5 or var_276_5 * (utf8.len(var_276_7) / 40)) > 0 and var_276_5 < var_276_9 then
					arg_273_1.talkMaxDuration = var_276_9

					if var_276_9 + var_276_4 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_9 + var_276_4
					end
				end

				arg_273_1.text_.text = var_276_7
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021068", "story_v_out_322021.awb") ~= 0 then
					local var_276_10 = manager.audio:GetVoiceLength("story_v_out_322021", "322021068", "story_v_out_322021.awb") / 1000

					if var_276_10 + var_276_4 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_10 + var_276_4
					end

					if var_276_6.prefab_name ~= "" and arg_273_1.actors_[var_276_6.prefab_name] ~= nil then
						local var_276_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_6.prefab_name].transform, "story_v_out_322021", "322021068", "story_v_out_322021.awb")

						arg_273_1:RecordAudio("322021068", var_276_11)
						arg_273_1:RecordAudio("322021068", var_276_11)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_322021", "322021068", "story_v_out_322021.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_322021", "322021068", "story_v_out_322021.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_12 = math.max(var_276_5, arg_273_1.talkMaxDuration)

			if var_276_4 <= arg_273_1.time_ and arg_273_1.time_ < var_276_4 + var_276_12 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_4) / var_276_12

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_4 + var_276_12 and arg_273_1.time_ < var_276_4 + var_276_12 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play322021069 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 322021069
		arg_277_1.duration_ = 3.5

		local var_277_0 = {
			zh = 3.066,
			ja = 3.5
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play322021070(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(arg_277_1.actors_["404001ui_story"]) and arg_277_1.var_.characterEffect404001ui_story == nil then
				arg_277_1.var_.characterEffect404001ui_story = arg_277_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_0 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 and not isNil(arg_277_1.actors_["404001ui_story"]) then
				if arg_277_1.var_.characterEffect404001ui_story and not isNil(arg_277_1.actors_["404001ui_story"]) then
					arg_277_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 and not isNil(arg_277_1.actors_["404001ui_story"]) and arg_277_1.var_.characterEffect404001ui_story then
				arg_277_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_280_2 = arg_277_1.actors_["1043ui_story"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_2) and arg_277_1.var_.characterEffect1043ui_story == nil then
				arg_277_1.var_.characterEffect1043ui_story = var_280_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_3 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_3 and not isNil(var_280_2) then
				if arg_277_1.var_.characterEffect1043ui_story and not isNil(var_280_2) then
					arg_277_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_277_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_277_1.time_ - 0) / var_280_3)
				end
			end

			if arg_277_1.time_ >= 0 + var_280_3 and arg_277_1.time_ < 0 + var_280_3 + arg_280_0 and not isNil(var_280_2) and arg_277_1.var_.characterEffect1043ui_story then
				arg_277_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_277_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_280_4 = 0
			local var_280_5 = 0.45

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_4 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_6 = arg_277_1:GetWordFromCfg(322021069)
				local var_280_7 = arg_277_1:FormatText(var_280_6.content)

				arg_277_1.text_.text = var_280_7

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_9 = 18 <= 0 and var_280_5 or var_280_5 * (utf8.len(var_280_7) / 18)

				if (18 <= 0 and var_280_5 or var_280_5 * (utf8.len(var_280_7) / 18)) > 0 and var_280_5 < var_280_9 then
					arg_277_1.talkMaxDuration = var_280_9

					if var_280_9 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_9 + var_280_4
					end
				end

				arg_277_1.text_.text = var_280_7
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021069", "story_v_out_322021.awb") ~= 0 then
					local var_280_10 = manager.audio:GetVoiceLength("story_v_out_322021", "322021069", "story_v_out_322021.awb") / 1000

					if var_280_10 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_10 + var_280_4
					end

					if var_280_6.prefab_name ~= "" and arg_277_1.actors_[var_280_6.prefab_name] ~= nil then
						local var_280_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_6.prefab_name].transform, "story_v_out_322021", "322021069", "story_v_out_322021.awb")

						arg_277_1:RecordAudio("322021069", var_280_11)
						arg_277_1:RecordAudio("322021069", var_280_11)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_322021", "322021069", "story_v_out_322021.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_322021", "322021069", "story_v_out_322021.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_12 = math.max(var_280_5, arg_277_1.talkMaxDuration)

			if var_280_4 <= arg_277_1.time_ and arg_277_1.time_ < var_280_4 + var_280_12 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_4) / var_280_12

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_4 + var_280_12 and arg_277_1.time_ < var_280_4 + var_280_12 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play322021070 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 322021070
		arg_281_1.duration_ = 2.73

		local var_281_0 = {
			zh = 2.733,
			ja = 2.533
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play322021071(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos1061ui_story = arg_281_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_284_0 = 0.001

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 then
				arg_281_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_281_1.time_ - 0) / var_284_0)
				arg_281_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_281_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1061ui_story"].transform.position).z)
				arg_281_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_281_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_281_1.actors_["1061ui_story"].transform.localEulerAngles = arg_281_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 then
				arg_281_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_281_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_281_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1061ui_story"].transform.position).z)
				arg_281_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_281_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_281_1.actors_["1061ui_story"].transform.localEulerAngles = arg_281_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_284_1 = arg_281_1.actors_["404001ui_story"].transform

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos404001ui_story = var_284_1.localPosition
			end

			local var_284_2 = 0.001

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_2 then
				var_284_1.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_281_1.time_ - 0) / var_284_2)
				var_284_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_284_1.position).x, (manager.ui.mainCamera.transform.position - var_284_1.position).y, (manager.ui.mainCamera.transform.position - var_284_1.position).z)
				var_284_1.localEulerAngles.z = 0
				var_284_1.localEulerAngles.x = 0
				var_284_1.localEulerAngles = var_284_1.localEulerAngles
			end

			if arg_281_1.time_ >= 0 + var_284_2 and arg_281_1.time_ < 0 + var_284_2 + arg_284_0 then
				var_284_1.localPosition = Vector3.New(0, 100, 0)
				var_284_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_284_1.position).x, (manager.ui.mainCamera.transform.position - var_284_1.position).y, (manager.ui.mainCamera.transform.position - var_284_1.position).z)
				var_284_1.localEulerAngles.z = 0
				var_284_1.localEulerAngles.x = 0
				var_284_1.localEulerAngles = var_284_1.localEulerAngles
			end

			local var_284_3 = arg_281_1.actors_["1043ui_story"].transform

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos1043ui_story = var_284_3.localPosition
			end

			local var_284_4 = 0.001

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_4 then
				var_284_3.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_281_1.time_ - 0) / var_284_4)
				var_284_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_284_3.position).x, (manager.ui.mainCamera.transform.position - var_284_3.position).y, (manager.ui.mainCamera.transform.position - var_284_3.position).z)
				var_284_3.localEulerAngles.z = 0
				var_284_3.localEulerAngles.x = 0
				var_284_3.localEulerAngles = var_284_3.localEulerAngles
			end

			if arg_281_1.time_ >= 0 + var_284_4 and arg_281_1.time_ < 0 + var_284_4 + arg_284_0 then
				var_284_3.localPosition = Vector3.New(0, 100, 0)
				var_284_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_284_3.position).x, (manager.ui.mainCamera.transform.position - var_284_3.position).y, (manager.ui.mainCamera.transform.position - var_284_3.position).z)
				var_284_3.localEulerAngles.z = 0
				var_284_3.localEulerAngles.x = 0
				var_284_3.localEulerAngles = var_284_3.localEulerAngles
			end

			local var_284_5 = arg_281_1.actors_["1061ui_story"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_5) and arg_281_1.var_.characterEffect1061ui_story == nil then
				arg_281_1.var_.characterEffect1061ui_story = var_284_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_6 = 0.200000002980232

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_6 and not isNil(var_284_5) then
				if arg_281_1.var_.characterEffect1061ui_story and not isNil(var_284_5) then
					arg_281_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= 0 + var_284_6 and arg_281_1.time_ < 0 + var_284_6 + arg_284_0 and not isNil(var_284_5) and arg_281_1.var_.characterEffect1061ui_story then
				arg_281_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_284_8 = arg_281_1.actors_["404001ui_story"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_8) and arg_281_1.var_.characterEffect404001ui_story == nil then
				arg_281_1.var_.characterEffect404001ui_story = var_284_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_9 = 0.200000002980232

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_9 and not isNil(var_284_8) then
				if arg_281_1.var_.characterEffect404001ui_story and not isNil(var_284_8) then
					arg_281_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_281_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_281_1.time_ - 0) / var_284_9)
				end
			end

			if arg_281_1.time_ >= 0 + var_284_9 and arg_281_1.time_ < 0 + var_284_9 + arg_284_0 and not isNil(var_284_8) and arg_281_1.var_.characterEffect404001ui_story then
				arg_281_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_281_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action8_1")
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_284_10 = 0
			local var_284_11 = 0.25

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_10 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_12 = arg_281_1:GetWordFromCfg(322021070)
				local var_284_13 = arg_281_1:FormatText(var_284_12.content)

				arg_281_1.text_.text = var_284_13

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_15 = 10 <= 0 and var_284_11 or var_284_11 * (utf8.len(var_284_13) / 10)

				if (10 <= 0 and var_284_11 or var_284_11 * (utf8.len(var_284_13) / 10)) > 0 and var_284_11 < var_284_15 then
					arg_281_1.talkMaxDuration = var_284_15

					if var_284_15 + var_284_10 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_15 + var_284_10
					end
				end

				arg_281_1.text_.text = var_284_13
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021070", "story_v_out_322021.awb") ~= 0 then
					local var_284_16 = manager.audio:GetVoiceLength("story_v_out_322021", "322021070", "story_v_out_322021.awb") / 1000

					if var_284_16 + var_284_10 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_16 + var_284_10
					end

					if var_284_12.prefab_name ~= "" and arg_281_1.actors_[var_284_12.prefab_name] ~= nil then
						local var_284_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_12.prefab_name].transform, "story_v_out_322021", "322021070", "story_v_out_322021.awb")

						arg_281_1:RecordAudio("322021070", var_284_17)
						arg_281_1:RecordAudio("322021070", var_284_17)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_322021", "322021070", "story_v_out_322021.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_322021", "322021070", "story_v_out_322021.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_18 = math.max(var_284_11, arg_281_1.talkMaxDuration)

			if var_284_10 <= arg_281_1.time_ and arg_281_1.time_ < var_284_10 + var_284_18 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_10) / var_284_18

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_10 + var_284_18 and arg_281_1.time_ < var_284_10 + var_284_18 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_281_1:InitPlayNodeList()
	end,
	Play322021071 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 322021071
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play322021072(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos1061ui_story = arg_285_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_288_0 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 then
				arg_285_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_285_1.time_ - 0) / var_288_0)
				arg_285_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_285_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1061ui_story"].transform.position).z)
				arg_285_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_285_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_285_1.actors_["1061ui_story"].transform.localEulerAngles = arg_285_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 then
				arg_285_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_285_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_285_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1061ui_story"].transform.position).z)
				arg_285_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_285_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_285_1.actors_["1061ui_story"].transform.localEulerAngles = arg_285_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_288_1 = 0
			local var_288_2 = 1.075

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, false)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_3 = arg_285_1:FormatText(arg_285_1:GetWordFromCfg(322021071).content)

				arg_285_1.text_.text = var_288_3

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_5 = 43 <= 0 and var_288_2 or var_288_2 * (utf8.len(var_288_3) / 43)

				if (43 <= 0 and var_288_2 or var_288_2 * (utf8.len(var_288_3) / 43)) > 0 and var_288_2 < var_288_5 then
					arg_285_1.talkMaxDuration = var_288_5

					if var_288_5 + var_288_1 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_5 + var_288_1
					end
				end

				arg_285_1.text_.text = var_288_3
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_6 = math.max(var_288_2, arg_285_1.talkMaxDuration)

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_6 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_1) / var_288_6

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_1 + var_288_6 and arg_285_1.time_ < var_288_1 + var_288_6 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_285_1:InitPlayNodeList()
	end,
	Play322021072 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 322021072
		arg_289_1.duration_ = 8.7

		local var_289_0 = {
			zh = 5.8,
			ja = 8.7
		}
		local var_289_1 = manager.audio:GetLocalizationFlag()

		if var_289_0[var_289_1] ~= nil then
			arg_289_1.duration_ = var_289_0[var_289_1]
		end

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play322021073(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.var_.moveOldPos1061ui_story = arg_289_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_292_0 = 0.001

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 then
				arg_289_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1061ui_story, Vector3.New(-0.7, -1.18, -6.15), (arg_289_1.time_ - 0) / var_292_0)
				arg_289_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_289_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1061ui_story"].transform.position).z)
				arg_289_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_289_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_289_1.actors_["1061ui_story"].transform.localEulerAngles = arg_289_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 then
				arg_289_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(-0.7, -1.18, -6.15)
				arg_289_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_289_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1061ui_story"].transform.position).z)
				arg_289_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_289_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_289_1.actors_["1061ui_story"].transform.localEulerAngles = arg_289_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_292_1 = arg_289_1.actors_["1061ui_story"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_1) and arg_289_1.var_.characterEffect1061ui_story == nil then
				arg_289_1.var_.characterEffect1061ui_story = var_292_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_2 = 0.200000002980232

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_2 and not isNil(var_292_1) then
				if arg_289_1.var_.characterEffect1061ui_story and not isNil(var_292_1) then
					arg_289_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= 0 + var_292_2 and arg_289_1.time_ < 0 + var_292_2 + arg_292_0 and not isNil(var_292_1) and arg_289_1.var_.characterEffect1061ui_story then
				arg_289_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action8_2")
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_292_4 = 0
			local var_292_5 = 0.75

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_4 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_6 = arg_289_1:GetWordFromCfg(322021072)
				local var_292_7 = arg_289_1:FormatText(var_292_6.content)

				arg_289_1.text_.text = var_292_7

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_9 = 30 <= 0 and var_292_5 or var_292_5 * (utf8.len(var_292_7) / 30)

				if (30 <= 0 and var_292_5 or var_292_5 * (utf8.len(var_292_7) / 30)) > 0 and var_292_5 < var_292_9 then
					arg_289_1.talkMaxDuration = var_292_9

					if var_292_9 + var_292_4 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_9 + var_292_4
					end
				end

				arg_289_1.text_.text = var_292_7
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021072", "story_v_out_322021.awb") ~= 0 then
					local var_292_10 = manager.audio:GetVoiceLength("story_v_out_322021", "322021072", "story_v_out_322021.awb") / 1000

					if var_292_10 + var_292_4 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_10 + var_292_4
					end

					if var_292_6.prefab_name ~= "" and arg_289_1.actors_[var_292_6.prefab_name] ~= nil then
						local var_292_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_6.prefab_name].transform, "story_v_out_322021", "322021072", "story_v_out_322021.awb")

						arg_289_1:RecordAudio("322021072", var_292_11)
						arg_289_1:RecordAudio("322021072", var_292_11)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_322021", "322021072", "story_v_out_322021.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_322021", "322021072", "story_v_out_322021.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_12 = math.max(var_292_5, arg_289_1.talkMaxDuration)

			if var_292_4 <= arg_289_1.time_ and arg_289_1.time_ < var_292_4 + var_292_12 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_4) / var_292_12

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_4 + var_292_12 and arg_289_1.time_ < var_292_4 + var_292_12 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_289_1:InitPlayNodeList()
	end,
	Play322021073 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 322021073
		arg_293_1.duration_ = 3.43

		local var_293_0 = {
			zh = 2.8,
			ja = 3.433
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play322021074(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos404001ui_story = arg_293_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_296_0 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 then
				arg_293_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos404001ui_story, Vector3.New(0.8, -1.55, -5.5), (arg_293_1.time_ - 0) / var_296_0)
				arg_293_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_293_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["404001ui_story"].transform.position).z)
				arg_293_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_293_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_293_1.actors_["404001ui_story"].transform.localEulerAngles = arg_293_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 then
				arg_293_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0.8, -1.55, -5.5)
				arg_293_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_293_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["404001ui_story"].transform.position).z)
				arg_293_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_293_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_293_1.actors_["404001ui_story"].transform.localEulerAngles = arg_293_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_296_1 = arg_293_1.actors_["404001ui_story"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_1) and arg_293_1.var_.characterEffect404001ui_story == nil then
				arg_293_1.var_.characterEffect404001ui_story = var_296_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_2 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_2 and not isNil(var_296_1) then
				if arg_293_1.var_.characterEffect404001ui_story and not isNil(var_296_1) then
					arg_293_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= 0 + var_296_2 and arg_293_1.time_ < 0 + var_296_2 + arg_296_0 and not isNil(var_296_1) and arg_293_1.var_.characterEffect404001ui_story then
				arg_293_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_296_4 = arg_293_1.actors_["1061ui_story"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_4) and arg_293_1.var_.characterEffect1061ui_story == nil then
				arg_293_1.var_.characterEffect1061ui_story = var_296_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_5 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_5 and not isNil(var_296_4) then
				if arg_293_1.var_.characterEffect1061ui_story and not isNil(var_296_4) then
					arg_293_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_293_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_293_1.time_ - 0) / var_296_5)
				end
			end

			if arg_293_1.time_ >= 0 + var_296_5 and arg_293_1.time_ < 0 + var_296_5 + arg_296_0 and not isNil(var_296_4) and arg_293_1.var_.characterEffect1061ui_story then
				arg_293_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_293_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_296_6 = 0
			local var_296_7 = 0.275

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_6 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_8 = arg_293_1:GetWordFromCfg(322021073)
				local var_296_9 = arg_293_1:FormatText(var_296_8.content)

				arg_293_1.text_.text = var_296_9

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_11 = 11 <= 0 and var_296_7 or var_296_7 * (utf8.len(var_296_9) / 11)

				if (11 <= 0 and var_296_7 or var_296_7 * (utf8.len(var_296_9) / 11)) > 0 and var_296_7 < var_296_11 then
					arg_293_1.talkMaxDuration = var_296_11

					if var_296_11 + var_296_6 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_11 + var_296_6
					end
				end

				arg_293_1.text_.text = var_296_9
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021073", "story_v_out_322021.awb") ~= 0 then
					local var_296_12 = manager.audio:GetVoiceLength("story_v_out_322021", "322021073", "story_v_out_322021.awb") / 1000

					if var_296_12 + var_296_6 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_12 + var_296_6
					end

					if var_296_8.prefab_name ~= "" and arg_293_1.actors_[var_296_8.prefab_name] ~= nil then
						local var_296_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_8.prefab_name].transform, "story_v_out_322021", "322021073", "story_v_out_322021.awb")

						arg_293_1:RecordAudio("322021073", var_296_13)
						arg_293_1:RecordAudio("322021073", var_296_13)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_322021", "322021073", "story_v_out_322021.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_322021", "322021073", "story_v_out_322021.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_14 = math.max(var_296_7, arg_293_1.talkMaxDuration)

			if var_296_6 <= arg_293_1.time_ and arg_293_1.time_ < var_296_6 + var_296_14 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_6) / var_296_14

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_6 + var_296_14 and arg_293_1.time_ < var_296_6 + var_296_14 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play322021074 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 322021074
		arg_297_1.duration_ = 14.57

		local var_297_0 = {
			zh = 9.233,
			ja = 14.566
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play322021075(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(arg_297_1.actors_["1061ui_story"]) and arg_297_1.var_.characterEffect1061ui_story == nil then
				arg_297_1.var_.characterEffect1061ui_story = arg_297_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_0 = 0.200000002980232

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 and not isNil(arg_297_1.actors_["1061ui_story"]) then
				if arg_297_1.var_.characterEffect1061ui_story and not isNil(arg_297_1.actors_["1061ui_story"]) then
					arg_297_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 and not isNil(arg_297_1.actors_["1061ui_story"]) and arg_297_1.var_.characterEffect1061ui_story then
				arg_297_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_300_2 = arg_297_1.actors_["404001ui_story"]

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(var_300_2) and arg_297_1.var_.characterEffect404001ui_story == nil then
				arg_297_1.var_.characterEffect404001ui_story = var_300_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_3 = 0.200000002980232

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_3 and not isNil(var_300_2) then
				if arg_297_1.var_.characterEffect404001ui_story and not isNil(var_300_2) then
					arg_297_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_297_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_297_1.time_ - 0) / var_300_3)
				end
			end

			if arg_297_1.time_ >= 0 + var_300_3 and arg_297_1.time_ < 0 + var_300_3 + arg_300_0 and not isNil(var_300_2) and arg_297_1.var_.characterEffect404001ui_story then
				arg_297_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_297_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_300_4 = 0
			local var_300_5 = 1.2

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_4 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_6 = arg_297_1:GetWordFromCfg(322021074)
				local var_300_7 = arg_297_1:FormatText(var_300_6.content)

				arg_297_1.text_.text = var_300_7

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_9 = 48 <= 0 and var_300_5 or var_300_5 * (utf8.len(var_300_7) / 48)

				if (48 <= 0 and var_300_5 or var_300_5 * (utf8.len(var_300_7) / 48)) > 0 and var_300_5 < var_300_9 then
					arg_297_1.talkMaxDuration = var_300_9

					if var_300_9 + var_300_4 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_9 + var_300_4
					end
				end

				arg_297_1.text_.text = var_300_7
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021074", "story_v_out_322021.awb") ~= 0 then
					local var_300_10 = manager.audio:GetVoiceLength("story_v_out_322021", "322021074", "story_v_out_322021.awb") / 1000

					if var_300_10 + var_300_4 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_10 + var_300_4
					end

					if var_300_6.prefab_name ~= "" and arg_297_1.actors_[var_300_6.prefab_name] ~= nil then
						local var_300_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_6.prefab_name].transform, "story_v_out_322021", "322021074", "story_v_out_322021.awb")

						arg_297_1:RecordAudio("322021074", var_300_11)
						arg_297_1:RecordAudio("322021074", var_300_11)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_322021", "322021074", "story_v_out_322021.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_322021", "322021074", "story_v_out_322021.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_12 = math.max(var_300_5, arg_297_1.talkMaxDuration)

			if var_300_4 <= arg_297_1.time_ and arg_297_1.time_ < var_300_4 + var_300_12 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_4) / var_300_12

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_4 + var_300_12 and arg_297_1.time_ < var_300_4 + var_300_12 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play322021075 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 322021075
		arg_301_1.duration_ = 6.33

		local var_301_0 = {
			zh = 6.333,
			ja = 6.2
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play322021076(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.var_.moveOldPos1043ui_story = arg_301_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_304_0 = 0.001

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_0 then
				arg_301_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1043ui_story, Vector3.New(-0.92, -1.01, -5.73), (arg_301_1.time_ - 0) / var_304_0)
				arg_301_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_301_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1043ui_story"].transform.position).z)
				arg_301_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_301_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_301_1.actors_["1043ui_story"].transform.localEulerAngles = arg_301_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_301_1.time_ >= 0 + var_304_0 and arg_301_1.time_ < 0 + var_304_0 + arg_304_0 then
				arg_301_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(-0.92, -1.01, -5.73)
				arg_301_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_301_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1043ui_story"].transform.position).z)
				arg_301_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_301_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_301_1.actors_["1043ui_story"].transform.localEulerAngles = arg_301_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_304_1 = arg_301_1.actors_["1061ui_story"].transform

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.var_.moveOldPos1061ui_story = var_304_1.localPosition
			end

			local var_304_2 = 0.001

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_2 then
				var_304_1.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_301_1.time_ - 0) / var_304_2)
				var_304_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_304_1.position).x, (manager.ui.mainCamera.transform.position - var_304_1.position).y, (manager.ui.mainCamera.transform.position - var_304_1.position).z)
				var_304_1.localEulerAngles.z = 0
				var_304_1.localEulerAngles.x = 0
				var_304_1.localEulerAngles = var_304_1.localEulerAngles
			end

			if arg_301_1.time_ >= 0 + var_304_2 and arg_301_1.time_ < 0 + var_304_2 + arg_304_0 then
				var_304_1.localPosition = Vector3.New(0, 100, 0)
				var_304_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_304_1.position).x, (manager.ui.mainCamera.transform.position - var_304_1.position).y, (manager.ui.mainCamera.transform.position - var_304_1.position).z)
				var_304_1.localEulerAngles.z = 0
				var_304_1.localEulerAngles.x = 0
				var_304_1.localEulerAngles = var_304_1.localEulerAngles
			end

			local var_304_3 = arg_301_1.actors_["1043ui_story"]

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(var_304_3) and arg_301_1.var_.characterEffect1043ui_story == nil then
				arg_301_1.var_.characterEffect1043ui_story = var_304_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_4 = 0.200000002980232

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_4 and not isNil(var_304_3) then
				if arg_301_1.var_.characterEffect1043ui_story and not isNil(var_304_3) then
					arg_301_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= 0 + var_304_4 and arg_301_1.time_ < 0 + var_304_4 + arg_304_0 and not isNil(var_304_3) and arg_301_1.var_.characterEffect1043ui_story then
				arg_301_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_304_6 = arg_301_1.actors_["1061ui_story"]

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(var_304_6) and arg_301_1.var_.characterEffect1061ui_story == nil then
				arg_301_1.var_.characterEffect1061ui_story = var_304_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_7 = 0.200000002980232

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_7 and not isNil(var_304_6) then
				if arg_301_1.var_.characterEffect1061ui_story and not isNil(var_304_6) then
					arg_301_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_301_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_301_1.time_ - 0) / var_304_7)
				end
			end

			if arg_301_1.time_ >= 0 + var_304_7 and arg_301_1.time_ < 0 + var_304_7 + arg_304_0 and not isNil(var_304_6) and arg_301_1.var_.characterEffect1061ui_story then
				arg_301_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_301_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_304_8 = 0
			local var_304_9 = 0.725

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_8 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_10 = arg_301_1:GetWordFromCfg(322021075)
				local var_304_11 = arg_301_1:FormatText(var_304_10.content)

				arg_301_1.text_.text = var_304_11

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_13 = 29 <= 0 and var_304_9 or var_304_9 * (utf8.len(var_304_11) / 29)

				if (29 <= 0 and var_304_9 or var_304_9 * (utf8.len(var_304_11) / 29)) > 0 and var_304_9 < var_304_13 then
					arg_301_1.talkMaxDuration = var_304_13

					if var_304_13 + var_304_8 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_13 + var_304_8
					end
				end

				arg_301_1.text_.text = var_304_11
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021075", "story_v_out_322021.awb") ~= 0 then
					local var_304_14 = manager.audio:GetVoiceLength("story_v_out_322021", "322021075", "story_v_out_322021.awb") / 1000

					if var_304_14 + var_304_8 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_14 + var_304_8
					end

					if var_304_10.prefab_name ~= "" and arg_301_1.actors_[var_304_10.prefab_name] ~= nil then
						local var_304_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_10.prefab_name].transform, "story_v_out_322021", "322021075", "story_v_out_322021.awb")

						arg_301_1:RecordAudio("322021075", var_304_15)
						arg_301_1:RecordAudio("322021075", var_304_15)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_322021", "322021075", "story_v_out_322021.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_322021", "322021075", "story_v_out_322021.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_16 = math.max(var_304_9, arg_301_1.talkMaxDuration)

			if var_304_8 <= arg_301_1.time_ and arg_301_1.time_ < var_304_8 + var_304_16 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_8) / var_304_16

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_8 + var_304_16 and arg_301_1.time_ < var_304_8 + var_304_16 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_301_1:InitPlayNodeList()
	end,
	Play322021076 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 322021076
		arg_305_1.duration_ = 2.73

		local var_305_0 = {
			zh = 2.266,
			ja = 2.733
		}
		local var_305_1 = manager.audio:GetLocalizationFlag()

		if var_305_0[var_305_1] ~= nil then
			arg_305_1.duration_ = var_305_0[var_305_1]
		end

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play322021077(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.var_.moveOldPos1211ui_story = arg_305_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_308_0 = 0.001

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_0 then
				arg_305_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1211ui_story, Vector3.New(0.7, -0.67, -6.07), (arg_305_1.time_ - 0) / var_308_0)
				arg_305_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_305_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["1211ui_story"].transform.position).z)
				arg_305_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_305_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_305_1.actors_["1211ui_story"].transform.localEulerAngles = arg_305_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_305_1.time_ >= 0 + var_308_0 and arg_305_1.time_ < 0 + var_308_0 + arg_308_0 then
				arg_305_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(0.7, -0.67, -6.07)
				arg_305_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_305_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["1211ui_story"].transform.position).z)
				arg_305_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_305_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_305_1.actors_["1211ui_story"].transform.localEulerAngles = arg_305_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_308_1 = arg_305_1.actors_["404001ui_story"].transform

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.var_.moveOldPos404001ui_story = var_308_1.localPosition
			end

			local var_308_2 = 0.001

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_2 then
				var_308_1.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_305_1.time_ - 0) / var_308_2)
				var_308_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_308_1.position).x, (manager.ui.mainCamera.transform.position - var_308_1.position).y, (manager.ui.mainCamera.transform.position - var_308_1.position).z)
				var_308_1.localEulerAngles.z = 0
				var_308_1.localEulerAngles.x = 0
				var_308_1.localEulerAngles = var_308_1.localEulerAngles
			end

			if arg_305_1.time_ >= 0 + var_308_2 and arg_305_1.time_ < 0 + var_308_2 + arg_308_0 then
				var_308_1.localPosition = Vector3.New(0, 100, 0)
				var_308_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_308_1.position).x, (manager.ui.mainCamera.transform.position - var_308_1.position).y, (manager.ui.mainCamera.transform.position - var_308_1.position).z)
				var_308_1.localEulerAngles.z = 0
				var_308_1.localEulerAngles.x = 0
				var_308_1.localEulerAngles = var_308_1.localEulerAngles
			end

			local var_308_3 = arg_305_1.actors_["1211ui_story"]

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(var_308_3) and arg_305_1.var_.characterEffect1211ui_story == nil then
				arg_305_1.var_.characterEffect1211ui_story = var_308_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_4 = 0.200000002980232

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_4 and not isNil(var_308_3) then
				if arg_305_1.var_.characterEffect1211ui_story and not isNil(var_308_3) then
					arg_305_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_305_1.time_ >= 0 + var_308_4 and arg_305_1.time_ < 0 + var_308_4 + arg_308_0 and not isNil(var_308_3) and arg_305_1.var_.characterEffect1211ui_story then
				arg_305_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_308_6 = arg_305_1.actors_["1043ui_story"]

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(var_308_6) and arg_305_1.var_.characterEffect1043ui_story == nil then
				arg_305_1.var_.characterEffect1043ui_story = var_308_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_7 = 0.200000002980232

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_7 and not isNil(var_308_6) then
				if arg_305_1.var_.characterEffect1043ui_story and not isNil(var_308_6) then
					arg_305_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_305_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_305_1.time_ - 0) / var_308_7)
				end
			end

			if arg_305_1.time_ >= 0 + var_308_7 and arg_305_1.time_ < 0 + var_308_7 + arg_308_0 and not isNil(var_308_6) and arg_305_1.var_.characterEffect1043ui_story then
				arg_305_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_305_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action5_1")
			end

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_308_8 = 0
			local var_308_9 = 0.225

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_8 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_10 = arg_305_1:GetWordFromCfg(322021076)
				local var_308_11 = arg_305_1:FormatText(var_308_10.content)

				arg_305_1.text_.text = var_308_11

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_13 = 9 <= 0 and var_308_9 or var_308_9 * (utf8.len(var_308_11) / 9)

				if (9 <= 0 and var_308_9 or var_308_9 * (utf8.len(var_308_11) / 9)) > 0 and var_308_9 < var_308_13 then
					arg_305_1.talkMaxDuration = var_308_13

					if var_308_13 + var_308_8 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_13 + var_308_8
					end
				end

				arg_305_1.text_.text = var_308_11
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021076", "story_v_out_322021.awb") ~= 0 then
					local var_308_14 = manager.audio:GetVoiceLength("story_v_out_322021", "322021076", "story_v_out_322021.awb") / 1000

					if var_308_14 + var_308_8 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_14 + var_308_8
					end

					if var_308_10.prefab_name ~= "" and arg_305_1.actors_[var_308_10.prefab_name] ~= nil then
						local var_308_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_10.prefab_name].transform, "story_v_out_322021", "322021076", "story_v_out_322021.awb")

						arg_305_1:RecordAudio("322021076", var_308_15)
						arg_305_1:RecordAudio("322021076", var_308_15)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_322021", "322021076", "story_v_out_322021.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_322021", "322021076", "story_v_out_322021.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_16 = math.max(var_308_9, arg_305_1.talkMaxDuration)

			if var_308_8 <= arg_305_1.time_ and arg_305_1.time_ < var_308_8 + var_308_16 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_8) / var_308_16

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_8 + var_308_16 and arg_305_1.time_ < var_308_8 + var_308_16 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_305_1:InitPlayNodeList()
	end,
	Play322021077 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 322021077
		arg_309_1.duration_ = 7.17

		local var_309_0 = {
			zh = 6.2,
			ja = 7.166
		}
		local var_309_1 = manager.audio:GetLocalizationFlag()

		if var_309_0[var_309_1] ~= nil then
			arg_309_1.duration_ = var_309_0[var_309_1]
		end

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play322021078(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(arg_309_1.actors_["1043ui_story"]) and arg_309_1.var_.characterEffect1043ui_story == nil then
				arg_309_1.var_.characterEffect1043ui_story = arg_309_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_0 = 0.200000002980232

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_0 and not isNil(arg_309_1.actors_["1043ui_story"]) then
				if arg_309_1.var_.characterEffect1043ui_story and not isNil(arg_309_1.actors_["1043ui_story"]) then
					arg_309_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= 0 + var_312_0 and arg_309_1.time_ < 0 + var_312_0 + arg_312_0 and not isNil(arg_309_1.actors_["1043ui_story"]) and arg_309_1.var_.characterEffect1043ui_story then
				arg_309_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_312_2 = arg_309_1.actors_["1211ui_story"]

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(var_312_2) and arg_309_1.var_.characterEffect1211ui_story == nil then
				arg_309_1.var_.characterEffect1211ui_story = var_312_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_3 = 0.200000002980232

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_3 and not isNil(var_312_2) then
				if arg_309_1.var_.characterEffect1211ui_story and not isNil(var_312_2) then
					arg_309_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_309_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_309_1.time_ - 0) / var_312_3)
				end
			end

			if arg_309_1.time_ >= 0 + var_312_3 and arg_309_1.time_ < 0 + var_312_3 + arg_312_0 and not isNil(var_312_2) and arg_309_1.var_.characterEffect1211ui_story then
				arg_309_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_309_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_312_4 = 0
			local var_312_5 = 0.725

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_4 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_6 = arg_309_1:GetWordFromCfg(322021077)
				local var_312_7 = arg_309_1:FormatText(var_312_6.content)

				arg_309_1.text_.text = var_312_7

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_9 = 29 <= 0 and var_312_5 or var_312_5 * (utf8.len(var_312_7) / 29)

				if (29 <= 0 and var_312_5 or var_312_5 * (utf8.len(var_312_7) / 29)) > 0 and var_312_5 < var_312_9 then
					arg_309_1.talkMaxDuration = var_312_9

					if var_312_9 + var_312_4 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_9 + var_312_4
					end
				end

				arg_309_1.text_.text = var_312_7
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021077", "story_v_out_322021.awb") ~= 0 then
					local var_312_10 = manager.audio:GetVoiceLength("story_v_out_322021", "322021077", "story_v_out_322021.awb") / 1000

					if var_312_10 + var_312_4 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_10 + var_312_4
					end

					if var_312_6.prefab_name ~= "" and arg_309_1.actors_[var_312_6.prefab_name] ~= nil then
						local var_312_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_6.prefab_name].transform, "story_v_out_322021", "322021077", "story_v_out_322021.awb")

						arg_309_1:RecordAudio("322021077", var_312_11)
						arg_309_1:RecordAudio("322021077", var_312_11)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_322021", "322021077", "story_v_out_322021.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_322021", "322021077", "story_v_out_322021.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_12 = math.max(var_312_5, arg_309_1.talkMaxDuration)

			if var_312_4 <= arg_309_1.time_ and arg_309_1.time_ < var_312_4 + var_312_12 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_4) / var_312_12

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_4 + var_312_12 and arg_309_1.time_ < var_312_4 + var_312_12 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play322021078 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 322021078
		arg_313_1.duration_ = 8.8

		local var_313_0 = {
			zh = 6.433,
			ja = 8.8
		}
		local var_313_1 = manager.audio:GetLocalizationFlag()

		if var_313_0[var_313_1] ~= nil then
			arg_313_1.duration_ = var_313_0[var_313_1]
		end

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play322021079(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos1061ui_story = arg_313_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_316_0 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 then
				arg_313_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1061ui_story, Vector3.New(-0.7, -1.18, -6.15), (arg_313_1.time_ - 0) / var_316_0)
				arg_313_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1061ui_story"].transform.position).z)
				arg_313_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["1061ui_story"].transform.localEulerAngles = arg_313_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 then
				arg_313_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(-0.7, -1.18, -6.15)
				arg_313_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1061ui_story"].transform.position).z)
				arg_313_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["1061ui_story"].transform.localEulerAngles = arg_313_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_316_1 = arg_313_1.actors_["1043ui_story"].transform

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos1043ui_story = var_316_1.localPosition
			end

			local var_316_2 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_2 then
				var_316_1.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_313_1.time_ - 0) / var_316_2)
				var_316_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_316_1.position).x, (manager.ui.mainCamera.transform.position - var_316_1.position).y, (manager.ui.mainCamera.transform.position - var_316_1.position).z)
				var_316_1.localEulerAngles.z = 0
				var_316_1.localEulerAngles.x = 0
				var_316_1.localEulerAngles = var_316_1.localEulerAngles
			end

			if arg_313_1.time_ >= 0 + var_316_2 and arg_313_1.time_ < 0 + var_316_2 + arg_316_0 then
				var_316_1.localPosition = Vector3.New(0, 100, 0)
				var_316_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_316_1.position).x, (manager.ui.mainCamera.transform.position - var_316_1.position).y, (manager.ui.mainCamera.transform.position - var_316_1.position).z)
				var_316_1.localEulerAngles.z = 0
				var_316_1.localEulerAngles.x = 0
				var_316_1.localEulerAngles = var_316_1.localEulerAngles
			end

			local var_316_3 = arg_313_1.actors_["1061ui_story"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_3) and arg_313_1.var_.characterEffect1061ui_story == nil then
				arg_313_1.var_.characterEffect1061ui_story = var_316_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_4 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_4 and not isNil(var_316_3) then
				if arg_313_1.var_.characterEffect1061ui_story and not isNil(var_316_3) then
					arg_313_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= 0 + var_316_4 and arg_313_1.time_ < 0 + var_316_4 + arg_316_0 and not isNil(var_316_3) and arg_313_1.var_.characterEffect1061ui_story then
				arg_313_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_316_6 = arg_313_1.actors_["1043ui_story"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_6) and arg_313_1.var_.characterEffect1043ui_story == nil then
				arg_313_1.var_.characterEffect1043ui_story = var_316_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_7 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_7 and not isNil(var_316_6) then
				if arg_313_1.var_.characterEffect1043ui_story and not isNil(var_316_6) then
					arg_313_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_313_1.time_ - 0) / var_316_7)
				end
			end

			if arg_313_1.time_ >= 0 + var_316_7 and arg_313_1.time_ < 0 + var_316_7 + arg_316_0 and not isNil(var_316_6) and arg_313_1.var_.characterEffect1043ui_story then
				arg_313_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_1")
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_316_8 = 0
			local var_316_9 = 0.575

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_8 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_10 = arg_313_1:GetWordFromCfg(322021078)
				local var_316_11 = arg_313_1:FormatText(var_316_10.content)

				arg_313_1.text_.text = var_316_11

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_13 = 23 <= 0 and var_316_9 or var_316_9 * (utf8.len(var_316_11) / 23)

				if (23 <= 0 and var_316_9 or var_316_9 * (utf8.len(var_316_11) / 23)) > 0 and var_316_9 < var_316_13 then
					arg_313_1.talkMaxDuration = var_316_13

					if var_316_13 + var_316_8 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_13 + var_316_8
					end
				end

				arg_313_1.text_.text = var_316_11
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021078", "story_v_out_322021.awb") ~= 0 then
					local var_316_14 = manager.audio:GetVoiceLength("story_v_out_322021", "322021078", "story_v_out_322021.awb") / 1000

					if var_316_14 + var_316_8 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_14 + var_316_8
					end

					if var_316_10.prefab_name ~= "" and arg_313_1.actors_[var_316_10.prefab_name] ~= nil then
						local var_316_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_10.prefab_name].transform, "story_v_out_322021", "322021078", "story_v_out_322021.awb")

						arg_313_1:RecordAudio("322021078", var_316_15)
						arg_313_1:RecordAudio("322021078", var_316_15)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_322021", "322021078", "story_v_out_322021.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_322021", "322021078", "story_v_out_322021.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_16 = math.max(var_316_9, arg_313_1.talkMaxDuration)

			if var_316_8 <= arg_313_1.time_ and arg_313_1.time_ < var_316_8 + var_316_16 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_8) / var_316_16

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_8 + var_316_16 and arg_313_1.time_ < var_316_8 + var_316_16 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_313_1:InitPlayNodeList()
	end,
	Play322021079 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 322021079
		arg_317_1.duration_ = 2

		local var_317_0 = {
			zh = 1.999999999999,
			ja = 2
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play322021080(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(arg_317_1.actors_["1211ui_story"]) and arg_317_1.var_.characterEffect1211ui_story == nil then
				arg_317_1.var_.characterEffect1211ui_story = arg_317_1.actors_["1211ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_0 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 and not isNil(arg_317_1.actors_["1211ui_story"]) then
				if arg_317_1.var_.characterEffect1211ui_story and not isNil(arg_317_1.actors_["1211ui_story"]) then
					arg_317_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 and not isNil(arg_317_1.actors_["1211ui_story"]) and arg_317_1.var_.characterEffect1211ui_story then
				arg_317_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_320_2 = arg_317_1.actors_["1061ui_story"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_2) and arg_317_1.var_.characterEffect1061ui_story == nil then
				arg_317_1.var_.characterEffect1061ui_story = var_320_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_3 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_3 and not isNil(var_320_2) then
				if arg_317_1.var_.characterEffect1061ui_story and not isNil(var_320_2) then
					arg_317_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_317_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_317_1.time_ - 0) / var_320_3)
				end
			end

			if arg_317_1.time_ >= 0 + var_320_3 and arg_317_1.time_ < 0 + var_320_3 + arg_320_0 and not isNil(var_320_2) and arg_317_1.var_.characterEffect1061ui_story then
				arg_317_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_317_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action5_2")
			end

			local var_320_4 = 0
			local var_320_5 = 0.175

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_4 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_6 = arg_317_1:GetWordFromCfg(322021079)
				local var_320_7 = arg_317_1:FormatText(var_320_6.content)

				arg_317_1.text_.text = var_320_7

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_9 = 7 <= 0 and var_320_5 or var_320_5 * (utf8.len(var_320_7) / 7)

				if (7 <= 0 and var_320_5 or var_320_5 * (utf8.len(var_320_7) / 7)) > 0 and var_320_5 < var_320_9 then
					arg_317_1.talkMaxDuration = var_320_9

					if var_320_9 + var_320_4 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_9 + var_320_4
					end
				end

				arg_317_1.text_.text = var_320_7
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021079", "story_v_out_322021.awb") ~= 0 then
					local var_320_10 = manager.audio:GetVoiceLength("story_v_out_322021", "322021079", "story_v_out_322021.awb") / 1000

					if var_320_10 + var_320_4 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_10 + var_320_4
					end

					if var_320_6.prefab_name ~= "" and arg_317_1.actors_[var_320_6.prefab_name] ~= nil then
						local var_320_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_6.prefab_name].transform, "story_v_out_322021", "322021079", "story_v_out_322021.awb")

						arg_317_1:RecordAudio("322021079", var_320_11)
						arg_317_1:RecordAudio("322021079", var_320_11)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_322021", "322021079", "story_v_out_322021.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_322021", "322021079", "story_v_out_322021.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_12 = math.max(var_320_5, arg_317_1.talkMaxDuration)

			if var_320_4 <= arg_317_1.time_ and arg_317_1.time_ < var_320_4 + var_320_12 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_4) / var_320_12

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_4 + var_320_12 and arg_317_1.time_ < var_320_4 + var_320_12 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play322021080 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 322021080
		arg_321_1.duration_ = 4.33

		local var_321_0 = {
			zh = 3.3,
			ja = 4.333
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play322021081(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action1_1")
			end

			local var_324_0 = 0
			local var_324_1 = 0.375

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_2 = arg_321_1:GetWordFromCfg(322021080)
				local var_324_3 = arg_321_1:FormatText(var_324_2.content)

				arg_321_1.text_.text = var_324_3

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_5 = 15 <= 0 and var_324_1 or var_324_1 * (utf8.len(var_324_3) / 15)

				if (15 <= 0 and var_324_1 or var_324_1 * (utf8.len(var_324_3) / 15)) > 0 and var_324_1 < var_324_5 then
					arg_321_1.talkMaxDuration = var_324_5

					if var_324_5 + var_324_0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_5 + var_324_0
					end
				end

				arg_321_1.text_.text = var_324_3
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021080", "story_v_out_322021.awb") ~= 0 then
					local var_324_6 = manager.audio:GetVoiceLength("story_v_out_322021", "322021080", "story_v_out_322021.awb") / 1000

					if var_324_6 + var_324_0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_6 + var_324_0
					end

					if var_324_2.prefab_name ~= "" and arg_321_1.actors_[var_324_2.prefab_name] ~= nil then
						local var_324_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_2.prefab_name].transform, "story_v_out_322021", "322021080", "story_v_out_322021.awb")

						arg_321_1:RecordAudio("322021080", var_324_7)
						arg_321_1:RecordAudio("322021080", var_324_7)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_322021", "322021080", "story_v_out_322021.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_322021", "322021080", "story_v_out_322021.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_8 = math.max(var_324_1, arg_321_1.talkMaxDuration)

			if var_324_0 <= arg_321_1.time_ and arg_321_1.time_ < var_324_0 + var_324_8 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_0) / var_324_8

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_0 + var_324_8 and arg_321_1.time_ < var_324_0 + var_324_8 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play322021081 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 322021081
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play322021082(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(arg_325_1.actors_["1211ui_story"]) and arg_325_1.var_.characterEffect1211ui_story == nil then
				arg_325_1.var_.characterEffect1211ui_story = arg_325_1.actors_["1211ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_0 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 and not isNil(arg_325_1.actors_["1211ui_story"]) then
				if arg_325_1.var_.characterEffect1211ui_story and not isNil(arg_325_1.actors_["1211ui_story"]) then
					arg_325_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_325_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_325_1.time_ - 0) / var_328_0)
				end
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 and not isNil(arg_325_1.actors_["1211ui_story"]) and arg_325_1.var_.characterEffect1211ui_story then
				arg_325_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_325_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			local var_328_1 = 0
			local var_328_2 = 1

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, true)
				arg_325_1.iconController_:SetSelectedState("hero")

				arg_325_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_325_1.callingController_:SetSelectedState("normal")

				arg_325_1.keyicon_.color = Color.New(1, 1, 1)
				arg_325_1.icon_.color = Color.New(1, 1, 1)

				local var_328_3 = arg_325_1:FormatText(arg_325_1:GetWordFromCfg(322021081).content)

				arg_325_1.text_.text = var_328_3

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_5 = 40 <= 0 and var_328_2 or var_328_2 * (utf8.len(var_328_3) / 40)

				if (40 <= 0 and var_328_2 or var_328_2 * (utf8.len(var_328_3) / 40)) > 0 and var_328_2 < var_328_5 then
					arg_325_1.talkMaxDuration = var_328_5

					if var_328_5 + var_328_1 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_5 + var_328_1
					end
				end

				arg_325_1.text_.text = var_328_3
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_6 = math.max(var_328_2, arg_325_1.talkMaxDuration)

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_6 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_1) / var_328_6

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_1 + var_328_6 and arg_325_1.time_ < var_328_1 + var_328_6 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play322021082 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 322021082
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play322021083(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = 1.2

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, true)
				arg_329_1.iconController_:SetSelectedState("hero")

				arg_329_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_329_1.callingController_:SetSelectedState("normal")

				arg_329_1.keyicon_.color = Color.New(1, 1, 1)
				arg_329_1.icon_.color = Color.New(1, 1, 1)

				local var_332_1 = arg_329_1:FormatText(arg_329_1:GetWordFromCfg(322021082).content)

				arg_329_1.text_.text = var_332_1

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_3 = 48 <= 0 and var_332_0 or var_332_0 * (utf8.len(var_332_1) / 48)

				if (48 <= 0 and var_332_0 or var_332_0 * (utf8.len(var_332_1) / 48)) > 0 and var_332_0 < var_332_3 then
					arg_329_1.talkMaxDuration = var_332_3

					if var_332_3 + 0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_3 + 0
					end
				end

				arg_329_1.text_.text = var_332_1
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_4 = math.max(var_332_0, arg_329_1.talkMaxDuration)

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_4 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - 0) / var_332_4

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= 0 + var_332_4 and arg_329_1.time_ < 0 + var_332_4 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play322021083 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 322021083
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play322021084(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = 0.8

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, true)
				arg_333_1.iconController_:SetSelectedState("hero")

				arg_333_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_333_1.callingController_:SetSelectedState("normal")

				arg_333_1.keyicon_.color = Color.New(1, 1, 1)
				arg_333_1.icon_.color = Color.New(1, 1, 1)

				local var_336_1 = arg_333_1:FormatText(arg_333_1:GetWordFromCfg(322021083).content)

				arg_333_1.text_.text = var_336_1

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_3 = 32 <= 0 and var_336_0 or var_336_0 * (utf8.len(var_336_1) / 32)

				if (32 <= 0 and var_336_0 or var_336_0 * (utf8.len(var_336_1) / 32)) > 0 and var_336_0 < var_336_3 then
					arg_333_1.talkMaxDuration = var_336_3

					if var_336_3 + 0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_3 + 0
					end
				end

				arg_333_1.text_.text = var_336_1
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_4 = math.max(var_336_0, arg_333_1.talkMaxDuration)

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_4 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - 0) / var_336_4

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= 0 + var_336_4 and arg_333_1.time_ < 0 + var_336_4 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play322021084 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 322021084
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play322021085(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.var_.moveOldPos1211ui_story = arg_337_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_340_0 = 0.001

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 then
				arg_337_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_337_1.time_ - 0) / var_340_0)
				arg_337_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_337_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["1211ui_story"].transform.position).z)
				arg_337_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_337_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_337_1.actors_["1211ui_story"].transform.localEulerAngles = arg_337_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 then
				arg_337_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_337_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_337_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["1211ui_story"].transform.position).z)
				arg_337_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_337_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_337_1.actors_["1211ui_story"].transform.localEulerAngles = arg_337_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_340_1 = arg_337_1.actors_["1043ui_story"].transform

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.var_.moveOldPos1043ui_story = var_340_1.localPosition
			end

			local var_340_2 = 0.001

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_2 then
				var_340_1.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_337_1.time_ - 0) / var_340_2)
				var_340_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_340_1.position).x, (manager.ui.mainCamera.transform.position - var_340_1.position).y, (manager.ui.mainCamera.transform.position - var_340_1.position).z)
				var_340_1.localEulerAngles.z = 0
				var_340_1.localEulerAngles.x = 0
				var_340_1.localEulerAngles = var_340_1.localEulerAngles
			end

			if arg_337_1.time_ >= 0 + var_340_2 and arg_337_1.time_ < 0 + var_340_2 + arg_340_0 then
				var_340_1.localPosition = Vector3.New(0, 100, 0)
				var_340_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_340_1.position).x, (manager.ui.mainCamera.transform.position - var_340_1.position).y, (manager.ui.mainCamera.transform.position - var_340_1.position).z)
				var_340_1.localEulerAngles.z = 0
				var_340_1.localEulerAngles.x = 0
				var_340_1.localEulerAngles = var_340_1.localEulerAngles
			end

			local var_340_3 = arg_337_1.actors_["1061ui_story"].transform

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.var_.moveOldPos1061ui_story = var_340_3.localPosition
			end

			local var_340_4 = 0.001

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_4 then
				var_340_3.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_337_1.time_ - 0) / var_340_4)
				var_340_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_340_3.position).x, (manager.ui.mainCamera.transform.position - var_340_3.position).y, (manager.ui.mainCamera.transform.position - var_340_3.position).z)
				var_340_3.localEulerAngles.z = 0
				var_340_3.localEulerAngles.x = 0
				var_340_3.localEulerAngles = var_340_3.localEulerAngles
			end

			if arg_337_1.time_ >= 0 + var_340_4 and arg_337_1.time_ < 0 + var_340_4 + arg_340_0 then
				var_340_3.localPosition = Vector3.New(0, 100, 0)
				var_340_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_340_3.position).x, (manager.ui.mainCamera.transform.position - var_340_3.position).y, (manager.ui.mainCamera.transform.position - var_340_3.position).z)
				var_340_3.localEulerAngles.z = 0
				var_340_3.localEulerAngles.x = 0
				var_340_3.localEulerAngles = var_340_3.localEulerAngles
			end

			local var_340_5 = 0
			local var_340_6 = 1.375

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_5 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, false)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_7 = arg_337_1:FormatText(arg_337_1:GetWordFromCfg(322021084).content)

				arg_337_1.text_.text = var_340_7

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_9 = 55 <= 0 and var_340_6 or var_340_6 * (utf8.len(var_340_7) / 55)

				if (55 <= 0 and var_340_6 or var_340_6 * (utf8.len(var_340_7) / 55)) > 0 and var_340_6 < var_340_9 then
					arg_337_1.talkMaxDuration = var_340_9

					if var_340_9 + var_340_5 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_9 + var_340_5
					end
				end

				arg_337_1.text_.text = var_340_7
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_10 = math.max(var_340_6, arg_337_1.talkMaxDuration)

			if var_340_5 <= arg_337_1.time_ and arg_337_1.time_ < var_340_5 + var_340_10 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_5) / var_340_10

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_5 + var_340_10 and arg_337_1.time_ < var_340_5 + var_340_10 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_337_1:InitPlayNodeList()
	end,
	Play322021085 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 322021085
		arg_341_1.duration_ = 7.3

		local var_341_0 = {
			zh = 7.3,
			ja = 7.166
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play322021086(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.var_.moveOldPos1061ui_story = arg_341_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_344_0 = 0.001

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 then
				arg_341_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_341_1.time_ - 0) / var_344_0)
				arg_341_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1061ui_story"].transform.position).z)
				arg_341_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["1061ui_story"].transform.localEulerAngles = arg_341_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 then
				arg_341_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_341_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1061ui_story"].transform.position).z)
				arg_341_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["1061ui_story"].transform.localEulerAngles = arg_341_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_344_1 = arg_341_1.actors_["1061ui_story"]

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect1061ui_story == nil then
				arg_341_1.var_.characterEffect1061ui_story = var_344_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_2 = 0.200000002980232

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_2 and not isNil(var_344_1) then
				if arg_341_1.var_.characterEffect1061ui_story and not isNil(var_344_1) then
					arg_341_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= 0 + var_344_2 and arg_341_1.time_ < 0 + var_344_2 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect1061ui_story then
				arg_341_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_344_4 = 0
			local var_344_5 = 0.875

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_4 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_6 = arg_341_1:GetWordFromCfg(322021085)
				local var_344_7 = arg_341_1:FormatText(var_344_6.content)

				arg_341_1.text_.text = var_344_7

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_9 = 35 <= 0 and var_344_5 or var_344_5 * (utf8.len(var_344_7) / 35)

				if (35 <= 0 and var_344_5 or var_344_5 * (utf8.len(var_344_7) / 35)) > 0 and var_344_5 < var_344_9 then
					arg_341_1.talkMaxDuration = var_344_9

					if var_344_9 + var_344_4 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_9 + var_344_4
					end
				end

				arg_341_1.text_.text = var_344_7
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021085", "story_v_out_322021.awb") ~= 0 then
					local var_344_10 = manager.audio:GetVoiceLength("story_v_out_322021", "322021085", "story_v_out_322021.awb") / 1000

					if var_344_10 + var_344_4 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_10 + var_344_4
					end

					if var_344_6.prefab_name ~= "" and arg_341_1.actors_[var_344_6.prefab_name] ~= nil then
						local var_344_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_6.prefab_name].transform, "story_v_out_322021", "322021085", "story_v_out_322021.awb")

						arg_341_1:RecordAudio("322021085", var_344_11)
						arg_341_1:RecordAudio("322021085", var_344_11)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_322021", "322021085", "story_v_out_322021.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_322021", "322021085", "story_v_out_322021.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_12 = math.max(var_344_5, arg_341_1.talkMaxDuration)

			if var_344_4 <= arg_341_1.time_ and arg_341_1.time_ < var_344_4 + var_344_12 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_4) / var_344_12

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_4 + var_344_12 and arg_341_1.time_ < var_344_4 + var_344_12 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_341_1:InitPlayNodeList()
	end,
	Play322021086 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 322021086
		arg_345_1.duration_ = 9

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play322021087(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 2 < arg_345_1.time_ and arg_345_1.time_ <= 2 + arg_348_0 then
				local var_348_0 = arg_345_1.bgs_.L14f

				arg_345_1.bgs_.L14f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_348_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_348_1 = var_348_0:GetComponent("SpriteRenderer")

				if var_348_1 and var_348_1.sprite then
					local var_348_2 = 2 * (var_348_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_348_0.transform.localScale = Vector3.New(var_348_2 / var_348_1.sprite.bounds.size.y < var_348_2 * manager.ui.mainCameraCom_.aspect / var_348_1.sprite.bounds.size.x and var_348_2 * manager.ui.mainCameraCom_.aspect / var_348_1.sprite.bounds.size.x or var_348_2 / var_348_1.sprite.bounds.size.y, var_348_2 / var_348_1.sprite.bounds.size.y < var_348_2 * manager.ui.mainCameraCom_.aspect / var_348_1.sprite.bounds.size.x and var_348_2 * manager.ui.mainCameraCom_.aspect / var_348_1.sprite.bounds.size.x or var_348_2 / var_348_1.sprite.bounds.size.y, 0)
				end

				for iter_348_0, iter_348_1 in pairs(arg_345_1.bgs_) do
					if iter_348_0 ~= "L14f" then
						iter_348_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_348_3 = 4

			if 4 < arg_345_1.time_ and arg_345_1.time_ <= var_348_3 + arg_348_0 then
				arg_345_1.allBtn_.enabled = false
			end

			if arg_345_1.time_ >= var_348_3 + 0.3 and arg_345_1.time_ < var_348_3 + 0.3 + arg_348_0 then
				arg_345_1.allBtn_.enabled = true
			end

			local var_348_4 = 0

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_4 + arg_348_0 then
				arg_345_1.mask_.enabled = true
				arg_345_1.mask_.raycastTarget = true

				arg_345_1:SetGaussion(false)
			end

			local var_348_5 = 2

			if var_348_4 <= arg_345_1.time_ and arg_345_1.time_ < var_348_4 + var_348_5 then
				local var_348_6 = Color.New(0, 0, 0)

				var_348_6.a = Mathf.Lerp(0, 1, (arg_345_1.time_ - var_348_4) / var_348_5)
				arg_345_1.mask_.color = var_348_6
			end

			if arg_345_1.time_ >= var_348_4 + var_348_5 and arg_345_1.time_ < var_348_4 + var_348_5 + arg_348_0 then
				local var_348_7 = Color.New(0, 0, 0)

				var_348_7.a = 1
				arg_345_1.mask_.color = var_348_7
			end

			local var_348_8 = 2

			if 2 < arg_345_1.time_ and arg_345_1.time_ <= var_348_8 + arg_348_0 then
				arg_345_1.mask_.enabled = true
				arg_345_1.mask_.raycastTarget = true

				arg_345_1:SetGaussion(false)
			end

			local var_348_9 = 2

			if var_348_8 <= arg_345_1.time_ and arg_345_1.time_ < var_348_8 + var_348_9 then
				local var_348_10 = Color.New(0, 0, 0)

				var_348_10.a = Mathf.Lerp(1, 0, (arg_345_1.time_ - var_348_8) / var_348_9)
				arg_345_1.mask_.color = var_348_10
			end

			if arg_345_1.time_ >= var_348_8 + var_348_9 and arg_345_1.time_ < var_348_8 + var_348_9 + arg_348_0 then
				local var_348_11 = Color.New(0, 0, 0)

				arg_345_1.mask_.enabled = false
				var_348_11.a = 0
				arg_345_1.mask_.color = var_348_11
			end

			local var_348_12 = arg_345_1.actors_["1061ui_story"].transform

			if 1.96599999815226 < arg_345_1.time_ and arg_345_1.time_ <= 1.96599999815226 + arg_348_0 then
				arg_345_1.var_.moveOldPos1061ui_story = var_348_12.localPosition
			end

			local var_348_13 = 0.001

			if 1.96599999815226 <= arg_345_1.time_ and arg_345_1.time_ < 1.96599999815226 + var_348_13 then
				var_348_12.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_345_1.time_ - 1.96599999815226) / var_348_13)
				var_348_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_348_12.position).x, (manager.ui.mainCamera.transform.position - var_348_12.position).y, (manager.ui.mainCamera.transform.position - var_348_12.position).z)
				var_348_12.localEulerAngles.z = 0
				var_348_12.localEulerAngles.x = 0
				var_348_12.localEulerAngles = var_348_12.localEulerAngles
			end

			if arg_345_1.time_ >= 1.96599999815226 + var_348_13 and arg_345_1.time_ < 1.96599999815226 + var_348_13 + arg_348_0 then
				var_348_12.localPosition = Vector3.New(0, 100, 0)
				var_348_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_348_12.position).x, (manager.ui.mainCamera.transform.position - var_348_12.position).y, (manager.ui.mainCamera.transform.position - var_348_12.position).z)
				var_348_12.localEulerAngles.z = 0
				var_348_12.localEulerAngles.x = 0
				var_348_12.localEulerAngles = var_348_12.localEulerAngles
			end

			local var_348_14 = arg_345_1.actors_["1061ui_story"]

			if 1.96599999815226 < arg_345_1.time_ and arg_345_1.time_ <= 1.96599999815226 + arg_348_0 and not isNil(var_348_14) and arg_345_1.var_.characterEffect1061ui_story == nil then
				arg_345_1.var_.characterEffect1061ui_story = var_348_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_15 = 0.034000001847744

			if 1.96599999815226 <= arg_345_1.time_ and arg_345_1.time_ < 1.96599999815226 + var_348_15 and not isNil(var_348_14) then
				if arg_345_1.var_.characterEffect1061ui_story and not isNil(var_348_14) then
					arg_345_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_345_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_345_1.time_ - 1.96599999815226) / var_348_15)
				end
			end

			if arg_345_1.time_ >= 1.96599999815226 + var_348_15 and arg_345_1.time_ < 1.96599999815226 + var_348_15 + arg_348_0 and not isNil(var_348_14) and arg_345_1.var_.characterEffect1061ui_story then
				arg_345_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_345_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if arg_345_1.frameCnt_ <= 1 then
				arg_345_1.dialog_:SetActive(false)
			end

			local var_348_16 = 4
			local var_348_17 = 1.525

			if 4 < arg_345_1.time_ and arg_345_1.time_ <= var_348_16 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0

				arg_345_1.dialog_:SetActive(true)

				arg_345_1.dialogCg_.alpha = 0

				local var_348_18 = LeanTween.value(arg_345_1.dialog_, 0, 1, 0.3)

				var_348_18:setOnUpdate(LuaHelper.FloatAction(function(arg_349_0)
					arg_345_1.dialogCg_.alpha = arg_349_0
				end))
				var_348_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_345_1.dialog_)
					var_348_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_345_1.duration_ = arg_345_1.duration_ + 0.3

				SetActive(arg_345_1.leftNameGo_, false)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_19 = arg_345_1:FormatText(arg_345_1:GetWordFromCfg(322021086).content)

				arg_345_1.text_.text = var_348_19

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_21 = 61 <= 0 and var_348_17 or var_348_17 * (utf8.len(var_348_19) / 61)

				if (61 <= 0 and var_348_17 or var_348_17 * (utf8.len(var_348_19) / 61)) > 0 and var_348_17 < var_348_21 then
					arg_345_1.talkMaxDuration = var_348_21
					var_348_16 = var_348_16 + 0.3

					if var_348_21 + var_348_16 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_21 + var_348_16
					end
				end

				arg_345_1.text_.text = var_348_19
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_22 = var_348_16 + 0.3
			local var_348_23 = math.max(var_348_17, arg_345_1.talkMaxDuration)

			if var_348_16 + 0.3 <= arg_345_1.time_ and arg_345_1.time_ < var_348_22 + var_348_23 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_22) / var_348_23

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_22 + var_348_23 and arg_345_1.time_ < var_348_22 + var_348_23 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_345_1:InitPlayNodeList()
	end,
	Play322021087 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 322021087
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play322021088(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = 1.375

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, false)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_1 = arg_351_1:FormatText(arg_351_1:GetWordFromCfg(322021087).content)

				arg_351_1.text_.text = var_354_1

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_3 = 55 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_1) / 55)

				if (55 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_1) / 55)) > 0 and var_354_0 < var_354_3 then
					arg_351_1.talkMaxDuration = var_354_3

					if var_354_3 + 0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_3 + 0
					end
				end

				arg_351_1.text_.text = var_354_1
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_4 = math.max(var_354_0, arg_351_1.talkMaxDuration)

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_4 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - 0) / var_354_4

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= 0 + var_354_4 and arg_351_1.time_ < 0 + var_354_4 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play322021088 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 322021088
		arg_355_1.duration_ = 5.87

		local var_355_0 = {
			zh = 5,
			ja = 5.866
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play322021089(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.var_.moveOldPos404001ui_story = arg_355_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_358_0 = 0.001

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_0 then
				arg_355_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos404001ui_story, Vector3.New(-0.8, -1.55, -5.5), (arg_355_1.time_ - 0) / var_358_0)
				arg_355_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_355_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["404001ui_story"].transform.position).z)
				arg_355_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_355_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_355_1.actors_["404001ui_story"].transform.localEulerAngles = arg_355_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_355_1.time_ >= 0 + var_358_0 and arg_355_1.time_ < 0 + var_358_0 + arg_358_0 then
				arg_355_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(-0.8, -1.55, -5.5)
				arg_355_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_355_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["404001ui_story"].transform.position).z)
				arg_355_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_355_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_355_1.actors_["404001ui_story"].transform.localEulerAngles = arg_355_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_358_1 = arg_355_1.actors_["404001ui_story"]

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(var_358_1) and arg_355_1.var_.characterEffect404001ui_story == nil then
				arg_355_1.var_.characterEffect404001ui_story = var_358_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_2 = 0.200000002980232

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_2 and not isNil(var_358_1) then
				if arg_355_1.var_.characterEffect404001ui_story and not isNil(var_358_1) then
					arg_355_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_355_1.time_ >= 0 + var_358_2 and arg_355_1.time_ < 0 + var_358_2 + arg_358_0 and not isNil(var_358_1) and arg_355_1.var_.characterEffect404001ui_story then
				arg_355_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_358_4 = 0
			local var_358_5 = 0.5

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_4 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_6 = arg_355_1:GetWordFromCfg(322021088)
				local var_358_7 = arg_355_1:FormatText(var_358_6.content)

				arg_355_1.text_.text = var_358_7

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_9 = 20 <= 0 and var_358_5 or var_358_5 * (utf8.len(var_358_7) / 20)

				if (20 <= 0 and var_358_5 or var_358_5 * (utf8.len(var_358_7) / 20)) > 0 and var_358_5 < var_358_9 then
					arg_355_1.talkMaxDuration = var_358_9

					if var_358_9 + var_358_4 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_9 + var_358_4
					end
				end

				arg_355_1.text_.text = var_358_7
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021088", "story_v_out_322021.awb") ~= 0 then
					local var_358_10 = manager.audio:GetVoiceLength("story_v_out_322021", "322021088", "story_v_out_322021.awb") / 1000

					if var_358_10 + var_358_4 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_10 + var_358_4
					end

					if var_358_6.prefab_name ~= "" and arg_355_1.actors_[var_358_6.prefab_name] ~= nil then
						local var_358_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_6.prefab_name].transform, "story_v_out_322021", "322021088", "story_v_out_322021.awb")

						arg_355_1:RecordAudio("322021088", var_358_11)
						arg_355_1:RecordAudio("322021088", var_358_11)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_322021", "322021088", "story_v_out_322021.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_322021", "322021088", "story_v_out_322021.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_12 = math.max(var_358_5, arg_355_1.talkMaxDuration)

			if var_358_4 <= arg_355_1.time_ and arg_355_1.time_ < var_358_4 + var_358_12 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_4) / var_358_12

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_4 + var_358_12 and arg_355_1.time_ < var_358_4 + var_358_12 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_355_1:InitPlayNodeList()
	end,
	Play322021089 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 322021089
		arg_359_1.duration_ = 5.97

		local var_359_0 = {
			zh = 2.7,
			ja = 5.966
		}
		local var_359_1 = manager.audio:GetLocalizationFlag()

		if var_359_0[var_359_1] ~= nil then
			arg_359_1.duration_ = var_359_0[var_359_1]
		end

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play322021090(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.var_.moveOldPos1284ui_story = arg_359_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_362_0 = 0.001

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_0 then
				arg_359_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos1284ui_story, Vector3.New(0.7, -0.985, -6.22), (arg_359_1.time_ - 0) / var_362_0)
				arg_359_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_359_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1284ui_story"].transform.position).z)
				arg_359_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_359_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_359_1.actors_["1284ui_story"].transform.localEulerAngles = arg_359_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_359_1.time_ >= 0 + var_362_0 and arg_359_1.time_ < 0 + var_362_0 + arg_362_0 then
				arg_359_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.22)
				arg_359_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_359_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1284ui_story"].transform.position).z)
				arg_359_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_359_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_359_1.actors_["1284ui_story"].transform.localEulerAngles = arg_359_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_362_1 = arg_359_1.actors_["1284ui_story"]

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(var_362_1) and arg_359_1.var_.characterEffect1284ui_story == nil then
				arg_359_1.var_.characterEffect1284ui_story = var_362_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_2 = 0.200000002980232

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_2 and not isNil(var_362_1) then
				if arg_359_1.var_.characterEffect1284ui_story and not isNil(var_362_1) then
					arg_359_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_359_1.time_ >= 0 + var_362_2 and arg_359_1.time_ < 0 + var_362_2 + arg_362_0 and not isNil(var_362_1) and arg_359_1.var_.characterEffect1284ui_story then
				arg_359_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_362_4 = arg_359_1.actors_["404001ui_story"]

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(var_362_4) and arg_359_1.var_.characterEffect404001ui_story == nil then
				arg_359_1.var_.characterEffect404001ui_story = var_362_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_5 = 0.200000002980232

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_5 and not isNil(var_362_4) then
				if arg_359_1.var_.characterEffect404001ui_story and not isNil(var_362_4) then
					arg_359_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_359_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_359_1.time_ - 0) / var_362_5)
				end
			end

			if arg_359_1.time_ >= 0 + var_362_5 and arg_359_1.time_ < 0 + var_362_5 + arg_362_0 and not isNil(var_362_4) and arg_359_1.var_.characterEffect404001ui_story then
				arg_359_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_359_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action3_1")
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_362_6 = 0
			local var_362_7 = 0.325

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_6 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_8 = arg_359_1:GetWordFromCfg(322021089)
				local var_362_9 = arg_359_1:FormatText(var_362_8.content)

				arg_359_1.text_.text = var_362_9

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_11 = 13 <= 0 and var_362_7 or var_362_7 * (utf8.len(var_362_9) / 13)

				if (13 <= 0 and var_362_7 or var_362_7 * (utf8.len(var_362_9) / 13)) > 0 and var_362_7 < var_362_11 then
					arg_359_1.talkMaxDuration = var_362_11

					if var_362_11 + var_362_6 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_11 + var_362_6
					end
				end

				arg_359_1.text_.text = var_362_9
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021089", "story_v_out_322021.awb") ~= 0 then
					local var_362_12 = manager.audio:GetVoiceLength("story_v_out_322021", "322021089", "story_v_out_322021.awb") / 1000

					if var_362_12 + var_362_6 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_12 + var_362_6
					end

					if var_362_8.prefab_name ~= "" and arg_359_1.actors_[var_362_8.prefab_name] ~= nil then
						local var_362_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_8.prefab_name].transform, "story_v_out_322021", "322021089", "story_v_out_322021.awb")

						arg_359_1:RecordAudio("322021089", var_362_13)
						arg_359_1:RecordAudio("322021089", var_362_13)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_322021", "322021089", "story_v_out_322021.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_322021", "322021089", "story_v_out_322021.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_14 = math.max(var_362_7, arg_359_1.talkMaxDuration)

			if var_362_6 <= arg_359_1.time_ and arg_359_1.time_ < var_362_6 + var_362_14 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_6) / var_362_14

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_6 + var_362_14 and arg_359_1.time_ < var_362_6 + var_362_14 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_359_1:InitPlayNodeList()
	end,
	Play322021090 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 322021090
		arg_363_1.duration_ = 5.2

		local var_363_0 = {
			zh = 3.8,
			ja = 5.2
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play322021091(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action3_2")
			end

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_366_0 = 0
			local var_366_1 = 0.55

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_0 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_2 = arg_363_1:GetWordFromCfg(322021090)
				local var_366_3 = arg_363_1:FormatText(var_366_2.content)

				arg_363_1.text_.text = var_366_3

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_5 = 22 <= 0 and var_366_1 or var_366_1 * (utf8.len(var_366_3) / 22)

				if (22 <= 0 and var_366_1 or var_366_1 * (utf8.len(var_366_3) / 22)) > 0 and var_366_1 < var_366_5 then
					arg_363_1.talkMaxDuration = var_366_5

					if var_366_5 + var_366_0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_5 + var_366_0
					end
				end

				arg_363_1.text_.text = var_366_3
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021090", "story_v_out_322021.awb") ~= 0 then
					local var_366_6 = manager.audio:GetVoiceLength("story_v_out_322021", "322021090", "story_v_out_322021.awb") / 1000

					if var_366_6 + var_366_0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_6 + var_366_0
					end

					if var_366_2.prefab_name ~= "" and arg_363_1.actors_[var_366_2.prefab_name] ~= nil then
						local var_366_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_2.prefab_name].transform, "story_v_out_322021", "322021090", "story_v_out_322021.awb")

						arg_363_1:RecordAudio("322021090", var_366_7)
						arg_363_1:RecordAudio("322021090", var_366_7)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_322021", "322021090", "story_v_out_322021.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_322021", "322021090", "story_v_out_322021.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_8 = math.max(var_366_1, arg_363_1.talkMaxDuration)

			if var_366_0 <= arg_363_1.time_ and arg_363_1.time_ < var_366_0 + var_366_8 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_0) / var_366_8

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_0 + var_366_8 and arg_363_1.time_ < var_366_0 + var_366_8 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play322021091 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 322021091
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play322021092(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(arg_367_1.actors_["1284ui_story"]) and arg_367_1.var_.characterEffect1284ui_story == nil then
				arg_367_1.var_.characterEffect1284ui_story = arg_367_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_0 = 0.200000002980232

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_0 and not isNil(arg_367_1.actors_["1284ui_story"]) then
				if arg_367_1.var_.characterEffect1284ui_story and not isNil(arg_367_1.actors_["1284ui_story"]) then
					arg_367_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_367_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_367_1.time_ - 0) / var_370_0)
				end
			end

			if arg_367_1.time_ >= 0 + var_370_0 and arg_367_1.time_ < 0 + var_370_0 + arg_370_0 and not isNil(arg_367_1.actors_["1284ui_story"]) and arg_367_1.var_.characterEffect1284ui_story then
				arg_367_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_367_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			local var_370_1 = 0
			local var_370_2 = 0.325

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_1 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, true)
				arg_367_1.iconController_:SetSelectedState("hero")

				arg_367_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_367_1.callingController_:SetSelectedState("normal")

				arg_367_1.keyicon_.color = Color.New(1, 1, 1)
				arg_367_1.icon_.color = Color.New(1, 1, 1)

				local var_370_3 = arg_367_1:FormatText(arg_367_1:GetWordFromCfg(322021091).content)

				arg_367_1.text_.text = var_370_3

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_5 = 13 <= 0 and var_370_2 or var_370_2 * (utf8.len(var_370_3) / 13)

				if (13 <= 0 and var_370_2 or var_370_2 * (utf8.len(var_370_3) / 13)) > 0 and var_370_2 < var_370_5 then
					arg_367_1.talkMaxDuration = var_370_5

					if var_370_5 + var_370_1 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_5 + var_370_1
					end
				end

				arg_367_1.text_.text = var_370_3
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_6 = math.max(var_370_2, arg_367_1.talkMaxDuration)

			if var_370_1 <= arg_367_1.time_ and arg_367_1.time_ < var_370_1 + var_370_6 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_1) / var_370_6

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_1 + var_370_6 and arg_367_1.time_ < var_370_1 + var_370_6 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play322021092 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 322021092
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play322021093(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.var_.moveOldPos1284ui_story = arg_371_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_374_0 = 0.001

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_0 then
				arg_371_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_371_1.time_ - 0) / var_374_0)
				arg_371_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_371_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1284ui_story"].transform.position).z)
				arg_371_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_371_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_371_1.actors_["1284ui_story"].transform.localEulerAngles = arg_371_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_371_1.time_ >= 0 + var_374_0 and arg_371_1.time_ < 0 + var_374_0 + arg_374_0 then
				arg_371_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_371_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_371_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1284ui_story"].transform.position).z)
				arg_371_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_371_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_371_1.actors_["1284ui_story"].transform.localEulerAngles = arg_371_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_374_1 = arg_371_1.actors_["404001ui_story"].transform

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.var_.moveOldPos404001ui_story = var_374_1.localPosition
			end

			local var_374_2 = 0.001

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_2 then
				var_374_1.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_371_1.time_ - 0) / var_374_2)
				var_374_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_374_1.position).x, (manager.ui.mainCamera.transform.position - var_374_1.position).y, (manager.ui.mainCamera.transform.position - var_374_1.position).z)
				var_374_1.localEulerAngles.z = 0
				var_374_1.localEulerAngles.x = 0
				var_374_1.localEulerAngles = var_374_1.localEulerAngles
			end

			if arg_371_1.time_ >= 0 + var_374_2 and arg_371_1.time_ < 0 + var_374_2 + arg_374_0 then
				var_374_1.localPosition = Vector3.New(0, 100, 0)
				var_374_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_374_1.position).x, (manager.ui.mainCamera.transform.position - var_374_1.position).y, (manager.ui.mainCamera.transform.position - var_374_1.position).z)
				var_374_1.localEulerAngles.z = 0
				var_374_1.localEulerAngles.x = 0
				var_374_1.localEulerAngles = var_374_1.localEulerAngles
			end

			local var_374_3 = 0
			local var_374_4 = 0.65

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_3 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, false)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_5 = arg_371_1:FormatText(arg_371_1:GetWordFromCfg(322021092).content)

				arg_371_1.text_.text = var_374_5

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_7 = 26 <= 0 and var_374_4 or var_374_4 * (utf8.len(var_374_5) / 26)

				if (26 <= 0 and var_374_4 or var_374_4 * (utf8.len(var_374_5) / 26)) > 0 and var_374_4 < var_374_7 then
					arg_371_1.talkMaxDuration = var_374_7

					if var_374_7 + var_374_3 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_7 + var_374_3
					end
				end

				arg_371_1.text_.text = var_374_5
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_8 = math.max(var_374_4, arg_371_1.talkMaxDuration)

			if var_374_3 <= arg_371_1.time_ and arg_371_1.time_ < var_374_3 + var_374_8 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_3) / var_374_8

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_3 + var_374_8 and arg_371_1.time_ < var_374_3 + var_374_8 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_371_1:InitPlayNodeList()
	end,
	Play322021093 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 322021093
		arg_375_1.duration_ = 5

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play322021094(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = 0.15

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, true)
				arg_375_1.iconController_:SetSelectedState("hero")

				arg_375_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_375_1.callingController_:SetSelectedState("normal")

				arg_375_1.keyicon_.color = Color.New(1, 1, 1)
				arg_375_1.icon_.color = Color.New(1, 1, 1)

				local var_378_1 = arg_375_1:FormatText(arg_375_1:GetWordFromCfg(322021093).content)

				arg_375_1.text_.text = var_378_1

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_3 = 6 <= 0 and var_378_0 or var_378_0 * (utf8.len(var_378_1) / 6)

				if (6 <= 0 and var_378_0 or var_378_0 * (utf8.len(var_378_1) / 6)) > 0 and var_378_0 < var_378_3 then
					arg_375_1.talkMaxDuration = var_378_3

					if var_378_3 + 0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_3 + 0
					end
				end

				arg_375_1.text_.text = var_378_1
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)
				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_4 = math.max(var_378_0, arg_375_1.talkMaxDuration)

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_4 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - 0) / var_378_4

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= 0 + var_378_4 and arg_375_1.time_ < 0 + var_378_4 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play322021094 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 322021094
		arg_379_1.duration_ = 8.43

		local var_379_0 = {
			zh = 6.333,
			ja = 8.433
		}
		local var_379_1 = manager.audio:GetLocalizationFlag()

		if var_379_0[var_379_1] ~= nil then
			arg_379_1.duration_ = var_379_0[var_379_1]
		end

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play322021095(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.var_.moveOldPos404001ui_story = arg_379_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_382_0 = 0.001

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_0 then
				arg_379_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_379_1.time_ - 0) / var_382_0)
				arg_379_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_379_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["404001ui_story"].transform.position).z)
				arg_379_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_379_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_379_1.actors_["404001ui_story"].transform.localEulerAngles = arg_379_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_379_1.time_ >= 0 + var_382_0 and arg_379_1.time_ < 0 + var_382_0 + arg_382_0 then
				arg_379_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_379_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_379_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["404001ui_story"].transform.position).z)
				arg_379_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_379_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_379_1.actors_["404001ui_story"].transform.localEulerAngles = arg_379_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_382_1 = arg_379_1.actors_["404001ui_story"]

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(var_382_1) and arg_379_1.var_.characterEffect404001ui_story == nil then
				arg_379_1.var_.characterEffect404001ui_story = var_382_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_2 = 0.200000002980232

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_2 and not isNil(var_382_1) then
				if arg_379_1.var_.characterEffect404001ui_story and not isNil(var_382_1) then
					arg_379_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_379_1.time_ >= 0 + var_382_2 and arg_379_1.time_ < 0 + var_382_2 + arg_382_0 and not isNil(var_382_1) and arg_379_1.var_.characterEffect404001ui_story then
				arg_379_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action4_1")
			end

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_382_4 = 0
			local var_382_5 = 0.825

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_4 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_6 = arg_379_1:GetWordFromCfg(322021094)
				local var_382_7 = arg_379_1:FormatText(var_382_6.content)

				arg_379_1.text_.text = var_382_7

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_9 = 33 <= 0 and var_382_5 or var_382_5 * (utf8.len(var_382_7) / 33)

				if (33 <= 0 and var_382_5 or var_382_5 * (utf8.len(var_382_7) / 33)) > 0 and var_382_5 < var_382_9 then
					arg_379_1.talkMaxDuration = var_382_9

					if var_382_9 + var_382_4 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_9 + var_382_4
					end
				end

				arg_379_1.text_.text = var_382_7
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021094", "story_v_out_322021.awb") ~= 0 then
					local var_382_10 = manager.audio:GetVoiceLength("story_v_out_322021", "322021094", "story_v_out_322021.awb") / 1000

					if var_382_10 + var_382_4 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_10 + var_382_4
					end

					if var_382_6.prefab_name ~= "" and arg_379_1.actors_[var_382_6.prefab_name] ~= nil then
						local var_382_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_6.prefab_name].transform, "story_v_out_322021", "322021094", "story_v_out_322021.awb")

						arg_379_1:RecordAudio("322021094", var_382_11)
						arg_379_1:RecordAudio("322021094", var_382_11)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_322021", "322021094", "story_v_out_322021.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_322021", "322021094", "story_v_out_322021.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_12 = math.max(var_382_5, arg_379_1.talkMaxDuration)

			if var_382_4 <= arg_379_1.time_ and arg_379_1.time_ < var_382_4 + var_382_12 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_4) / var_382_12

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_4 + var_382_12 and arg_379_1.time_ < var_382_4 + var_382_12 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_379_1:InitPlayNodeList()
	end,
	Play322021095 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 322021095
		arg_383_1.duration_ = 9.1

		local var_383_0 = {
			zh = 7.2,
			ja = 9.1
		}
		local var_383_1 = manager.audio:GetLocalizationFlag()

		if var_383_0[var_383_1] ~= nil then
			arg_383_1.duration_ = var_383_0[var_383_1]
		end

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play322021096(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = 0.9

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_1 = arg_383_1:GetWordFromCfg(322021095)
				local var_386_2 = arg_383_1:FormatText(var_386_1.content)

				arg_383_1.text_.text = var_386_2

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_4 = 36 <= 0 and var_386_0 or var_386_0 * (utf8.len(var_386_2) / 36)

				if (36 <= 0 and var_386_0 or var_386_0 * (utf8.len(var_386_2) / 36)) > 0 and var_386_0 < var_386_4 then
					arg_383_1.talkMaxDuration = var_386_4

					if var_386_4 + 0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_4 + 0
					end
				end

				arg_383_1.text_.text = var_386_2
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021095", "story_v_out_322021.awb") ~= 0 then
					local var_386_5 = manager.audio:GetVoiceLength("story_v_out_322021", "322021095", "story_v_out_322021.awb") / 1000

					if var_386_5 + 0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_5 + 0
					end

					if var_386_1.prefab_name ~= "" and arg_383_1.actors_[var_386_1.prefab_name] ~= nil then
						local var_386_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_1.prefab_name].transform, "story_v_out_322021", "322021095", "story_v_out_322021.awb")

						arg_383_1:RecordAudio("322021095", var_386_6)
						arg_383_1:RecordAudio("322021095", var_386_6)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_322021", "322021095", "story_v_out_322021.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_322021", "322021095", "story_v_out_322021.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_7 = math.max(var_386_0, arg_383_1.talkMaxDuration)

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_7 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - 0) / var_386_7

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= 0 + var_386_7 and arg_383_1.time_ < 0 + var_386_7 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play322021096 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 322021096
		arg_387_1.duration_ = 5

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play322021097(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 and not isNil(arg_387_1.actors_["404001ui_story"]) and arg_387_1.var_.characterEffect404001ui_story == nil then
				arg_387_1.var_.characterEffect404001ui_story = arg_387_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_0 = 0.200000002980232

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_0 and not isNil(arg_387_1.actors_["404001ui_story"]) then
				if arg_387_1.var_.characterEffect404001ui_story and not isNil(arg_387_1.actors_["404001ui_story"]) then
					arg_387_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_387_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_387_1.time_ - 0) / var_390_0)
				end
			end

			if arg_387_1.time_ >= 0 + var_390_0 and arg_387_1.time_ < 0 + var_390_0 + arg_390_0 and not isNil(arg_387_1.actors_["404001ui_story"]) and arg_387_1.var_.characterEffect404001ui_story then
				arg_387_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_387_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			local var_390_1 = 0
			local var_390_2 = 0.3

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_1 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				arg_387_1.leftNameTxt_.text = arg_387_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, true)
				arg_387_1.iconController_:SetSelectedState("hero")

				arg_387_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_387_1.callingController_:SetSelectedState("normal")

				arg_387_1.keyicon_.color = Color.New(1, 1, 1)
				arg_387_1.icon_.color = Color.New(1, 1, 1)

				local var_390_3 = arg_387_1:FormatText(arg_387_1:GetWordFromCfg(322021096).content)

				arg_387_1.text_.text = var_390_3

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_5 = 12 <= 0 and var_390_2 or var_390_2 * (utf8.len(var_390_3) / 12)

				if (12 <= 0 and var_390_2 or var_390_2 * (utf8.len(var_390_3) / 12)) > 0 and var_390_2 < var_390_5 then
					arg_387_1.talkMaxDuration = var_390_5

					if var_390_5 + var_390_1 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_5 + var_390_1
					end
				end

				arg_387_1.text_.text = var_390_3
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)
				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_6 = math.max(var_390_2, arg_387_1.talkMaxDuration)

			if var_390_1 <= arg_387_1.time_ and arg_387_1.time_ < var_390_1 + var_390_6 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_1) / var_390_6

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_1 + var_390_6 and arg_387_1.time_ < var_390_1 + var_390_6 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play322021097 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 322021097
		arg_391_1.duration_ = 9.37

		local var_391_0 = {
			zh = 8.833,
			ja = 9.366
		}
		local var_391_1 = manager.audio:GetLocalizationFlag()

		if var_391_0[var_391_1] ~= nil then
			arg_391_1.duration_ = var_391_0[var_391_1]
		end

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play322021098(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 and not isNil(arg_391_1.actors_["404001ui_story"]) and arg_391_1.var_.characterEffect404001ui_story == nil then
				arg_391_1.var_.characterEffect404001ui_story = arg_391_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_0 = 0.200000002980232

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_0 and not isNil(arg_391_1.actors_["404001ui_story"]) then
				if arg_391_1.var_.characterEffect404001ui_story and not isNil(arg_391_1.actors_["404001ui_story"]) then
					arg_391_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_391_1.time_ >= 0 + var_394_0 and arg_391_1.time_ < 0 + var_394_0 + arg_394_0 and not isNil(arg_391_1.actors_["404001ui_story"]) and arg_391_1.var_.characterEffect404001ui_story then
				arg_391_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action4_2")
			end

			local var_394_2 = 0
			local var_394_3 = 1.05

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_2 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_4 = arg_391_1:GetWordFromCfg(322021097)
				local var_394_5 = arg_391_1:FormatText(var_394_4.content)

				arg_391_1.text_.text = var_394_5

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_7 = 42 <= 0 and var_394_3 or var_394_3 * (utf8.len(var_394_5) / 42)

				if (42 <= 0 and var_394_3 or var_394_3 * (utf8.len(var_394_5) / 42)) > 0 and var_394_3 < var_394_7 then
					arg_391_1.talkMaxDuration = var_394_7

					if var_394_7 + var_394_2 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_7 + var_394_2
					end
				end

				arg_391_1.text_.text = var_394_5
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021097", "story_v_out_322021.awb") ~= 0 then
					local var_394_8 = manager.audio:GetVoiceLength("story_v_out_322021", "322021097", "story_v_out_322021.awb") / 1000

					if var_394_8 + var_394_2 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_8 + var_394_2
					end

					if var_394_4.prefab_name ~= "" and arg_391_1.actors_[var_394_4.prefab_name] ~= nil then
						local var_394_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_4.prefab_name].transform, "story_v_out_322021", "322021097", "story_v_out_322021.awb")

						arg_391_1:RecordAudio("322021097", var_394_9)
						arg_391_1:RecordAudio("322021097", var_394_9)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_out_322021", "322021097", "story_v_out_322021.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_out_322021", "322021097", "story_v_out_322021.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_10 = math.max(var_394_3, arg_391_1.talkMaxDuration)

			if var_394_2 <= arg_391_1.time_ and arg_391_1.time_ < var_394_2 + var_394_10 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_2) / var_394_10

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_2 + var_394_10 and arg_391_1.time_ < var_394_2 + var_394_10 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play322021098 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 322021098
		arg_395_1.duration_ = 5

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play322021099(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 and not isNil(arg_395_1.actors_["404001ui_story"]) and arg_395_1.var_.characterEffect404001ui_story == nil then
				arg_395_1.var_.characterEffect404001ui_story = arg_395_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_0 = 0.200000002980232

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_0 and not isNil(arg_395_1.actors_["404001ui_story"]) then
				if arg_395_1.var_.characterEffect404001ui_story and not isNil(arg_395_1.actors_["404001ui_story"]) then
					arg_395_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_395_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_395_1.time_ - 0) / var_398_0)
				end
			end

			if arg_395_1.time_ >= 0 + var_398_0 and arg_395_1.time_ < 0 + var_398_0 + arg_398_0 and not isNil(arg_395_1.actors_["404001ui_story"]) and arg_395_1.var_.characterEffect404001ui_story then
				arg_395_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_395_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			local var_398_1 = 0
			local var_398_2 = 0.225

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_1 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, true)
				arg_395_1.iconController_:SetSelectedState("hero")

				arg_395_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_395_1.callingController_:SetSelectedState("normal")

				arg_395_1.keyicon_.color = Color.New(1, 1, 1)
				arg_395_1.icon_.color = Color.New(1, 1, 1)

				local var_398_3 = arg_395_1:FormatText(arg_395_1:GetWordFromCfg(322021098).content)

				arg_395_1.text_.text = var_398_3

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_5 = 9 <= 0 and var_398_2 or var_398_2 * (utf8.len(var_398_3) / 9)

				if (9 <= 0 and var_398_2 or var_398_2 * (utf8.len(var_398_3) / 9)) > 0 and var_398_2 < var_398_5 then
					arg_395_1.talkMaxDuration = var_398_5

					if var_398_5 + var_398_1 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_5 + var_398_1
					end
				end

				arg_395_1.text_.text = var_398_3
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)
				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_6 = math.max(var_398_2, arg_395_1.talkMaxDuration)

			if var_398_1 <= arg_395_1.time_ and arg_395_1.time_ < var_398_1 + var_398_6 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_1) / var_398_6

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_1 + var_398_6 and arg_395_1.time_ < var_398_1 + var_398_6 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play322021099 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 322021099
		arg_399_1.duration_ = 5

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play322021100(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1.var_.moveOldPos404001ui_story = arg_399_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_402_0 = 0.001

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_0 then
				arg_399_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_399_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_399_1.time_ - 0) / var_402_0)
				arg_399_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_399_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_399_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_399_1.actors_["404001ui_story"].transform.position).z)
				arg_399_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_399_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_399_1.actors_["404001ui_story"].transform.localEulerAngles = arg_399_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_399_1.time_ >= 0 + var_402_0 and arg_399_1.time_ < 0 + var_402_0 + arg_402_0 then
				arg_399_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_399_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_399_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_399_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_399_1.actors_["404001ui_story"].transform.position).z)
				arg_399_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_399_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_399_1.actors_["404001ui_story"].transform.localEulerAngles = arg_399_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_402_1 = 0
			local var_402_2 = 0.625

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_1 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, false)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_3 = arg_399_1:FormatText(arg_399_1:GetWordFromCfg(322021099).content)

				arg_399_1.text_.text = var_402_3

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_5 = 25 <= 0 and var_402_2 or var_402_2 * (utf8.len(var_402_3) / 25)

				if (25 <= 0 and var_402_2 or var_402_2 * (utf8.len(var_402_3) / 25)) > 0 and var_402_2 < var_402_5 then
					arg_399_1.talkMaxDuration = var_402_5

					if var_402_5 + var_402_1 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_5 + var_402_1
					end
				end

				arg_399_1.text_.text = var_402_3
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)
				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_6 = math.max(var_402_2, arg_399_1.talkMaxDuration)

			if var_402_1 <= arg_399_1.time_ and arg_399_1.time_ < var_402_1 + var_402_6 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_1) / var_402_6

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_1 + var_402_6 and arg_399_1.time_ < var_402_1 + var_402_6 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_399_1:InitPlayNodeList()
	end,
	Play322021100 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 322021100
		arg_403_1.duration_ = 5

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play322021101(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = 0.45

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, true)
				arg_403_1.iconController_:SetSelectedState("hero")

				arg_403_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_403_1.callingController_:SetSelectedState("normal")

				arg_403_1.keyicon_.color = Color.New(1, 1, 1)
				arg_403_1.icon_.color = Color.New(1, 1, 1)

				local var_406_1 = arg_403_1:FormatText(arg_403_1:GetWordFromCfg(322021100).content)

				arg_403_1.text_.text = var_406_1

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_3 = 18 <= 0 and var_406_0 or var_406_0 * (utf8.len(var_406_1) / 18)

				if (18 <= 0 and var_406_0 or var_406_0 * (utf8.len(var_406_1) / 18)) > 0 and var_406_0 < var_406_3 then
					arg_403_1.talkMaxDuration = var_406_3

					if var_406_3 + 0 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_3 + 0
					end
				end

				arg_403_1.text_.text = var_406_1
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)
				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_4 = math.max(var_406_0, arg_403_1.talkMaxDuration)

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_4 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - 0) / var_406_4

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= 0 + var_406_4 and arg_403_1.time_ < 0 + var_406_4 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play322021101 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 322021101
		arg_407_1.duration_ = 9

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play322021102(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			if arg_407_1.bgs_.L15 == nil then
				local var_410_0 = Object.Instantiate(arg_407_1.paintGo_)

				var_410_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L15")
				var_410_0.name = "L15"
				var_410_0.transform.parent = arg_407_1.stage_.transform
				var_410_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_407_1.bgs_.L15 = var_410_0
			end

			if 2 < arg_407_1.time_ and arg_407_1.time_ <= 2 + arg_410_0 then
				local var_410_1 = arg_407_1.bgs_.L15

				arg_407_1.bgs_.L15.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_410_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_410_2 = var_410_1:GetComponent("SpriteRenderer")

				if var_410_2 and var_410_2.sprite then
					local var_410_3 = 2 * (var_410_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_410_1.transform.localScale = Vector3.New(var_410_3 / var_410_2.sprite.bounds.size.y < var_410_3 * manager.ui.mainCameraCom_.aspect / var_410_2.sprite.bounds.size.x and var_410_3 * manager.ui.mainCameraCom_.aspect / var_410_2.sprite.bounds.size.x or var_410_3 / var_410_2.sprite.bounds.size.y, var_410_3 / var_410_2.sprite.bounds.size.y < var_410_3 * manager.ui.mainCameraCom_.aspect / var_410_2.sprite.bounds.size.x and var_410_3 * manager.ui.mainCameraCom_.aspect / var_410_2.sprite.bounds.size.x or var_410_3 / var_410_2.sprite.bounds.size.y, 0)
				end

				for iter_410_0, iter_410_1 in pairs(arg_407_1.bgs_) do
					if iter_410_0 ~= "L15" then
						iter_410_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_410_4 = 4

			if 4 < arg_407_1.time_ and arg_407_1.time_ <= var_410_4 + arg_410_0 then
				arg_407_1.allBtn_.enabled = false
			end

			if arg_407_1.time_ >= var_410_4 + 0.3 and arg_407_1.time_ < var_410_4 + 0.3 + arg_410_0 then
				arg_407_1.allBtn_.enabled = true
			end

			local var_410_5 = 0

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_5 + arg_410_0 then
				arg_407_1.mask_.enabled = true
				arg_407_1.mask_.raycastTarget = true

				arg_407_1:SetGaussion(false)
			end

			local var_410_6 = 2

			if var_410_5 <= arg_407_1.time_ and arg_407_1.time_ < var_410_5 + var_410_6 then
				local var_410_7 = Color.New(0, 0, 0)

				var_410_7.a = Mathf.Lerp(0, 1, (arg_407_1.time_ - var_410_5) / var_410_6)
				arg_407_1.mask_.color = var_410_7
			end

			if arg_407_1.time_ >= var_410_5 + var_410_6 and arg_407_1.time_ < var_410_5 + var_410_6 + arg_410_0 then
				local var_410_8 = Color.New(0, 0, 0)

				var_410_8.a = 1
				arg_407_1.mask_.color = var_410_8
			end

			local var_410_9 = 2

			if 2 < arg_407_1.time_ and arg_407_1.time_ <= var_410_9 + arg_410_0 then
				arg_407_1.mask_.enabled = true
				arg_407_1.mask_.raycastTarget = true

				arg_407_1:SetGaussion(false)
			end

			local var_410_10 = 2

			if var_410_9 <= arg_407_1.time_ and arg_407_1.time_ < var_410_9 + var_410_10 then
				local var_410_11 = Color.New(0, 0, 0)

				var_410_11.a = Mathf.Lerp(1, 0, (arg_407_1.time_ - var_410_9) / var_410_10)
				arg_407_1.mask_.color = var_410_11
			end

			if arg_407_1.time_ >= var_410_9 + var_410_10 and arg_407_1.time_ < var_410_9 + var_410_10 + arg_410_0 then
				local var_410_12 = Color.New(0, 0, 0)

				arg_407_1.mask_.enabled = false
				var_410_12.a = 0
				arg_407_1.mask_.color = var_410_12
			end

			if 0.2 < arg_407_1.time_ and arg_407_1.time_ <= 0.2 + arg_410_0 then
				arg_407_1:AudioAction("stop", "effect", "se_story_145", "se_story_145_amb_construction", "")
			end

			if 1.63333333333333 < arg_407_1.time_ and arg_407_1.time_ <= 1.63333333333333 + arg_410_0 then
				arg_407_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			if 4.06666666666667 < arg_407_1.time_ and arg_407_1.time_ <= 4.06666666666667 + arg_410_0 then
				arg_407_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_car02", "")
			end

			if arg_407_1.frameCnt_ <= 1 then
				arg_407_1.dialog_:SetActive(false)
			end

			local var_410_16 = 4
			local var_410_17 = 0.925

			if 4 < arg_407_1.time_ and arg_407_1.time_ <= var_410_16 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0

				arg_407_1.dialog_:SetActive(true)

				arg_407_1.dialogCg_.alpha = 0

				local var_410_18 = LeanTween.value(arg_407_1.dialog_, 0, 1, 0.3)

				var_410_18:setOnUpdate(LuaHelper.FloatAction(function(arg_411_0)
					arg_407_1.dialogCg_.alpha = arg_411_0
				end))
				var_410_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_407_1.dialog_)
					var_410_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_407_1.duration_ = arg_407_1.duration_ + 0.3

				SetActive(arg_407_1.leftNameGo_, false)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_19 = arg_407_1:FormatText(arg_407_1:GetWordFromCfg(322021101).content)

				arg_407_1.text_.text = var_410_19

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_21 = 37 <= 0 and var_410_17 or var_410_17 * (utf8.len(var_410_19) / 37)

				if (37 <= 0 and var_410_17 or var_410_17 * (utf8.len(var_410_19) / 37)) > 0 and var_410_17 < var_410_21 then
					arg_407_1.talkMaxDuration = var_410_21
					var_410_16 = var_410_16 + 0.3

					if var_410_21 + var_410_16 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_21 + var_410_16
					end
				end

				arg_407_1.text_.text = var_410_19
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)
				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_22 = var_410_16 + 0.3
			local var_410_23 = math.max(var_410_17, arg_407_1.talkMaxDuration)

			if var_410_16 + 0.3 <= arg_407_1.time_ and arg_407_1.time_ < var_410_22 + var_410_23 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_22) / var_410_23

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_22 + var_410_23 and arg_407_1.time_ < var_410_22 + var_410_23 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play322021102 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 322021102
		arg_413_1.duration_ = 5

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play322021103(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = 1.625

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, false)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_1 = arg_413_1:FormatText(arg_413_1:GetWordFromCfg(322021102).content)

				arg_413_1.text_.text = var_416_1

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_3 = 65 <= 0 and var_416_0 or var_416_0 * (utf8.len(var_416_1) / 65)

				if (65 <= 0 and var_416_0 or var_416_0 * (utf8.len(var_416_1) / 65)) > 0 and var_416_0 < var_416_3 then
					arg_413_1.talkMaxDuration = var_416_3

					if var_416_3 + 0 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_3 + 0
					end
				end

				arg_413_1.text_.text = var_416_1
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)
				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_4 = math.max(var_416_0, arg_413_1.talkMaxDuration)

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_4 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - 0) / var_416_4

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= 0 + var_416_4 and arg_413_1.time_ < 0 + var_416_4 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play322021103 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 322021103
		arg_417_1.duration_ = 2

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play322021104(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1.var_.moveOldPos1284ui_story = arg_417_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_420_0 = 0.001

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_0 then
				arg_417_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_417_1.var_.moveOldPos1284ui_story, Vector3.New(0, -0.985, -6.22), (arg_417_1.time_ - 0) / var_420_0)
				arg_417_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_417_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["1284ui_story"].transform.position).z)
				arg_417_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_417_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_417_1.actors_["1284ui_story"].transform.localEulerAngles = arg_417_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_417_1.time_ >= 0 + var_420_0 and arg_417_1.time_ < 0 + var_420_0 + arg_420_0 then
				arg_417_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.22)
				arg_417_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_417_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["1284ui_story"].transform.position).z)
				arg_417_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_417_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_417_1.actors_["1284ui_story"].transform.localEulerAngles = arg_417_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_420_1 = arg_417_1.actors_["1284ui_story"]

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(var_420_1) and arg_417_1.var_.characterEffect1284ui_story == nil then
				arg_417_1.var_.characterEffect1284ui_story = var_420_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_2 = 0.200000002980232

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_2 and not isNil(var_420_1) then
				if arg_417_1.var_.characterEffect1284ui_story and not isNil(var_420_1) then
					arg_417_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_417_1.time_ >= 0 + var_420_2 and arg_417_1.time_ < 0 + var_420_2 + arg_420_0 and not isNil(var_420_1) and arg_417_1.var_.characterEffect1284ui_story then
				arg_417_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_420_4 = 0
			local var_420_5 = 0.125

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_4 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				arg_417_1.leftNameTxt_.text = arg_417_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_6 = arg_417_1:GetWordFromCfg(322021103)
				local var_420_7 = arg_417_1:FormatText(var_420_6.content)

				arg_417_1.text_.text = var_420_7

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_9 = 5 <= 0 and var_420_5 or var_420_5 * (utf8.len(var_420_7) / 5)

				if (5 <= 0 and var_420_5 or var_420_5 * (utf8.len(var_420_7) / 5)) > 0 and var_420_5 < var_420_9 then
					arg_417_1.talkMaxDuration = var_420_9

					if var_420_9 + var_420_4 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_9 + var_420_4
					end
				end

				arg_417_1.text_.text = var_420_7
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021103", "story_v_out_322021.awb") ~= 0 then
					local var_420_10 = manager.audio:GetVoiceLength("story_v_out_322021", "322021103", "story_v_out_322021.awb") / 1000

					if var_420_10 + var_420_4 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_10 + var_420_4
					end

					if var_420_6.prefab_name ~= "" and arg_417_1.actors_[var_420_6.prefab_name] ~= nil then
						local var_420_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_6.prefab_name].transform, "story_v_out_322021", "322021103", "story_v_out_322021.awb")

						arg_417_1:RecordAudio("322021103", var_420_11)
						arg_417_1:RecordAudio("322021103", var_420_11)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_out_322021", "322021103", "story_v_out_322021.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_out_322021", "322021103", "story_v_out_322021.awb")
				end

				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_12 = math.max(var_420_5, arg_417_1.talkMaxDuration)

			if var_420_4 <= arg_417_1.time_ and arg_417_1.time_ < var_420_4 + var_420_12 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_4) / var_420_12

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_4 + var_420_12 and arg_417_1.time_ < var_420_4 + var_420_12 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_417_1:InitPlayNodeList()
	end,
	Play322021104 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 322021104
		arg_421_1.duration_ = 5

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play322021105(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 and not isNil(arg_421_1.actors_["1284ui_story"]) and arg_421_1.var_.characterEffect1284ui_story == nil then
				arg_421_1.var_.characterEffect1284ui_story = arg_421_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_0 = 0.200000002980232

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_0 and not isNil(arg_421_1.actors_["1284ui_story"]) then
				if arg_421_1.var_.characterEffect1284ui_story and not isNil(arg_421_1.actors_["1284ui_story"]) then
					arg_421_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_421_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_421_1.time_ - 0) / var_424_0)
				end
			end

			if arg_421_1.time_ >= 0 + var_424_0 and arg_421_1.time_ < 0 + var_424_0 + arg_424_0 and not isNil(arg_421_1.actors_["1284ui_story"]) and arg_421_1.var_.characterEffect1284ui_story then
				arg_421_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_421_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			local var_424_1 = 0
			local var_424_2 = 0.875

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_1 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				arg_421_1.leftNameTxt_.text = arg_421_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, true)
				arg_421_1.iconController_:SetSelectedState("hero")

				arg_421_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_421_1.callingController_:SetSelectedState("normal")

				arg_421_1.keyicon_.color = Color.New(1, 1, 1)
				arg_421_1.icon_.color = Color.New(1, 1, 1)

				local var_424_3 = arg_421_1:FormatText(arg_421_1:GetWordFromCfg(322021104).content)

				arg_421_1.text_.text = var_424_3

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_5 = 35 <= 0 and var_424_2 or var_424_2 * (utf8.len(var_424_3) / 35)

				if (35 <= 0 and var_424_2 or var_424_2 * (utf8.len(var_424_3) / 35)) > 0 and var_424_2 < var_424_5 then
					arg_421_1.talkMaxDuration = var_424_5

					if var_424_5 + var_424_1 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_5 + var_424_1
					end
				end

				arg_421_1.text_.text = var_424_3
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)
				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_6 = math.max(var_424_2, arg_421_1.talkMaxDuration)

			if var_424_1 <= arg_421_1.time_ and arg_421_1.time_ < var_424_1 + var_424_6 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_1) / var_424_6

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_1 + var_424_6 and arg_421_1.time_ < var_424_1 + var_424_6 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play322021105 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 322021105
		arg_425_1.duration_ = 5

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play322021106(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = 0.775

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				arg_425_1.leftNameTxt_.text = arg_425_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, true)
				arg_425_1.iconController_:SetSelectedState("hero")

				arg_425_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_425_1.callingController_:SetSelectedState("normal")

				arg_425_1.keyicon_.color = Color.New(1, 1, 1)
				arg_425_1.icon_.color = Color.New(1, 1, 1)

				local var_428_1 = arg_425_1:FormatText(arg_425_1:GetWordFromCfg(322021105).content)

				arg_425_1.text_.text = var_428_1

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_3 = 31 <= 0 and var_428_0 or var_428_0 * (utf8.len(var_428_1) / 31)

				if (31 <= 0 and var_428_0 or var_428_0 * (utf8.len(var_428_1) / 31)) > 0 and var_428_0 < var_428_3 then
					arg_425_1.talkMaxDuration = var_428_3

					if var_428_3 + 0 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_3 + 0
					end
				end

				arg_425_1.text_.text = var_428_1
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)
				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_4 = math.max(var_428_0, arg_425_1.talkMaxDuration)

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_4 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - 0) / var_428_4

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= 0 + var_428_4 and arg_425_1.time_ < 0 + var_428_4 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play322021106 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 322021106
		arg_429_1.duration_ = 2.77

		local var_429_0 = {
			zh = 2,
			ja = 2.766
		}
		local var_429_1 = manager.audio:GetLocalizationFlag()

		if var_429_0[var_429_1] ~= nil then
			arg_429_1.duration_ = var_429_0[var_429_1]
		end

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play322021107(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1.var_.moveOldPos1284ui_story = arg_429_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_432_0 = 0.001

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_0 then
				arg_429_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_429_1.var_.moveOldPos1284ui_story, Vector3.New(0, -0.985, -6.22), (arg_429_1.time_ - 0) / var_432_0)
				arg_429_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_429_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["1284ui_story"].transform.position).z)
				arg_429_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_429_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_429_1.actors_["1284ui_story"].transform.localEulerAngles = arg_429_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_429_1.time_ >= 0 + var_432_0 and arg_429_1.time_ < 0 + var_432_0 + arg_432_0 then
				arg_429_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.22)
				arg_429_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_429_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["1284ui_story"].transform.position).z)
				arg_429_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_429_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_429_1.actors_["1284ui_story"].transform.localEulerAngles = arg_429_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_432_1 = arg_429_1.actors_["1284ui_story"]

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 and not isNil(var_432_1) and arg_429_1.var_.characterEffect1284ui_story == nil then
				arg_429_1.var_.characterEffect1284ui_story = var_432_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_2 = 0.200000002980232

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_2 and not isNil(var_432_1) then
				if arg_429_1.var_.characterEffect1284ui_story and not isNil(var_432_1) then
					arg_429_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_429_1.time_ >= 0 + var_432_2 and arg_429_1.time_ < 0 + var_432_2 + arg_432_0 and not isNil(var_432_1) and arg_429_1.var_.characterEffect1284ui_story then
				arg_429_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action2_1")
			end

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_432_4 = 0
			local var_432_5 = 0.2

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_4 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				arg_429_1.leftNameTxt_.text = arg_429_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_6 = arg_429_1:GetWordFromCfg(322021106)
				local var_432_7 = arg_429_1:FormatText(var_432_6.content)

				arg_429_1.text_.text = var_432_7

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_9 = 8 <= 0 and var_432_5 or var_432_5 * (utf8.len(var_432_7) / 8)

				if (8 <= 0 and var_432_5 or var_432_5 * (utf8.len(var_432_7) / 8)) > 0 and var_432_5 < var_432_9 then
					arg_429_1.talkMaxDuration = var_432_9

					if var_432_9 + var_432_4 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_9 + var_432_4
					end
				end

				arg_429_1.text_.text = var_432_7
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021106", "story_v_out_322021.awb") ~= 0 then
					local var_432_10 = manager.audio:GetVoiceLength("story_v_out_322021", "322021106", "story_v_out_322021.awb") / 1000

					if var_432_10 + var_432_4 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_10 + var_432_4
					end

					if var_432_6.prefab_name ~= "" and arg_429_1.actors_[var_432_6.prefab_name] ~= nil then
						local var_432_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_429_1.actors_[var_432_6.prefab_name].transform, "story_v_out_322021", "322021106", "story_v_out_322021.awb")

						arg_429_1:RecordAudio("322021106", var_432_11)
						arg_429_1:RecordAudio("322021106", var_432_11)
					else
						arg_429_1:AudioAction("play", "voice", "story_v_out_322021", "322021106", "story_v_out_322021.awb")
					end

					arg_429_1:RecordHistoryTalkVoice("story_v_out_322021", "322021106", "story_v_out_322021.awb")
				end

				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_12 = math.max(var_432_5, arg_429_1.talkMaxDuration)

			if var_432_4 <= arg_429_1.time_ and arg_429_1.time_ < var_432_4 + var_432_12 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_4) / var_432_12

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_4 + var_432_12 and arg_429_1.time_ < var_432_4 + var_432_12 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_429_1:InitPlayNodeList()
	end,
	Play322021107 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 322021107
		arg_433_1.duration_ = 5

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play322021108(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 and not isNil(arg_433_1.actors_["1284ui_story"]) and arg_433_1.var_.characterEffect1284ui_story == nil then
				arg_433_1.var_.characterEffect1284ui_story = arg_433_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_0 = 0.200000002980232

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_0 and not isNil(arg_433_1.actors_["1284ui_story"]) then
				if arg_433_1.var_.characterEffect1284ui_story and not isNil(arg_433_1.actors_["1284ui_story"]) then
					arg_433_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_433_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_433_1.time_ - 0) / var_436_0)
				end
			end

			if arg_433_1.time_ >= 0 + var_436_0 and arg_433_1.time_ < 0 + var_436_0 + arg_436_0 and not isNil(arg_433_1.actors_["1284ui_story"]) and arg_433_1.var_.characterEffect1284ui_story then
				arg_433_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_433_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			local var_436_1 = 0
			local var_436_2 = 0.775

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_1 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				arg_433_1.leftNameTxt_.text = arg_433_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, true)
				arg_433_1.iconController_:SetSelectedState("hero")

				arg_433_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_433_1.callingController_:SetSelectedState("normal")

				arg_433_1.keyicon_.color = Color.New(1, 1, 1)
				arg_433_1.icon_.color = Color.New(1, 1, 1)

				local var_436_3 = arg_433_1:FormatText(arg_433_1:GetWordFromCfg(322021107).content)

				arg_433_1.text_.text = var_436_3

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_5 = 31 <= 0 and var_436_2 or var_436_2 * (utf8.len(var_436_3) / 31)

				if (31 <= 0 and var_436_2 or var_436_2 * (utf8.len(var_436_3) / 31)) > 0 and var_436_2 < var_436_5 then
					arg_433_1.talkMaxDuration = var_436_5

					if var_436_5 + var_436_1 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_5 + var_436_1
					end
				end

				arg_433_1.text_.text = var_436_3
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)
				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_6 = math.max(var_436_2, arg_433_1.talkMaxDuration)

			if var_436_1 <= arg_433_1.time_ and arg_433_1.time_ < var_436_1 + var_436_6 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_1) / var_436_6

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_1 + var_436_6 and arg_433_1.time_ < var_436_1 + var_436_6 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play322021108 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 322021108
		arg_437_1.duration_ = 2.13

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play322021109(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 and not isNil(arg_437_1.actors_["1284ui_story"]) and arg_437_1.var_.characterEffect1284ui_story == nil then
				arg_437_1.var_.characterEffect1284ui_story = arg_437_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_0 = 0.200000002980232

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_0 and not isNil(arg_437_1.actors_["1284ui_story"]) then
				if arg_437_1.var_.characterEffect1284ui_story and not isNil(arg_437_1.actors_["1284ui_story"]) then
					arg_437_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_437_1.time_ >= 0 + var_440_0 and arg_437_1.time_ < 0 + var_440_0 + arg_440_0 and not isNil(arg_437_1.actors_["1284ui_story"]) and arg_437_1.var_.characterEffect1284ui_story then
				arg_437_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action2_2")
			end

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_440_2 = 0
			local var_440_3 = 0.15

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_2 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				arg_437_1.leftNameTxt_.text = arg_437_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_4 = arg_437_1:GetWordFromCfg(322021108)
				local var_440_5 = arg_437_1:FormatText(var_440_4.content)

				arg_437_1.text_.text = var_440_5

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_7 = 6 <= 0 and var_440_3 or var_440_3 * (utf8.len(var_440_5) / 6)

				if (6 <= 0 and var_440_3 or var_440_3 * (utf8.len(var_440_5) / 6)) > 0 and var_440_3 < var_440_7 then
					arg_437_1.talkMaxDuration = var_440_7

					if var_440_7 + var_440_2 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_7 + var_440_2
					end
				end

				arg_437_1.text_.text = var_440_5
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021108", "story_v_out_322021.awb") ~= 0 then
					local var_440_8 = manager.audio:GetVoiceLength("story_v_out_322021", "322021108", "story_v_out_322021.awb") / 1000

					if var_440_8 + var_440_2 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_8 + var_440_2
					end

					if var_440_4.prefab_name ~= "" and arg_437_1.actors_[var_440_4.prefab_name] ~= nil then
						local var_440_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_4.prefab_name].transform, "story_v_out_322021", "322021108", "story_v_out_322021.awb")

						arg_437_1:RecordAudio("322021108", var_440_9)
						arg_437_1:RecordAudio("322021108", var_440_9)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_out_322021", "322021108", "story_v_out_322021.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_out_322021", "322021108", "story_v_out_322021.awb")
				end

				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_10 = math.max(var_440_3, arg_437_1.talkMaxDuration)

			if var_440_2 <= arg_437_1.time_ and arg_437_1.time_ < var_440_2 + var_440_10 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_2) / var_440_10

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_2 + var_440_10 and arg_437_1.time_ < var_440_2 + var_440_10 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play322021109 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 322021109
		arg_441_1.duration_ = 9

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play322021110(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			if 2 < arg_441_1.time_ and arg_441_1.time_ <= 2 + arg_444_0 then
				local var_444_0 = arg_441_1.bgs_.L14f

				arg_441_1.bgs_.L14f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_444_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_444_1 = var_444_0:GetComponent("SpriteRenderer")

				if var_444_1 and var_444_1.sprite then
					local var_444_2 = 2 * (var_444_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_444_0.transform.localScale = Vector3.New(var_444_2 / var_444_1.sprite.bounds.size.y < var_444_2 * manager.ui.mainCameraCom_.aspect / var_444_1.sprite.bounds.size.x and var_444_2 * manager.ui.mainCameraCom_.aspect / var_444_1.sprite.bounds.size.x or var_444_2 / var_444_1.sprite.bounds.size.y, var_444_2 / var_444_1.sprite.bounds.size.y < var_444_2 * manager.ui.mainCameraCom_.aspect / var_444_1.sprite.bounds.size.x and var_444_2 * manager.ui.mainCameraCom_.aspect / var_444_1.sprite.bounds.size.x or var_444_2 / var_444_1.sprite.bounds.size.y, 0)
				end

				for iter_444_0, iter_444_1 in pairs(arg_441_1.bgs_) do
					if iter_444_0 ~= "L14f" then
						iter_444_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_444_3 = 4

			if 4 < arg_441_1.time_ and arg_441_1.time_ <= var_444_3 + arg_444_0 then
				arg_441_1.allBtn_.enabled = false
			end

			if arg_441_1.time_ >= var_444_3 + 0.3 and arg_441_1.time_ < var_444_3 + 0.3 + arg_444_0 then
				arg_441_1.allBtn_.enabled = true
			end

			local var_444_4 = 0

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_4 + arg_444_0 then
				arg_441_1.mask_.enabled = true
				arg_441_1.mask_.raycastTarget = true

				arg_441_1:SetGaussion(false)
			end

			local var_444_5 = 2

			if var_444_4 <= arg_441_1.time_ and arg_441_1.time_ < var_444_4 + var_444_5 then
				local var_444_6 = Color.New(0, 0, 0)

				var_444_6.a = Mathf.Lerp(0, 1, (arg_441_1.time_ - var_444_4) / var_444_5)
				arg_441_1.mask_.color = var_444_6
			end

			if arg_441_1.time_ >= var_444_4 + var_444_5 and arg_441_1.time_ < var_444_4 + var_444_5 + arg_444_0 then
				local var_444_7 = Color.New(0, 0, 0)

				var_444_7.a = 1
				arg_441_1.mask_.color = var_444_7
			end

			local var_444_8 = 2

			if 2 < arg_441_1.time_ and arg_441_1.time_ <= var_444_8 + arg_444_0 then
				arg_441_1.mask_.enabled = true
				arg_441_1.mask_.raycastTarget = true

				arg_441_1:SetGaussion(false)
			end

			local var_444_9 = 2

			if var_444_8 <= arg_441_1.time_ and arg_441_1.time_ < var_444_8 + var_444_9 then
				local var_444_10 = Color.New(0, 0, 0)

				var_444_10.a = Mathf.Lerp(1, 0, (arg_441_1.time_ - var_444_8) / var_444_9)
				arg_441_1.mask_.color = var_444_10
			end

			if arg_441_1.time_ >= var_444_8 + var_444_9 and arg_441_1.time_ < var_444_8 + var_444_9 + arg_444_0 then
				local var_444_11 = Color.New(0, 0, 0)

				arg_441_1.mask_.enabled = false
				var_444_11.a = 0
				arg_441_1.mask_.color = var_444_11
			end

			local var_444_12 = arg_441_1.actors_["1284ui_story"].transform

			if 1.96599999815226 < arg_441_1.time_ and arg_441_1.time_ <= 1.96599999815226 + arg_444_0 then
				arg_441_1.var_.moveOldPos1284ui_story = var_444_12.localPosition
			end

			local var_444_13 = 0.001

			if 1.96599999815226 <= arg_441_1.time_ and arg_441_1.time_ < 1.96599999815226 + var_444_13 then
				var_444_12.localPosition = Vector3.Lerp(arg_441_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_441_1.time_ - 1.96599999815226) / var_444_13)
				var_444_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_444_12.position).x, (manager.ui.mainCamera.transform.position - var_444_12.position).y, (manager.ui.mainCamera.transform.position - var_444_12.position).z)
				var_444_12.localEulerAngles.z = 0
				var_444_12.localEulerAngles.x = 0
				var_444_12.localEulerAngles = var_444_12.localEulerAngles
			end

			if arg_441_1.time_ >= 1.96599999815226 + var_444_13 and arg_441_1.time_ < 1.96599999815226 + var_444_13 + arg_444_0 then
				var_444_12.localPosition = Vector3.New(0, 100, 0)
				var_444_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_444_12.position).x, (manager.ui.mainCamera.transform.position - var_444_12.position).y, (manager.ui.mainCamera.transform.position - var_444_12.position).z)
				var_444_12.localEulerAngles.z = 0
				var_444_12.localEulerAngles.x = 0
				var_444_12.localEulerAngles = var_444_12.localEulerAngles
			end

			local var_444_14 = arg_441_1.actors_["1284ui_story"]

			if 1.96599999815226 < arg_441_1.time_ and arg_441_1.time_ <= 1.96599999815226 + arg_444_0 and not isNil(var_444_14) and arg_441_1.var_.characterEffect1284ui_story == nil then
				arg_441_1.var_.characterEffect1284ui_story = var_444_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_444_15 = 0.034000001847744

			if 1.96599999815226 <= arg_441_1.time_ and arg_441_1.time_ < 1.96599999815226 + var_444_15 and not isNil(var_444_14) then
				if arg_441_1.var_.characterEffect1284ui_story and not isNil(var_444_14) then
					arg_441_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_441_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_441_1.time_ - 1.96599999815226) / var_444_15)
				end
			end

			if arg_441_1.time_ >= 1.96599999815226 + var_444_15 and arg_441_1.time_ < 1.96599999815226 + var_444_15 + arg_444_0 and not isNil(var_444_14) and arg_441_1.var_.characterEffect1284ui_story then
				arg_441_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_441_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 3.8 < arg_441_1.time_ and arg_441_1.time_ <= 3.8 + arg_444_0 then
				arg_441_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_plane02", "")
			end

			if arg_441_1.frameCnt_ <= 1 then
				arg_441_1.dialog_:SetActive(false)
			end

			local var_444_17 = 4
			local var_444_18 = 0.375

			if 4 < arg_441_1.time_ and arg_441_1.time_ <= var_444_17 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0

				arg_441_1.dialog_:SetActive(true)

				arg_441_1.dialogCg_.alpha = 0

				local var_444_19 = LeanTween.value(arg_441_1.dialog_, 0, 1, 0.3)

				var_444_19:setOnUpdate(LuaHelper.FloatAction(function(arg_445_0)
					arg_441_1.dialogCg_.alpha = arg_445_0
				end))
				var_444_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_441_1.dialog_)
					var_444_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_441_1.duration_ = arg_441_1.duration_ + 0.3

				SetActive(arg_441_1.leftNameGo_, false)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_20 = arg_441_1:FormatText(arg_441_1:GetWordFromCfg(322021109).content)

				arg_441_1.text_.text = var_444_20

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_22 = 15 <= 0 and var_444_18 or var_444_18 * (utf8.len(var_444_20) / 15)

				if (15 <= 0 and var_444_18 or var_444_18 * (utf8.len(var_444_20) / 15)) > 0 and var_444_18 < var_444_22 then
					arg_441_1.talkMaxDuration = var_444_22
					var_444_17 = var_444_17 + 0.3

					if var_444_22 + var_444_17 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_22 + var_444_17
					end
				end

				arg_441_1.text_.text = var_444_20
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)
				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_23 = var_444_17 + 0.3
			local var_444_24 = math.max(var_444_18, arg_441_1.talkMaxDuration)

			if var_444_17 + 0.3 <= arg_441_1.time_ and arg_441_1.time_ < var_444_23 + var_444_24 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_23) / var_444_24

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_23 + var_444_24 and arg_441_1.time_ < var_444_23 + var_444_24 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_441_1:InitPlayNodeList()
	end,
	Play322021110 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 322021110
		arg_447_1.duration_ = 14.8

		local var_447_0 = {
			zh = 7.2,
			ja = 14.8
		}
		local var_447_1 = manager.audio:GetLocalizationFlag()

		if var_447_0[var_447_1] ~= nil then
			arg_447_1.duration_ = var_447_0[var_447_1]
		end

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play322021111(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = 1.1

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				arg_447_1.leftNameTxt_.text = arg_447_1:FormatText(StoryNameCfg[672].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, true)
				arg_447_1.iconController_:SetSelectedState("hero")

				arg_447_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_447_1.callingController_:SetSelectedState("normal")

				arg_447_1.keyicon_.color = Color.New(1, 1, 1)
				arg_447_1.icon_.color = Color.New(1, 1, 1)

				local var_450_1 = arg_447_1:GetWordFromCfg(322021110)
				local var_450_2 = arg_447_1:FormatText(var_450_1.content)

				arg_447_1.text_.text = var_450_2

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_4 = 44 <= 0 and var_450_0 or var_450_0 * (utf8.len(var_450_2) / 44)

				if (44 <= 0 and var_450_0 or var_450_0 * (utf8.len(var_450_2) / 44)) > 0 and var_450_0 < var_450_4 then
					arg_447_1.talkMaxDuration = var_450_4

					if var_450_4 + 0 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_4 + 0
					end
				end

				arg_447_1.text_.text = var_450_2
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021110", "story_v_out_322021.awb") ~= 0 then
					local var_450_5 = manager.audio:GetVoiceLength("story_v_out_322021", "322021110", "story_v_out_322021.awb") / 1000

					if var_450_5 + 0 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_5 + 0
					end

					if var_450_1.prefab_name ~= "" and arg_447_1.actors_[var_450_1.prefab_name] ~= nil then
						local var_450_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_447_1.actors_[var_450_1.prefab_name].transform, "story_v_out_322021", "322021110", "story_v_out_322021.awb")

						arg_447_1:RecordAudio("322021110", var_450_6)
						arg_447_1:RecordAudio("322021110", var_450_6)
					else
						arg_447_1:AudioAction("play", "voice", "story_v_out_322021", "322021110", "story_v_out_322021.awb")
					end

					arg_447_1:RecordHistoryTalkVoice("story_v_out_322021", "322021110", "story_v_out_322021.awb")
				end

				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_7 = math.max(var_450_0, arg_447_1.talkMaxDuration)

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_7 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - 0) / var_450_7

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= 0 + var_450_7 and arg_447_1.time_ < 0 + var_450_7 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play322021111 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 322021111
		arg_451_1.duration_ = 5

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play322021112(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = 1.8

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, false)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_1 = arg_451_1:FormatText(arg_451_1:GetWordFromCfg(322021111).content)

				arg_451_1.text_.text = var_454_1

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_3 = 72 <= 0 and var_454_0 or var_454_0 * (utf8.len(var_454_1) / 72)

				if (72 <= 0 and var_454_0 or var_454_0 * (utf8.len(var_454_1) / 72)) > 0 and var_454_0 < var_454_3 then
					arg_451_1.talkMaxDuration = var_454_3

					if var_454_3 + 0 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_3 + 0
					end
				end

				arg_451_1.text_.text = var_454_1
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)
				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_4 = math.max(var_454_0, arg_451_1.talkMaxDuration)

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_4 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - 0) / var_454_4

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= 0 + var_454_4 and arg_451_1.time_ < 0 + var_454_4 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play322021112 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 322021112
		arg_455_1.duration_ = 5

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play322021113(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = 1.325

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, false)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_1 = arg_455_1:FormatText(arg_455_1:GetWordFromCfg(322021112).content)

				arg_455_1.text_.text = var_458_1

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_3 = 53 <= 0 and var_458_0 or var_458_0 * (utf8.len(var_458_1) / 53)

				if (53 <= 0 and var_458_0 or var_458_0 * (utf8.len(var_458_1) / 53)) > 0 and var_458_0 < var_458_3 then
					arg_455_1.talkMaxDuration = var_458_3

					if var_458_3 + 0 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_3 + 0
					end
				end

				arg_455_1.text_.text = var_458_1
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)
				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_4 = math.max(var_458_0, arg_455_1.talkMaxDuration)

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_4 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - 0) / var_458_4

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= 0 + var_458_4 and arg_455_1.time_ < 0 + var_458_4 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play322021113 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 322021113
		arg_459_1.duration_ = 5

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play322021114(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = 1.4

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, false)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_1 = arg_459_1:FormatText(arg_459_1:GetWordFromCfg(322021113).content)

				arg_459_1.text_.text = var_462_1

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_3 = 56 <= 0 and var_462_0 or var_462_0 * (utf8.len(var_462_1) / 56)

				if (56 <= 0 and var_462_0 or var_462_0 * (utf8.len(var_462_1) / 56)) > 0 and var_462_0 < var_462_3 then
					arg_459_1.talkMaxDuration = var_462_3

					if var_462_3 + 0 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_3 + 0
					end
				end

				arg_459_1.text_.text = var_462_1
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)
				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_4 = math.max(var_462_0, arg_459_1.talkMaxDuration)

			if 0 <= arg_459_1.time_ and arg_459_1.time_ < 0 + var_462_4 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - 0) / var_462_4

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= 0 + var_462_4 and arg_459_1.time_ < 0 + var_462_4 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play322021114 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 322021114
		arg_463_1.duration_ = 1.77

		local var_463_0 = {
			zh = 1.766,
			ja = 1.3
		}
		local var_463_1 = manager.audio:GetLocalizationFlag()

		if var_463_0[var_463_1] ~= nil then
			arg_463_1.duration_ = var_463_0[var_463_1]
		end

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play322021115(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = 0.125

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				arg_463_1.leftNameTxt_.text = arg_463_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, false)
				arg_463_1.callingController_:SetSelectedState("normal")

				local var_466_1 = arg_463_1:GetWordFromCfg(322021114)
				local var_466_2 = arg_463_1:FormatText(var_466_1.content)

				arg_463_1.text_.text = var_466_2

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_4 = 5 <= 0 and var_466_0 or var_466_0 * (utf8.len(var_466_2) / 5)

				if (5 <= 0 and var_466_0 or var_466_0 * (utf8.len(var_466_2) / 5)) > 0 and var_466_0 < var_466_4 then
					arg_463_1.talkMaxDuration = var_466_4

					if var_466_4 + 0 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_4 + 0
					end
				end

				arg_463_1.text_.text = var_466_2
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021114", "story_v_out_322021.awb") ~= 0 then
					local var_466_5 = manager.audio:GetVoiceLength("story_v_out_322021", "322021114", "story_v_out_322021.awb") / 1000

					if var_466_5 + 0 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_5 + 0
					end

					if var_466_1.prefab_name ~= "" and arg_463_1.actors_[var_466_1.prefab_name] ~= nil then
						local var_466_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_463_1.actors_[var_466_1.prefab_name].transform, "story_v_out_322021", "322021114", "story_v_out_322021.awb")

						arg_463_1:RecordAudio("322021114", var_466_6)
						arg_463_1:RecordAudio("322021114", var_466_6)
					else
						arg_463_1:AudioAction("play", "voice", "story_v_out_322021", "322021114", "story_v_out_322021.awb")
					end

					arg_463_1:RecordHistoryTalkVoice("story_v_out_322021", "322021114", "story_v_out_322021.awb")
				end

				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_7 = math.max(var_466_0, arg_463_1.talkMaxDuration)

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_7 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - 0) / var_466_7

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= 0 + var_466_7 and arg_463_1.time_ < 0 + var_466_7 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play322021115 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 322021115
		arg_467_1.duration_ = 1.03

		local var_467_0 = {
			zh = 1.033,
			ja = 0.999999999999
		}
		local var_467_1 = manager.audio:GetLocalizationFlag()

		if var_467_0[var_467_1] ~= nil then
			arg_467_1.duration_ = var_467_0[var_467_1]
		end

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play322021116(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			local var_470_0 = 0.0329999998211861

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, true)

				arg_467_1.leftNameTxt_.text = arg_467_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, true)
				arg_467_1.iconController_:SetSelectedState("hero")

				arg_467_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_467_1.callingController_:SetSelectedState("normal")

				arg_467_1.keyicon_.color = Color.New(1, 1, 1)
				arg_467_1.icon_.color = Color.New(1, 1, 1)

				local var_470_1 = arg_467_1:GetWordFromCfg(322021115)
				local var_470_2 = arg_467_1:FormatText(var_470_1.content)

				arg_467_1.text_.text = var_470_2

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_4 = 1 <= 0 and var_470_0 or var_470_0 * (utf8.len(var_470_2) / 1)

				if (1 <= 0 and var_470_0 or var_470_0 * (utf8.len(var_470_2) / 1)) > 0 and var_470_0 < var_470_4 then
					arg_467_1.talkMaxDuration = var_470_4

					if var_470_4 + 0 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_4 + 0
					end
				end

				arg_467_1.text_.text = var_470_2
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021115", "story_v_out_322021.awb") ~= 0 then
					local var_470_5 = manager.audio:GetVoiceLength("story_v_out_322021", "322021115", "story_v_out_322021.awb") / 1000

					if var_470_5 + 0 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_5 + 0
					end

					if var_470_1.prefab_name ~= "" and arg_467_1.actors_[var_470_1.prefab_name] ~= nil then
						local var_470_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_467_1.actors_[var_470_1.prefab_name].transform, "story_v_out_322021", "322021115", "story_v_out_322021.awb")

						arg_467_1:RecordAudio("322021115", var_470_6)
						arg_467_1:RecordAudio("322021115", var_470_6)
					else
						arg_467_1:AudioAction("play", "voice", "story_v_out_322021", "322021115", "story_v_out_322021.awb")
					end

					arg_467_1:RecordHistoryTalkVoice("story_v_out_322021", "322021115", "story_v_out_322021.awb")
				end

				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_7 = math.max(var_470_0, arg_467_1.talkMaxDuration)

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_7 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - 0) / var_470_7

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= 0 + var_470_7 and arg_467_1.time_ < 0 + var_470_7 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play322021116 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 322021116
		arg_471_1.duration_ = 5

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play322021117(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			if 0.1 < arg_471_1.time_ and arg_471_1.time_ <= 0.1 + arg_474_0 then
				arg_471_1:AudioAction("play", "effect", "se_story_side_1020", "se_story_side_1020_footstep_walk", "")
			end

			local var_474_1 = 0
			local var_474_2 = 1

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= var_474_1 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, false)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_3 = arg_471_1:FormatText(arg_471_1:GetWordFromCfg(322021116).content)

				arg_471_1.text_.text = var_474_3

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_5 = 40 <= 0 and var_474_2 or var_474_2 * (utf8.len(var_474_3) / 40)

				if (40 <= 0 and var_474_2 or var_474_2 * (utf8.len(var_474_3) / 40)) > 0 and var_474_2 < var_474_5 then
					arg_471_1.talkMaxDuration = var_474_5

					if var_474_5 + var_474_1 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_5 + var_474_1
					end
				end

				arg_471_1.text_.text = var_474_3
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)
				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_6 = math.max(var_474_2, arg_471_1.talkMaxDuration)

			if var_474_1 <= arg_471_1.time_ and arg_471_1.time_ < var_474_1 + var_474_6 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_1) / var_474_6

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_1 + var_474_6 and arg_471_1.time_ < var_474_1 + var_474_6 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {}

		arg_471_1:InitPlayNodeList()
	end,
	Play322021117 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 322021117
		arg_475_1.duration_ = 4.07

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play322021118(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1.var_.moveOldPos404001ui_story = arg_475_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_478_0 = 0.001

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_0 then
				arg_475_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_475_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_475_1.time_ - 0) / var_478_0)
				arg_475_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_475_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_475_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_475_1.actors_["404001ui_story"].transform.position).z)
				arg_475_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_475_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_475_1.actors_["404001ui_story"].transform.localEulerAngles = arg_475_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_475_1.time_ >= 0 + var_478_0 and arg_475_1.time_ < 0 + var_478_0 + arg_478_0 then
				arg_475_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_475_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_475_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_475_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_475_1.actors_["404001ui_story"].transform.position).z)
				arg_475_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_475_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_475_1.actors_["404001ui_story"].transform.localEulerAngles = arg_475_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_478_1 = arg_475_1.actors_["404001ui_story"]

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 and not isNil(var_478_1) and arg_475_1.var_.characterEffect404001ui_story == nil then
				arg_475_1.var_.characterEffect404001ui_story = var_478_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_478_2 = 0.200000002980232

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_2 and not isNil(var_478_1) then
				if arg_475_1.var_.characterEffect404001ui_story and not isNil(var_478_1) then
					arg_475_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_475_1.time_ >= 0 + var_478_2 and arg_475_1.time_ < 0 + var_478_2 + arg_478_0 and not isNil(var_478_1) and arg_475_1.var_.characterEffect404001ui_story then
				arg_475_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_478_4 = 0
			local var_478_5 = 0.3

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= var_478_4 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				arg_475_1.leftNameTxt_.text = arg_475_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, false)
				arg_475_1.callingController_:SetSelectedState("normal")

				local var_478_6 = arg_475_1:GetWordFromCfg(322021117)
				local var_478_7 = arg_475_1:FormatText(var_478_6.content)

				arg_475_1.text_.text = var_478_7

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_9 = 12 <= 0 and var_478_5 or var_478_5 * (utf8.len(var_478_7) / 12)

				if (12 <= 0 and var_478_5 or var_478_5 * (utf8.len(var_478_7) / 12)) > 0 and var_478_5 < var_478_9 then
					arg_475_1.talkMaxDuration = var_478_9

					if var_478_9 + var_478_4 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_9 + var_478_4
					end
				end

				arg_475_1.text_.text = var_478_7
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021117", "story_v_out_322021.awb") ~= 0 then
					local var_478_10 = manager.audio:GetVoiceLength("story_v_out_322021", "322021117", "story_v_out_322021.awb") / 1000

					if var_478_10 + var_478_4 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_10 + var_478_4
					end

					if var_478_6.prefab_name ~= "" and arg_475_1.actors_[var_478_6.prefab_name] ~= nil then
						local var_478_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_475_1.actors_[var_478_6.prefab_name].transform, "story_v_out_322021", "322021117", "story_v_out_322021.awb")

						arg_475_1:RecordAudio("322021117", var_478_11)
						arg_475_1:RecordAudio("322021117", var_478_11)
					else
						arg_475_1:AudioAction("play", "voice", "story_v_out_322021", "322021117", "story_v_out_322021.awb")
					end

					arg_475_1:RecordHistoryTalkVoice("story_v_out_322021", "322021117", "story_v_out_322021.awb")
				end

				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_12 = math.max(var_478_5, arg_475_1.talkMaxDuration)

			if var_478_4 <= arg_475_1.time_ and arg_475_1.time_ < var_478_4 + var_478_12 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_4) / var_478_12

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_4 + var_478_12 and arg_475_1.time_ < var_478_4 + var_478_12 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_475_1:InitPlayNodeList()
	end,
	Play322021118 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 322021118
		arg_479_1.duration_ = 6.03

		local var_479_0 = {
			zh = 4.6,
			ja = 6.033
		}
		local var_479_1 = manager.audio:GetLocalizationFlag()

		if var_479_0[var_479_1] ~= nil then
			arg_479_1.duration_ = var_479_0[var_479_1]
		end

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play322021119(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 and not isNil(arg_479_1.actors_["404001ui_story"]) and arg_479_1.var_.characterEffect404001ui_story == nil then
				arg_479_1.var_.characterEffect404001ui_story = arg_479_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_482_0 = 0.200000002980232

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_0 and not isNil(arg_479_1.actors_["404001ui_story"]) then
				if arg_479_1.var_.characterEffect404001ui_story and not isNil(arg_479_1.actors_["404001ui_story"]) then
					arg_479_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_479_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_479_1.time_ - 0) / var_482_0)
				end
			end

			if arg_479_1.time_ >= 0 + var_482_0 and arg_479_1.time_ < 0 + var_482_0 + arg_482_0 and not isNil(arg_479_1.actors_["404001ui_story"]) and arg_479_1.var_.characterEffect404001ui_story then
				arg_479_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_479_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			local var_482_1 = 0
			local var_482_2 = 0.525

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= var_482_1 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				arg_479_1.leftNameTxt_.text = arg_479_1:FormatText(StoryNameCfg[1167].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, true)
				arg_479_1.iconController_:SetSelectedState("hero")

				arg_479_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_479_1.callingController_:SetSelectedState("normal")

				arg_479_1.keyicon_.color = Color.New(1, 1, 1)
				arg_479_1.icon_.color = Color.New(1, 1, 1)

				local var_482_3 = arg_479_1:GetWordFromCfg(322021118)
				local var_482_4 = arg_479_1:FormatText(var_482_3.content)

				arg_479_1.text_.text = var_482_4

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_6 = 21 <= 0 and var_482_2 or var_482_2 * (utf8.len(var_482_4) / 21)

				if (21 <= 0 and var_482_2 or var_482_2 * (utf8.len(var_482_4) / 21)) > 0 and var_482_2 < var_482_6 then
					arg_479_1.talkMaxDuration = var_482_6

					if var_482_6 + var_482_1 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_6 + var_482_1
					end
				end

				arg_479_1.text_.text = var_482_4
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021118", "story_v_out_322021.awb") ~= 0 then
					local var_482_7 = manager.audio:GetVoiceLength("story_v_out_322021", "322021118", "story_v_out_322021.awb") / 1000

					if var_482_7 + var_482_1 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_7 + var_482_1
					end

					if var_482_3.prefab_name ~= "" and arg_479_1.actors_[var_482_3.prefab_name] ~= nil then
						local var_482_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_479_1.actors_[var_482_3.prefab_name].transform, "story_v_out_322021", "322021118", "story_v_out_322021.awb")

						arg_479_1:RecordAudio("322021118", var_482_8)
						arg_479_1:RecordAudio("322021118", var_482_8)
					else
						arg_479_1:AudioAction("play", "voice", "story_v_out_322021", "322021118", "story_v_out_322021.awb")
					end

					arg_479_1:RecordHistoryTalkVoice("story_v_out_322021", "322021118", "story_v_out_322021.awb")
				end

				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_9 = math.max(var_482_2, arg_479_1.talkMaxDuration)

			if var_482_1 <= arg_479_1.time_ and arg_479_1.time_ < var_482_1 + var_482_9 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_1) / var_482_9

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_1 + var_482_9 and arg_479_1.time_ < var_482_1 + var_482_9 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {}

		arg_479_1:InitPlayNodeList()
	end,
	Play322021119 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 322021119
		arg_483_1.duration_ = 22.8

		local var_483_0 = {
			zh = 11.766,
			ja = 22.8
		}
		local var_483_1 = manager.audio:GetLocalizationFlag()

		if var_483_0[var_483_1] ~= nil then
			arg_483_1.duration_ = var_483_0[var_483_1]
		end

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play322021120(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = 1.65

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, true)

				arg_483_1.leftNameTxt_.text = arg_483_1:FormatText(StoryNameCfg[1167].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_483_1.leftNameTxt_.transform)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1.leftNameTxt_.text)
				SetActive(arg_483_1.iconTrs_.gameObject, true)
				arg_483_1.iconController_:SetSelectedState("hero")

				arg_483_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_483_1.callingController_:SetSelectedState("normal")

				arg_483_1.keyicon_.color = Color.New(1, 1, 1)
				arg_483_1.icon_.color = Color.New(1, 1, 1)

				local var_486_1 = arg_483_1:GetWordFromCfg(322021119)
				local var_486_2 = arg_483_1:FormatText(var_486_1.content)

				arg_483_1.text_.text = var_486_2

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_4 = 66 <= 0 and var_486_0 or var_486_0 * (utf8.len(var_486_2) / 66)

				if (66 <= 0 and var_486_0 or var_486_0 * (utf8.len(var_486_2) / 66)) > 0 and var_486_0 < var_486_4 then
					arg_483_1.talkMaxDuration = var_486_4

					if var_486_4 + 0 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_4 + 0
					end
				end

				arg_483_1.text_.text = var_486_2
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021119", "story_v_out_322021.awb") ~= 0 then
					local var_486_5 = manager.audio:GetVoiceLength("story_v_out_322021", "322021119", "story_v_out_322021.awb") / 1000

					if var_486_5 + 0 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_5 + 0
					end

					if var_486_1.prefab_name ~= "" and arg_483_1.actors_[var_486_1.prefab_name] ~= nil then
						local var_486_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_483_1.actors_[var_486_1.prefab_name].transform, "story_v_out_322021", "322021119", "story_v_out_322021.awb")

						arg_483_1:RecordAudio("322021119", var_486_6)
						arg_483_1:RecordAudio("322021119", var_486_6)
					else
						arg_483_1:AudioAction("play", "voice", "story_v_out_322021", "322021119", "story_v_out_322021.awb")
					end

					arg_483_1:RecordHistoryTalkVoice("story_v_out_322021", "322021119", "story_v_out_322021.awb")
				end

				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_7 = math.max(var_486_0, arg_483_1.talkMaxDuration)

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_7 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - 0) / var_486_7

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= 0 + var_486_7 and arg_483_1.time_ < 0 + var_486_7 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {}

		arg_483_1:InitPlayNodeList()
	end,
	Play322021120 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 322021120
		arg_487_1.duration_ = 2.73

		local var_487_0 = {
			zh = 1.5,
			ja = 2.733
		}
		local var_487_1 = manager.audio:GetLocalizationFlag()

		if var_487_0[var_487_1] ~= nil then
			arg_487_1.duration_ = var_487_0[var_487_1]
		end

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play322021121(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = 0.2

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				arg_487_1.leftNameTxt_.text = arg_487_1:FormatText(StoryNameCfg[1167].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, true)
				arg_487_1.iconController_:SetSelectedState("hero")

				arg_487_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_487_1.callingController_:SetSelectedState("normal")

				arg_487_1.keyicon_.color = Color.New(1, 1, 1)
				arg_487_1.icon_.color = Color.New(1, 1, 1)

				local var_490_1 = arg_487_1:GetWordFromCfg(322021120)
				local var_490_2 = arg_487_1:FormatText(var_490_1.content)

				arg_487_1.text_.text = var_490_2

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_4 = 8 <= 0 and var_490_0 or var_490_0 * (utf8.len(var_490_2) / 8)

				if (8 <= 0 and var_490_0 or var_490_0 * (utf8.len(var_490_2) / 8)) > 0 and var_490_0 < var_490_4 then
					arg_487_1.talkMaxDuration = var_490_4

					if var_490_4 + 0 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_4 + 0
					end
				end

				arg_487_1.text_.text = var_490_2
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021120", "story_v_out_322021.awb") ~= 0 then
					local var_490_5 = manager.audio:GetVoiceLength("story_v_out_322021", "322021120", "story_v_out_322021.awb") / 1000

					if var_490_5 + 0 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_5 + 0
					end

					if var_490_1.prefab_name ~= "" and arg_487_1.actors_[var_490_1.prefab_name] ~= nil then
						local var_490_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_487_1.actors_[var_490_1.prefab_name].transform, "story_v_out_322021", "322021120", "story_v_out_322021.awb")

						arg_487_1:RecordAudio("322021120", var_490_6)
						arg_487_1:RecordAudio("322021120", var_490_6)
					else
						arg_487_1:AudioAction("play", "voice", "story_v_out_322021", "322021120", "story_v_out_322021.awb")
					end

					arg_487_1:RecordHistoryTalkVoice("story_v_out_322021", "322021120", "story_v_out_322021.awb")
				end

				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_7 = math.max(var_490_0, arg_487_1.talkMaxDuration)

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_7 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - 0) / var_490_7

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= 0 + var_490_7 and arg_487_1.time_ < 0 + var_490_7 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play322021121 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 322021121
		arg_491_1.duration_ = 2.7

		local var_491_0 = {
			zh = 2.133,
			ja = 2.7
		}
		local var_491_1 = manager.audio:GetLocalizationFlag()

		if var_491_0[var_491_1] ~= nil then
			arg_491_1.duration_ = var_491_0[var_491_1]
		end

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play322021122(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 and not isNil(arg_491_1.actors_["404001ui_story"]) and arg_491_1.var_.characterEffect404001ui_story == nil then
				arg_491_1.var_.characterEffect404001ui_story = arg_491_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_494_0 = 0.200000002980232

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_0 and not isNil(arg_491_1.actors_["404001ui_story"]) then
				if arg_491_1.var_.characterEffect404001ui_story and not isNil(arg_491_1.actors_["404001ui_story"]) then
					arg_491_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_491_1.time_ >= 0 + var_494_0 and arg_491_1.time_ < 0 + var_494_0 + arg_494_0 and not isNil(arg_491_1.actors_["404001ui_story"]) and arg_491_1.var_.characterEffect404001ui_story then
				arg_491_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			local var_494_2 = 0
			local var_494_3 = 0.225

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= var_494_2 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				arg_491_1.leftNameTxt_.text = arg_491_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_4 = arg_491_1:GetWordFromCfg(322021121)
				local var_494_5 = arg_491_1:FormatText(var_494_4.content)

				arg_491_1.text_.text = var_494_5

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_7 = 9 <= 0 and var_494_3 or var_494_3 * (utf8.len(var_494_5) / 9)

				if (9 <= 0 and var_494_3 or var_494_3 * (utf8.len(var_494_5) / 9)) > 0 and var_494_3 < var_494_7 then
					arg_491_1.talkMaxDuration = var_494_7

					if var_494_7 + var_494_2 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_7 + var_494_2
					end
				end

				arg_491_1.text_.text = var_494_5
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021121", "story_v_out_322021.awb") ~= 0 then
					local var_494_8 = manager.audio:GetVoiceLength("story_v_out_322021", "322021121", "story_v_out_322021.awb") / 1000

					if var_494_8 + var_494_2 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_8 + var_494_2
					end

					if var_494_4.prefab_name ~= "" and arg_491_1.actors_[var_494_4.prefab_name] ~= nil then
						local var_494_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_4.prefab_name].transform, "story_v_out_322021", "322021121", "story_v_out_322021.awb")

						arg_491_1:RecordAudio("322021121", var_494_9)
						arg_491_1:RecordAudio("322021121", var_494_9)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_out_322021", "322021121", "story_v_out_322021.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_out_322021", "322021121", "story_v_out_322021.awb")
				end

				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_10 = math.max(var_494_3, arg_491_1.talkMaxDuration)

			if var_494_2 <= arg_491_1.time_ and arg_491_1.time_ < var_494_2 + var_494_10 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_2) / var_494_10

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_2 + var_494_10 and arg_491_1.time_ < var_494_2 + var_494_10 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {}

		arg_491_1:InitPlayNodeList()
	end,
	Play322021122 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 322021122
		arg_495_1.duration_ = 9.27

		local var_495_0 = {
			zh = 7.733,
			ja = 9.266
		}
		local var_495_1 = manager.audio:GetLocalizationFlag()

		if var_495_0[var_495_1] ~= nil then
			arg_495_1.duration_ = var_495_0[var_495_1]
		end

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play322021123(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 and not isNil(arg_495_1.actors_["404001ui_story"]) and arg_495_1.var_.characterEffect404001ui_story == nil then
				arg_495_1.var_.characterEffect404001ui_story = arg_495_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_498_0 = 0.200000002980232

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_0 and not isNil(arg_495_1.actors_["404001ui_story"]) then
				if arg_495_1.var_.characterEffect404001ui_story and not isNil(arg_495_1.actors_["404001ui_story"]) then
					arg_495_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_495_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_495_1.time_ - 0) / var_498_0)
				end
			end

			if arg_495_1.time_ >= 0 + var_498_0 and arg_495_1.time_ < 0 + var_498_0 + arg_498_0 and not isNil(arg_495_1.actors_["404001ui_story"]) and arg_495_1.var_.characterEffect404001ui_story then
				arg_495_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_495_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			local var_498_1 = 0
			local var_498_2 = 0.85

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= var_498_1 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				arg_495_1.leftNameTxt_.text = arg_495_1:FormatText(StoryNameCfg[1167].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, true)
				arg_495_1.iconController_:SetSelectedState("hero")

				arg_495_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_495_1.callingController_:SetSelectedState("normal")

				arg_495_1.keyicon_.color = Color.New(1, 1, 1)
				arg_495_1.icon_.color = Color.New(1, 1, 1)

				local var_498_3 = arg_495_1:GetWordFromCfg(322021122)
				local var_498_4 = arg_495_1:FormatText(var_498_3.content)

				arg_495_1.text_.text = var_498_4

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_6 = 34 <= 0 and var_498_2 or var_498_2 * (utf8.len(var_498_4) / 34)

				if (34 <= 0 and var_498_2 or var_498_2 * (utf8.len(var_498_4) / 34)) > 0 and var_498_2 < var_498_6 then
					arg_495_1.talkMaxDuration = var_498_6

					if var_498_6 + var_498_1 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_6 + var_498_1
					end
				end

				arg_495_1.text_.text = var_498_4
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021122", "story_v_out_322021.awb") ~= 0 then
					local var_498_7 = manager.audio:GetVoiceLength("story_v_out_322021", "322021122", "story_v_out_322021.awb") / 1000

					if var_498_7 + var_498_1 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_7 + var_498_1
					end

					if var_498_3.prefab_name ~= "" and arg_495_1.actors_[var_498_3.prefab_name] ~= nil then
						local var_498_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_495_1.actors_[var_498_3.prefab_name].transform, "story_v_out_322021", "322021122", "story_v_out_322021.awb")

						arg_495_1:RecordAudio("322021122", var_498_8)
						arg_495_1:RecordAudio("322021122", var_498_8)
					else
						arg_495_1:AudioAction("play", "voice", "story_v_out_322021", "322021122", "story_v_out_322021.awb")
					end

					arg_495_1:RecordHistoryTalkVoice("story_v_out_322021", "322021122", "story_v_out_322021.awb")
				end

				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_9 = math.max(var_498_2, arg_495_1.talkMaxDuration)

			if var_498_1 <= arg_495_1.time_ and arg_495_1.time_ < var_498_1 + var_498_9 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_1) / var_498_9

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_1 + var_498_9 and arg_495_1.time_ < var_498_1 + var_498_9 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play322021123 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 322021123
		arg_499_1.duration_ = 5.07

		local var_499_0 = {
			zh = 4.766,
			ja = 5.066
		}
		local var_499_1 = manager.audio:GetLocalizationFlag()

		if var_499_0[var_499_1] ~= nil then
			arg_499_1.duration_ = var_499_0[var_499_1]
		end

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play322021124(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 and not isNil(arg_499_1.actors_["404001ui_story"]) and arg_499_1.var_.characterEffect404001ui_story == nil then
				arg_499_1.var_.characterEffect404001ui_story = arg_499_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_502_0 = 0.200000002980232

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_0 and not isNil(arg_499_1.actors_["404001ui_story"]) then
				if arg_499_1.var_.characterEffect404001ui_story and not isNil(arg_499_1.actors_["404001ui_story"]) then
					arg_499_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_499_1.time_ >= 0 + var_502_0 and arg_499_1.time_ < 0 + var_502_0 + arg_502_0 and not isNil(arg_499_1.actors_["404001ui_story"]) and arg_499_1.var_.characterEffect404001ui_story then
				arg_499_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_502_2 = 0
			local var_502_3 = 0.5

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= var_502_2 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				arg_499_1.leftNameTxt_.text = arg_499_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_4 = arg_499_1:GetWordFromCfg(322021123)
				local var_502_5 = arg_499_1:FormatText(var_502_4.content)

				arg_499_1.text_.text = var_502_5

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_7 = 20 <= 0 and var_502_3 or var_502_3 * (utf8.len(var_502_5) / 20)

				if (20 <= 0 and var_502_3 or var_502_3 * (utf8.len(var_502_5) / 20)) > 0 and var_502_3 < var_502_7 then
					arg_499_1.talkMaxDuration = var_502_7

					if var_502_7 + var_502_2 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_7 + var_502_2
					end
				end

				arg_499_1.text_.text = var_502_5
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021123", "story_v_out_322021.awb") ~= 0 then
					local var_502_8 = manager.audio:GetVoiceLength("story_v_out_322021", "322021123", "story_v_out_322021.awb") / 1000

					if var_502_8 + var_502_2 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_8 + var_502_2
					end

					if var_502_4.prefab_name ~= "" and arg_499_1.actors_[var_502_4.prefab_name] ~= nil then
						local var_502_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_4.prefab_name].transform, "story_v_out_322021", "322021123", "story_v_out_322021.awb")

						arg_499_1:RecordAudio("322021123", var_502_9)
						arg_499_1:RecordAudio("322021123", var_502_9)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_out_322021", "322021123", "story_v_out_322021.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_out_322021", "322021123", "story_v_out_322021.awb")
				end

				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_10 = math.max(var_502_3, arg_499_1.talkMaxDuration)

			if var_502_2 <= arg_499_1.time_ and arg_499_1.time_ < var_502_2 + var_502_10 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_2) / var_502_10

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_2 + var_502_10 and arg_499_1.time_ < var_502_2 + var_502_10 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {}

		arg_499_1:InitPlayNodeList()
	end,
	Play322021124 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 322021124
		arg_503_1.duration_ = 5

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play322021125(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1.var_.moveOldPos404001ui_story = arg_503_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_506_0 = 0.001

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_0 then
				arg_503_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_503_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_503_1.time_ - 0) / var_506_0)
				arg_503_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_503_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_503_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_503_1.actors_["404001ui_story"].transform.position).z)
				arg_503_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_503_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_503_1.actors_["404001ui_story"].transform.localEulerAngles = arg_503_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_503_1.time_ >= 0 + var_506_0 and arg_503_1.time_ < 0 + var_506_0 + arg_506_0 then
				arg_503_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_503_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_503_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_503_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_503_1.actors_["404001ui_story"].transform.position).z)
				arg_503_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_503_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_503_1.actors_["404001ui_story"].transform.localEulerAngles = arg_503_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_506_1 = 0
			local var_506_2 = 1

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_1 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, false)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_3 = arg_503_1:FormatText(arg_503_1:GetWordFromCfg(322021124).content)

				arg_503_1.text_.text = var_506_3

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_5 = 40 <= 0 and var_506_2 or var_506_2 * (utf8.len(var_506_3) / 40)

				if (40 <= 0 and var_506_2 or var_506_2 * (utf8.len(var_506_3) / 40)) > 0 and var_506_2 < var_506_5 then
					arg_503_1.talkMaxDuration = var_506_5

					if var_506_5 + var_506_1 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_5 + var_506_1
					end
				end

				arg_503_1.text_.text = var_506_3
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)
				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_6 = math.max(var_506_2, arg_503_1.talkMaxDuration)

			if var_506_1 <= arg_503_1.time_ and arg_503_1.time_ < var_506_1 + var_506_6 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_1) / var_506_6

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_1 + var_506_6 and arg_503_1.time_ < var_506_1 + var_506_6 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_503_1:InitPlayNodeList()
	end,
	Play322021125 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 322021125
		arg_507_1.duration_ = 5

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play322021126(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			if 0.633333333333333 < arg_507_1.time_ and arg_507_1.time_ <= 0.633333333333333 + arg_510_0 then
				arg_507_1:AudioAction("play", "effect", "se_story_side_1033", "se_story_side_1033_footstep", "")
			end

			local var_510_1 = 0
			local var_510_2 = 1.075

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_1 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, false)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_3 = arg_507_1:FormatText(arg_507_1:GetWordFromCfg(322021125).content)

				arg_507_1.text_.text = var_510_3

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_5 = 43 <= 0 and var_510_2 or var_510_2 * (utf8.len(var_510_3) / 43)

				if (43 <= 0 and var_510_2 or var_510_2 * (utf8.len(var_510_3) / 43)) > 0 and var_510_2 < var_510_5 then
					arg_507_1.talkMaxDuration = var_510_5

					if var_510_5 + var_510_1 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_5 + var_510_1
					end
				end

				arg_507_1.text_.text = var_510_3
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)
				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_6 = math.max(var_510_2, arg_507_1.talkMaxDuration)

			if var_510_1 <= arg_507_1.time_ and arg_507_1.time_ < var_510_1 + var_510_6 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_1) / var_510_6

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_1 + var_510_6 and arg_507_1.time_ < var_510_1 + var_510_6 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play322021126 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 322021126
		arg_511_1.duration_ = 19

		local var_511_0 = {
			zh = 10.833,
			ja = 19
		}
		local var_511_1 = manager.audio:GetLocalizationFlag()

		if var_511_0[var_511_1] ~= nil then
			arg_511_1.duration_ = var_511_0[var_511_1]
		end

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play322021127(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			local var_514_0 = 1.4

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				arg_511_1.leftNameTxt_.text = arg_511_1:FormatText(StoryNameCfg[1167].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, true)
				arg_511_1.iconController_:SetSelectedState("hero")

				arg_511_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_511_1.callingController_:SetSelectedState("normal")

				arg_511_1.keyicon_.color = Color.New(1, 1, 1)
				arg_511_1.icon_.color = Color.New(1, 1, 1)

				local var_514_1 = arg_511_1:GetWordFromCfg(322021126)
				local var_514_2 = arg_511_1:FormatText(var_514_1.content)

				arg_511_1.text_.text = var_514_2

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_4 = 56 <= 0 and var_514_0 or var_514_0 * (utf8.len(var_514_2) / 56)

				if (56 <= 0 and var_514_0 or var_514_0 * (utf8.len(var_514_2) / 56)) > 0 and var_514_0 < var_514_4 then
					arg_511_1.talkMaxDuration = var_514_4

					if var_514_4 + 0 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_4 + 0
					end
				end

				arg_511_1.text_.text = var_514_2
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021126", "story_v_out_322021.awb") ~= 0 then
					local var_514_5 = manager.audio:GetVoiceLength("story_v_out_322021", "322021126", "story_v_out_322021.awb") / 1000

					if var_514_5 + 0 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_5 + 0
					end

					if var_514_1.prefab_name ~= "" and arg_511_1.actors_[var_514_1.prefab_name] ~= nil then
						local var_514_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_511_1.actors_[var_514_1.prefab_name].transform, "story_v_out_322021", "322021126", "story_v_out_322021.awb")

						arg_511_1:RecordAudio("322021126", var_514_6)
						arg_511_1:RecordAudio("322021126", var_514_6)
					else
						arg_511_1:AudioAction("play", "voice", "story_v_out_322021", "322021126", "story_v_out_322021.awb")
					end

					arg_511_1:RecordHistoryTalkVoice("story_v_out_322021", "322021126", "story_v_out_322021.awb")
				end

				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_7 = math.max(var_514_0, arg_511_1.talkMaxDuration)

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_7 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - 0) / var_514_7

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= 0 + var_514_7 and arg_511_1.time_ < 0 + var_514_7 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	Play322021127 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 322021127
		arg_515_1.duration_ = 4.4

		local var_515_0 = {
			zh = 3.166,
			ja = 4.4
		}
		local var_515_1 = manager.audio:GetLocalizationFlag()

		if var_515_0[var_515_1] ~= nil then
			arg_515_1.duration_ = var_515_0[var_515_1]
		end

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play322021128(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			local var_518_0 = 0.425

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				arg_515_1.leftNameTxt_.text = arg_515_1:FormatText(StoryNameCfg[1167].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, true)
				arg_515_1.iconController_:SetSelectedState("hero")

				arg_515_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_515_1.callingController_:SetSelectedState("normal")

				arg_515_1.keyicon_.color = Color.New(1, 1, 1)
				arg_515_1.icon_.color = Color.New(1, 1, 1)

				local var_518_1 = arg_515_1:GetWordFromCfg(322021127)
				local var_518_2 = arg_515_1:FormatText(var_518_1.content)

				arg_515_1.text_.text = var_518_2

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_4 = 17 <= 0 and var_518_0 or var_518_0 * (utf8.len(var_518_2) / 17)

				if (17 <= 0 and var_518_0 or var_518_0 * (utf8.len(var_518_2) / 17)) > 0 and var_518_0 < var_518_4 then
					arg_515_1.talkMaxDuration = var_518_4

					if var_518_4 + 0 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_4 + 0
					end
				end

				arg_515_1.text_.text = var_518_2
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021127", "story_v_out_322021.awb") ~= 0 then
					local var_518_5 = manager.audio:GetVoiceLength("story_v_out_322021", "322021127", "story_v_out_322021.awb") / 1000

					if var_518_5 + 0 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_5 + 0
					end

					if var_518_1.prefab_name ~= "" and arg_515_1.actors_[var_518_1.prefab_name] ~= nil then
						local var_518_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_515_1.actors_[var_518_1.prefab_name].transform, "story_v_out_322021", "322021127", "story_v_out_322021.awb")

						arg_515_1:RecordAudio("322021127", var_518_6)
						arg_515_1:RecordAudio("322021127", var_518_6)
					else
						arg_515_1:AudioAction("play", "voice", "story_v_out_322021", "322021127", "story_v_out_322021.awb")
					end

					arg_515_1:RecordHistoryTalkVoice("story_v_out_322021", "322021127", "story_v_out_322021.awb")
				end

				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_7 = math.max(var_518_0, arg_515_1.talkMaxDuration)

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_7 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - 0) / var_518_7

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= 0 + var_518_7 and arg_515_1.time_ < 0 + var_518_7 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {}

		arg_515_1:InitPlayNodeList()
	end,
	Play322021128 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 322021128
		arg_519_1.duration_ = 6.07

		local var_519_0 = {
			zh = 3.8,
			ja = 6.066
		}
		local var_519_1 = manager.audio:GetLocalizationFlag()

		if var_519_0[var_519_1] ~= nil then
			arg_519_1.duration_ = var_519_0[var_519_1]
		end

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play322021129(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1.var_.moveOldPos404001ui_story = arg_519_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_522_0 = 0.001

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_0 then
				arg_519_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_519_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_519_1.time_ - 0) / var_522_0)
				arg_519_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_519_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_519_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_519_1.actors_["404001ui_story"].transform.position).z)
				arg_519_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_519_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_519_1.actors_["404001ui_story"].transform.localEulerAngles = arg_519_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_519_1.time_ >= 0 + var_522_0 and arg_519_1.time_ < 0 + var_522_0 + arg_522_0 then
				arg_519_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_519_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_519_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_519_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_519_1.actors_["404001ui_story"].transform.position).z)
				arg_519_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_519_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_519_1.actors_["404001ui_story"].transform.localEulerAngles = arg_519_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_522_1 = arg_519_1.actors_["404001ui_story"]

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 and not isNil(var_522_1) and arg_519_1.var_.characterEffect404001ui_story == nil then
				arg_519_1.var_.characterEffect404001ui_story = var_522_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_522_2 = 0.200000002980232

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_2 and not isNil(var_522_1) then
				if arg_519_1.var_.characterEffect404001ui_story and not isNil(var_522_1) then
					arg_519_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_519_1.time_ >= 0 + var_522_2 and arg_519_1.time_ < 0 + var_522_2 + arg_522_0 and not isNil(var_522_1) and arg_519_1.var_.characterEffect404001ui_story then
				arg_519_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_2")
			end

			local var_522_4 = 0
			local var_522_5 = 0.4

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= var_522_4 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				arg_519_1.leftNameTxt_.text = arg_519_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_6 = arg_519_1:GetWordFromCfg(322021128)
				local var_522_7 = arg_519_1:FormatText(var_522_6.content)

				arg_519_1.text_.text = var_522_7

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_9 = 16 <= 0 and var_522_5 or var_522_5 * (utf8.len(var_522_7) / 16)

				if (16 <= 0 and var_522_5 or var_522_5 * (utf8.len(var_522_7) / 16)) > 0 and var_522_5 < var_522_9 then
					arg_519_1.talkMaxDuration = var_522_9

					if var_522_9 + var_522_4 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_9 + var_522_4
					end
				end

				arg_519_1.text_.text = var_522_7
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021128", "story_v_out_322021.awb") ~= 0 then
					local var_522_10 = manager.audio:GetVoiceLength("story_v_out_322021", "322021128", "story_v_out_322021.awb") / 1000

					if var_522_10 + var_522_4 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_10 + var_522_4
					end

					if var_522_6.prefab_name ~= "" and arg_519_1.actors_[var_522_6.prefab_name] ~= nil then
						local var_522_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_6.prefab_name].transform, "story_v_out_322021", "322021128", "story_v_out_322021.awb")

						arg_519_1:RecordAudio("322021128", var_522_11)
						arg_519_1:RecordAudio("322021128", var_522_11)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_out_322021", "322021128", "story_v_out_322021.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_out_322021", "322021128", "story_v_out_322021.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_12 = math.max(var_522_5, arg_519_1.talkMaxDuration)

			if var_522_4 <= arg_519_1.time_ and arg_519_1.time_ < var_522_4 + var_522_12 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_4) / var_522_12

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_4 + var_522_12 and arg_519_1.time_ < var_522_4 + var_522_12 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_519_1:InitPlayNodeList()
	end,
	Play322021129 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 322021129
		arg_523_1.duration_ = 1.5

		local var_523_0 = {
			zh = 1.033,
			ja = 1.5
		}
		local var_523_1 = manager.audio:GetLocalizationFlag()

		if var_523_0[var_523_1] ~= nil then
			arg_523_1.duration_ = var_523_0[var_523_1]
		end

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play322021130(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 and not isNil(arg_523_1.actors_["404001ui_story"]) and arg_523_1.var_.characterEffect404001ui_story == nil then
				arg_523_1.var_.characterEffect404001ui_story = arg_523_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_526_0 = 0.200000002980232

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_0 and not isNil(arg_523_1.actors_["404001ui_story"]) then
				if arg_523_1.var_.characterEffect404001ui_story and not isNil(arg_523_1.actors_["404001ui_story"]) then
					arg_523_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_523_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_523_1.time_ - 0) / var_526_0)
				end
			end

			if arg_523_1.time_ >= 0 + var_526_0 and arg_523_1.time_ < 0 + var_526_0 + arg_526_0 and not isNil(arg_523_1.actors_["404001ui_story"]) and arg_523_1.var_.characterEffect404001ui_story then
				arg_523_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_523_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			local var_526_1 = 0
			local var_526_2 = 0.075

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= var_526_1 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, true)

				arg_523_1.leftNameTxt_.text = arg_523_1:FormatText(StoryNameCfg[1167].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_523_1.leftNameTxt_.transform)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1.leftNameTxt_.text)
				SetActive(arg_523_1.iconTrs_.gameObject, true)
				arg_523_1.iconController_:SetSelectedState("hero")

				arg_523_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_523_1.callingController_:SetSelectedState("normal")

				arg_523_1.keyicon_.color = Color.New(1, 1, 1)
				arg_523_1.icon_.color = Color.New(1, 1, 1)

				local var_526_3 = arg_523_1:GetWordFromCfg(322021129)
				local var_526_4 = arg_523_1:FormatText(var_526_3.content)

				arg_523_1.text_.text = var_526_4

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_6 = 3 <= 0 and var_526_2 or var_526_2 * (utf8.len(var_526_4) / 3)

				if (3 <= 0 and var_526_2 or var_526_2 * (utf8.len(var_526_4) / 3)) > 0 and var_526_2 < var_526_6 then
					arg_523_1.talkMaxDuration = var_526_6

					if var_526_6 + var_526_1 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_6 + var_526_1
					end
				end

				arg_523_1.text_.text = var_526_4
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021129", "story_v_out_322021.awb") ~= 0 then
					local var_526_7 = manager.audio:GetVoiceLength("story_v_out_322021", "322021129", "story_v_out_322021.awb") / 1000

					if var_526_7 + var_526_1 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_7 + var_526_1
					end

					if var_526_3.prefab_name ~= "" and arg_523_1.actors_[var_526_3.prefab_name] ~= nil then
						local var_526_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_523_1.actors_[var_526_3.prefab_name].transform, "story_v_out_322021", "322021129", "story_v_out_322021.awb")

						arg_523_1:RecordAudio("322021129", var_526_8)
						arg_523_1:RecordAudio("322021129", var_526_8)
					else
						arg_523_1:AudioAction("play", "voice", "story_v_out_322021", "322021129", "story_v_out_322021.awb")
					end

					arg_523_1:RecordHistoryTalkVoice("story_v_out_322021", "322021129", "story_v_out_322021.awb")
				end

				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_9 = math.max(var_526_2, arg_523_1.talkMaxDuration)

			if var_526_1 <= arg_523_1.time_ and arg_523_1.time_ < var_526_1 + var_526_9 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_1) / var_526_9

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_1 + var_526_9 and arg_523_1.time_ < var_526_1 + var_526_9 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play322021130 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 322021130
		arg_527_1.duration_ = 10.23

		local var_527_0 = {
			zh = 8.2,
			ja = 10.233
		}
		local var_527_1 = manager.audio:GetLocalizationFlag()

		if var_527_0[var_527_1] ~= nil then
			arg_527_1.duration_ = var_527_0[var_527_1]
		end

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play322021131(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 and not isNil(arg_527_1.actors_["404001ui_story"]) and arg_527_1.var_.characterEffect404001ui_story == nil then
				arg_527_1.var_.characterEffect404001ui_story = arg_527_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_530_0 = 0.200000002980232

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_0 and not isNil(arg_527_1.actors_["404001ui_story"]) then
				if arg_527_1.var_.characterEffect404001ui_story and not isNil(arg_527_1.actors_["404001ui_story"]) then
					arg_527_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_527_1.time_ >= 0 + var_530_0 and arg_527_1.time_ < 0 + var_530_0 + arg_530_0 and not isNil(arg_527_1.actors_["404001ui_story"]) and arg_527_1.var_.characterEffect404001ui_story then
				arg_527_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_530_2 = 0
			local var_530_3 = 0.975

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= var_530_2 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				arg_527_1.leftNameTxt_.text = arg_527_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, false)
				arg_527_1.callingController_:SetSelectedState("normal")

				local var_530_4 = arg_527_1:GetWordFromCfg(322021130)
				local var_530_5 = arg_527_1:FormatText(var_530_4.content)

				arg_527_1.text_.text = var_530_5

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_7 = 39 <= 0 and var_530_3 or var_530_3 * (utf8.len(var_530_5) / 39)

				if (39 <= 0 and var_530_3 or var_530_3 * (utf8.len(var_530_5) / 39)) > 0 and var_530_3 < var_530_7 then
					arg_527_1.talkMaxDuration = var_530_7

					if var_530_7 + var_530_2 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_7 + var_530_2
					end
				end

				arg_527_1.text_.text = var_530_5
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021130", "story_v_out_322021.awb") ~= 0 then
					local var_530_8 = manager.audio:GetVoiceLength("story_v_out_322021", "322021130", "story_v_out_322021.awb") / 1000

					if var_530_8 + var_530_2 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_8 + var_530_2
					end

					if var_530_4.prefab_name ~= "" and arg_527_1.actors_[var_530_4.prefab_name] ~= nil then
						local var_530_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_527_1.actors_[var_530_4.prefab_name].transform, "story_v_out_322021", "322021130", "story_v_out_322021.awb")

						arg_527_1:RecordAudio("322021130", var_530_9)
						arg_527_1:RecordAudio("322021130", var_530_9)
					else
						arg_527_1:AudioAction("play", "voice", "story_v_out_322021", "322021130", "story_v_out_322021.awb")
					end

					arg_527_1:RecordHistoryTalkVoice("story_v_out_322021", "322021130", "story_v_out_322021.awb")
				end

				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_10 = math.max(var_530_3, arg_527_1.talkMaxDuration)

			if var_530_2 <= arg_527_1.time_ and arg_527_1.time_ < var_530_2 + var_530_10 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_2) / var_530_10

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_2 + var_530_10 and arg_527_1.time_ < var_530_2 + var_530_10 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	Play322021131 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 322021131
		arg_531_1.duration_ = 7.73

		local var_531_0 = {
			zh = 4.566,
			ja = 7.733
		}
		local var_531_1 = manager.audio:GetLocalizationFlag()

		if var_531_0[var_531_1] ~= nil then
			arg_531_1.duration_ = var_531_0[var_531_1]
		end

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play322021132(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 and not isNil(arg_531_1.actors_["404001ui_story"]) and arg_531_1.var_.characterEffect404001ui_story == nil then
				arg_531_1.var_.characterEffect404001ui_story = arg_531_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_534_0 = 0.200000002980232

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_0 and not isNil(arg_531_1.actors_["404001ui_story"]) then
				if arg_531_1.var_.characterEffect404001ui_story and not isNil(arg_531_1.actors_["404001ui_story"]) then
					arg_531_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_531_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_531_1.time_ - 0) / var_534_0)
				end
			end

			if arg_531_1.time_ >= 0 + var_534_0 and arg_531_1.time_ < 0 + var_534_0 + arg_534_0 and not isNil(arg_531_1.actors_["404001ui_story"]) and arg_531_1.var_.characterEffect404001ui_story then
				arg_531_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_531_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			local var_534_1 = 0
			local var_534_2 = 0.55

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= var_534_1 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				arg_531_1.leftNameTxt_.text = arg_531_1:FormatText(StoryNameCfg[1167].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, true)
				arg_531_1.iconController_:SetSelectedState("hero")

				arg_531_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_531_1.callingController_:SetSelectedState("normal")

				arg_531_1.keyicon_.color = Color.New(1, 1, 1)
				arg_531_1.icon_.color = Color.New(1, 1, 1)

				local var_534_3 = arg_531_1:GetWordFromCfg(322021131)
				local var_534_4 = arg_531_1:FormatText(var_534_3.content)

				arg_531_1.text_.text = var_534_4

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_6 = 22 <= 0 and var_534_2 or var_534_2 * (utf8.len(var_534_4) / 22)

				if (22 <= 0 and var_534_2 or var_534_2 * (utf8.len(var_534_4) / 22)) > 0 and var_534_2 < var_534_6 then
					arg_531_1.talkMaxDuration = var_534_6

					if var_534_6 + var_534_1 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_6 + var_534_1
					end
				end

				arg_531_1.text_.text = var_534_4
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021131", "story_v_out_322021.awb") ~= 0 then
					local var_534_7 = manager.audio:GetVoiceLength("story_v_out_322021", "322021131", "story_v_out_322021.awb") / 1000

					if var_534_7 + var_534_1 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_7 + var_534_1
					end

					if var_534_3.prefab_name ~= "" and arg_531_1.actors_[var_534_3.prefab_name] ~= nil then
						local var_534_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_531_1.actors_[var_534_3.prefab_name].transform, "story_v_out_322021", "322021131", "story_v_out_322021.awb")

						arg_531_1:RecordAudio("322021131", var_534_8)
						arg_531_1:RecordAudio("322021131", var_534_8)
					else
						arg_531_1:AudioAction("play", "voice", "story_v_out_322021", "322021131", "story_v_out_322021.awb")
					end

					arg_531_1:RecordHistoryTalkVoice("story_v_out_322021", "322021131", "story_v_out_322021.awb")
				end

				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_9 = math.max(var_534_2, arg_531_1.talkMaxDuration)

			if var_534_1 <= arg_531_1.time_ and arg_531_1.time_ < var_534_1 + var_534_9 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_1) / var_534_9

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_1 + var_534_9 and arg_531_1.time_ < var_534_1 + var_534_9 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {}

		arg_531_1:InitPlayNodeList()
	end,
	Play322021132 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 322021132
		arg_535_1.duration_ = 3.1

		local var_535_0 = {
			zh = 3,
			ja = 3.1
		}
		local var_535_1 = manager.audio:GetLocalizationFlag()

		if var_535_0[var_535_1] ~= nil then
			arg_535_1.duration_ = var_535_0[var_535_1]
		end

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play322021133(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			local var_538_0 = 0.375

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, true)

				arg_535_1.leftNameTxt_.text = arg_535_1:FormatText(StoryNameCfg[1167].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_535_1.leftNameTxt_.transform)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1.leftNameTxt_.text)
				SetActive(arg_535_1.iconTrs_.gameObject, true)
				arg_535_1.iconController_:SetSelectedState("hero")

				arg_535_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_535_1.callingController_:SetSelectedState("normal")

				arg_535_1.keyicon_.color = Color.New(1, 1, 1)
				arg_535_1.icon_.color = Color.New(1, 1, 1)

				local var_538_1 = arg_535_1:GetWordFromCfg(322021132)
				local var_538_2 = arg_535_1:FormatText(var_538_1.content)

				arg_535_1.text_.text = var_538_2

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_4 = 15 <= 0 and var_538_0 or var_538_0 * (utf8.len(var_538_2) / 15)

				if (15 <= 0 and var_538_0 or var_538_0 * (utf8.len(var_538_2) / 15)) > 0 and var_538_0 < var_538_4 then
					arg_535_1.talkMaxDuration = var_538_4

					if var_538_4 + 0 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_4 + 0
					end
				end

				arg_535_1.text_.text = var_538_2
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021132", "story_v_out_322021.awb") ~= 0 then
					local var_538_5 = manager.audio:GetVoiceLength("story_v_out_322021", "322021132", "story_v_out_322021.awb") / 1000

					if var_538_5 + 0 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_5 + 0
					end

					if var_538_1.prefab_name ~= "" and arg_535_1.actors_[var_538_1.prefab_name] ~= nil then
						local var_538_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_535_1.actors_[var_538_1.prefab_name].transform, "story_v_out_322021", "322021132", "story_v_out_322021.awb")

						arg_535_1:RecordAudio("322021132", var_538_6)
						arg_535_1:RecordAudio("322021132", var_538_6)
					else
						arg_535_1:AudioAction("play", "voice", "story_v_out_322021", "322021132", "story_v_out_322021.awb")
					end

					arg_535_1:RecordHistoryTalkVoice("story_v_out_322021", "322021132", "story_v_out_322021.awb")
				end

				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_7 = math.max(var_538_0, arg_535_1.talkMaxDuration)

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_7 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - 0) / var_538_7

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= 0 + var_538_7 and arg_535_1.time_ < 0 + var_538_7 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {}

		arg_535_1:InitPlayNodeList()
	end,
	Play322021133 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 322021133
		arg_539_1.duration_ = 13.5

		local var_539_0 = {
			zh = 11.233,
			ja = 13.5
		}
		local var_539_1 = manager.audio:GetLocalizationFlag()

		if var_539_0[var_539_1] ~= nil then
			arg_539_1.duration_ = var_539_0[var_539_1]
		end

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play322021134(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 and not isNil(arg_539_1.actors_["404001ui_story"]) and arg_539_1.var_.characterEffect404001ui_story == nil then
				arg_539_1.var_.characterEffect404001ui_story = arg_539_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_542_0 = 0.200000002980232

			if 0 <= arg_539_1.time_ and arg_539_1.time_ < 0 + var_542_0 and not isNil(arg_539_1.actors_["404001ui_story"]) then
				if arg_539_1.var_.characterEffect404001ui_story and not isNil(arg_539_1.actors_["404001ui_story"]) then
					arg_539_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_539_1.time_ >= 0 + var_542_0 and arg_539_1.time_ < 0 + var_542_0 + arg_542_0 and not isNil(arg_539_1.actors_["404001ui_story"]) and arg_539_1.var_.characterEffect404001ui_story then
				arg_539_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_542_2 = 0
			local var_542_3 = 1.375

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= var_542_2 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, true)

				arg_539_1.leftNameTxt_.text = arg_539_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_539_1.leftNameTxt_.transform)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1.leftNameTxt_.text)
				SetActive(arg_539_1.iconTrs_.gameObject, false)
				arg_539_1.callingController_:SetSelectedState("normal")

				local var_542_4 = arg_539_1:GetWordFromCfg(322021133)
				local var_542_5 = arg_539_1:FormatText(var_542_4.content)

				arg_539_1.text_.text = var_542_5

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_7 = 55 <= 0 and var_542_3 or var_542_3 * (utf8.len(var_542_5) / 55)

				if (55 <= 0 and var_542_3 or var_542_3 * (utf8.len(var_542_5) / 55)) > 0 and var_542_3 < var_542_7 then
					arg_539_1.talkMaxDuration = var_542_7

					if var_542_7 + var_542_2 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_7 + var_542_2
					end
				end

				arg_539_1.text_.text = var_542_5
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021133", "story_v_out_322021.awb") ~= 0 then
					local var_542_8 = manager.audio:GetVoiceLength("story_v_out_322021", "322021133", "story_v_out_322021.awb") / 1000

					if var_542_8 + var_542_2 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_8 + var_542_2
					end

					if var_542_4.prefab_name ~= "" and arg_539_1.actors_[var_542_4.prefab_name] ~= nil then
						local var_542_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_539_1.actors_[var_542_4.prefab_name].transform, "story_v_out_322021", "322021133", "story_v_out_322021.awb")

						arg_539_1:RecordAudio("322021133", var_542_9)
						arg_539_1:RecordAudio("322021133", var_542_9)
					else
						arg_539_1:AudioAction("play", "voice", "story_v_out_322021", "322021133", "story_v_out_322021.awb")
					end

					arg_539_1:RecordHistoryTalkVoice("story_v_out_322021", "322021133", "story_v_out_322021.awb")
				end

				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_10 = math.max(var_542_3, arg_539_1.talkMaxDuration)

			if var_542_2 <= arg_539_1.time_ and arg_539_1.time_ < var_542_2 + var_542_10 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - var_542_2) / var_542_10

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= var_542_2 + var_542_10 and arg_539_1.time_ < var_542_2 + var_542_10 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {}

		arg_539_1:InitPlayNodeList()
	end,
	Play322021134 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 322021134
		arg_543_1.duration_ = 9.73

		local var_543_0 = {
			zh = 7.366,
			ja = 9.733
		}
		local var_543_1 = manager.audio:GetLocalizationFlag()

		if var_543_0[var_543_1] ~= nil then
			arg_543_1.duration_ = var_543_0[var_543_1]
		end

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play322021135(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 and not isNil(arg_543_1.actors_["404001ui_story"]) and arg_543_1.var_.characterEffect404001ui_story == nil then
				arg_543_1.var_.characterEffect404001ui_story = arg_543_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_546_0 = 0.200000002980232

			if 0 <= arg_543_1.time_ and arg_543_1.time_ < 0 + var_546_0 and not isNil(arg_543_1.actors_["404001ui_story"]) then
				if arg_543_1.var_.characterEffect404001ui_story and not isNil(arg_543_1.actors_["404001ui_story"]) then
					arg_543_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_543_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_543_1.time_ - 0) / var_546_0)
				end
			end

			if arg_543_1.time_ >= 0 + var_546_0 and arg_543_1.time_ < 0 + var_546_0 + arg_546_0 and not isNil(arg_543_1.actors_["404001ui_story"]) and arg_543_1.var_.characterEffect404001ui_story then
				arg_543_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_543_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			local var_546_1 = 0
			local var_546_2 = 0.925

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= var_546_1 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, true)

				arg_543_1.leftNameTxt_.text = arg_543_1:FormatText(StoryNameCfg[1167].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_543_1.leftNameTxt_.transform)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1.leftNameTxt_.text)
				SetActive(arg_543_1.iconTrs_.gameObject, true)
				arg_543_1.iconController_:SetSelectedState("hero")

				arg_543_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_543_1.callingController_:SetSelectedState("normal")

				arg_543_1.keyicon_.color = Color.New(1, 1, 1)
				arg_543_1.icon_.color = Color.New(1, 1, 1)

				local var_546_3 = arg_543_1:GetWordFromCfg(322021134)
				local var_546_4 = arg_543_1:FormatText(var_546_3.content)

				arg_543_1.text_.text = var_546_4

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_6 = 37 <= 0 and var_546_2 or var_546_2 * (utf8.len(var_546_4) / 37)

				if (37 <= 0 and var_546_2 or var_546_2 * (utf8.len(var_546_4) / 37)) > 0 and var_546_2 < var_546_6 then
					arg_543_1.talkMaxDuration = var_546_6

					if var_546_6 + var_546_1 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_6 + var_546_1
					end
				end

				arg_543_1.text_.text = var_546_4
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021134", "story_v_out_322021.awb") ~= 0 then
					local var_546_7 = manager.audio:GetVoiceLength("story_v_out_322021", "322021134", "story_v_out_322021.awb") / 1000

					if var_546_7 + var_546_1 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_7 + var_546_1
					end

					if var_546_3.prefab_name ~= "" and arg_543_1.actors_[var_546_3.prefab_name] ~= nil then
						local var_546_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_543_1.actors_[var_546_3.prefab_name].transform, "story_v_out_322021", "322021134", "story_v_out_322021.awb")

						arg_543_1:RecordAudio("322021134", var_546_8)
						arg_543_1:RecordAudio("322021134", var_546_8)
					else
						arg_543_1:AudioAction("play", "voice", "story_v_out_322021", "322021134", "story_v_out_322021.awb")
					end

					arg_543_1:RecordHistoryTalkVoice("story_v_out_322021", "322021134", "story_v_out_322021.awb")
				end

				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_9 = math.max(var_546_2, arg_543_1.talkMaxDuration)

			if var_546_1 <= arg_543_1.time_ and arg_543_1.time_ < var_546_1 + var_546_9 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - var_546_1) / var_546_9

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= var_546_1 + var_546_9 and arg_543_1.time_ < var_546_1 + var_546_9 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {}

		arg_543_1:InitPlayNodeList()
	end,
	Play322021135 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 322021135
		arg_547_1.duration_ = 7.27

		local var_547_0 = {
			zh = 4.666,
			ja = 7.266
		}
		local var_547_1 = manager.audio:GetLocalizationFlag()

		if var_547_0[var_547_1] ~= nil then
			arg_547_1.duration_ = var_547_0[var_547_1]
		end

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play322021136(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			local var_550_0 = 0.525

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 then
				arg_547_1.talkMaxDuration = 0
				arg_547_1.dialogCg_.alpha = 1

				arg_547_1.dialog_:SetActive(true)
				SetActive(arg_547_1.leftNameGo_, true)

				arg_547_1.leftNameTxt_.text = arg_547_1:FormatText(StoryNameCfg[1167].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_547_1.leftNameTxt_.transform)

				arg_547_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_547_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_547_1:RecordName(arg_547_1.leftNameTxt_.text)
				SetActive(arg_547_1.iconTrs_.gameObject, true)
				arg_547_1.iconController_:SetSelectedState("hero")

				arg_547_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_547_1.callingController_:SetSelectedState("normal")

				arg_547_1.keyicon_.color = Color.New(1, 1, 1)
				arg_547_1.icon_.color = Color.New(1, 1, 1)

				local var_550_1 = arg_547_1:GetWordFromCfg(322021135)
				local var_550_2 = arg_547_1:FormatText(var_550_1.content)

				arg_547_1.text_.text = var_550_2

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_4 = 21 <= 0 and var_550_0 or var_550_0 * (utf8.len(var_550_2) / 21)

				if (21 <= 0 and var_550_0 or var_550_0 * (utf8.len(var_550_2) / 21)) > 0 and var_550_0 < var_550_4 then
					arg_547_1.talkMaxDuration = var_550_4

					if var_550_4 + 0 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_4 + 0
					end
				end

				arg_547_1.text_.text = var_550_2
				arg_547_1.typewritter.percent = 0

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021135", "story_v_out_322021.awb") ~= 0 then
					local var_550_5 = manager.audio:GetVoiceLength("story_v_out_322021", "322021135", "story_v_out_322021.awb") / 1000

					if var_550_5 + 0 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_5 + 0
					end

					if var_550_1.prefab_name ~= "" and arg_547_1.actors_[var_550_1.prefab_name] ~= nil then
						local var_550_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_547_1.actors_[var_550_1.prefab_name].transform, "story_v_out_322021", "322021135", "story_v_out_322021.awb")

						arg_547_1:RecordAudio("322021135", var_550_6)
						arg_547_1:RecordAudio("322021135", var_550_6)
					else
						arg_547_1:AudioAction("play", "voice", "story_v_out_322021", "322021135", "story_v_out_322021.awb")
					end

					arg_547_1:RecordHistoryTalkVoice("story_v_out_322021", "322021135", "story_v_out_322021.awb")
				end

				arg_547_1:RecordContent(arg_547_1.text_.text)
			end

			local var_550_7 = math.max(var_550_0, arg_547_1.talkMaxDuration)

			if 0 <= arg_547_1.time_ and arg_547_1.time_ < 0 + var_550_7 then
				arg_547_1.typewritter.percent = (arg_547_1.time_ - 0) / var_550_7

				arg_547_1.typewritter:SetDirty()
			end

			if arg_547_1.time_ >= 0 + var_550_7 and arg_547_1.time_ < 0 + var_550_7 + arg_550_0 then
				arg_547_1.typewritter.percent = 1

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(true)
			end
		end

		arg_547_1.nodeConfigList_ = {}

		arg_547_1:InitPlayNodeList()
	end,
	Play322021136 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 322021136
		arg_551_1.duration_ = 9.37

		local var_551_0 = {
			zh = 9.066,
			ja = 9.366
		}
		local var_551_1 = manager.audio:GetLocalizationFlag()

		if var_551_0[var_551_1] ~= nil then
			arg_551_1.duration_ = var_551_0[var_551_1]
		end

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play322021137(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			if 0 < arg_551_1.time_ and arg_551_1.time_ <= 0 + arg_554_0 and not isNil(arg_551_1.actors_["404001ui_story"]) and arg_551_1.var_.characterEffect404001ui_story == nil then
				arg_551_1.var_.characterEffect404001ui_story = arg_551_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_554_0 = 0.200000002980232

			if 0 <= arg_551_1.time_ and arg_551_1.time_ < 0 + var_554_0 and not isNil(arg_551_1.actors_["404001ui_story"]) then
				if arg_551_1.var_.characterEffect404001ui_story and not isNil(arg_551_1.actors_["404001ui_story"]) then
					arg_551_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_551_1.time_ >= 0 + var_554_0 and arg_551_1.time_ < 0 + var_554_0 + arg_554_0 and not isNil(arg_551_1.actors_["404001ui_story"]) and arg_551_1.var_.characterEffect404001ui_story then
				arg_551_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_551_1.time_ and arg_551_1.time_ <= 0 + arg_554_0 then
				arg_551_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			local var_554_2 = 0
			local var_554_3 = 0.95

			if 0 < arg_551_1.time_ and arg_551_1.time_ <= var_554_2 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, true)

				arg_551_1.leftNameTxt_.text = arg_551_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_551_1.leftNameTxt_.transform)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1.leftNameTxt_.text)
				SetActive(arg_551_1.iconTrs_.gameObject, false)
				arg_551_1.callingController_:SetSelectedState("normal")

				local var_554_4 = arg_551_1:GetWordFromCfg(322021136)
				local var_554_5 = arg_551_1:FormatText(var_554_4.content)

				arg_551_1.text_.text = var_554_5

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_7 = 38 <= 0 and var_554_3 or var_554_3 * (utf8.len(var_554_5) / 38)

				if (38 <= 0 and var_554_3 or var_554_3 * (utf8.len(var_554_5) / 38)) > 0 and var_554_3 < var_554_7 then
					arg_551_1.talkMaxDuration = var_554_7

					if var_554_7 + var_554_2 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_7 + var_554_2
					end
				end

				arg_551_1.text_.text = var_554_5
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021136", "story_v_out_322021.awb") ~= 0 then
					local var_554_8 = manager.audio:GetVoiceLength("story_v_out_322021", "322021136", "story_v_out_322021.awb") / 1000

					if var_554_8 + var_554_2 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_8 + var_554_2
					end

					if var_554_4.prefab_name ~= "" and arg_551_1.actors_[var_554_4.prefab_name] ~= nil then
						local var_554_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_551_1.actors_[var_554_4.prefab_name].transform, "story_v_out_322021", "322021136", "story_v_out_322021.awb")

						arg_551_1:RecordAudio("322021136", var_554_9)
						arg_551_1:RecordAudio("322021136", var_554_9)
					else
						arg_551_1:AudioAction("play", "voice", "story_v_out_322021", "322021136", "story_v_out_322021.awb")
					end

					arg_551_1:RecordHistoryTalkVoice("story_v_out_322021", "322021136", "story_v_out_322021.awb")
				end

				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_10 = math.max(var_554_3, arg_551_1.talkMaxDuration)

			if var_554_2 <= arg_551_1.time_ and arg_551_1.time_ < var_554_2 + var_554_10 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - var_554_2) / var_554_10

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= var_554_2 + var_554_10 and arg_551_1.time_ < var_554_2 + var_554_10 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {}

		arg_551_1:InitPlayNodeList()
	end,
	Play322021137 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 322021137
		arg_555_1.duration_ = 11.5

		local var_555_0 = {
			zh = 7.933,
			ja = 11.5
		}
		local var_555_1 = manager.audio:GetLocalizationFlag()

		if var_555_0[var_555_1] ~= nil then
			arg_555_1.duration_ = var_555_0[var_555_1]
		end

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play322021138(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 and not isNil(arg_555_1.actors_["404001ui_story"]) and arg_555_1.var_.characterEffect404001ui_story == nil then
				arg_555_1.var_.characterEffect404001ui_story = arg_555_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_558_0 = 0.200000002980232

			if 0 <= arg_555_1.time_ and arg_555_1.time_ < 0 + var_558_0 and not isNil(arg_555_1.actors_["404001ui_story"]) then
				if arg_555_1.var_.characterEffect404001ui_story and not isNil(arg_555_1.actors_["404001ui_story"]) then
					arg_555_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_555_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_555_1.time_ - 0) / var_558_0)
				end
			end

			if arg_555_1.time_ >= 0 + var_558_0 and arg_555_1.time_ < 0 + var_558_0 + arg_558_0 and not isNil(arg_555_1.actors_["404001ui_story"]) and arg_555_1.var_.characterEffect404001ui_story then
				arg_555_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_555_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			local var_558_1 = 0
			local var_558_2 = 0.925

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= var_558_1 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, true)

				arg_555_1.leftNameTxt_.text = arg_555_1:FormatText(StoryNameCfg[1167].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_555_1.leftNameTxt_.transform)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1.leftNameTxt_.text)
				SetActive(arg_555_1.iconTrs_.gameObject, true)
				arg_555_1.iconController_:SetSelectedState("hero")

				arg_555_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_555_1.callingController_:SetSelectedState("normal")

				arg_555_1.keyicon_.color = Color.New(1, 1, 1)
				arg_555_1.icon_.color = Color.New(1, 1, 1)

				local var_558_3 = arg_555_1:GetWordFromCfg(322021137)
				local var_558_4 = arg_555_1:FormatText(var_558_3.content)

				arg_555_1.text_.text = var_558_4

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_6 = 37 <= 0 and var_558_2 or var_558_2 * (utf8.len(var_558_4) / 37)

				if (37 <= 0 and var_558_2 or var_558_2 * (utf8.len(var_558_4) / 37)) > 0 and var_558_2 < var_558_6 then
					arg_555_1.talkMaxDuration = var_558_6

					if var_558_6 + var_558_1 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_6 + var_558_1
					end
				end

				arg_555_1.text_.text = var_558_4
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021137", "story_v_out_322021.awb") ~= 0 then
					local var_558_7 = manager.audio:GetVoiceLength("story_v_out_322021", "322021137", "story_v_out_322021.awb") / 1000

					if var_558_7 + var_558_1 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_7 + var_558_1
					end

					if var_558_3.prefab_name ~= "" and arg_555_1.actors_[var_558_3.prefab_name] ~= nil then
						local var_558_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_555_1.actors_[var_558_3.prefab_name].transform, "story_v_out_322021", "322021137", "story_v_out_322021.awb")

						arg_555_1:RecordAudio("322021137", var_558_8)
						arg_555_1:RecordAudio("322021137", var_558_8)
					else
						arg_555_1:AudioAction("play", "voice", "story_v_out_322021", "322021137", "story_v_out_322021.awb")
					end

					arg_555_1:RecordHistoryTalkVoice("story_v_out_322021", "322021137", "story_v_out_322021.awb")
				end

				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_9 = math.max(var_558_2, arg_555_1.talkMaxDuration)

			if var_558_1 <= arg_555_1.time_ and arg_555_1.time_ < var_558_1 + var_558_9 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - var_558_1) / var_558_9

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= var_558_1 + var_558_9 and arg_555_1.time_ < var_558_1 + var_558_9 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {}

		arg_555_1:InitPlayNodeList()
	end,
	Play322021138 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 322021138
		arg_559_1.duration_ = 11.77

		local var_559_0 = {
			zh = 11.733,
			ja = 11.766
		}
		local var_559_1 = manager.audio:GetLocalizationFlag()

		if var_559_0[var_559_1] ~= nil then
			arg_559_1.duration_ = var_559_0[var_559_1]
		end

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play322021139(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			if 0 < arg_559_1.time_ and arg_559_1.time_ <= 0 + arg_562_0 and not isNil(arg_559_1.actors_["404001ui_story"]) and arg_559_1.var_.characterEffect404001ui_story == nil then
				arg_559_1.var_.characterEffect404001ui_story = arg_559_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_562_0 = 0.200000002980232

			if 0 <= arg_559_1.time_ and arg_559_1.time_ < 0 + var_562_0 and not isNil(arg_559_1.actors_["404001ui_story"]) then
				if arg_559_1.var_.characterEffect404001ui_story and not isNil(arg_559_1.actors_["404001ui_story"]) then
					arg_559_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_559_1.time_ >= 0 + var_562_0 and arg_559_1.time_ < 0 + var_562_0 + arg_562_0 and not isNil(arg_559_1.actors_["404001ui_story"]) and arg_559_1.var_.characterEffect404001ui_story then
				arg_559_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= 0 + arg_562_0 then
				arg_559_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_2", "EmotionTimelineAnimator")
			end

			local var_562_2 = 0
			local var_562_3 = 1.05

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= var_562_2 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, true)

				arg_559_1.leftNameTxt_.text = arg_559_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_559_1.leftNameTxt_.transform)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1.leftNameTxt_.text)
				SetActive(arg_559_1.iconTrs_.gameObject, false)
				arg_559_1.callingController_:SetSelectedState("normal")

				local var_562_4 = arg_559_1:GetWordFromCfg(322021138)
				local var_562_5 = arg_559_1:FormatText(var_562_4.content)

				arg_559_1.text_.text = var_562_5

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_7 = 42 <= 0 and var_562_3 or var_562_3 * (utf8.len(var_562_5) / 42)

				if (42 <= 0 and var_562_3 or var_562_3 * (utf8.len(var_562_5) / 42)) > 0 and var_562_3 < var_562_7 then
					arg_559_1.talkMaxDuration = var_562_7

					if var_562_7 + var_562_2 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_7 + var_562_2
					end
				end

				arg_559_1.text_.text = var_562_5
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021138", "story_v_out_322021.awb") ~= 0 then
					local var_562_8 = manager.audio:GetVoiceLength("story_v_out_322021", "322021138", "story_v_out_322021.awb") / 1000

					if var_562_8 + var_562_2 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_8 + var_562_2
					end

					if var_562_4.prefab_name ~= "" and arg_559_1.actors_[var_562_4.prefab_name] ~= nil then
						local var_562_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_559_1.actors_[var_562_4.prefab_name].transform, "story_v_out_322021", "322021138", "story_v_out_322021.awb")

						arg_559_1:RecordAudio("322021138", var_562_9)
						arg_559_1:RecordAudio("322021138", var_562_9)
					else
						arg_559_1:AudioAction("play", "voice", "story_v_out_322021", "322021138", "story_v_out_322021.awb")
					end

					arg_559_1:RecordHistoryTalkVoice("story_v_out_322021", "322021138", "story_v_out_322021.awb")
				end

				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_10 = math.max(var_562_3, arg_559_1.talkMaxDuration)

			if var_562_2 <= arg_559_1.time_ and arg_559_1.time_ < var_562_2 + var_562_10 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - var_562_2) / var_562_10

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= var_562_2 + var_562_10 and arg_559_1.time_ < var_562_2 + var_562_10 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end

		arg_559_1.nodeConfigList_ = {}

		arg_559_1:InitPlayNodeList()
	end,
	Play322021139 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 322021139
		arg_563_1.duration_ = 16.5

		local var_563_0 = {
			zh = 14.833,
			ja = 16.5
		}
		local var_563_1 = manager.audio:GetLocalizationFlag()

		if var_563_0[var_563_1] ~= nil then
			arg_563_1.duration_ = var_563_0[var_563_1]
		end

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"
		end

		function arg_563_1.playNext_(arg_565_0)
			if arg_565_0 == 1 then
				arg_563_0:Play322021140(arg_563_1)
			end
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			local var_566_0 = 1.5

			if 0 < arg_563_1.time_ and arg_563_1.time_ <= 0 + arg_566_0 then
				arg_563_1.talkMaxDuration = 0
				arg_563_1.dialogCg_.alpha = 1

				arg_563_1.dialog_:SetActive(true)
				SetActive(arg_563_1.leftNameGo_, true)

				arg_563_1.leftNameTxt_.text = arg_563_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_563_1.leftNameTxt_.transform)

				arg_563_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_563_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_563_1:RecordName(arg_563_1.leftNameTxt_.text)
				SetActive(arg_563_1.iconTrs_.gameObject, false)
				arg_563_1.callingController_:SetSelectedState("normal")

				local var_566_1 = arg_563_1:GetWordFromCfg(322021139)
				local var_566_2 = arg_563_1:FormatText(var_566_1.content)

				arg_563_1.text_.text = var_566_2

				LuaForUtil.ClearLinePrefixSymbol(arg_563_1.text_)

				local var_566_4 = 60 <= 0 and var_566_0 or var_566_0 * (utf8.len(var_566_2) / 60)

				if (60 <= 0 and var_566_0 or var_566_0 * (utf8.len(var_566_2) / 60)) > 0 and var_566_0 < var_566_4 then
					arg_563_1.talkMaxDuration = var_566_4

					if var_566_4 + 0 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_4 + 0
					end
				end

				arg_563_1.text_.text = var_566_2
				arg_563_1.typewritter.percent = 0

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021139", "story_v_out_322021.awb") ~= 0 then
					local var_566_5 = manager.audio:GetVoiceLength("story_v_out_322021", "322021139", "story_v_out_322021.awb") / 1000

					if var_566_5 + 0 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_5 + 0
					end

					if var_566_1.prefab_name ~= "" and arg_563_1.actors_[var_566_1.prefab_name] ~= nil then
						local var_566_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_563_1.actors_[var_566_1.prefab_name].transform, "story_v_out_322021", "322021139", "story_v_out_322021.awb")

						arg_563_1:RecordAudio("322021139", var_566_6)
						arg_563_1:RecordAudio("322021139", var_566_6)
					else
						arg_563_1:AudioAction("play", "voice", "story_v_out_322021", "322021139", "story_v_out_322021.awb")
					end

					arg_563_1:RecordHistoryTalkVoice("story_v_out_322021", "322021139", "story_v_out_322021.awb")
				end

				arg_563_1:RecordContent(arg_563_1.text_.text)
			end

			local var_566_7 = math.max(var_566_0, arg_563_1.talkMaxDuration)

			if 0 <= arg_563_1.time_ and arg_563_1.time_ < 0 + var_566_7 then
				arg_563_1.typewritter.percent = (arg_563_1.time_ - 0) / var_566_7

				arg_563_1.typewritter:SetDirty()
			end

			if arg_563_1.time_ >= 0 + var_566_7 and arg_563_1.time_ < 0 + var_566_7 + arg_566_0 then
				arg_563_1.typewritter.percent = 1

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(true)
			end
		end

		arg_563_1.nodeConfigList_ = {}

		arg_563_1:InitPlayNodeList()
	end,
	Play322021140 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 322021140
		arg_567_1.duration_ = 11.27

		local var_567_0 = {
			zh = 11.266,
			ja = 8.733
		}
		local var_567_1 = manager.audio:GetLocalizationFlag()

		if var_567_0[var_567_1] ~= nil then
			arg_567_1.duration_ = var_567_0[var_567_1]
		end

		SetActive(arg_567_1.tipsGo_, false)

		function arg_567_1.onSingleLineFinish_()
			arg_567_1.onSingleLineUpdate_ = nil
			arg_567_1.onSingleLineFinish_ = nil
			arg_567_1.state_ = "waiting"
		end

		function arg_567_1.playNext_(arg_569_0)
			if arg_569_0 == 1 then
				arg_567_0:Play322021141(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			local var_570_0 = 0.875

			if 0 < arg_567_1.time_ and arg_567_1.time_ <= 0 + arg_570_0 then
				arg_567_1.talkMaxDuration = 0
				arg_567_1.dialogCg_.alpha = 1

				arg_567_1.dialog_:SetActive(true)
				SetActive(arg_567_1.leftNameGo_, true)

				arg_567_1.leftNameTxt_.text = arg_567_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_567_1.leftNameTxt_.transform)

				arg_567_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_567_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_567_1:RecordName(arg_567_1.leftNameTxt_.text)
				SetActive(arg_567_1.iconTrs_.gameObject, false)
				arg_567_1.callingController_:SetSelectedState("normal")

				local var_570_1 = arg_567_1:GetWordFromCfg(322021140)
				local var_570_2 = arg_567_1:FormatText(var_570_1.content)

				arg_567_1.text_.text = var_570_2

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_4 = 35 <= 0 and var_570_0 or var_570_0 * (utf8.len(var_570_2) / 35)

				if (35 <= 0 and var_570_0 or var_570_0 * (utf8.len(var_570_2) / 35)) > 0 and var_570_0 < var_570_4 then
					arg_567_1.talkMaxDuration = var_570_4

					if var_570_4 + 0 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_4 + 0
					end
				end

				arg_567_1.text_.text = var_570_2
				arg_567_1.typewritter.percent = 0

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021140", "story_v_out_322021.awb") ~= 0 then
					local var_570_5 = manager.audio:GetVoiceLength("story_v_out_322021", "322021140", "story_v_out_322021.awb") / 1000

					if var_570_5 + 0 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_5 + 0
					end

					if var_570_1.prefab_name ~= "" and arg_567_1.actors_[var_570_1.prefab_name] ~= nil then
						local var_570_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_567_1.actors_[var_570_1.prefab_name].transform, "story_v_out_322021", "322021140", "story_v_out_322021.awb")

						arg_567_1:RecordAudio("322021140", var_570_6)
						arg_567_1:RecordAudio("322021140", var_570_6)
					else
						arg_567_1:AudioAction("play", "voice", "story_v_out_322021", "322021140", "story_v_out_322021.awb")
					end

					arg_567_1:RecordHistoryTalkVoice("story_v_out_322021", "322021140", "story_v_out_322021.awb")
				end

				arg_567_1:RecordContent(arg_567_1.text_.text)
			end

			local var_570_7 = math.max(var_570_0, arg_567_1.talkMaxDuration)

			if 0 <= arg_567_1.time_ and arg_567_1.time_ < 0 + var_570_7 then
				arg_567_1.typewritter.percent = (arg_567_1.time_ - 0) / var_570_7

				arg_567_1.typewritter:SetDirty()
			end

			if arg_567_1.time_ >= 0 + var_570_7 and arg_567_1.time_ < 0 + var_570_7 + arg_570_0 then
				arg_567_1.typewritter.percent = 1

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(true)
			end
		end

		arg_567_1.nodeConfigList_ = {}

		arg_567_1:InitPlayNodeList()
	end,
	Play322021141 = function(arg_571_0, arg_571_1)
		arg_571_1.time_ = 0
		arg_571_1.frameCnt_ = 0
		arg_571_1.state_ = "playing"
		arg_571_1.curTalkId_ = 322021141
		arg_571_1.duration_ = 5

		SetActive(arg_571_1.tipsGo_, false)

		function arg_571_1.onSingleLineFinish_()
			arg_571_1.onSingleLineUpdate_ = nil
			arg_571_1.onSingleLineFinish_ = nil
			arg_571_1.state_ = "waiting"
		end

		function arg_571_1.playNext_(arg_573_0)
			if arg_573_0 == 1 then
				arg_571_0:Play322021142(arg_571_1)
			end
		end

		function arg_571_1.onSingleLineUpdate_(arg_574_0)
			if 0 < arg_571_1.time_ and arg_571_1.time_ <= 0 + arg_574_0 then
				arg_571_1.var_.moveOldPos404001ui_story = arg_571_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_574_0 = 0.001

			if 0 <= arg_571_1.time_ and arg_571_1.time_ < 0 + var_574_0 then
				arg_571_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_571_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_571_1.time_ - 0) / var_574_0)
				arg_571_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_571_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_571_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_571_1.actors_["404001ui_story"].transform.position).z)
				arg_571_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_571_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_571_1.actors_["404001ui_story"].transform.localEulerAngles = arg_571_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_571_1.time_ >= 0 + var_574_0 and arg_571_1.time_ < 0 + var_574_0 + arg_574_0 then
				arg_571_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_571_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_571_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_571_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_571_1.actors_["404001ui_story"].transform.position).z)
				arg_571_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_571_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_571_1.actors_["404001ui_story"].transform.localEulerAngles = arg_571_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_574_1 = 0
			local var_574_2 = 1.075

			if 0 < arg_571_1.time_ and arg_571_1.time_ <= var_574_1 + arg_574_0 then
				arg_571_1.talkMaxDuration = 0
				arg_571_1.dialogCg_.alpha = 1

				arg_571_1.dialog_:SetActive(true)
				SetActive(arg_571_1.leftNameGo_, false)

				arg_571_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_571_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_571_1:RecordName(arg_571_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_571_1.iconTrs_.gameObject, false)
				arg_571_1.callingController_:SetSelectedState("normal")

				local var_574_3 = arg_571_1:FormatText(arg_571_1:GetWordFromCfg(322021141).content)

				arg_571_1.text_.text = var_574_3

				LuaForUtil.ClearLinePrefixSymbol(arg_571_1.text_)

				local var_574_5 = 43 <= 0 and var_574_2 or var_574_2 * (utf8.len(var_574_3) / 43)

				if (43 <= 0 and var_574_2 or var_574_2 * (utf8.len(var_574_3) / 43)) > 0 and var_574_2 < var_574_5 then
					arg_571_1.talkMaxDuration = var_574_5

					if var_574_5 + var_574_1 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_5 + var_574_1
					end
				end

				arg_571_1.text_.text = var_574_3
				arg_571_1.typewritter.percent = 0

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(false)
				arg_571_1:RecordContent(arg_571_1.text_.text)
			end

			local var_574_6 = math.max(var_574_2, arg_571_1.talkMaxDuration)

			if var_574_1 <= arg_571_1.time_ and arg_571_1.time_ < var_574_1 + var_574_6 then
				arg_571_1.typewritter.percent = (arg_571_1.time_ - var_574_1) / var_574_6

				arg_571_1.typewritter:SetDirty()
			end

			if arg_571_1.time_ >= var_574_1 + var_574_6 and arg_571_1.time_ < var_574_1 + var_574_6 + arg_574_0 then
				arg_571_1.typewritter.percent = 1

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(true)
			end
		end

		arg_571_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_571_1:InitPlayNodeList()
	end,
	Play322021142 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 322021142
		arg_575_1.duration_ = 6.7

		local var_575_0 = {
			zh = 5.5,
			ja = 6.7
		}
		local var_575_1 = manager.audio:GetLocalizationFlag()

		if var_575_0[var_575_1] ~= nil then
			arg_575_1.duration_ = var_575_0[var_575_1]
		end

		SetActive(arg_575_1.tipsGo_, false)

		function arg_575_1.onSingleLineFinish_()
			arg_575_1.onSingleLineUpdate_ = nil
			arg_575_1.onSingleLineFinish_ = nil
			arg_575_1.state_ = "waiting"
		end

		function arg_575_1.playNext_(arg_577_0)
			if arg_577_0 == 1 then
				arg_575_0:Play322021143(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 then
				arg_575_1.var_.moveOldPos404001ui_story = arg_575_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_578_0 = 0.001

			if 0 <= arg_575_1.time_ and arg_575_1.time_ < 0 + var_578_0 then
				arg_575_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_575_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_575_1.time_ - 0) / var_578_0)
				arg_575_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_575_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_575_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_575_1.actors_["404001ui_story"].transform.position).z)
				arg_575_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_575_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_575_1.actors_["404001ui_story"].transform.localEulerAngles = arg_575_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_575_1.time_ >= 0 + var_578_0 and arg_575_1.time_ < 0 + var_578_0 + arg_578_0 then
				arg_575_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_575_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_575_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_575_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_575_1.actors_["404001ui_story"].transform.position).z)
				arg_575_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_575_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_575_1.actors_["404001ui_story"].transform.localEulerAngles = arg_575_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_578_1 = arg_575_1.actors_["404001ui_story"]

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 and not isNil(var_578_1) and arg_575_1.var_.characterEffect404001ui_story == nil then
				arg_575_1.var_.characterEffect404001ui_story = var_578_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_578_2 = 0.200000002980232

			if 0 <= arg_575_1.time_ and arg_575_1.time_ < 0 + var_578_2 and not isNil(var_578_1) then
				if arg_575_1.var_.characterEffect404001ui_story and not isNil(var_578_1) then
					arg_575_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_575_1.time_ >= 0 + var_578_2 and arg_575_1.time_ < 0 + var_578_2 + arg_578_0 and not isNil(var_578_1) and arg_575_1.var_.characterEffect404001ui_story then
				arg_575_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 then
				arg_575_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action4_1")
			end

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 then
				arg_575_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_578_4 = 0
			local var_578_5 = 0.625

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= var_578_4 + arg_578_0 then
				arg_575_1.talkMaxDuration = 0
				arg_575_1.dialogCg_.alpha = 1

				arg_575_1.dialog_:SetActive(true)
				SetActive(arg_575_1.leftNameGo_, true)

				arg_575_1.leftNameTxt_.text = arg_575_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_575_1.leftNameTxt_.transform)

				arg_575_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_575_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_575_1:RecordName(arg_575_1.leftNameTxt_.text)
				SetActive(arg_575_1.iconTrs_.gameObject, false)
				arg_575_1.callingController_:SetSelectedState("normal")

				local var_578_6 = arg_575_1:GetWordFromCfg(322021142)
				local var_578_7 = arg_575_1:FormatText(var_578_6.content)

				arg_575_1.text_.text = var_578_7

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_9 = 25 <= 0 and var_578_5 or var_578_5 * (utf8.len(var_578_7) / 25)

				if (25 <= 0 and var_578_5 or var_578_5 * (utf8.len(var_578_7) / 25)) > 0 and var_578_5 < var_578_9 then
					arg_575_1.talkMaxDuration = var_578_9

					if var_578_9 + var_578_4 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_9 + var_578_4
					end
				end

				arg_575_1.text_.text = var_578_7
				arg_575_1.typewritter.percent = 0

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021142", "story_v_out_322021.awb") ~= 0 then
					local var_578_10 = manager.audio:GetVoiceLength("story_v_out_322021", "322021142", "story_v_out_322021.awb") / 1000

					if var_578_10 + var_578_4 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_10 + var_578_4
					end

					if var_578_6.prefab_name ~= "" and arg_575_1.actors_[var_578_6.prefab_name] ~= nil then
						local var_578_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_575_1.actors_[var_578_6.prefab_name].transform, "story_v_out_322021", "322021142", "story_v_out_322021.awb")

						arg_575_1:RecordAudio("322021142", var_578_11)
						arg_575_1:RecordAudio("322021142", var_578_11)
					else
						arg_575_1:AudioAction("play", "voice", "story_v_out_322021", "322021142", "story_v_out_322021.awb")
					end

					arg_575_1:RecordHistoryTalkVoice("story_v_out_322021", "322021142", "story_v_out_322021.awb")
				end

				arg_575_1:RecordContent(arg_575_1.text_.text)
			end

			local var_578_12 = math.max(var_578_5, arg_575_1.talkMaxDuration)

			if var_578_4 <= arg_575_1.time_ and arg_575_1.time_ < var_578_4 + var_578_12 then
				arg_575_1.typewritter.percent = (arg_575_1.time_ - var_578_4) / var_578_12

				arg_575_1.typewritter:SetDirty()
			end

			if arg_575_1.time_ >= var_578_4 + var_578_12 and arg_575_1.time_ < var_578_4 + var_578_12 + arg_578_0 then
				arg_575_1.typewritter.percent = 1

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(true)
			end
		end

		arg_575_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_575_1:InitPlayNodeList()
	end,
	Play322021143 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 322021143
		arg_579_1.duration_ = 7.17

		local var_579_0 = {
			zh = 6.6,
			ja = 7.166
		}
		local var_579_1 = manager.audio:GetLocalizationFlag()

		if var_579_0[var_579_1] ~= nil then
			arg_579_1.duration_ = var_579_0[var_579_1]
		end

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play322021144(arg_579_1)
			end
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			if 0 < arg_579_1.time_ and arg_579_1.time_ <= 0 + arg_582_0 then
				arg_579_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_579_1.time_ and arg_579_1.time_ <= 0 + arg_582_0 then
				arg_579_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action4_2")
			end

			local var_582_0 = 0
			local var_582_1 = 0.7

			if 0 < arg_579_1.time_ and arg_579_1.time_ <= var_582_0 + arg_582_0 then
				arg_579_1.talkMaxDuration = 0
				arg_579_1.dialogCg_.alpha = 1

				arg_579_1.dialog_:SetActive(true)
				SetActive(arg_579_1.leftNameGo_, true)

				arg_579_1.leftNameTxt_.text = arg_579_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_579_1.leftNameTxt_.transform)

				arg_579_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_579_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_579_1:RecordName(arg_579_1.leftNameTxt_.text)
				SetActive(arg_579_1.iconTrs_.gameObject, false)
				arg_579_1.callingController_:SetSelectedState("normal")

				local var_582_2 = arg_579_1:GetWordFromCfg(322021143)
				local var_582_3 = arg_579_1:FormatText(var_582_2.content)

				arg_579_1.text_.text = var_582_3

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_5 = 28 <= 0 and var_582_1 or var_582_1 * (utf8.len(var_582_3) / 28)

				if (28 <= 0 and var_582_1 or var_582_1 * (utf8.len(var_582_3) / 28)) > 0 and var_582_1 < var_582_5 then
					arg_579_1.talkMaxDuration = var_582_5

					if var_582_5 + var_582_0 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_5 + var_582_0
					end
				end

				arg_579_1.text_.text = var_582_3
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021143", "story_v_out_322021.awb") ~= 0 then
					local var_582_6 = manager.audio:GetVoiceLength("story_v_out_322021", "322021143", "story_v_out_322021.awb") / 1000

					if var_582_6 + var_582_0 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_6 + var_582_0
					end

					if var_582_2.prefab_name ~= "" and arg_579_1.actors_[var_582_2.prefab_name] ~= nil then
						local var_582_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_579_1.actors_[var_582_2.prefab_name].transform, "story_v_out_322021", "322021143", "story_v_out_322021.awb")

						arg_579_1:RecordAudio("322021143", var_582_7)
						arg_579_1:RecordAudio("322021143", var_582_7)
					else
						arg_579_1:AudioAction("play", "voice", "story_v_out_322021", "322021143", "story_v_out_322021.awb")
					end

					arg_579_1:RecordHistoryTalkVoice("story_v_out_322021", "322021143", "story_v_out_322021.awb")
				end

				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_8 = math.max(var_582_1, arg_579_1.talkMaxDuration)

			if var_582_0 <= arg_579_1.time_ and arg_579_1.time_ < var_582_0 + var_582_8 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - var_582_0) / var_582_8

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= var_582_0 + var_582_8 and arg_579_1.time_ < var_582_0 + var_582_8 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end

		arg_579_1.nodeConfigList_ = {}

		arg_579_1:InitPlayNodeList()
	end,
	Play322021144 = function(arg_583_0, arg_583_1)
		arg_583_1.time_ = 0
		arg_583_1.frameCnt_ = 0
		arg_583_1.state_ = "playing"
		arg_583_1.curTalkId_ = 322021144
		arg_583_1.duration_ = 5

		SetActive(arg_583_1.tipsGo_, false)

		function arg_583_1.onSingleLineFinish_()
			arg_583_1.onSingleLineUpdate_ = nil
			arg_583_1.onSingleLineFinish_ = nil
			arg_583_1.state_ = "waiting"
		end

		function arg_583_1.playNext_(arg_585_0)
			if arg_585_0 == 1 then
				arg_583_0:Play322021145(arg_583_1)
			end
		end

		function arg_583_1.onSingleLineUpdate_(arg_586_0)
			if 0 < arg_583_1.time_ and arg_583_1.time_ <= 0 + arg_586_0 then
				arg_583_1.var_.moveOldPos404001ui_story = arg_583_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_586_0 = 0.001

			if 0 <= arg_583_1.time_ and arg_583_1.time_ < 0 + var_586_0 then
				arg_583_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_583_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_583_1.time_ - 0) / var_586_0)
				arg_583_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_583_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_583_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_583_1.actors_["404001ui_story"].transform.position).z)
				arg_583_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_583_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_583_1.actors_["404001ui_story"].transform.localEulerAngles = arg_583_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_583_1.time_ >= 0 + var_586_0 and arg_583_1.time_ < 0 + var_586_0 + arg_586_0 then
				arg_583_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_583_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_583_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_583_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_583_1.actors_["404001ui_story"].transform.position).z)
				arg_583_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_583_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_583_1.actors_["404001ui_story"].transform.localEulerAngles = arg_583_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_586_1 = arg_583_1.actors_["404001ui_story"]

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= 0 + arg_586_0 and not isNil(var_586_1) and arg_583_1.var_.characterEffect404001ui_story == nil then
				arg_583_1.var_.characterEffect404001ui_story = var_586_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_586_2 = 0.200000002980232

			if 0 <= arg_583_1.time_ and arg_583_1.time_ < 0 + var_586_2 and not isNil(var_586_1) then
				if arg_583_1.var_.characterEffect404001ui_story and not isNil(var_586_1) then
					arg_583_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_583_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_583_1.time_ - 0) / var_586_2)
				end
			end

			if arg_583_1.time_ >= 0 + var_586_2 and arg_583_1.time_ < 0 + var_586_2 + arg_586_0 and not isNil(var_586_1) and arg_583_1.var_.characterEffect404001ui_story then
				arg_583_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_583_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0.766666666666667 < arg_583_1.time_ and arg_583_1.time_ <= 0.766666666666667 + arg_586_0 then
				arg_583_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_footstep02", "")
			end

			local var_586_4 = 0
			local var_586_5 = 1.025

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= var_586_4 + arg_586_0 then
				arg_583_1.talkMaxDuration = 0
				arg_583_1.dialogCg_.alpha = 1

				arg_583_1.dialog_:SetActive(true)
				SetActive(arg_583_1.leftNameGo_, false)

				arg_583_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_583_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_583_1:RecordName(arg_583_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_583_1.iconTrs_.gameObject, false)
				arg_583_1.callingController_:SetSelectedState("normal")

				local var_586_6 = arg_583_1:FormatText(arg_583_1:GetWordFromCfg(322021144).content)

				arg_583_1.text_.text = var_586_6

				LuaForUtil.ClearLinePrefixSymbol(arg_583_1.text_)

				local var_586_8 = 41 <= 0 and var_586_5 or var_586_5 * (utf8.len(var_586_6) / 41)

				if (41 <= 0 and var_586_5 or var_586_5 * (utf8.len(var_586_6) / 41)) > 0 and var_586_5 < var_586_8 then
					arg_583_1.talkMaxDuration = var_586_8

					if var_586_8 + var_586_4 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_8 + var_586_4
					end
				end

				arg_583_1.text_.text = var_586_6
				arg_583_1.typewritter.percent = 0

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(false)
				arg_583_1:RecordContent(arg_583_1.text_.text)
			end

			local var_586_9 = math.max(var_586_5, arg_583_1.talkMaxDuration)

			if var_586_4 <= arg_583_1.time_ and arg_583_1.time_ < var_586_4 + var_586_9 then
				arg_583_1.typewritter.percent = (arg_583_1.time_ - var_586_4) / var_586_9

				arg_583_1.typewritter:SetDirty()
			end

			if arg_583_1.time_ >= var_586_4 + var_586_9 and arg_583_1.time_ < var_586_4 + var_586_9 + arg_586_0 then
				arg_583_1.typewritter.percent = 1

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(true)
			end
		end

		arg_583_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_583_1:InitPlayNodeList()
	end,
	Play322021145 = function(arg_587_0, arg_587_1)
		arg_587_1.time_ = 0
		arg_587_1.frameCnt_ = 0
		arg_587_1.state_ = "playing"
		arg_587_1.curTalkId_ = 322021145
		arg_587_1.duration_ = 5

		SetActive(arg_587_1.tipsGo_, false)

		function arg_587_1.onSingleLineFinish_()
			arg_587_1.onSingleLineUpdate_ = nil
			arg_587_1.onSingleLineFinish_ = nil
			arg_587_1.state_ = "waiting"
		end

		function arg_587_1.playNext_(arg_589_0)
			if arg_589_0 == 1 then
				arg_587_0:Play322021146(arg_587_1)
			end
		end

		function arg_587_1.onSingleLineUpdate_(arg_590_0)
			local var_590_0 = 1.525

			if 0 < arg_587_1.time_ and arg_587_1.time_ <= 0 + arg_590_0 then
				arg_587_1.talkMaxDuration = 0
				arg_587_1.dialogCg_.alpha = 1

				arg_587_1.dialog_:SetActive(true)
				SetActive(arg_587_1.leftNameGo_, false)

				arg_587_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_587_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_587_1:RecordName(arg_587_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_587_1.iconTrs_.gameObject, false)
				arg_587_1.callingController_:SetSelectedState("normal")

				local var_590_1 = arg_587_1:FormatText(arg_587_1:GetWordFromCfg(322021145).content)

				arg_587_1.text_.text = var_590_1

				LuaForUtil.ClearLinePrefixSymbol(arg_587_1.text_)

				local var_590_3 = 61 <= 0 and var_590_0 or var_590_0 * (utf8.len(var_590_1) / 61)

				if (61 <= 0 and var_590_0 or var_590_0 * (utf8.len(var_590_1) / 61)) > 0 and var_590_0 < var_590_3 then
					arg_587_1.talkMaxDuration = var_590_3

					if var_590_3 + 0 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_3 + 0
					end
				end

				arg_587_1.text_.text = var_590_1
				arg_587_1.typewritter.percent = 0

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(false)
				arg_587_1:RecordContent(arg_587_1.text_.text)
			end

			local var_590_4 = math.max(var_590_0, arg_587_1.talkMaxDuration)

			if 0 <= arg_587_1.time_ and arg_587_1.time_ < 0 + var_590_4 then
				arg_587_1.typewritter.percent = (arg_587_1.time_ - 0) / var_590_4

				arg_587_1.typewritter:SetDirty()
			end

			if arg_587_1.time_ >= 0 + var_590_4 and arg_587_1.time_ < 0 + var_590_4 + arg_590_0 then
				arg_587_1.typewritter.percent = 1

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(true)
			end
		end

		arg_587_1.nodeConfigList_ = {}

		arg_587_1:InitPlayNodeList()
	end,
	Play322021146 = function(arg_591_0, arg_591_1)
		arg_591_1.time_ = 0
		arg_591_1.frameCnt_ = 0
		arg_591_1.state_ = "playing"
		arg_591_1.curTalkId_ = 322021146
		arg_591_1.duration_ = 9

		SetActive(arg_591_1.tipsGo_, false)

		function arg_591_1.onSingleLineFinish_()
			arg_591_1.onSingleLineUpdate_ = nil
			arg_591_1.onSingleLineFinish_ = nil
			arg_591_1.state_ = "waiting"
		end

		function arg_591_1.playNext_(arg_593_0)
			if arg_593_0 == 1 then
				arg_591_0:Play322021147(arg_591_1)
			end
		end

		function arg_591_1.onSingleLineUpdate_(arg_594_0)
			if 2 < arg_591_1.time_ and arg_591_1.time_ <= 2 + arg_594_0 then
				local var_594_0 = arg_591_1.bgs_.L14f

				arg_591_1.bgs_.L14f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_594_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_594_1 = var_594_0:GetComponent("SpriteRenderer")

				if var_594_1 and var_594_1.sprite then
					local var_594_2 = 2 * (var_594_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_594_0.transform.localScale = Vector3.New(var_594_2 / var_594_1.sprite.bounds.size.y < var_594_2 * manager.ui.mainCameraCom_.aspect / var_594_1.sprite.bounds.size.x and var_594_2 * manager.ui.mainCameraCom_.aspect / var_594_1.sprite.bounds.size.x or var_594_2 / var_594_1.sprite.bounds.size.y, var_594_2 / var_594_1.sprite.bounds.size.y < var_594_2 * manager.ui.mainCameraCom_.aspect / var_594_1.sprite.bounds.size.x and var_594_2 * manager.ui.mainCameraCom_.aspect / var_594_1.sprite.bounds.size.x or var_594_2 / var_594_1.sprite.bounds.size.y, 0)
				end

				for iter_594_0, iter_594_1 in pairs(arg_591_1.bgs_) do
					if iter_594_0 ~= "L14f" then
						iter_594_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_594_3 = 4

			if 4 < arg_591_1.time_ and arg_591_1.time_ <= var_594_3 + arg_594_0 then
				arg_591_1.allBtn_.enabled = false
			end

			if arg_591_1.time_ >= var_594_3 + 0.3 and arg_591_1.time_ < var_594_3 + 0.3 + arg_594_0 then
				arg_591_1.allBtn_.enabled = true
			end

			local var_594_4 = 0

			if 0 < arg_591_1.time_ and arg_591_1.time_ <= var_594_4 + arg_594_0 then
				arg_591_1.mask_.enabled = true
				arg_591_1.mask_.raycastTarget = true

				arg_591_1:SetGaussion(false)
			end

			local var_594_5 = 2

			if var_594_4 <= arg_591_1.time_ and arg_591_1.time_ < var_594_4 + var_594_5 then
				local var_594_6 = Color.New(0, 0, 0)

				var_594_6.a = Mathf.Lerp(0, 1, (arg_591_1.time_ - var_594_4) / var_594_5)
				arg_591_1.mask_.color = var_594_6
			end

			if arg_591_1.time_ >= var_594_4 + var_594_5 and arg_591_1.time_ < var_594_4 + var_594_5 + arg_594_0 then
				local var_594_7 = Color.New(0, 0, 0)

				var_594_7.a = 1
				arg_591_1.mask_.color = var_594_7
			end

			local var_594_8 = 2

			if 2 < arg_591_1.time_ and arg_591_1.time_ <= var_594_8 + arg_594_0 then
				arg_591_1.mask_.enabled = true
				arg_591_1.mask_.raycastTarget = true

				arg_591_1:SetGaussion(false)
			end

			local var_594_9 = 2

			if var_594_8 <= arg_591_1.time_ and arg_591_1.time_ < var_594_8 + var_594_9 then
				local var_594_10 = Color.New(0, 0, 0)

				var_594_10.a = Mathf.Lerp(1, 0, (arg_591_1.time_ - var_594_8) / var_594_9)
				arg_591_1.mask_.color = var_594_10
			end

			if arg_591_1.time_ >= var_594_8 + var_594_9 and arg_591_1.time_ < var_594_8 + var_594_9 + arg_594_0 then
				local var_594_11 = Color.New(0, 0, 0)

				arg_591_1.mask_.enabled = false
				var_594_11.a = 0
				arg_591_1.mask_.color = var_594_11
			end

			if arg_591_1.frameCnt_ <= 1 then
				arg_591_1.dialog_:SetActive(false)
			end

			local var_594_12 = 4
			local var_594_13 = 1.85

			if 4 < arg_591_1.time_ and arg_591_1.time_ <= var_594_12 + arg_594_0 then
				arg_591_1.talkMaxDuration = 0

				arg_591_1.dialog_:SetActive(true)

				arg_591_1.dialogCg_.alpha = 0

				local var_594_14 = LeanTween.value(arg_591_1.dialog_, 0, 1, 0.3)

				var_594_14:setOnUpdate(LuaHelper.FloatAction(function(arg_595_0)
					arg_591_1.dialogCg_.alpha = arg_595_0
				end))
				var_594_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_591_1.dialog_)
					var_594_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_591_1.duration_ = arg_591_1.duration_ + 0.3

				SetActive(arg_591_1.leftNameGo_, false)

				arg_591_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_591_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_591_1:RecordName(arg_591_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_591_1.iconTrs_.gameObject, false)
				arg_591_1.callingController_:SetSelectedState("normal")

				local var_594_15 = arg_591_1:FormatText(arg_591_1:GetWordFromCfg(322021146).content)

				arg_591_1.text_.text = var_594_15

				LuaForUtil.ClearLinePrefixSymbol(arg_591_1.text_)

				local var_594_17 = 74 <= 0 and var_594_13 or var_594_13 * (utf8.len(var_594_15) / 74)

				if (74 <= 0 and var_594_13 or var_594_13 * (utf8.len(var_594_15) / 74)) > 0 and var_594_13 < var_594_17 then
					arg_591_1.talkMaxDuration = var_594_17
					var_594_12 = var_594_12 + 0.3

					if var_594_17 + var_594_12 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_17 + var_594_12
					end
				end

				arg_591_1.text_.text = var_594_15
				arg_591_1.typewritter.percent = 0

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(false)
				arg_591_1:RecordContent(arg_591_1.text_.text)
			end

			local var_594_18 = var_594_12 + 0.3
			local var_594_19 = math.max(var_594_13, arg_591_1.talkMaxDuration)

			if var_594_12 + 0.3 <= arg_591_1.time_ and arg_591_1.time_ < var_594_18 + var_594_19 then
				arg_591_1.typewritter.percent = (arg_591_1.time_ - var_594_18) / var_594_19

				arg_591_1.typewritter:SetDirty()
			end

			if arg_591_1.time_ >= var_594_18 + var_594_19 and arg_591_1.time_ < var_594_18 + var_594_19 + arg_594_0 then
				arg_591_1.typewritter.percent = 1

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(true)
			end
		end

		arg_591_1.nodeConfigList_ = {}

		arg_591_1:InitPlayNodeList()
	end,
	Play322021147 = function(arg_597_0, arg_597_1)
		arg_597_1.time_ = 0
		arg_597_1.frameCnt_ = 0
		arg_597_1.state_ = "playing"
		arg_597_1.curTalkId_ = 322021147
		arg_597_1.duration_ = 5

		SetActive(arg_597_1.tipsGo_, false)

		function arg_597_1.onSingleLineFinish_()
			arg_597_1.onSingleLineUpdate_ = nil
			arg_597_1.onSingleLineFinish_ = nil
			arg_597_1.state_ = "waiting"
		end

		function arg_597_1.playNext_(arg_599_0)
			if arg_599_0 == 1 then
				arg_597_0:Play322021148(arg_597_1)
			end
		end

		function arg_597_1.onSingleLineUpdate_(arg_600_0)
			local var_600_0 = 1.625

			if 0 < arg_597_1.time_ and arg_597_1.time_ <= 0 + arg_600_0 then
				arg_597_1.talkMaxDuration = 0
				arg_597_1.dialogCg_.alpha = 1

				arg_597_1.dialog_:SetActive(true)
				SetActive(arg_597_1.leftNameGo_, false)

				arg_597_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_597_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_597_1:RecordName(arg_597_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_597_1.iconTrs_.gameObject, false)
				arg_597_1.callingController_:SetSelectedState("normal")

				local var_600_1 = arg_597_1:FormatText(arg_597_1:GetWordFromCfg(322021147).content)

				arg_597_1.text_.text = var_600_1

				LuaForUtil.ClearLinePrefixSymbol(arg_597_1.text_)

				local var_600_3 = 65 <= 0 and var_600_0 or var_600_0 * (utf8.len(var_600_1) / 65)

				if (65 <= 0 and var_600_0 or var_600_0 * (utf8.len(var_600_1) / 65)) > 0 and var_600_0 < var_600_3 then
					arg_597_1.talkMaxDuration = var_600_3

					if var_600_3 + 0 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_3 + 0
					end
				end

				arg_597_1.text_.text = var_600_1
				arg_597_1.typewritter.percent = 0

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(false)
				arg_597_1:RecordContent(arg_597_1.text_.text)
			end

			local var_600_4 = math.max(var_600_0, arg_597_1.talkMaxDuration)

			if 0 <= arg_597_1.time_ and arg_597_1.time_ < 0 + var_600_4 then
				arg_597_1.typewritter.percent = (arg_597_1.time_ - 0) / var_600_4

				arg_597_1.typewritter:SetDirty()
			end

			if arg_597_1.time_ >= 0 + var_600_4 and arg_597_1.time_ < 0 + var_600_4 + arg_600_0 then
				arg_597_1.typewritter.percent = 1

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(true)
			end
		end

		arg_597_1.nodeConfigList_ = {}

		arg_597_1:InitPlayNodeList()
	end,
	Play322021148 = function(arg_601_0, arg_601_1)
		arg_601_1.time_ = 0
		arg_601_1.frameCnt_ = 0
		arg_601_1.state_ = "playing"
		arg_601_1.curTalkId_ = 322021148
		arg_601_1.duration_ = 5

		SetActive(arg_601_1.tipsGo_, false)

		function arg_601_1.onSingleLineFinish_()
			arg_601_1.onSingleLineUpdate_ = nil
			arg_601_1.onSingleLineFinish_ = nil
			arg_601_1.state_ = "waiting"
		end

		function arg_601_1.playNext_(arg_603_0)
			if arg_603_0 == 1 then
				arg_601_0:Play322021149(arg_601_1)
			end
		end

		function arg_601_1.onSingleLineUpdate_(arg_604_0)
			local var_604_0 = 1.7

			if 0 < arg_601_1.time_ and arg_601_1.time_ <= 0 + arg_604_0 then
				arg_601_1.talkMaxDuration = 0
				arg_601_1.dialogCg_.alpha = 1

				arg_601_1.dialog_:SetActive(true)
				SetActive(arg_601_1.leftNameGo_, false)

				arg_601_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_601_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_601_1:RecordName(arg_601_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_601_1.iconTrs_.gameObject, false)
				arg_601_1.callingController_:SetSelectedState("normal")

				local var_604_1 = arg_601_1:FormatText(arg_601_1:GetWordFromCfg(322021148).content)

				arg_601_1.text_.text = var_604_1

				LuaForUtil.ClearLinePrefixSymbol(arg_601_1.text_)

				local var_604_3 = 68 <= 0 and var_604_0 or var_604_0 * (utf8.len(var_604_1) / 68)

				if (68 <= 0 and var_604_0 or var_604_0 * (utf8.len(var_604_1) / 68)) > 0 and var_604_0 < var_604_3 then
					arg_601_1.talkMaxDuration = var_604_3

					if var_604_3 + 0 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_3 + 0
					end
				end

				arg_601_1.text_.text = var_604_1
				arg_601_1.typewritter.percent = 0

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(false)
				arg_601_1:RecordContent(arg_601_1.text_.text)
			end

			local var_604_4 = math.max(var_604_0, arg_601_1.talkMaxDuration)

			if 0 <= arg_601_1.time_ and arg_601_1.time_ < 0 + var_604_4 then
				arg_601_1.typewritter.percent = (arg_601_1.time_ - 0) / var_604_4

				arg_601_1.typewritter:SetDirty()
			end

			if arg_601_1.time_ >= 0 + var_604_4 and arg_601_1.time_ < 0 + var_604_4 + arg_604_0 then
				arg_601_1.typewritter.percent = 1

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(true)
			end
		end

		arg_601_1.nodeConfigList_ = {}

		arg_601_1:InitPlayNodeList()
	end,
	Play322021149 = function(arg_605_0, arg_605_1)
		arg_605_1.time_ = 0
		arg_605_1.frameCnt_ = 0
		arg_605_1.state_ = "playing"
		arg_605_1.curTalkId_ = 322021149
		arg_605_1.duration_ = 6

		local var_605_0 = {
			zh = 6,
			ja = 5.533
		}
		local var_605_1 = manager.audio:GetLocalizationFlag()

		if var_605_0[var_605_1] ~= nil then
			arg_605_1.duration_ = var_605_0[var_605_1]
		end

		SetActive(arg_605_1.tipsGo_, false)

		function arg_605_1.onSingleLineFinish_()
			arg_605_1.onSingleLineUpdate_ = nil
			arg_605_1.onSingleLineFinish_ = nil
			arg_605_1.state_ = "waiting"
		end

		function arg_605_1.playNext_(arg_607_0)
			if arg_607_0 == 1 then
				arg_605_0:Play322021150(arg_605_1)
			end
		end

		function arg_605_1.onSingleLineUpdate_(arg_608_0)
			local var_608_0 = 0.575

			if 0 < arg_605_1.time_ and arg_605_1.time_ <= 0 + arg_608_0 then
				arg_605_1.talkMaxDuration = 0
				arg_605_1.dialogCg_.alpha = 1

				arg_605_1.dialog_:SetActive(true)
				SetActive(arg_605_1.leftNameGo_, true)

				arg_605_1.leftNameTxt_.text = arg_605_1:FormatText(StoryNameCfg[1362].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_605_1.leftNameTxt_.transform)

				arg_605_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_605_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_605_1:RecordName(arg_605_1.leftNameTxt_.text)
				SetActive(arg_605_1.iconTrs_.gameObject, true)
				arg_605_1.iconController_:SetSelectedState("hero")

				arg_605_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_605_1.callingController_:SetSelectedState("normal")

				arg_605_1.keyicon_.color = Color.New(1, 1, 1)
				arg_605_1.icon_.color = Color.New(1, 1, 1)

				local var_608_1 = arg_605_1:GetWordFromCfg(322021149)
				local var_608_2 = arg_605_1:FormatText(var_608_1.content)

				arg_605_1.text_.text = var_608_2

				LuaForUtil.ClearLinePrefixSymbol(arg_605_1.text_)

				local var_608_4 = 23 <= 0 and var_608_0 or var_608_0 * (utf8.len(var_608_2) / 23)

				if (23 <= 0 and var_608_0 or var_608_0 * (utf8.len(var_608_2) / 23)) > 0 and var_608_0 < var_608_4 then
					arg_605_1.talkMaxDuration = var_608_4

					if var_608_4 + 0 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_4 + 0
					end
				end

				arg_605_1.text_.text = var_608_2
				arg_605_1.typewritter.percent = 0

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021149", "story_v_out_322021.awb") ~= 0 then
					local var_608_5 = manager.audio:GetVoiceLength("story_v_out_322021", "322021149", "story_v_out_322021.awb") / 1000

					if var_608_5 + 0 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_5 + 0
					end

					if var_608_1.prefab_name ~= "" and arg_605_1.actors_[var_608_1.prefab_name] ~= nil then
						local var_608_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_605_1.actors_[var_608_1.prefab_name].transform, "story_v_out_322021", "322021149", "story_v_out_322021.awb")

						arg_605_1:RecordAudio("322021149", var_608_6)
						arg_605_1:RecordAudio("322021149", var_608_6)
					else
						arg_605_1:AudioAction("play", "voice", "story_v_out_322021", "322021149", "story_v_out_322021.awb")
					end

					arg_605_1:RecordHistoryTalkVoice("story_v_out_322021", "322021149", "story_v_out_322021.awb")
				end

				arg_605_1:RecordContent(arg_605_1.text_.text)
			end

			local var_608_7 = math.max(var_608_0, arg_605_1.talkMaxDuration)

			if 0 <= arg_605_1.time_ and arg_605_1.time_ < 0 + var_608_7 then
				arg_605_1.typewritter.percent = (arg_605_1.time_ - 0) / var_608_7

				arg_605_1.typewritter:SetDirty()
			end

			if arg_605_1.time_ >= 0 + var_608_7 and arg_605_1.time_ < 0 + var_608_7 + arg_608_0 then
				arg_605_1.typewritter.percent = 1

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(true)
			end
		end

		arg_605_1.nodeConfigList_ = {}

		arg_605_1:InitPlayNodeList()
	end,
	Play322021150 = function(arg_609_0, arg_609_1)
		arg_609_1.time_ = 0
		arg_609_1.frameCnt_ = 0
		arg_609_1.state_ = "playing"
		arg_609_1.curTalkId_ = 322021150
		arg_609_1.duration_ = 5

		SetActive(arg_609_1.tipsGo_, false)

		function arg_609_1.onSingleLineFinish_()
			arg_609_1.onSingleLineUpdate_ = nil
			arg_609_1.onSingleLineFinish_ = nil
			arg_609_1.state_ = "waiting"
		end

		function arg_609_1.playNext_(arg_611_0)
			if arg_611_0 == 1 then
				arg_609_0:Play322021151(arg_609_1)
			end
		end

		function arg_609_1.onSingleLineUpdate_(arg_612_0)
			local var_612_0 = 0.925

			if 0 < arg_609_1.time_ and arg_609_1.time_ <= 0 + arg_612_0 then
				arg_609_1.talkMaxDuration = 0
				arg_609_1.dialogCg_.alpha = 1

				arg_609_1.dialog_:SetActive(true)
				SetActive(arg_609_1.leftNameGo_, false)

				arg_609_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_609_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_609_1:RecordName(arg_609_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_609_1.iconTrs_.gameObject, false)
				arg_609_1.callingController_:SetSelectedState("normal")

				local var_612_1 = arg_609_1:FormatText(arg_609_1:GetWordFromCfg(322021150).content)

				arg_609_1.text_.text = var_612_1

				LuaForUtil.ClearLinePrefixSymbol(arg_609_1.text_)

				local var_612_3 = 37 <= 0 and var_612_0 or var_612_0 * (utf8.len(var_612_1) / 37)

				if (37 <= 0 and var_612_0 or var_612_0 * (utf8.len(var_612_1) / 37)) > 0 and var_612_0 < var_612_3 then
					arg_609_1.talkMaxDuration = var_612_3

					if var_612_3 + 0 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_3 + 0
					end
				end

				arg_609_1.text_.text = var_612_1
				arg_609_1.typewritter.percent = 0

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(false)
				arg_609_1:RecordContent(arg_609_1.text_.text)
			end

			local var_612_4 = math.max(var_612_0, arg_609_1.talkMaxDuration)

			if 0 <= arg_609_1.time_ and arg_609_1.time_ < 0 + var_612_4 then
				arg_609_1.typewritter.percent = (arg_609_1.time_ - 0) / var_612_4

				arg_609_1.typewritter:SetDirty()
			end

			if arg_609_1.time_ >= 0 + var_612_4 and arg_609_1.time_ < 0 + var_612_4 + arg_612_0 then
				arg_609_1.typewritter.percent = 1

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(true)
			end
		end

		arg_609_1.nodeConfigList_ = {}

		arg_609_1:InitPlayNodeList()
	end,
	Play322021151 = function(arg_613_0, arg_613_1)
		arg_613_1.time_ = 0
		arg_613_1.frameCnt_ = 0
		arg_613_1.state_ = "playing"
		arg_613_1.curTalkId_ = 322021151
		arg_613_1.duration_ = 5

		SetActive(arg_613_1.tipsGo_, false)

		function arg_613_1.onSingleLineFinish_()
			arg_613_1.onSingleLineUpdate_ = nil
			arg_613_1.onSingleLineFinish_ = nil
			arg_613_1.state_ = "waiting"
		end

		function arg_613_1.playNext_(arg_615_0)
			if arg_615_0 == 1 then
				arg_613_0:Play322021152(arg_613_1)
			end
		end

		function arg_613_1.onSingleLineUpdate_(arg_616_0)
			if 0.725 < arg_613_1.time_ and arg_613_1.time_ <= 0.725 + arg_616_0 then
				arg_613_1:AudioAction("play", "effect", "se_story_141", "se_story_141_amb_bass", "")
			end

			if 0.441666666665667 < arg_613_1.time_ and arg_613_1.time_ <= 0.441666666665667 + arg_616_0 then
				arg_613_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_machine03", "")
			end

			if 0 < arg_613_1.time_ and arg_613_1.time_ <= 0 + arg_616_0 then
				arg_613_1:AudioAction("stop", "effect", "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			local var_616_3 = 0
			local var_616_4 = 1.725

			if 0 < arg_613_1.time_ and arg_613_1.time_ <= var_616_3 + arg_616_0 then
				arg_613_1.talkMaxDuration = 0
				arg_613_1.dialogCg_.alpha = 1

				arg_613_1.dialog_:SetActive(true)
				SetActive(arg_613_1.leftNameGo_, false)

				arg_613_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_613_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_613_1:RecordName(arg_613_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_613_1.iconTrs_.gameObject, false)
				arg_613_1.callingController_:SetSelectedState("normal")

				local var_616_5 = arg_613_1:FormatText(arg_613_1:GetWordFromCfg(322021151).content)

				arg_613_1.text_.text = var_616_5

				LuaForUtil.ClearLinePrefixSymbol(arg_613_1.text_)

				local var_616_7 = 69 <= 0 and var_616_4 or var_616_4 * (utf8.len(var_616_5) / 69)

				if (69 <= 0 and var_616_4 or var_616_4 * (utf8.len(var_616_5) / 69)) > 0 and var_616_4 < var_616_7 then
					arg_613_1.talkMaxDuration = var_616_7

					if var_616_7 + var_616_3 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_7 + var_616_3
					end
				end

				arg_613_1.text_.text = var_616_5
				arg_613_1.typewritter.percent = 0

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(false)
				arg_613_1:RecordContent(arg_613_1.text_.text)
			end

			local var_616_8 = math.max(var_616_4, arg_613_1.talkMaxDuration)

			if var_616_3 <= arg_613_1.time_ and arg_613_1.time_ < var_616_3 + var_616_8 then
				arg_613_1.typewritter.percent = (arg_613_1.time_ - var_616_3) / var_616_8

				arg_613_1.typewritter:SetDirty()
			end

			if arg_613_1.time_ >= var_616_3 + var_616_8 and arg_613_1.time_ < var_616_3 + var_616_8 + arg_616_0 then
				arg_613_1.typewritter.percent = 1

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(true)
			end
		end

		arg_613_1.nodeConfigList_ = {}

		arg_613_1:InitPlayNodeList()
	end,
	Play322021152 = function(arg_617_0, arg_617_1)
		arg_617_1.time_ = 0
		arg_617_1.frameCnt_ = 0
		arg_617_1.state_ = "playing"
		arg_617_1.curTalkId_ = 322021152
		arg_617_1.duration_ = 5

		SetActive(arg_617_1.tipsGo_, false)

		function arg_617_1.onSingleLineFinish_()
			arg_617_1.onSingleLineUpdate_ = nil
			arg_617_1.onSingleLineFinish_ = nil
			arg_617_1.state_ = "waiting"
		end

		function arg_617_1.playNext_(arg_619_0)
			if arg_619_0 == 1 then
				arg_617_0:Play322021153(arg_617_1)
			end
		end

		function arg_617_1.onSingleLineUpdate_(arg_620_0)
			local var_620_0 = 1.15

			if 0 < arg_617_1.time_ and arg_617_1.time_ <= 0 + arg_620_0 then
				arg_617_1.talkMaxDuration = 0
				arg_617_1.dialogCg_.alpha = 1

				arg_617_1.dialog_:SetActive(true)
				SetActive(arg_617_1.leftNameGo_, false)

				arg_617_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_617_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_617_1:RecordName(arg_617_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_617_1.iconTrs_.gameObject, false)
				arg_617_1.callingController_:SetSelectedState("normal")

				local var_620_1 = arg_617_1:FormatText(arg_617_1:GetWordFromCfg(322021152).content)

				arg_617_1.text_.text = var_620_1

				LuaForUtil.ClearLinePrefixSymbol(arg_617_1.text_)

				local var_620_3 = 46 <= 0 and var_620_0 or var_620_0 * (utf8.len(var_620_1) / 46)

				if (46 <= 0 and var_620_0 or var_620_0 * (utf8.len(var_620_1) / 46)) > 0 and var_620_0 < var_620_3 then
					arg_617_1.talkMaxDuration = var_620_3

					if var_620_3 + 0 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_3 + 0
					end
				end

				arg_617_1.text_.text = var_620_1
				arg_617_1.typewritter.percent = 0

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(false)
				arg_617_1:RecordContent(arg_617_1.text_.text)
			end

			local var_620_4 = math.max(var_620_0, arg_617_1.talkMaxDuration)

			if 0 <= arg_617_1.time_ and arg_617_1.time_ < 0 + var_620_4 then
				arg_617_1.typewritter.percent = (arg_617_1.time_ - 0) / var_620_4

				arg_617_1.typewritter:SetDirty()
			end

			if arg_617_1.time_ >= 0 + var_620_4 and arg_617_1.time_ < 0 + var_620_4 + arg_620_0 then
				arg_617_1.typewritter.percent = 1

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(true)
			end
		end

		arg_617_1.nodeConfigList_ = {}

		arg_617_1:InitPlayNodeList()
	end,
	Play322021153 = function(arg_621_0, arg_621_1)
		arg_621_1.time_ = 0
		arg_621_1.frameCnt_ = 0
		arg_621_1.state_ = "playing"
		arg_621_1.curTalkId_ = 322021153
		arg_621_1.duration_ = 6.77

		local var_621_0 = {
			zh = 4.7,
			ja = 6.766
		}
		local var_621_1 = manager.audio:GetLocalizationFlag()

		if var_621_0[var_621_1] ~= nil then
			arg_621_1.duration_ = var_621_0[var_621_1]
		end

		SetActive(arg_621_1.tipsGo_, false)

		function arg_621_1.onSingleLineFinish_()
			arg_621_1.onSingleLineUpdate_ = nil
			arg_621_1.onSingleLineFinish_ = nil
			arg_621_1.state_ = "waiting"
		end

		function arg_621_1.playNext_(arg_623_0)
			if arg_623_0 == 1 then
				arg_621_0:Play322021154(arg_621_1)
			end
		end

		function arg_621_1.onSingleLineUpdate_(arg_624_0)
			local var_624_0 = 0.55

			if 0 < arg_621_1.time_ and arg_621_1.time_ <= 0 + arg_624_0 then
				arg_621_1.talkMaxDuration = 0
				arg_621_1.dialogCg_.alpha = 1

				arg_621_1.dialog_:SetActive(true)
				SetActive(arg_621_1.leftNameGo_, true)

				arg_621_1.leftNameTxt_.text = arg_621_1:FormatText(StoryNameCfg[1362].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_621_1.leftNameTxt_.transform)

				arg_621_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_621_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_621_1:RecordName(arg_621_1.leftNameTxt_.text)
				SetActive(arg_621_1.iconTrs_.gameObject, true)
				arg_621_1.iconController_:SetSelectedState("hero")

				arg_621_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_621_1.callingController_:SetSelectedState("normal")

				arg_621_1.keyicon_.color = Color.New(1, 1, 1)
				arg_621_1.icon_.color = Color.New(1, 1, 1)

				local var_624_1 = arg_621_1:GetWordFromCfg(322021153)
				local var_624_2 = arg_621_1:FormatText(var_624_1.content)

				arg_621_1.text_.text = var_624_2

				LuaForUtil.ClearLinePrefixSymbol(arg_621_1.text_)

				local var_624_4 = 22 <= 0 and var_624_0 or var_624_0 * (utf8.len(var_624_2) / 22)

				if (22 <= 0 and var_624_0 or var_624_0 * (utf8.len(var_624_2) / 22)) > 0 and var_624_0 < var_624_4 then
					arg_621_1.talkMaxDuration = var_624_4

					if var_624_4 + 0 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_4 + 0
					end
				end

				arg_621_1.text_.text = var_624_2
				arg_621_1.typewritter.percent = 0

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021153", "story_v_out_322021.awb") ~= 0 then
					local var_624_5 = manager.audio:GetVoiceLength("story_v_out_322021", "322021153", "story_v_out_322021.awb") / 1000

					if var_624_5 + 0 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_5 + 0
					end

					if var_624_1.prefab_name ~= "" and arg_621_1.actors_[var_624_1.prefab_name] ~= nil then
						local var_624_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_621_1.actors_[var_624_1.prefab_name].transform, "story_v_out_322021", "322021153", "story_v_out_322021.awb")

						arg_621_1:RecordAudio("322021153", var_624_6)
						arg_621_1:RecordAudio("322021153", var_624_6)
					else
						arg_621_1:AudioAction("play", "voice", "story_v_out_322021", "322021153", "story_v_out_322021.awb")
					end

					arg_621_1:RecordHistoryTalkVoice("story_v_out_322021", "322021153", "story_v_out_322021.awb")
				end

				arg_621_1:RecordContent(arg_621_1.text_.text)
			end

			local var_624_7 = math.max(var_624_0, arg_621_1.talkMaxDuration)

			if 0 <= arg_621_1.time_ and arg_621_1.time_ < 0 + var_624_7 then
				arg_621_1.typewritter.percent = (arg_621_1.time_ - 0) / var_624_7

				arg_621_1.typewritter:SetDirty()
			end

			if arg_621_1.time_ >= 0 + var_624_7 and arg_621_1.time_ < 0 + var_624_7 + arg_624_0 then
				arg_621_1.typewritter.percent = 1

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(true)
			end
		end

		arg_621_1.nodeConfigList_ = {}

		arg_621_1:InitPlayNodeList()
	end,
	Play322021154 = function(arg_625_0, arg_625_1)
		arg_625_1.time_ = 0
		arg_625_1.frameCnt_ = 0
		arg_625_1.state_ = "playing"
		arg_625_1.curTalkId_ = 322021154
		arg_625_1.duration_ = 5

		SetActive(arg_625_1.tipsGo_, false)

		function arg_625_1.onSingleLineFinish_()
			arg_625_1.onSingleLineUpdate_ = nil
			arg_625_1.onSingleLineFinish_ = nil
			arg_625_1.state_ = "waiting"
		end

		function arg_625_1.playNext_(arg_627_0)
			if arg_627_0 == 1 then
				arg_625_0:Play322021155(arg_625_1)
			end
		end

		function arg_625_1.onSingleLineUpdate_(arg_628_0)
			local var_628_9000

			if 0.1 < arg_625_1.time_ and arg_625_1.time_ <= 0.1 + arg_628_0 then
				arg_625_1:AudioAction("play", "effect", "se_story_140", "se_story_140_data03", "")
			end

			if 0.1 < arg_625_1.time_ and arg_625_1.time_ <= 0.1 + arg_628_0 then
				local var_628_1 = arg_625_1.var_.effect1154

				if not arg_625_1.var_.effect1154 then
					var_628_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_jingbao_in_keep"), manager.ui.mainCamera.transform)
					var_628_1.name = "1154"
					arg_625_1.var_.effect1154 = var_628_1
				else
					var_628_1.transform:SetParent(var_628_9000)
				end

				var_628_1.transform.localPosition = Vector3.New(0, 0, -0.6)
				var_628_1.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_628_3 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_628_0, iter_628_1 in ipairs((var_628_1.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_628_1.transform.localScale = Vector3.New(iter_628_1.transform.localScale.x / var_628_3 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_628_1.transform.localScale.y / var_628_3, iter_628_1.transform.localScale.z)
				end
			end

			local var_628_5 = 0
			local var_628_6 = 1.075

			if 0 < arg_625_1.time_ and arg_625_1.time_ <= var_628_5 + arg_628_0 then
				arg_625_1.talkMaxDuration = 0
				arg_625_1.dialogCg_.alpha = 1

				arg_625_1.dialog_:SetActive(true)
				SetActive(arg_625_1.leftNameGo_, false)

				arg_625_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_625_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_625_1:RecordName(arg_625_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_625_1.iconTrs_.gameObject, false)
				arg_625_1.callingController_:SetSelectedState("normal")

				local var_628_7 = arg_625_1:FormatText(arg_625_1:GetWordFromCfg(322021154).content)

				arg_625_1.text_.text = var_628_7

				LuaForUtil.ClearLinePrefixSymbol(arg_625_1.text_)

				local var_628_9 = 43 <= 0 and var_628_6 or var_628_6 * (utf8.len(var_628_7) / 43)

				if (43 <= 0 and var_628_6 or var_628_6 * (utf8.len(var_628_7) / 43)) > 0 and var_628_6 < var_628_9 then
					arg_625_1.talkMaxDuration = var_628_9

					if var_628_9 + var_628_5 > arg_625_1.duration_ then
						arg_625_1.duration_ = var_628_9 + var_628_5
					end
				end

				arg_625_1.text_.text = var_628_7
				arg_625_1.typewritter.percent = 0

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(false)
				arg_625_1:RecordContent(arg_625_1.text_.text)
			end

			local var_628_10 = math.max(var_628_6, arg_625_1.talkMaxDuration)

			if var_628_5 <= arg_625_1.time_ and arg_625_1.time_ < var_628_5 + var_628_10 then
				arg_625_1.typewritter.percent = (arg_625_1.time_ - var_628_5) / var_628_10

				arg_625_1.typewritter:SetDirty()
			end

			if arg_625_1.time_ >= var_628_5 + var_628_10 and arg_625_1.time_ < var_628_5 + var_628_10 + arg_628_0 then
				arg_625_1.typewritter.percent = 1

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(true)
			end
		end

		arg_625_1.nodeConfigList_ = {}

		arg_625_1:InitPlayNodeList()
	end,
	Play322021155 = function(arg_629_0, arg_629_1)
		arg_629_1.time_ = 0
		arg_629_1.frameCnt_ = 0
		arg_629_1.state_ = "playing"
		arg_629_1.curTalkId_ = 322021155
		arg_629_1.duration_ = 5

		SetActive(arg_629_1.tipsGo_, false)

		function arg_629_1.onSingleLineFinish_()
			arg_629_1.onSingleLineUpdate_ = nil
			arg_629_1.onSingleLineFinish_ = nil
			arg_629_1.state_ = "waiting"
		end

		function arg_629_1.playNext_(arg_631_0)
			if arg_631_0 == 1 then
				arg_629_0:Play322021156(arg_629_1)
			end
		end

		function arg_629_1.onSingleLineUpdate_(arg_632_0)
			if 0.133333333333333 < arg_629_1.time_ and arg_629_1.time_ <= 0.133333333333333 + arg_632_0 then
				arg_629_1:AudioAction("play", "effect", "se_story_1211", "se_story_1211_energy01", "")
			end

			if 0.133333333333333 < arg_629_1.time_ and arg_629_1.time_ <= 0.133333333333333 + arg_632_0 then
				arg_629_1:AudioAction("stop", "effect", "se_story_141", "se_story_141_amb_bass", "")
			end

			local var_632_2 = 0
			local var_632_3 = 1.8

			if 0 < arg_629_1.time_ and arg_629_1.time_ <= var_632_2 + arg_632_0 then
				arg_629_1.talkMaxDuration = 0
				arg_629_1.dialogCg_.alpha = 1

				arg_629_1.dialog_:SetActive(true)
				SetActive(arg_629_1.leftNameGo_, false)

				arg_629_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_629_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_629_1:RecordName(arg_629_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_629_1.iconTrs_.gameObject, false)
				arg_629_1.callingController_:SetSelectedState("normal")

				local var_632_4 = arg_629_1:FormatText(arg_629_1:GetWordFromCfg(322021155).content)

				arg_629_1.text_.text = var_632_4

				LuaForUtil.ClearLinePrefixSymbol(arg_629_1.text_)

				local var_632_6 = 72 <= 0 and var_632_3 or var_632_3 * (utf8.len(var_632_4) / 72)

				if (72 <= 0 and var_632_3 or var_632_3 * (utf8.len(var_632_4) / 72)) > 0 and var_632_3 < var_632_6 then
					arg_629_1.talkMaxDuration = var_632_6

					if var_632_6 + var_632_2 > arg_629_1.duration_ then
						arg_629_1.duration_ = var_632_6 + var_632_2
					end
				end

				arg_629_1.text_.text = var_632_4
				arg_629_1.typewritter.percent = 0

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(false)
				arg_629_1:RecordContent(arg_629_1.text_.text)
			end

			local var_632_7 = math.max(var_632_3, arg_629_1.talkMaxDuration)

			if var_632_2 <= arg_629_1.time_ and arg_629_1.time_ < var_632_2 + var_632_7 then
				arg_629_1.typewritter.percent = (arg_629_1.time_ - var_632_2) / var_632_7

				arg_629_1.typewritter:SetDirty()
			end

			if arg_629_1.time_ >= var_632_2 + var_632_7 and arg_629_1.time_ < var_632_2 + var_632_7 + arg_632_0 then
				arg_629_1.typewritter.percent = 1

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(true)
			end
		end

		arg_629_1.nodeConfigList_ = {}

		arg_629_1:InitPlayNodeList()
	end,
	Play322021156 = function(arg_633_0, arg_633_1)
		arg_633_1.time_ = 0
		arg_633_1.frameCnt_ = 0
		arg_633_1.state_ = "playing"
		arg_633_1.curTalkId_ = 322021156
		arg_633_1.duration_ = 3.9

		local var_633_0 = {
			zh = 3.666,
			ja = 3.9
		}
		local var_633_1 = manager.audio:GetLocalizationFlag()

		if var_633_0[var_633_1] ~= nil then
			arg_633_1.duration_ = var_633_0[var_633_1]
		end

		SetActive(arg_633_1.tipsGo_, false)

		function arg_633_1.onSingleLineFinish_()
			arg_633_1.onSingleLineUpdate_ = nil
			arg_633_1.onSingleLineFinish_ = nil
			arg_633_1.state_ = "waiting"
		end

		function arg_633_1.playNext_(arg_635_0)
			if arg_635_0 == 1 then
				arg_633_0:Play322021157(arg_633_1)
			end
		end

		function arg_633_1.onSingleLineUpdate_(arg_636_0)
			if 1 < arg_633_1.time_ and arg_633_1.time_ <= 1 + arg_636_0 then
				if arg_633_1.var_.effect1154 then
					Object.Destroy(arg_633_1.var_.effect1154)

					arg_633_1.var_.effect1154 = nil
				end
			end

			local var_636_1 = 0

			if 0 < arg_633_1.time_ and arg_633_1.time_ <= var_636_1 + arg_636_0 then
				arg_633_1.mask_.enabled = true
				arg_633_1.mask_.raycastTarget = true

				arg_633_1:SetGaussion(false)
			end

			local var_636_2 = 1

			if var_636_1 <= arg_633_1.time_ and arg_633_1.time_ < var_636_1 + var_636_2 then
				local var_636_3 = Color.New(0, 0, 0)

				var_636_3.a = Mathf.Lerp(0, 1, (arg_633_1.time_ - var_636_1) / var_636_2)
				arg_633_1.mask_.color = var_636_3
			end

			if arg_633_1.time_ >= var_636_1 + var_636_2 and arg_633_1.time_ < var_636_1 + var_636_2 + arg_636_0 then
				local var_636_4 = Color.New(0, 0, 0)

				var_636_4.a = 1
				arg_633_1.mask_.color = var_636_4
			end

			local var_636_5 = 1

			if 1 < arg_633_1.time_ and arg_633_1.time_ <= var_636_5 + arg_636_0 then
				arg_633_1.mask_.enabled = true
				arg_633_1.mask_.raycastTarget = true

				arg_633_1:SetGaussion(false)
			end

			local var_636_6 = 1

			if var_636_5 <= arg_633_1.time_ and arg_633_1.time_ < var_636_5 + var_636_6 then
				local var_636_7 = Color.New(0, 0, 0)

				var_636_7.a = Mathf.Lerp(1, 0, (arg_633_1.time_ - var_636_5) / var_636_6)
				arg_633_1.mask_.color = var_636_7
			end

			if arg_633_1.time_ >= var_636_5 + var_636_6 and arg_633_1.time_ < var_636_5 + var_636_6 + arg_636_0 then
				local var_636_8 = Color.New(0, 0, 0)

				arg_633_1.mask_.enabled = false
				var_636_8.a = 0
				arg_633_1.mask_.color = var_636_8
			end

			if 1 < arg_633_1.time_ and arg_633_1.time_ <= 1 + arg_636_0 then
				local var_636_9 = arg_633_1.bgs_.L14f

				arg_633_1.bgs_.L14f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_636_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_636_10 = var_636_9:GetComponent("SpriteRenderer")

				if var_636_10 and var_636_10.sprite then
					local var_636_11 = 2 * (var_636_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_636_9.transform.localScale = Vector3.New(var_636_11 / var_636_10.sprite.bounds.size.y < var_636_11 * manager.ui.mainCameraCom_.aspect / var_636_10.sprite.bounds.size.x and var_636_11 * manager.ui.mainCameraCom_.aspect / var_636_10.sprite.bounds.size.x or var_636_11 / var_636_10.sprite.bounds.size.y, var_636_11 / var_636_10.sprite.bounds.size.y < var_636_11 * manager.ui.mainCameraCom_.aspect / var_636_10.sprite.bounds.size.x and var_636_11 * manager.ui.mainCameraCom_.aspect / var_636_10.sprite.bounds.size.x or var_636_11 / var_636_10.sprite.bounds.size.y, 0)
				end

				for iter_636_0, iter_636_1 in pairs(arg_633_1.bgs_) do
					if iter_636_0 ~= "L14f" then
						iter_636_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_633_1.frameCnt_ <= 1 then
				arg_633_1.dialog_:SetActive(false)
			end

			local var_636_12 = 2
			local var_636_13 = 0.225

			if 2 < arg_633_1.time_ and arg_633_1.time_ <= var_636_12 + arg_636_0 then
				arg_633_1.talkMaxDuration = 0

				arg_633_1.dialog_:SetActive(true)

				arg_633_1.dialogCg_.alpha = 0

				local var_636_14 = LeanTween.value(arg_633_1.dialog_, 0, 1, 0.3)

				var_636_14:setOnUpdate(LuaHelper.FloatAction(function(arg_637_0)
					arg_633_1.dialogCg_.alpha = arg_637_0
				end))
				var_636_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_633_1.dialog_)
					var_636_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_633_1.duration_ = arg_633_1.duration_ + 0.3

				SetActive(arg_633_1.leftNameGo_, true)

				arg_633_1.leftNameTxt_.text = arg_633_1:FormatText(StoryNameCfg[1167].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_633_1.leftNameTxt_.transform)

				arg_633_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_633_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_633_1:RecordName(arg_633_1.leftNameTxt_.text)
				SetActive(arg_633_1.iconTrs_.gameObject, true)
				arg_633_1.iconController_:SetSelectedState("hero")

				arg_633_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_633_1.callingController_:SetSelectedState("normal")

				arg_633_1.keyicon_.color = Color.New(1, 1, 1)
				arg_633_1.icon_.color = Color.New(1, 1, 1)

				local var_636_15 = arg_633_1:GetWordFromCfg(322021156)
				local var_636_16 = arg_633_1:FormatText(var_636_15.content)

				arg_633_1.text_.text = var_636_16

				LuaForUtil.ClearLinePrefixSymbol(arg_633_1.text_)

				local var_636_18 = 9 <= 0 and var_636_13 or var_636_13 * (utf8.len(var_636_16) / 9)

				if (9 <= 0 and var_636_13 or var_636_13 * (utf8.len(var_636_16) / 9)) > 0 and var_636_13 < var_636_18 then
					arg_633_1.talkMaxDuration = var_636_18
					var_636_12 = var_636_12 + 0.3

					if var_636_18 + var_636_12 > arg_633_1.duration_ then
						arg_633_1.duration_ = var_636_18 + var_636_12
					end
				end

				arg_633_1.text_.text = var_636_16
				arg_633_1.typewritter.percent = 0

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021156", "story_v_out_322021.awb") ~= 0 then
					local var_636_19 = manager.audio:GetVoiceLength("story_v_out_322021", "322021156", "story_v_out_322021.awb") / 1000

					if var_636_19 + var_636_12 > arg_633_1.duration_ then
						arg_633_1.duration_ = var_636_19 + var_636_12
					end

					if var_636_15.prefab_name ~= "" and arg_633_1.actors_[var_636_15.prefab_name] ~= nil then
						local var_636_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_633_1.actors_[var_636_15.prefab_name].transform, "story_v_out_322021", "322021156", "story_v_out_322021.awb")

						arg_633_1:RecordAudio("322021156", var_636_20)
						arg_633_1:RecordAudio("322021156", var_636_20)
					else
						arg_633_1:AudioAction("play", "voice", "story_v_out_322021", "322021156", "story_v_out_322021.awb")
					end

					arg_633_1:RecordHistoryTalkVoice("story_v_out_322021", "322021156", "story_v_out_322021.awb")
				end

				arg_633_1:RecordContent(arg_633_1.text_.text)
			end

			local var_636_21 = var_636_12 + 0.3
			local var_636_22 = math.max(var_636_13, arg_633_1.talkMaxDuration)

			if var_636_12 + 0.3 <= arg_633_1.time_ and arg_633_1.time_ < var_636_21 + var_636_22 then
				arg_633_1.typewritter.percent = (arg_633_1.time_ - var_636_21) / var_636_22

				arg_633_1.typewritter:SetDirty()
			end

			if arg_633_1.time_ >= var_636_21 + var_636_22 and arg_633_1.time_ < var_636_21 + var_636_22 + arg_636_0 then
				arg_633_1.typewritter.percent = 1

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(true)
			end
		end

		arg_633_1.nodeConfigList_ = {}

		arg_633_1:InitPlayNodeList()
	end,
	Play322021157 = function(arg_639_0, arg_639_1)
		arg_639_1.time_ = 0
		arg_639_1.frameCnt_ = 0
		arg_639_1.state_ = "playing"
		arg_639_1.curTalkId_ = 322021157
		arg_639_1.duration_ = 14.87

		local var_639_0 = {
			zh = 12.033,
			ja = 14.866
		}
		local var_639_1 = manager.audio:GetLocalizationFlag()

		if var_639_0[var_639_1] ~= nil then
			arg_639_1.duration_ = var_639_0[var_639_1]
		end

		SetActive(arg_639_1.tipsGo_, false)

		function arg_639_1.onSingleLineFinish_()
			arg_639_1.onSingleLineUpdate_ = nil
			arg_639_1.onSingleLineFinish_ = nil
			arg_639_1.state_ = "waiting"
		end

		function arg_639_1.playNext_(arg_641_0)
			if arg_641_0 == 1 then
				arg_639_0:Play322021158(arg_639_1)
			end
		end

		function arg_639_1.onSingleLineUpdate_(arg_642_0)
			local var_642_0 = 1.4

			if 0 < arg_639_1.time_ and arg_639_1.time_ <= 0 + arg_642_0 then
				arg_639_1.talkMaxDuration = 0
				arg_639_1.dialogCg_.alpha = 1

				arg_639_1.dialog_:SetActive(true)
				SetActive(arg_639_1.leftNameGo_, true)

				arg_639_1.leftNameTxt_.text = arg_639_1:FormatText(StoryNameCfg[1362].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_639_1.leftNameTxt_.transform)

				arg_639_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_639_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_639_1:RecordName(arg_639_1.leftNameTxt_.text)
				SetActive(arg_639_1.iconTrs_.gameObject, true)
				arg_639_1.iconController_:SetSelectedState("hero")

				arg_639_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_639_1.callingController_:SetSelectedState("normal")

				arg_639_1.keyicon_.color = Color.New(1, 1, 1)
				arg_639_1.icon_.color = Color.New(1, 1, 1)

				local var_642_1 = arg_639_1:GetWordFromCfg(322021157)
				local var_642_2 = arg_639_1:FormatText(var_642_1.content)

				arg_639_1.text_.text = var_642_2

				LuaForUtil.ClearLinePrefixSymbol(arg_639_1.text_)

				local var_642_4 = 56 <= 0 and var_642_0 or var_642_0 * (utf8.len(var_642_2) / 56)

				if (56 <= 0 and var_642_0 or var_642_0 * (utf8.len(var_642_2) / 56)) > 0 and var_642_0 < var_642_4 then
					arg_639_1.talkMaxDuration = var_642_4

					if var_642_4 + 0 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_4 + 0
					end
				end

				arg_639_1.text_.text = var_642_2
				arg_639_1.typewritter.percent = 0

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021157", "story_v_out_322021.awb") ~= 0 then
					local var_642_5 = manager.audio:GetVoiceLength("story_v_out_322021", "322021157", "story_v_out_322021.awb") / 1000

					if var_642_5 + 0 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_5 + 0
					end

					if var_642_1.prefab_name ~= "" and arg_639_1.actors_[var_642_1.prefab_name] ~= nil then
						local var_642_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_639_1.actors_[var_642_1.prefab_name].transform, "story_v_out_322021", "322021157", "story_v_out_322021.awb")

						arg_639_1:RecordAudio("322021157", var_642_6)
						arg_639_1:RecordAudio("322021157", var_642_6)
					else
						arg_639_1:AudioAction("play", "voice", "story_v_out_322021", "322021157", "story_v_out_322021.awb")
					end

					arg_639_1:RecordHistoryTalkVoice("story_v_out_322021", "322021157", "story_v_out_322021.awb")
				end

				arg_639_1:RecordContent(arg_639_1.text_.text)
			end

			local var_642_7 = math.max(var_642_0, arg_639_1.talkMaxDuration)

			if 0 <= arg_639_1.time_ and arg_639_1.time_ < 0 + var_642_7 then
				arg_639_1.typewritter.percent = (arg_639_1.time_ - 0) / var_642_7

				arg_639_1.typewritter:SetDirty()
			end

			if arg_639_1.time_ >= 0 + var_642_7 and arg_639_1.time_ < 0 + var_642_7 + arg_642_0 then
				arg_639_1.typewritter.percent = 1

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(true)
			end
		end

		arg_639_1.nodeConfigList_ = {}

		arg_639_1:InitPlayNodeList()
	end,
	Play322021158 = function(arg_643_0, arg_643_1)
		arg_643_1.time_ = 0
		arg_643_1.frameCnt_ = 0
		arg_643_1.state_ = "playing"
		arg_643_1.curTalkId_ = 322021158
		arg_643_1.duration_ = 14.27

		local var_643_0 = {
			zh = 11.133,
			ja = 14.266
		}
		local var_643_1 = manager.audio:GetLocalizationFlag()

		if var_643_0[var_643_1] ~= nil then
			arg_643_1.duration_ = var_643_0[var_643_1]
		end

		SetActive(arg_643_1.tipsGo_, false)

		function arg_643_1.onSingleLineFinish_()
			arg_643_1.onSingleLineUpdate_ = nil
			arg_643_1.onSingleLineFinish_ = nil
			arg_643_1.state_ = "waiting"
		end

		function arg_643_1.playNext_(arg_645_0)
			if arg_645_0 == 1 then
				arg_643_0:Play322021159(arg_643_1)
			end
		end

		function arg_643_1.onSingleLineUpdate_(arg_646_0)
			local var_646_0 = 1.375

			if 0 < arg_643_1.time_ and arg_643_1.time_ <= 0 + arg_646_0 then
				arg_643_1.talkMaxDuration = 0
				arg_643_1.dialogCg_.alpha = 1

				arg_643_1.dialog_:SetActive(true)
				SetActive(arg_643_1.leftNameGo_, true)

				arg_643_1.leftNameTxt_.text = arg_643_1:FormatText(StoryNameCfg[1362].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_643_1.leftNameTxt_.transform)

				arg_643_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_643_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_643_1:RecordName(arg_643_1.leftNameTxt_.text)
				SetActive(arg_643_1.iconTrs_.gameObject, true)
				arg_643_1.iconController_:SetSelectedState("hero")

				arg_643_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_643_1.callingController_:SetSelectedState("normal")

				arg_643_1.keyicon_.color = Color.New(1, 1, 1)
				arg_643_1.icon_.color = Color.New(1, 1, 1)

				local var_646_1 = arg_643_1:GetWordFromCfg(322021158)
				local var_646_2 = arg_643_1:FormatText(var_646_1.content)

				arg_643_1.text_.text = var_646_2

				LuaForUtil.ClearLinePrefixSymbol(arg_643_1.text_)

				local var_646_4 = 55 <= 0 and var_646_0 or var_646_0 * (utf8.len(var_646_2) / 55)

				if (55 <= 0 and var_646_0 or var_646_0 * (utf8.len(var_646_2) / 55)) > 0 and var_646_0 < var_646_4 then
					arg_643_1.talkMaxDuration = var_646_4

					if var_646_4 + 0 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_4 + 0
					end
				end

				arg_643_1.text_.text = var_646_2
				arg_643_1.typewritter.percent = 0

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021158", "story_v_out_322021.awb") ~= 0 then
					local var_646_5 = manager.audio:GetVoiceLength("story_v_out_322021", "322021158", "story_v_out_322021.awb") / 1000

					if var_646_5 + 0 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_5 + 0
					end

					if var_646_1.prefab_name ~= "" and arg_643_1.actors_[var_646_1.prefab_name] ~= nil then
						local var_646_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_643_1.actors_[var_646_1.prefab_name].transform, "story_v_out_322021", "322021158", "story_v_out_322021.awb")

						arg_643_1:RecordAudio("322021158", var_646_6)
						arg_643_1:RecordAudio("322021158", var_646_6)
					else
						arg_643_1:AudioAction("play", "voice", "story_v_out_322021", "322021158", "story_v_out_322021.awb")
					end

					arg_643_1:RecordHistoryTalkVoice("story_v_out_322021", "322021158", "story_v_out_322021.awb")
				end

				arg_643_1:RecordContent(arg_643_1.text_.text)
			end

			local var_646_7 = math.max(var_646_0, arg_643_1.talkMaxDuration)

			if 0 <= arg_643_1.time_ and arg_643_1.time_ < 0 + var_646_7 then
				arg_643_1.typewritter.percent = (arg_643_1.time_ - 0) / var_646_7

				arg_643_1.typewritter:SetDirty()
			end

			if arg_643_1.time_ >= 0 + var_646_7 and arg_643_1.time_ < 0 + var_646_7 + arg_646_0 then
				arg_643_1.typewritter.percent = 1

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(true)
			end
		end

		arg_643_1.nodeConfigList_ = {}

		arg_643_1:InitPlayNodeList()
	end,
	Play322021159 = function(arg_647_0, arg_647_1)
		arg_647_1.time_ = 0
		arg_647_1.frameCnt_ = 0
		arg_647_1.state_ = "playing"
		arg_647_1.curTalkId_ = 322021159
		arg_647_1.duration_ = 6.63

		local var_647_0 = {
			zh = 3.5,
			ja = 6.633
		}
		local var_647_1 = manager.audio:GetLocalizationFlag()

		if var_647_0[var_647_1] ~= nil then
			arg_647_1.duration_ = var_647_0[var_647_1]
		end

		SetActive(arg_647_1.tipsGo_, false)

		function arg_647_1.onSingleLineFinish_()
			arg_647_1.onSingleLineUpdate_ = nil
			arg_647_1.onSingleLineFinish_ = nil
			arg_647_1.state_ = "waiting"
		end

		function arg_647_1.playNext_(arg_649_0)
			if arg_649_0 == 1 then
				arg_647_0:Play322021160(arg_647_1)
			end
		end

		function arg_647_1.onSingleLineUpdate_(arg_650_0)
			local var_650_0 = 0.45

			if 0 < arg_647_1.time_ and arg_647_1.time_ <= 0 + arg_650_0 then
				arg_647_1.talkMaxDuration = 0
				arg_647_1.dialogCg_.alpha = 1

				arg_647_1.dialog_:SetActive(true)
				SetActive(arg_647_1.leftNameGo_, true)

				arg_647_1.leftNameTxt_.text = arg_647_1:FormatText(StoryNameCfg[1167].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_647_1.leftNameTxt_.transform)

				arg_647_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_647_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_647_1:RecordName(arg_647_1.leftNameTxt_.text)
				SetActive(arg_647_1.iconTrs_.gameObject, true)
				arg_647_1.iconController_:SetSelectedState("hero")

				arg_647_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_647_1.callingController_:SetSelectedState("normal")

				arg_647_1.keyicon_.color = Color.New(1, 1, 1)
				arg_647_1.icon_.color = Color.New(1, 1, 1)

				local var_650_1 = arg_647_1:GetWordFromCfg(322021159)
				local var_650_2 = arg_647_1:FormatText(var_650_1.content)

				arg_647_1.text_.text = var_650_2

				LuaForUtil.ClearLinePrefixSymbol(arg_647_1.text_)

				local var_650_4 = 18 <= 0 and var_650_0 or var_650_0 * (utf8.len(var_650_2) / 18)

				if (18 <= 0 and var_650_0 or var_650_0 * (utf8.len(var_650_2) / 18)) > 0 and var_650_0 < var_650_4 then
					arg_647_1.talkMaxDuration = var_650_4

					if var_650_4 + 0 > arg_647_1.duration_ then
						arg_647_1.duration_ = var_650_4 + 0
					end
				end

				arg_647_1.text_.text = var_650_2
				arg_647_1.typewritter.percent = 0

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021159", "story_v_out_322021.awb") ~= 0 then
					local var_650_5 = manager.audio:GetVoiceLength("story_v_out_322021", "322021159", "story_v_out_322021.awb") / 1000

					if var_650_5 + 0 > arg_647_1.duration_ then
						arg_647_1.duration_ = var_650_5 + 0
					end

					if var_650_1.prefab_name ~= "" and arg_647_1.actors_[var_650_1.prefab_name] ~= nil then
						local var_650_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_647_1.actors_[var_650_1.prefab_name].transform, "story_v_out_322021", "322021159", "story_v_out_322021.awb")

						arg_647_1:RecordAudio("322021159", var_650_6)
						arg_647_1:RecordAudio("322021159", var_650_6)
					else
						arg_647_1:AudioAction("play", "voice", "story_v_out_322021", "322021159", "story_v_out_322021.awb")
					end

					arg_647_1:RecordHistoryTalkVoice("story_v_out_322021", "322021159", "story_v_out_322021.awb")
				end

				arg_647_1:RecordContent(arg_647_1.text_.text)
			end

			local var_650_7 = math.max(var_650_0, arg_647_1.talkMaxDuration)

			if 0 <= arg_647_1.time_ and arg_647_1.time_ < 0 + var_650_7 then
				arg_647_1.typewritter.percent = (arg_647_1.time_ - 0) / var_650_7

				arg_647_1.typewritter:SetDirty()
			end

			if arg_647_1.time_ >= 0 + var_650_7 and arg_647_1.time_ < 0 + var_650_7 + arg_650_0 then
				arg_647_1.typewritter.percent = 1

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(true)
			end
		end

		arg_647_1.nodeConfigList_ = {}

		arg_647_1:InitPlayNodeList()
	end,
	Play322021160 = function(arg_651_0, arg_651_1)
		arg_651_1.time_ = 0
		arg_651_1.frameCnt_ = 0
		arg_651_1.state_ = "playing"
		arg_651_1.curTalkId_ = 322021160
		arg_651_1.duration_ = 4.9

		local var_651_0 = {
			zh = 3.2,
			ja = 4.9
		}
		local var_651_1 = manager.audio:GetLocalizationFlag()

		if var_651_0[var_651_1] ~= nil then
			arg_651_1.duration_ = var_651_0[var_651_1]
		end

		SetActive(arg_651_1.tipsGo_, false)

		function arg_651_1.onSingleLineFinish_()
			arg_651_1.onSingleLineUpdate_ = nil
			arg_651_1.onSingleLineFinish_ = nil
			arg_651_1.state_ = "waiting"
		end

		function arg_651_1.playNext_(arg_653_0)
			if arg_653_0 == 1 then
				arg_651_0:Play322021161(arg_651_1)
			end
		end

		function arg_651_1.onSingleLineUpdate_(arg_654_0)
			local var_654_0 = 0.325

			if 0 < arg_651_1.time_ and arg_651_1.time_ <= 0 + arg_654_0 then
				arg_651_1.talkMaxDuration = 0
				arg_651_1.dialogCg_.alpha = 1

				arg_651_1.dialog_:SetActive(true)
				SetActive(arg_651_1.leftNameGo_, true)

				arg_651_1.leftNameTxt_.text = arg_651_1:FormatText(StoryNameCfg[1362].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_651_1.leftNameTxt_.transform)

				arg_651_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_651_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_651_1:RecordName(arg_651_1.leftNameTxt_.text)
				SetActive(arg_651_1.iconTrs_.gameObject, true)
				arg_651_1.iconController_:SetSelectedState("hero")

				arg_651_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_651_1.callingController_:SetSelectedState("normal")

				arg_651_1.keyicon_.color = Color.New(1, 1, 1)
				arg_651_1.icon_.color = Color.New(1, 1, 1)

				local var_654_1 = arg_651_1:GetWordFromCfg(322021160)
				local var_654_2 = arg_651_1:FormatText(var_654_1.content)

				arg_651_1.text_.text = var_654_2

				LuaForUtil.ClearLinePrefixSymbol(arg_651_1.text_)

				local var_654_4 = 13 <= 0 and var_654_0 or var_654_0 * (utf8.len(var_654_2) / 13)

				if (13 <= 0 and var_654_0 or var_654_0 * (utf8.len(var_654_2) / 13)) > 0 and var_654_0 < var_654_4 then
					arg_651_1.talkMaxDuration = var_654_4

					if var_654_4 + 0 > arg_651_1.duration_ then
						arg_651_1.duration_ = var_654_4 + 0
					end
				end

				arg_651_1.text_.text = var_654_2
				arg_651_1.typewritter.percent = 0

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021160", "story_v_out_322021.awb") ~= 0 then
					local var_654_5 = manager.audio:GetVoiceLength("story_v_out_322021", "322021160", "story_v_out_322021.awb") / 1000

					if var_654_5 + 0 > arg_651_1.duration_ then
						arg_651_1.duration_ = var_654_5 + 0
					end

					if var_654_1.prefab_name ~= "" and arg_651_1.actors_[var_654_1.prefab_name] ~= nil then
						local var_654_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_651_1.actors_[var_654_1.prefab_name].transform, "story_v_out_322021", "322021160", "story_v_out_322021.awb")

						arg_651_1:RecordAudio("322021160", var_654_6)
						arg_651_1:RecordAudio("322021160", var_654_6)
					else
						arg_651_1:AudioAction("play", "voice", "story_v_out_322021", "322021160", "story_v_out_322021.awb")
					end

					arg_651_1:RecordHistoryTalkVoice("story_v_out_322021", "322021160", "story_v_out_322021.awb")
				end

				arg_651_1:RecordContent(arg_651_1.text_.text)
			end

			local var_654_7 = math.max(var_654_0, arg_651_1.talkMaxDuration)

			if 0 <= arg_651_1.time_ and arg_651_1.time_ < 0 + var_654_7 then
				arg_651_1.typewritter.percent = (arg_651_1.time_ - 0) / var_654_7

				arg_651_1.typewritter:SetDirty()
			end

			if arg_651_1.time_ >= 0 + var_654_7 and arg_651_1.time_ < 0 + var_654_7 + arg_654_0 then
				arg_651_1.typewritter.percent = 1

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(true)
			end
		end

		arg_651_1.nodeConfigList_ = {}

		arg_651_1:InitPlayNodeList()
	end,
	Play322021161 = function(arg_655_0, arg_655_1)
		arg_655_1.time_ = 0
		arg_655_1.frameCnt_ = 0
		arg_655_1.state_ = "playing"
		arg_655_1.curTalkId_ = 322021161
		arg_655_1.duration_ = 2.6

		local var_655_0 = {
			zh = 2.4,
			ja = 2.6
		}
		local var_655_1 = manager.audio:GetLocalizationFlag()

		if var_655_0[var_655_1] ~= nil then
			arg_655_1.duration_ = var_655_0[var_655_1]
		end

		SetActive(arg_655_1.tipsGo_, false)

		function arg_655_1.onSingleLineFinish_()
			arg_655_1.onSingleLineUpdate_ = nil
			arg_655_1.onSingleLineFinish_ = nil
			arg_655_1.state_ = "waiting"
		end

		function arg_655_1.playNext_(arg_657_0)
			if arg_657_0 == 1 then
				arg_655_0:Play322021162(arg_655_1)
			end
		end

		function arg_655_1.onSingleLineUpdate_(arg_658_0)
			if 0 < arg_655_1.time_ and arg_655_1.time_ <= 0 + arg_658_0 and not isNil(arg_655_1.actors_["404001ui_story"]) and arg_655_1.var_.characterEffect404001ui_story == nil then
				arg_655_1.var_.characterEffect404001ui_story = arg_655_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_658_0 = 0.200000002980232

			if 0 <= arg_655_1.time_ and arg_655_1.time_ < 0 + var_658_0 and not isNil(arg_655_1.actors_["404001ui_story"]) then
				if arg_655_1.var_.characterEffect404001ui_story and not isNil(arg_655_1.actors_["404001ui_story"]) then
					arg_655_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_655_1.time_ >= 0 + var_658_0 and arg_655_1.time_ < 0 + var_658_0 + arg_658_0 and not isNil(arg_655_1.actors_["404001ui_story"]) and arg_655_1.var_.characterEffect404001ui_story then
				arg_655_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_658_2 = 0
			local var_658_3 = 0.25

			if 0 < arg_655_1.time_ and arg_655_1.time_ <= var_658_2 + arg_658_0 then
				arg_655_1.talkMaxDuration = 0
				arg_655_1.dialogCg_.alpha = 1

				arg_655_1.dialog_:SetActive(true)
				SetActive(arg_655_1.leftNameGo_, true)

				arg_655_1.leftNameTxt_.text = arg_655_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_655_1.leftNameTxt_.transform)

				arg_655_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_655_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_655_1:RecordName(arg_655_1.leftNameTxt_.text)
				SetActive(arg_655_1.iconTrs_.gameObject, true)
				arg_655_1.iconController_:SetSelectedState("hero")

				arg_655_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_655_1.callingController_:SetSelectedState("normal")

				arg_655_1.keyicon_.color = Color.New(1, 1, 1)
				arg_655_1.icon_.color = Color.New(1, 1, 1)

				local var_658_4 = arg_655_1:GetWordFromCfg(322021161)
				local var_658_5 = arg_655_1:FormatText(var_658_4.content)

				arg_655_1.text_.text = var_658_5

				LuaForUtil.ClearLinePrefixSymbol(arg_655_1.text_)

				local var_658_7 = 10 <= 0 and var_658_3 or var_658_3 * (utf8.len(var_658_5) / 10)

				if (10 <= 0 and var_658_3 or var_658_3 * (utf8.len(var_658_5) / 10)) > 0 and var_658_3 < var_658_7 then
					arg_655_1.talkMaxDuration = var_658_7

					if var_658_7 + var_658_2 > arg_655_1.duration_ then
						arg_655_1.duration_ = var_658_7 + var_658_2
					end
				end

				arg_655_1.text_.text = var_658_5
				arg_655_1.typewritter.percent = 0

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021161", "story_v_out_322021.awb") ~= 0 then
					local var_658_8 = manager.audio:GetVoiceLength("story_v_out_322021", "322021161", "story_v_out_322021.awb") / 1000

					if var_658_8 + var_658_2 > arg_655_1.duration_ then
						arg_655_1.duration_ = var_658_8 + var_658_2
					end

					if var_658_4.prefab_name ~= "" and arg_655_1.actors_[var_658_4.prefab_name] ~= nil then
						local var_658_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_655_1.actors_[var_658_4.prefab_name].transform, "story_v_out_322021", "322021161", "story_v_out_322021.awb")

						arg_655_1:RecordAudio("322021161", var_658_9)
						arg_655_1:RecordAudio("322021161", var_658_9)
					else
						arg_655_1:AudioAction("play", "voice", "story_v_out_322021", "322021161", "story_v_out_322021.awb")
					end

					arg_655_1:RecordHistoryTalkVoice("story_v_out_322021", "322021161", "story_v_out_322021.awb")
				end

				arg_655_1:RecordContent(arg_655_1.text_.text)
			end

			local var_658_10 = math.max(var_658_3, arg_655_1.talkMaxDuration)

			if var_658_2 <= arg_655_1.time_ and arg_655_1.time_ < var_658_2 + var_658_10 then
				arg_655_1.typewritter.percent = (arg_655_1.time_ - var_658_2) / var_658_10

				arg_655_1.typewritter:SetDirty()
			end

			if arg_655_1.time_ >= var_658_2 + var_658_10 and arg_655_1.time_ < var_658_2 + var_658_10 + arg_658_0 then
				arg_655_1.typewritter.percent = 1

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(true)
			end
		end

		arg_655_1.nodeConfigList_ = {}

		arg_655_1:InitPlayNodeList()
	end,
	Play322021162 = function(arg_659_0, arg_659_1)
		arg_659_1.time_ = 0
		arg_659_1.frameCnt_ = 0
		arg_659_1.state_ = "playing"
		arg_659_1.curTalkId_ = 322021162
		arg_659_1.duration_ = 5

		SetActive(arg_659_1.tipsGo_, false)

		function arg_659_1.onSingleLineFinish_()
			arg_659_1.onSingleLineUpdate_ = nil
			arg_659_1.onSingleLineFinish_ = nil
			arg_659_1.state_ = "waiting"
		end

		function arg_659_1.playNext_(arg_661_0)
			if arg_661_0 == 1 then
				arg_659_0:Play322021163(arg_659_1)
			end
		end

		function arg_659_1.onSingleLineUpdate_(arg_662_0)
			local var_662_0 = 1.25

			if 0 < arg_659_1.time_ and arg_659_1.time_ <= 0 + arg_662_0 then
				arg_659_1.talkMaxDuration = 0
				arg_659_1.dialogCg_.alpha = 1

				arg_659_1.dialog_:SetActive(true)
				SetActive(arg_659_1.leftNameGo_, false)

				arg_659_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_659_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_659_1:RecordName(arg_659_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_659_1.iconTrs_.gameObject, false)
				arg_659_1.callingController_:SetSelectedState("normal")

				local var_662_1 = arg_659_1:FormatText(arg_659_1:GetWordFromCfg(322021162).content)

				arg_659_1.text_.text = var_662_1

				LuaForUtil.ClearLinePrefixSymbol(arg_659_1.text_)

				local var_662_3 = 50 <= 0 and var_662_0 or var_662_0 * (utf8.len(var_662_1) / 50)

				if (50 <= 0 and var_662_0 or var_662_0 * (utf8.len(var_662_1) / 50)) > 0 and var_662_0 < var_662_3 then
					arg_659_1.talkMaxDuration = var_662_3

					if var_662_3 + 0 > arg_659_1.duration_ then
						arg_659_1.duration_ = var_662_3 + 0
					end
				end

				arg_659_1.text_.text = var_662_1
				arg_659_1.typewritter.percent = 0

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(false)
				arg_659_1:RecordContent(arg_659_1.text_.text)
			end

			local var_662_4 = math.max(var_662_0, arg_659_1.talkMaxDuration)

			if 0 <= arg_659_1.time_ and arg_659_1.time_ < 0 + var_662_4 then
				arg_659_1.typewritter.percent = (arg_659_1.time_ - 0) / var_662_4

				arg_659_1.typewritter:SetDirty()
			end

			if arg_659_1.time_ >= 0 + var_662_4 and arg_659_1.time_ < 0 + var_662_4 + arg_662_0 then
				arg_659_1.typewritter.percent = 1

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(true)
			end
		end

		arg_659_1.nodeConfigList_ = {}

		arg_659_1:InitPlayNodeList()
	end,
	Play322021163 = function(arg_663_0, arg_663_1)
		arg_663_1.time_ = 0
		arg_663_1.frameCnt_ = 0
		arg_663_1.state_ = "playing"
		arg_663_1.curTalkId_ = 322021163
		arg_663_1.duration_ = 2.77

		local var_663_0 = {
			zh = 1.6,
			ja = 2.766
		}
		local var_663_1 = manager.audio:GetLocalizationFlag()

		if var_663_0[var_663_1] ~= nil then
			arg_663_1.duration_ = var_663_0[var_663_1]
		end

		SetActive(arg_663_1.tipsGo_, false)

		function arg_663_1.onSingleLineFinish_()
			arg_663_1.onSingleLineUpdate_ = nil
			arg_663_1.onSingleLineFinish_ = nil
			arg_663_1.state_ = "waiting"
		end

		function arg_663_1.playNext_(arg_665_0)
			if arg_665_0 == 1 then
				arg_663_0:Play322021164(arg_663_1)
			end
		end

		function arg_663_1.onSingleLineUpdate_(arg_666_0)
			local var_666_0 = 0.2

			if 0 < arg_663_1.time_ and arg_663_1.time_ <= 0 + arg_666_0 then
				arg_663_1.talkMaxDuration = 0
				arg_663_1.dialogCg_.alpha = 1

				arg_663_1.dialog_:SetActive(true)
				SetActive(arg_663_1.leftNameGo_, true)

				arg_663_1.leftNameTxt_.text = arg_663_1:FormatText(StoryNameCfg[1167].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_663_1.leftNameTxt_.transform)

				arg_663_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_663_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_663_1:RecordName(arg_663_1.leftNameTxt_.text)
				SetActive(arg_663_1.iconTrs_.gameObject, true)
				arg_663_1.iconController_:SetSelectedState("hero")

				arg_663_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_663_1.callingController_:SetSelectedState("normal")

				arg_663_1.keyicon_.color = Color.New(1, 1, 1)
				arg_663_1.icon_.color = Color.New(1, 1, 1)

				local var_666_1 = arg_663_1:GetWordFromCfg(322021163)
				local var_666_2 = arg_663_1:FormatText(var_666_1.content)

				arg_663_1.text_.text = var_666_2

				LuaForUtil.ClearLinePrefixSymbol(arg_663_1.text_)

				local var_666_4 = 8 <= 0 and var_666_0 or var_666_0 * (utf8.len(var_666_2) / 8)

				if (8 <= 0 and var_666_0 or var_666_0 * (utf8.len(var_666_2) / 8)) > 0 and var_666_0 < var_666_4 then
					arg_663_1.talkMaxDuration = var_666_4

					if var_666_4 + 0 > arg_663_1.duration_ then
						arg_663_1.duration_ = var_666_4 + 0
					end
				end

				arg_663_1.text_.text = var_666_2
				arg_663_1.typewritter.percent = 0

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021163", "story_v_out_322021.awb") ~= 0 then
					local var_666_5 = manager.audio:GetVoiceLength("story_v_out_322021", "322021163", "story_v_out_322021.awb") / 1000

					if var_666_5 + 0 > arg_663_1.duration_ then
						arg_663_1.duration_ = var_666_5 + 0
					end

					if var_666_1.prefab_name ~= "" and arg_663_1.actors_[var_666_1.prefab_name] ~= nil then
						local var_666_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_663_1.actors_[var_666_1.prefab_name].transform, "story_v_out_322021", "322021163", "story_v_out_322021.awb")

						arg_663_1:RecordAudio("322021163", var_666_6)
						arg_663_1:RecordAudio("322021163", var_666_6)
					else
						arg_663_1:AudioAction("play", "voice", "story_v_out_322021", "322021163", "story_v_out_322021.awb")
					end

					arg_663_1:RecordHistoryTalkVoice("story_v_out_322021", "322021163", "story_v_out_322021.awb")
				end

				arg_663_1:RecordContent(arg_663_1.text_.text)
			end

			local var_666_7 = math.max(var_666_0, arg_663_1.talkMaxDuration)

			if 0 <= arg_663_1.time_ and arg_663_1.time_ < 0 + var_666_7 then
				arg_663_1.typewritter.percent = (arg_663_1.time_ - 0) / var_666_7

				arg_663_1.typewritter:SetDirty()
			end

			if arg_663_1.time_ >= 0 + var_666_7 and arg_663_1.time_ < 0 + var_666_7 + arg_666_0 then
				arg_663_1.typewritter.percent = 1

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(true)
			end
		end

		arg_663_1.nodeConfigList_ = {}

		arg_663_1:InitPlayNodeList()
	end,
	Play322021164 = function(arg_667_0, arg_667_1)
		arg_667_1.time_ = 0
		arg_667_1.frameCnt_ = 0
		arg_667_1.state_ = "playing"
		arg_667_1.curTalkId_ = 322021164
		arg_667_1.duration_ = 4.7

		local var_667_0 = {
			zh = 4.4,
			ja = 4.7
		}
		local var_667_1 = manager.audio:GetLocalizationFlag()

		if var_667_0[var_667_1] ~= nil then
			arg_667_1.duration_ = var_667_0[var_667_1]
		end

		SetActive(arg_667_1.tipsGo_, false)

		function arg_667_1.onSingleLineFinish_()
			arg_667_1.onSingleLineUpdate_ = nil
			arg_667_1.onSingleLineFinish_ = nil
			arg_667_1.state_ = "waiting"
		end

		function arg_667_1.playNext_(arg_669_0)
			if arg_669_0 == 1 then
				arg_667_0:Play322021165(arg_667_1)
			end
		end

		function arg_667_1.onSingleLineUpdate_(arg_670_0)
			if 0 < arg_667_1.time_ and arg_667_1.time_ <= 0 + arg_670_0 then
				arg_667_1.var_.moveOldPos404001ui_story = arg_667_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_670_0 = 0.001

			if 0 <= arg_667_1.time_ and arg_667_1.time_ < 0 + var_670_0 then
				arg_667_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_667_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_667_1.time_ - 0) / var_670_0)
				arg_667_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_667_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_667_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_667_1.actors_["404001ui_story"].transform.position).z)
				arg_667_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_667_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_667_1.actors_["404001ui_story"].transform.localEulerAngles = arg_667_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_667_1.time_ >= 0 + var_670_0 and arg_667_1.time_ < 0 + var_670_0 + arg_670_0 then
				arg_667_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_667_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_667_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_667_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_667_1.actors_["404001ui_story"].transform.position).z)
				arg_667_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_667_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_667_1.actors_["404001ui_story"].transform.localEulerAngles = arg_667_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_670_1 = arg_667_1.actors_["404001ui_story"]

			if 0 < arg_667_1.time_ and arg_667_1.time_ <= 0 + arg_670_0 and not isNil(var_670_1) and arg_667_1.var_.characterEffect404001ui_story == nil then
				arg_667_1.var_.characterEffect404001ui_story = var_670_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_670_2 = 0.200000002980232

			if 0 <= arg_667_1.time_ and arg_667_1.time_ < 0 + var_670_2 and not isNil(var_670_1) then
				if arg_667_1.var_.characterEffect404001ui_story and not isNil(var_670_1) then
					arg_667_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_667_1.time_ >= 0 + var_670_2 and arg_667_1.time_ < 0 + var_670_2 + arg_670_0 and not isNil(var_670_1) and arg_667_1.var_.characterEffect404001ui_story then
				arg_667_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_667_1.time_ and arg_667_1.time_ <= 0 + arg_670_0 then
				arg_667_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_667_1.time_ and arg_667_1.time_ <= 0 + arg_670_0 then
				arg_667_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_670_4 = 0
			local var_670_5 = 0.5

			if 0 < arg_667_1.time_ and arg_667_1.time_ <= var_670_4 + arg_670_0 then
				arg_667_1.talkMaxDuration = 0
				arg_667_1.dialogCg_.alpha = 1

				arg_667_1.dialog_:SetActive(true)
				SetActive(arg_667_1.leftNameGo_, true)

				arg_667_1.leftNameTxt_.text = arg_667_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_667_1.leftNameTxt_.transform)

				arg_667_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_667_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_667_1:RecordName(arg_667_1.leftNameTxt_.text)
				SetActive(arg_667_1.iconTrs_.gameObject, false)
				arg_667_1.callingController_:SetSelectedState("normal")

				local var_670_6 = arg_667_1:GetWordFromCfg(322021164)
				local var_670_7 = arg_667_1:FormatText(var_670_6.content)

				arg_667_1.text_.text = var_670_7

				LuaForUtil.ClearLinePrefixSymbol(arg_667_1.text_)

				local var_670_9 = 20 <= 0 and var_670_5 or var_670_5 * (utf8.len(var_670_7) / 20)

				if (20 <= 0 and var_670_5 or var_670_5 * (utf8.len(var_670_7) / 20)) > 0 and var_670_5 < var_670_9 then
					arg_667_1.talkMaxDuration = var_670_9

					if var_670_9 + var_670_4 > arg_667_1.duration_ then
						arg_667_1.duration_ = var_670_9 + var_670_4
					end
				end

				arg_667_1.text_.text = var_670_7
				arg_667_1.typewritter.percent = 0

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021164", "story_v_out_322021.awb") ~= 0 then
					local var_670_10 = manager.audio:GetVoiceLength("story_v_out_322021", "322021164", "story_v_out_322021.awb") / 1000

					if var_670_10 + var_670_4 > arg_667_1.duration_ then
						arg_667_1.duration_ = var_670_10 + var_670_4
					end

					if var_670_6.prefab_name ~= "" and arg_667_1.actors_[var_670_6.prefab_name] ~= nil then
						local var_670_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_667_1.actors_[var_670_6.prefab_name].transform, "story_v_out_322021", "322021164", "story_v_out_322021.awb")

						arg_667_1:RecordAudio("322021164", var_670_11)
						arg_667_1:RecordAudio("322021164", var_670_11)
					else
						arg_667_1:AudioAction("play", "voice", "story_v_out_322021", "322021164", "story_v_out_322021.awb")
					end

					arg_667_1:RecordHistoryTalkVoice("story_v_out_322021", "322021164", "story_v_out_322021.awb")
				end

				arg_667_1:RecordContent(arg_667_1.text_.text)
			end

			local var_670_12 = math.max(var_670_5, arg_667_1.talkMaxDuration)

			if var_670_4 <= arg_667_1.time_ and arg_667_1.time_ < var_670_4 + var_670_12 then
				arg_667_1.typewritter.percent = (arg_667_1.time_ - var_670_4) / var_670_12

				arg_667_1.typewritter:SetDirty()
			end

			if arg_667_1.time_ >= var_670_4 + var_670_12 and arg_667_1.time_ < var_670_4 + var_670_12 + arg_670_0 then
				arg_667_1.typewritter.percent = 1

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(true)
			end
		end

		arg_667_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_667_1:InitPlayNodeList()
	end,
	Play322021165 = function(arg_671_0, arg_671_1)
		arg_671_1.time_ = 0
		arg_671_1.frameCnt_ = 0
		arg_671_1.state_ = "playing"
		arg_671_1.curTalkId_ = 322021165
		arg_671_1.duration_ = 5

		SetActive(arg_671_1.tipsGo_, false)

		function arg_671_1.onSingleLineFinish_()
			arg_671_1.onSingleLineUpdate_ = nil
			arg_671_1.onSingleLineFinish_ = nil
			arg_671_1.state_ = "waiting"
		end

		function arg_671_1.playNext_(arg_673_0)
			if arg_673_0 == 1 then
				arg_671_0:Play322021166(arg_671_1)
			end
		end

		function arg_671_1.onSingleLineUpdate_(arg_674_0)
			if 0 < arg_671_1.time_ and arg_671_1.time_ <= 0 + arg_674_0 then
				arg_671_1.var_.moveOldPos404001ui_story = arg_671_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_674_0 = 0.001

			if 0 <= arg_671_1.time_ and arg_671_1.time_ < 0 + var_674_0 then
				arg_671_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_671_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_671_1.time_ - 0) / var_674_0)
				arg_671_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_671_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_671_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_671_1.actors_["404001ui_story"].transform.position).z)
				arg_671_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_671_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_671_1.actors_["404001ui_story"].transform.localEulerAngles = arg_671_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_671_1.time_ >= 0 + var_674_0 and arg_671_1.time_ < 0 + var_674_0 + arg_674_0 then
				arg_671_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_671_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_671_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_671_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_671_1.actors_["404001ui_story"].transform.position).z)
				arg_671_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_671_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_671_1.actors_["404001ui_story"].transform.localEulerAngles = arg_671_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_674_1 = 0
			local var_674_2 = 0.775

			if 0 < arg_671_1.time_ and arg_671_1.time_ <= var_674_1 + arg_674_0 then
				arg_671_1.talkMaxDuration = 0
				arg_671_1.dialogCg_.alpha = 1

				arg_671_1.dialog_:SetActive(true)
				SetActive(arg_671_1.leftNameGo_, false)

				arg_671_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_671_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_671_1:RecordName(arg_671_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_671_1.iconTrs_.gameObject, false)
				arg_671_1.callingController_:SetSelectedState("normal")

				local var_674_3 = arg_671_1:FormatText(arg_671_1:GetWordFromCfg(322021165).content)

				arg_671_1.text_.text = var_674_3

				LuaForUtil.ClearLinePrefixSymbol(arg_671_1.text_)

				local var_674_5 = 31 <= 0 and var_674_2 or var_674_2 * (utf8.len(var_674_3) / 31)

				if (31 <= 0 and var_674_2 or var_674_2 * (utf8.len(var_674_3) / 31)) > 0 and var_674_2 < var_674_5 then
					arg_671_1.talkMaxDuration = var_674_5

					if var_674_5 + var_674_1 > arg_671_1.duration_ then
						arg_671_1.duration_ = var_674_5 + var_674_1
					end
				end

				arg_671_1.text_.text = var_674_3
				arg_671_1.typewritter.percent = 0

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(false)
				arg_671_1:RecordContent(arg_671_1.text_.text)
			end

			local var_674_6 = math.max(var_674_2, arg_671_1.talkMaxDuration)

			if var_674_1 <= arg_671_1.time_ and arg_671_1.time_ < var_674_1 + var_674_6 then
				arg_671_1.typewritter.percent = (arg_671_1.time_ - var_674_1) / var_674_6

				arg_671_1.typewritter:SetDirty()
			end

			if arg_671_1.time_ >= var_674_1 + var_674_6 and arg_671_1.time_ < var_674_1 + var_674_6 + arg_674_0 then
				arg_671_1.typewritter.percent = 1

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(true)
			end
		end

		arg_671_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_671_1:InitPlayNodeList()
	end,
	Play322021166 = function(arg_675_0, arg_675_1)
		arg_675_1.time_ = 0
		arg_675_1.frameCnt_ = 0
		arg_675_1.state_ = "playing"
		arg_675_1.curTalkId_ = 322021166
		arg_675_1.duration_ = 6.73

		local var_675_0 = {
			zh = 4.966,
			ja = 6.733
		}
		local var_675_1 = manager.audio:GetLocalizationFlag()

		if var_675_0[var_675_1] ~= nil then
			arg_675_1.duration_ = var_675_0[var_675_1]
		end

		SetActive(arg_675_1.tipsGo_, false)

		function arg_675_1.onSingleLineFinish_()
			arg_675_1.onSingleLineUpdate_ = nil
			arg_675_1.onSingleLineFinish_ = nil
			arg_675_1.state_ = "waiting"
		end

		function arg_675_1.playNext_(arg_677_0)
			if arg_677_0 == 1 then
				arg_675_0:Play322021167(arg_675_1)
			end
		end

		function arg_675_1.onSingleLineUpdate_(arg_678_0)
			local var_678_0 = 0.625

			if 0 < arg_675_1.time_ and arg_675_1.time_ <= 0 + arg_678_0 then
				arg_675_1.talkMaxDuration = 0
				arg_675_1.dialogCg_.alpha = 1

				arg_675_1.dialog_:SetActive(true)
				SetActive(arg_675_1.leftNameGo_, true)

				arg_675_1.leftNameTxt_.text = arg_675_1:FormatText(StoryNameCfg[1167].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_675_1.leftNameTxt_.transform)

				arg_675_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_675_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_675_1:RecordName(arg_675_1.leftNameTxt_.text)
				SetActive(arg_675_1.iconTrs_.gameObject, true)
				arg_675_1.iconController_:SetSelectedState("hero")

				arg_675_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_675_1.callingController_:SetSelectedState("normal")

				arg_675_1.keyicon_.color = Color.New(1, 1, 1)
				arg_675_1.icon_.color = Color.New(1, 1, 1)

				local var_678_1 = arg_675_1:GetWordFromCfg(322021166)
				local var_678_2 = arg_675_1:FormatText(var_678_1.content)

				arg_675_1.text_.text = var_678_2

				LuaForUtil.ClearLinePrefixSymbol(arg_675_1.text_)

				local var_678_4 = 25 <= 0 and var_678_0 or var_678_0 * (utf8.len(var_678_2) / 25)

				if (25 <= 0 and var_678_0 or var_678_0 * (utf8.len(var_678_2) / 25)) > 0 and var_678_0 < var_678_4 then
					arg_675_1.talkMaxDuration = var_678_4

					if var_678_4 + 0 > arg_675_1.duration_ then
						arg_675_1.duration_ = var_678_4 + 0
					end
				end

				arg_675_1.text_.text = var_678_2
				arg_675_1.typewritter.percent = 0

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021166", "story_v_out_322021.awb") ~= 0 then
					local var_678_5 = manager.audio:GetVoiceLength("story_v_out_322021", "322021166", "story_v_out_322021.awb") / 1000

					if var_678_5 + 0 > arg_675_1.duration_ then
						arg_675_1.duration_ = var_678_5 + 0
					end

					if var_678_1.prefab_name ~= "" and arg_675_1.actors_[var_678_1.prefab_name] ~= nil then
						local var_678_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_675_1.actors_[var_678_1.prefab_name].transform, "story_v_out_322021", "322021166", "story_v_out_322021.awb")

						arg_675_1:RecordAudio("322021166", var_678_6)
						arg_675_1:RecordAudio("322021166", var_678_6)
					else
						arg_675_1:AudioAction("play", "voice", "story_v_out_322021", "322021166", "story_v_out_322021.awb")
					end

					arg_675_1:RecordHistoryTalkVoice("story_v_out_322021", "322021166", "story_v_out_322021.awb")
				end

				arg_675_1:RecordContent(arg_675_1.text_.text)
			end

			local var_678_7 = math.max(var_678_0, arg_675_1.talkMaxDuration)

			if 0 <= arg_675_1.time_ and arg_675_1.time_ < 0 + var_678_7 then
				arg_675_1.typewritter.percent = (arg_675_1.time_ - 0) / var_678_7

				arg_675_1.typewritter:SetDirty()
			end

			if arg_675_1.time_ >= 0 + var_678_7 and arg_675_1.time_ < 0 + var_678_7 + arg_678_0 then
				arg_675_1.typewritter.percent = 1

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(true)
			end
		end

		arg_675_1.nodeConfigList_ = {}

		arg_675_1:InitPlayNodeList()
	end,
	Play322021167 = function(arg_679_0, arg_679_1)
		arg_679_1.time_ = 0
		arg_679_1.frameCnt_ = 0
		arg_679_1.state_ = "playing"
		arg_679_1.curTalkId_ = 322021167
		arg_679_1.duration_ = 3.5

		local var_679_0 = {
			zh = 3.5,
			ja = 2.733
		}
		local var_679_1 = manager.audio:GetLocalizationFlag()

		if var_679_0[var_679_1] ~= nil then
			arg_679_1.duration_ = var_679_0[var_679_1]
		end

		SetActive(arg_679_1.tipsGo_, false)

		function arg_679_1.onSingleLineFinish_()
			arg_679_1.onSingleLineUpdate_ = nil
			arg_679_1.onSingleLineFinish_ = nil
			arg_679_1.state_ = "waiting"
		end

		function arg_679_1.playNext_(arg_681_0)
			if arg_681_0 == 1 then
				arg_679_0:Play322021168(arg_679_1)
			end
		end

		function arg_679_1.onSingleLineUpdate_(arg_682_0)
			if 0 < arg_679_1.time_ and arg_679_1.time_ <= 0 + arg_682_0 then
				arg_679_1.var_.moveOldPos404001ui_story = arg_679_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_682_0 = 0.001

			if 0 <= arg_679_1.time_ and arg_679_1.time_ < 0 + var_682_0 then
				arg_679_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_679_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_679_1.time_ - 0) / var_682_0)
				arg_679_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_679_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_679_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_679_1.actors_["404001ui_story"].transform.position).z)
				arg_679_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_679_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_679_1.actors_["404001ui_story"].transform.localEulerAngles = arg_679_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_679_1.time_ >= 0 + var_682_0 and arg_679_1.time_ < 0 + var_682_0 + arg_682_0 then
				arg_679_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_679_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_679_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_679_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_679_1.actors_["404001ui_story"].transform.position).z)
				arg_679_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_679_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_679_1.actors_["404001ui_story"].transform.localEulerAngles = arg_679_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_682_1 = arg_679_1.actors_["404001ui_story"]

			if 0 < arg_679_1.time_ and arg_679_1.time_ <= 0 + arg_682_0 and not isNil(var_682_1) and arg_679_1.var_.characterEffect404001ui_story == nil then
				arg_679_1.var_.characterEffect404001ui_story = var_682_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_682_2 = 0.200000002980232

			if 0 <= arg_679_1.time_ and arg_679_1.time_ < 0 + var_682_2 and not isNil(var_682_1) then
				if arg_679_1.var_.characterEffect404001ui_story and not isNil(var_682_1) then
					arg_679_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_679_1.time_ >= 0 + var_682_2 and arg_679_1.time_ < 0 + var_682_2 + arg_682_0 and not isNil(var_682_1) and arg_679_1.var_.characterEffect404001ui_story then
				arg_679_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_679_1.time_ and arg_679_1.time_ <= 0 + arg_682_0 then
				arg_679_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action6_1")
			end

			if 0 < arg_679_1.time_ and arg_679_1.time_ <= 0 + arg_682_0 then
				arg_679_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva", "EmotionTimelineAnimator")
			end

			local var_682_4 = 0
			local var_682_5 = 0.25

			if 0 < arg_679_1.time_ and arg_679_1.time_ <= var_682_4 + arg_682_0 then
				arg_679_1.talkMaxDuration = 0
				arg_679_1.dialogCg_.alpha = 1

				arg_679_1.dialog_:SetActive(true)
				SetActive(arg_679_1.leftNameGo_, true)

				arg_679_1.leftNameTxt_.text = arg_679_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_679_1.leftNameTxt_.transform)

				arg_679_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_679_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_679_1:RecordName(arg_679_1.leftNameTxt_.text)
				SetActive(arg_679_1.iconTrs_.gameObject, false)
				arg_679_1.callingController_:SetSelectedState("normal")

				local var_682_6 = arg_679_1:GetWordFromCfg(322021167)
				local var_682_7 = arg_679_1:FormatText(var_682_6.content)

				arg_679_1.text_.text = var_682_7

				LuaForUtil.ClearLinePrefixSymbol(arg_679_1.text_)

				local var_682_9 = 10 <= 0 and var_682_5 or var_682_5 * (utf8.len(var_682_7) / 10)

				if (10 <= 0 and var_682_5 or var_682_5 * (utf8.len(var_682_7) / 10)) > 0 and var_682_5 < var_682_9 then
					arg_679_1.talkMaxDuration = var_682_9

					if var_682_9 + var_682_4 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_9 + var_682_4
					end
				end

				arg_679_1.text_.text = var_682_7
				arg_679_1.typewritter.percent = 0

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021167", "story_v_out_322021.awb") ~= 0 then
					local var_682_10 = manager.audio:GetVoiceLength("story_v_out_322021", "322021167", "story_v_out_322021.awb") / 1000

					if var_682_10 + var_682_4 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_10 + var_682_4
					end

					if var_682_6.prefab_name ~= "" and arg_679_1.actors_[var_682_6.prefab_name] ~= nil then
						local var_682_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_679_1.actors_[var_682_6.prefab_name].transform, "story_v_out_322021", "322021167", "story_v_out_322021.awb")

						arg_679_1:RecordAudio("322021167", var_682_11)
						arg_679_1:RecordAudio("322021167", var_682_11)
					else
						arg_679_1:AudioAction("play", "voice", "story_v_out_322021", "322021167", "story_v_out_322021.awb")
					end

					arg_679_1:RecordHistoryTalkVoice("story_v_out_322021", "322021167", "story_v_out_322021.awb")
				end

				arg_679_1:RecordContent(arg_679_1.text_.text)
			end

			local var_682_12 = math.max(var_682_5, arg_679_1.talkMaxDuration)

			if var_682_4 <= arg_679_1.time_ and arg_679_1.time_ < var_682_4 + var_682_12 then
				arg_679_1.typewritter.percent = (arg_679_1.time_ - var_682_4) / var_682_12

				arg_679_1.typewritter:SetDirty()
			end

			if arg_679_1.time_ >= var_682_4 + var_682_12 and arg_679_1.time_ < var_682_4 + var_682_12 + arg_682_0 then
				arg_679_1.typewritter.percent = 1

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(true)
			end
		end

		arg_679_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_679_1:InitPlayNodeList()
	end,
	Play322021168 = function(arg_683_0, arg_683_1)
		arg_683_1.time_ = 0
		arg_683_1.frameCnt_ = 0
		arg_683_1.state_ = "playing"
		arg_683_1.curTalkId_ = 322021168
		arg_683_1.duration_ = 5

		SetActive(arg_683_1.tipsGo_, false)

		function arg_683_1.onSingleLineFinish_()
			arg_683_1.onSingleLineUpdate_ = nil
			arg_683_1.onSingleLineFinish_ = nil
			arg_683_1.state_ = "waiting"
		end

		function arg_683_1.playNext_(arg_685_0)
			if arg_685_0 == 1 then
				arg_683_0:Play322021169(arg_683_1)
			end
		end

		function arg_683_1.onSingleLineUpdate_(arg_686_0)
			if 0 < arg_683_1.time_ and arg_683_1.time_ <= 0 + arg_686_0 then
				arg_683_1.var_.moveOldPos404001ui_story = arg_683_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_686_0 = 0.001

			if 0 <= arg_683_1.time_ and arg_683_1.time_ < 0 + var_686_0 then
				arg_683_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_683_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_683_1.time_ - 0) / var_686_0)
				arg_683_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_683_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_683_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_683_1.actors_["404001ui_story"].transform.position).z)
				arg_683_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_683_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_683_1.actors_["404001ui_story"].transform.localEulerAngles = arg_683_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_683_1.time_ >= 0 + var_686_0 and arg_683_1.time_ < 0 + var_686_0 + arg_686_0 then
				arg_683_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_683_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_683_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_683_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_683_1.actors_["404001ui_story"].transform.position).z)
				arg_683_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_683_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_683_1.actors_["404001ui_story"].transform.localEulerAngles = arg_683_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if 0.1 < arg_683_1.time_ and arg_683_1.time_ <= 0.1 + arg_686_0 then
				arg_683_1:AudioAction("play", "effect", "se_story_140", "se_story_140_tentacle1", "")
			end

			local var_686_2 = 0
			local var_686_3 = 1.35

			if 0 < arg_683_1.time_ and arg_683_1.time_ <= var_686_2 + arg_686_0 then
				arg_683_1.talkMaxDuration = 0
				arg_683_1.dialogCg_.alpha = 1

				arg_683_1.dialog_:SetActive(true)
				SetActive(arg_683_1.leftNameGo_, false)

				arg_683_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_683_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_683_1:RecordName(arg_683_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_683_1.iconTrs_.gameObject, false)
				arg_683_1.callingController_:SetSelectedState("normal")

				local var_686_4 = arg_683_1:FormatText(arg_683_1:GetWordFromCfg(322021168).content)

				arg_683_1.text_.text = var_686_4

				LuaForUtil.ClearLinePrefixSymbol(arg_683_1.text_)

				local var_686_6 = 54 <= 0 and var_686_3 or var_686_3 * (utf8.len(var_686_4) / 54)

				if (54 <= 0 and var_686_3 or var_686_3 * (utf8.len(var_686_4) / 54)) > 0 and var_686_3 < var_686_6 then
					arg_683_1.talkMaxDuration = var_686_6

					if var_686_6 + var_686_2 > arg_683_1.duration_ then
						arg_683_1.duration_ = var_686_6 + var_686_2
					end
				end

				arg_683_1.text_.text = var_686_4
				arg_683_1.typewritter.percent = 0

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(false)
				arg_683_1:RecordContent(arg_683_1.text_.text)
			end

			local var_686_7 = math.max(var_686_3, arg_683_1.talkMaxDuration)

			if var_686_2 <= arg_683_1.time_ and arg_683_1.time_ < var_686_2 + var_686_7 then
				arg_683_1.typewritter.percent = (arg_683_1.time_ - var_686_2) / var_686_7

				arg_683_1.typewritter:SetDirty()
			end

			if arg_683_1.time_ >= var_686_2 + var_686_7 and arg_683_1.time_ < var_686_2 + var_686_7 + arg_686_0 then
				arg_683_1.typewritter.percent = 1

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(true)
			end
		end

		arg_683_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_683_1:InitPlayNodeList()
	end,
	Play322021169 = function(arg_687_0, arg_687_1)
		arg_687_1.time_ = 0
		arg_687_1.frameCnt_ = 0
		arg_687_1.state_ = "playing"
		arg_687_1.curTalkId_ = 322021169
		arg_687_1.duration_ = 5

		SetActive(arg_687_1.tipsGo_, false)

		function arg_687_1.onSingleLineFinish_()
			arg_687_1.onSingleLineUpdate_ = nil
			arg_687_1.onSingleLineFinish_ = nil
			arg_687_1.state_ = "waiting"
		end

		function arg_687_1.playNext_(arg_689_0)
			if arg_689_0 == 1 then
				arg_687_0:Play322021170(arg_687_1)
			end
		end

		function arg_687_1.onSingleLineUpdate_(arg_690_0)
			local var_690_0 = 1.15

			if 0 < arg_687_1.time_ and arg_687_1.time_ <= 0 + arg_690_0 then
				arg_687_1.talkMaxDuration = 0
				arg_687_1.dialogCg_.alpha = 1

				arg_687_1.dialog_:SetActive(true)
				SetActive(arg_687_1.leftNameGo_, false)

				arg_687_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_687_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_687_1:RecordName(arg_687_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_687_1.iconTrs_.gameObject, false)
				arg_687_1.callingController_:SetSelectedState("normal")

				local var_690_1 = arg_687_1:FormatText(arg_687_1:GetWordFromCfg(322021169).content)

				arg_687_1.text_.text = var_690_1

				LuaForUtil.ClearLinePrefixSymbol(arg_687_1.text_)

				local var_690_3 = 46 <= 0 and var_690_0 or var_690_0 * (utf8.len(var_690_1) / 46)

				if (46 <= 0 and var_690_0 or var_690_0 * (utf8.len(var_690_1) / 46)) > 0 and var_690_0 < var_690_3 then
					arg_687_1.talkMaxDuration = var_690_3

					if var_690_3 + 0 > arg_687_1.duration_ then
						arg_687_1.duration_ = var_690_3 + 0
					end
				end

				arg_687_1.text_.text = var_690_1
				arg_687_1.typewritter.percent = 0

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(false)
				arg_687_1:RecordContent(arg_687_1.text_.text)
			end

			local var_690_4 = math.max(var_690_0, arg_687_1.talkMaxDuration)

			if 0 <= arg_687_1.time_ and arg_687_1.time_ < 0 + var_690_4 then
				arg_687_1.typewritter.percent = (arg_687_1.time_ - 0) / var_690_4

				arg_687_1.typewritter:SetDirty()
			end

			if arg_687_1.time_ >= 0 + var_690_4 and arg_687_1.time_ < 0 + var_690_4 + arg_690_0 then
				arg_687_1.typewritter.percent = 1

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(true)
			end
		end

		arg_687_1.nodeConfigList_ = {}

		arg_687_1:InitPlayNodeList()
	end,
	Play322021170 = function(arg_691_0, arg_691_1)
		arg_691_1.time_ = 0
		arg_691_1.frameCnt_ = 0
		arg_691_1.state_ = "playing"
		arg_691_1.curTalkId_ = 322021170
		arg_691_1.duration_ = 2

		SetActive(arg_691_1.tipsGo_, false)

		function arg_691_1.onSingleLineFinish_()
			arg_691_1.onSingleLineUpdate_ = nil
			arg_691_1.onSingleLineFinish_ = nil
			arg_691_1.state_ = "waiting"
		end

		function arg_691_1.playNext_(arg_693_0)
			if arg_693_0 == 1 then
				arg_691_0:Play322021171(arg_691_1)
			end
		end

		function arg_691_1.onSingleLineUpdate_(arg_694_0)
			if 0 < arg_691_1.time_ and arg_691_1.time_ <= 0 + arg_694_0 then
				arg_691_1.var_.moveOldPos404001ui_story = arg_691_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_694_0 = 0.001

			if 0 <= arg_691_1.time_ and arg_691_1.time_ < 0 + var_694_0 then
				arg_691_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_691_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_691_1.time_ - 0) / var_694_0)
				arg_691_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_691_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_691_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_691_1.actors_["404001ui_story"].transform.position).z)
				arg_691_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_691_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_691_1.actors_["404001ui_story"].transform.localEulerAngles = arg_691_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_691_1.time_ >= 0 + var_694_0 and arg_691_1.time_ < 0 + var_694_0 + arg_694_0 then
				arg_691_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_691_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_691_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_691_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_691_1.actors_["404001ui_story"].transform.position).z)
				arg_691_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_691_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_691_1.actors_["404001ui_story"].transform.localEulerAngles = arg_691_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_694_1 = arg_691_1.actors_["404001ui_story"]

			if 0 < arg_691_1.time_ and arg_691_1.time_ <= 0 + arg_694_0 and not isNil(var_694_1) and arg_691_1.var_.characterEffect404001ui_story == nil then
				arg_691_1.var_.characterEffect404001ui_story = var_694_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_694_2 = 0.200000002980232

			if 0 <= arg_691_1.time_ and arg_691_1.time_ < 0 + var_694_2 and not isNil(var_694_1) then
				if arg_691_1.var_.characterEffect404001ui_story and not isNil(var_694_1) then
					arg_691_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_691_1.time_ >= 0 + var_694_2 and arg_691_1.time_ < 0 + var_694_2 + arg_694_0 and not isNil(var_694_1) and arg_691_1.var_.characterEffect404001ui_story then
				arg_691_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_691_1.time_ and arg_691_1.time_ <= 0 + arg_694_0 then
				arg_691_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action6_2")
			end

			local var_694_4 = 0
			local var_694_5 = 0.1

			if 0 < arg_691_1.time_ and arg_691_1.time_ <= var_694_4 + arg_694_0 then
				arg_691_1.talkMaxDuration = 0
				arg_691_1.dialogCg_.alpha = 1

				arg_691_1.dialog_:SetActive(true)
				SetActive(arg_691_1.leftNameGo_, true)

				arg_691_1.leftNameTxt_.text = arg_691_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_691_1.leftNameTxt_.transform)

				arg_691_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_691_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_691_1:RecordName(arg_691_1.leftNameTxt_.text)
				SetActive(arg_691_1.iconTrs_.gameObject, false)
				arg_691_1.callingController_:SetSelectedState("normal")

				local var_694_6 = arg_691_1:GetWordFromCfg(322021170)
				local var_694_7 = arg_691_1:FormatText(var_694_6.content)

				arg_691_1.text_.text = var_694_7

				LuaForUtil.ClearLinePrefixSymbol(arg_691_1.text_)

				local var_694_9 = 4 <= 0 and var_694_5 or var_694_5 * (utf8.len(var_694_7) / 4)

				if (4 <= 0 and var_694_5 or var_694_5 * (utf8.len(var_694_7) / 4)) > 0 and var_694_5 < var_694_9 then
					arg_691_1.talkMaxDuration = var_694_9

					if var_694_9 + var_694_4 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_9 + var_694_4
					end
				end

				arg_691_1.text_.text = var_694_7
				arg_691_1.typewritter.percent = 0

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021170", "story_v_out_322021.awb") ~= 0 then
					local var_694_10 = manager.audio:GetVoiceLength("story_v_out_322021", "322021170", "story_v_out_322021.awb") / 1000

					if var_694_10 + var_694_4 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_10 + var_694_4
					end

					if var_694_6.prefab_name ~= "" and arg_691_1.actors_[var_694_6.prefab_name] ~= nil then
						local var_694_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_691_1.actors_[var_694_6.prefab_name].transform, "story_v_out_322021", "322021170", "story_v_out_322021.awb")

						arg_691_1:RecordAudio("322021170", var_694_11)
						arg_691_1:RecordAudio("322021170", var_694_11)
					else
						arg_691_1:AudioAction("play", "voice", "story_v_out_322021", "322021170", "story_v_out_322021.awb")
					end

					arg_691_1:RecordHistoryTalkVoice("story_v_out_322021", "322021170", "story_v_out_322021.awb")
				end

				arg_691_1:RecordContent(arg_691_1.text_.text)
			end

			local var_694_12 = math.max(var_694_5, arg_691_1.talkMaxDuration)

			if var_694_4 <= arg_691_1.time_ and arg_691_1.time_ < var_694_4 + var_694_12 then
				arg_691_1.typewritter.percent = (arg_691_1.time_ - var_694_4) / var_694_12

				arg_691_1.typewritter:SetDirty()
			end

			if arg_691_1.time_ >= var_694_4 + var_694_12 and arg_691_1.time_ < var_694_4 + var_694_12 + arg_694_0 then
				arg_691_1.typewritter.percent = 1

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(true)
			end
		end

		arg_691_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_691_1:InitPlayNodeList()
	end,
	Play322021171 = function(arg_695_0, arg_695_1)
		arg_695_1.time_ = 0
		arg_695_1.frameCnt_ = 0
		arg_695_1.state_ = "playing"
		arg_695_1.curTalkId_ = 322021171
		arg_695_1.duration_ = 9.5

		local var_695_0 = {
			zh = 5.466,
			ja = 9.5
		}
		local var_695_1 = manager.audio:GetLocalizationFlag()

		if var_695_0[var_695_1] ~= nil then
			arg_695_1.duration_ = var_695_0[var_695_1]
		end

		SetActive(arg_695_1.tipsGo_, false)

		function arg_695_1.onSingleLineFinish_()
			arg_695_1.onSingleLineUpdate_ = nil
			arg_695_1.onSingleLineFinish_ = nil
			arg_695_1.state_ = "waiting"
		end

		function arg_695_1.playNext_(arg_697_0)
			if arg_697_0 == 1 then
				arg_695_0:Play322021172(arg_695_1)
			end
		end

		function arg_695_1.onSingleLineUpdate_(arg_698_0)
			if 0 < arg_695_1.time_ and arg_695_1.time_ <= 0 + arg_698_0 and not isNil(arg_695_1.actors_["404001ui_story"]) and arg_695_1.var_.characterEffect404001ui_story == nil then
				arg_695_1.var_.characterEffect404001ui_story = arg_695_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_698_0 = 0.200000002980232

			if 0 <= arg_695_1.time_ and arg_695_1.time_ < 0 + var_698_0 and not isNil(arg_695_1.actors_["404001ui_story"]) then
				if arg_695_1.var_.characterEffect404001ui_story and not isNil(arg_695_1.actors_["404001ui_story"]) then
					arg_695_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_695_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_695_1.time_ - 0) / var_698_0)
				end
			end

			if arg_695_1.time_ >= 0 + var_698_0 and arg_695_1.time_ < 0 + var_698_0 + arg_698_0 and not isNil(arg_695_1.actors_["404001ui_story"]) and arg_695_1.var_.characterEffect404001ui_story then
				arg_695_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_695_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			local var_698_1 = 0
			local var_698_2 = 0.725

			if 0 < arg_695_1.time_ and arg_695_1.time_ <= var_698_1 + arg_698_0 then
				arg_695_1.talkMaxDuration = 0
				arg_695_1.dialogCg_.alpha = 1

				arg_695_1.dialog_:SetActive(true)
				SetActive(arg_695_1.leftNameGo_, true)

				arg_695_1.leftNameTxt_.text = arg_695_1:FormatText(StoryNameCfg[1167].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_695_1.leftNameTxt_.transform)

				arg_695_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_695_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_695_1:RecordName(arg_695_1.leftNameTxt_.text)
				SetActive(arg_695_1.iconTrs_.gameObject, true)
				arg_695_1.iconController_:SetSelectedState("hero")

				arg_695_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_695_1.callingController_:SetSelectedState("normal")

				arg_695_1.keyicon_.color = Color.New(1, 1, 1)
				arg_695_1.icon_.color = Color.New(1, 1, 1)

				local var_698_3 = arg_695_1:GetWordFromCfg(322021171)
				local var_698_4 = arg_695_1:FormatText(var_698_3.content)

				arg_695_1.text_.text = var_698_4

				LuaForUtil.ClearLinePrefixSymbol(arg_695_1.text_)

				local var_698_6 = 29 <= 0 and var_698_2 or var_698_2 * (utf8.len(var_698_4) / 29)

				if (29 <= 0 and var_698_2 or var_698_2 * (utf8.len(var_698_4) / 29)) > 0 and var_698_2 < var_698_6 then
					arg_695_1.talkMaxDuration = var_698_6

					if var_698_6 + var_698_1 > arg_695_1.duration_ then
						arg_695_1.duration_ = var_698_6 + var_698_1
					end
				end

				arg_695_1.text_.text = var_698_4
				arg_695_1.typewritter.percent = 0

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021171", "story_v_out_322021.awb") ~= 0 then
					local var_698_7 = manager.audio:GetVoiceLength("story_v_out_322021", "322021171", "story_v_out_322021.awb") / 1000

					if var_698_7 + var_698_1 > arg_695_1.duration_ then
						arg_695_1.duration_ = var_698_7 + var_698_1
					end

					if var_698_3.prefab_name ~= "" and arg_695_1.actors_[var_698_3.prefab_name] ~= nil then
						local var_698_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_695_1.actors_[var_698_3.prefab_name].transform, "story_v_out_322021", "322021171", "story_v_out_322021.awb")

						arg_695_1:RecordAudio("322021171", var_698_8)
						arg_695_1:RecordAudio("322021171", var_698_8)
					else
						arg_695_1:AudioAction("play", "voice", "story_v_out_322021", "322021171", "story_v_out_322021.awb")
					end

					arg_695_1:RecordHistoryTalkVoice("story_v_out_322021", "322021171", "story_v_out_322021.awb")
				end

				arg_695_1:RecordContent(arg_695_1.text_.text)
			end

			local var_698_9 = math.max(var_698_2, arg_695_1.talkMaxDuration)

			if var_698_1 <= arg_695_1.time_ and arg_695_1.time_ < var_698_1 + var_698_9 then
				arg_695_1.typewritter.percent = (arg_695_1.time_ - var_698_1) / var_698_9

				arg_695_1.typewritter:SetDirty()
			end

			if arg_695_1.time_ >= var_698_1 + var_698_9 and arg_695_1.time_ < var_698_1 + var_698_9 + arg_698_0 then
				arg_695_1.typewritter.percent = 1

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(true)
			end
		end

		arg_695_1.nodeConfigList_ = {}

		arg_695_1:InitPlayNodeList()
	end,
	Play322021172 = function(arg_699_0, arg_699_1)
		arg_699_1.time_ = 0
		arg_699_1.frameCnt_ = 0
		arg_699_1.state_ = "playing"
		arg_699_1.curTalkId_ = 322021172
		arg_699_1.duration_ = 2.9

		local var_699_0 = {
			zh = 1.999999999999,
			ja = 2.9
		}
		local var_699_1 = manager.audio:GetLocalizationFlag()

		if var_699_0[var_699_1] ~= nil then
			arg_699_1.duration_ = var_699_0[var_699_1]
		end

		SetActive(arg_699_1.tipsGo_, false)

		function arg_699_1.onSingleLineFinish_()
			arg_699_1.onSingleLineUpdate_ = nil
			arg_699_1.onSingleLineFinish_ = nil
			arg_699_1.state_ = "waiting"
		end

		function arg_699_1.playNext_(arg_701_0)
			if arg_701_0 == 1 then
				arg_699_0:Play322021173(arg_699_1)
			end
		end

		function arg_699_1.onSingleLineUpdate_(arg_702_0)
			if 0 < arg_699_1.time_ and arg_699_1.time_ <= 0 + arg_702_0 and not isNil(arg_699_1.actors_["404001ui_story"]) and arg_699_1.var_.characterEffect404001ui_story == nil then
				arg_699_1.var_.characterEffect404001ui_story = arg_699_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_702_0 = 0.200000002980232

			if 0 <= arg_699_1.time_ and arg_699_1.time_ < 0 + var_702_0 and not isNil(arg_699_1.actors_["404001ui_story"]) then
				if arg_699_1.var_.characterEffect404001ui_story and not isNil(arg_699_1.actors_["404001ui_story"]) then
					arg_699_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_699_1.time_ >= 0 + var_702_0 and arg_699_1.time_ < 0 + var_702_0 + arg_702_0 and not isNil(arg_699_1.actors_["404001ui_story"]) and arg_699_1.var_.characterEffect404001ui_story then
				arg_699_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_699_1.time_ and arg_699_1.time_ <= 0 + arg_702_0 then
				arg_699_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_699_1.time_ and arg_699_1.time_ <= 0 + arg_702_0 then
				arg_699_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_702_2 = 0
			local var_702_3 = 0.175

			if 0 < arg_699_1.time_ and arg_699_1.time_ <= var_702_2 + arg_702_0 then
				arg_699_1.talkMaxDuration = 0
				arg_699_1.dialogCg_.alpha = 1

				arg_699_1.dialog_:SetActive(true)
				SetActive(arg_699_1.leftNameGo_, true)

				arg_699_1.leftNameTxt_.text = arg_699_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_699_1.leftNameTxt_.transform)

				arg_699_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_699_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_699_1:RecordName(arg_699_1.leftNameTxt_.text)
				SetActive(arg_699_1.iconTrs_.gameObject, false)
				arg_699_1.callingController_:SetSelectedState("normal")

				local var_702_4 = arg_699_1:GetWordFromCfg(322021172)
				local var_702_5 = arg_699_1:FormatText(var_702_4.content)

				arg_699_1.text_.text = var_702_5

				LuaForUtil.ClearLinePrefixSymbol(arg_699_1.text_)

				local var_702_7 = 7 <= 0 and var_702_3 or var_702_3 * (utf8.len(var_702_5) / 7)

				if (7 <= 0 and var_702_3 or var_702_3 * (utf8.len(var_702_5) / 7)) > 0 and var_702_3 < var_702_7 then
					arg_699_1.talkMaxDuration = var_702_7

					if var_702_7 + var_702_2 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_7 + var_702_2
					end
				end

				arg_699_1.text_.text = var_702_5
				arg_699_1.typewritter.percent = 0

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021172", "story_v_out_322021.awb") ~= 0 then
					local var_702_8 = manager.audio:GetVoiceLength("story_v_out_322021", "322021172", "story_v_out_322021.awb") / 1000

					if var_702_8 + var_702_2 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_8 + var_702_2
					end

					if var_702_4.prefab_name ~= "" and arg_699_1.actors_[var_702_4.prefab_name] ~= nil then
						local var_702_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_699_1.actors_[var_702_4.prefab_name].transform, "story_v_out_322021", "322021172", "story_v_out_322021.awb")

						arg_699_1:RecordAudio("322021172", var_702_9)
						arg_699_1:RecordAudio("322021172", var_702_9)
					else
						arg_699_1:AudioAction("play", "voice", "story_v_out_322021", "322021172", "story_v_out_322021.awb")
					end

					arg_699_1:RecordHistoryTalkVoice("story_v_out_322021", "322021172", "story_v_out_322021.awb")
				end

				arg_699_1:RecordContent(arg_699_1.text_.text)
			end

			local var_702_10 = math.max(var_702_3, arg_699_1.talkMaxDuration)

			if var_702_2 <= arg_699_1.time_ and arg_699_1.time_ < var_702_2 + var_702_10 then
				arg_699_1.typewritter.percent = (arg_699_1.time_ - var_702_2) / var_702_10

				arg_699_1.typewritter:SetDirty()
			end

			if arg_699_1.time_ >= var_702_2 + var_702_10 and arg_699_1.time_ < var_702_2 + var_702_10 + arg_702_0 then
				arg_699_1.typewritter.percent = 1

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(true)
			end
		end

		arg_699_1.nodeConfigList_ = {}

		arg_699_1:InitPlayNodeList()
	end,
	Play322021173 = function(arg_703_0, arg_703_1)
		arg_703_1.time_ = 0
		arg_703_1.frameCnt_ = 0
		arg_703_1.state_ = "playing"
		arg_703_1.curTalkId_ = 322021173
		arg_703_1.duration_ = 14.6

		local var_703_0 = {
			zh = 9.166,
			ja = 14.6
		}
		local var_703_1 = manager.audio:GetLocalizationFlag()

		if var_703_0[var_703_1] ~= nil then
			arg_703_1.duration_ = var_703_0[var_703_1]
		end

		SetActive(arg_703_1.tipsGo_, false)

		function arg_703_1.onSingleLineFinish_()
			arg_703_1.onSingleLineUpdate_ = nil
			arg_703_1.onSingleLineFinish_ = nil
			arg_703_1.state_ = "waiting"
		end

		function arg_703_1.playNext_(arg_705_0)
			if arg_705_0 == 1 then
				arg_703_0:Play322021174(arg_703_1)
			end
		end

		function arg_703_1.onSingleLineUpdate_(arg_706_0)
			if 0 < arg_703_1.time_ and arg_703_1.time_ <= 0 + arg_706_0 and not isNil(arg_703_1.actors_["404001ui_story"]) and arg_703_1.var_.characterEffect404001ui_story == nil then
				arg_703_1.var_.characterEffect404001ui_story = arg_703_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_706_0 = 0.200000002980232

			if 0 <= arg_703_1.time_ and arg_703_1.time_ < 0 + var_706_0 and not isNil(arg_703_1.actors_["404001ui_story"]) then
				if arg_703_1.var_.characterEffect404001ui_story and not isNil(arg_703_1.actors_["404001ui_story"]) then
					arg_703_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_703_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_703_1.time_ - 0) / var_706_0)
				end
			end

			if arg_703_1.time_ >= 0 + var_706_0 and arg_703_1.time_ < 0 + var_706_0 + arg_706_0 and not isNil(arg_703_1.actors_["404001ui_story"]) and arg_703_1.var_.characterEffect404001ui_story then
				arg_703_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_703_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			local var_706_1 = 0
			local var_706_2 = 1.15

			if 0 < arg_703_1.time_ and arg_703_1.time_ <= var_706_1 + arg_706_0 then
				arg_703_1.talkMaxDuration = 0
				arg_703_1.dialogCg_.alpha = 1

				arg_703_1.dialog_:SetActive(true)
				SetActive(arg_703_1.leftNameGo_, true)

				arg_703_1.leftNameTxt_.text = arg_703_1:FormatText(StoryNameCfg[1167].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_703_1.leftNameTxt_.transform)

				arg_703_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_703_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_703_1:RecordName(arg_703_1.leftNameTxt_.text)
				SetActive(arg_703_1.iconTrs_.gameObject, true)
				arg_703_1.iconController_:SetSelectedState("hero")

				arg_703_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_703_1.callingController_:SetSelectedState("normal")

				arg_703_1.keyicon_.color = Color.New(1, 1, 1)
				arg_703_1.icon_.color = Color.New(1, 1, 1)

				local var_706_3 = arg_703_1:GetWordFromCfg(322021173)
				local var_706_4 = arg_703_1:FormatText(var_706_3.content)

				arg_703_1.text_.text = var_706_4

				LuaForUtil.ClearLinePrefixSymbol(arg_703_1.text_)

				local var_706_6 = 46 <= 0 and var_706_2 or var_706_2 * (utf8.len(var_706_4) / 46)

				if (46 <= 0 and var_706_2 or var_706_2 * (utf8.len(var_706_4) / 46)) > 0 and var_706_2 < var_706_6 then
					arg_703_1.talkMaxDuration = var_706_6

					if var_706_6 + var_706_1 > arg_703_1.duration_ then
						arg_703_1.duration_ = var_706_6 + var_706_1
					end
				end

				arg_703_1.text_.text = var_706_4
				arg_703_1.typewritter.percent = 0

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021173", "story_v_out_322021.awb") ~= 0 then
					local var_706_7 = manager.audio:GetVoiceLength("story_v_out_322021", "322021173", "story_v_out_322021.awb") / 1000

					if var_706_7 + var_706_1 > arg_703_1.duration_ then
						arg_703_1.duration_ = var_706_7 + var_706_1
					end

					if var_706_3.prefab_name ~= "" and arg_703_1.actors_[var_706_3.prefab_name] ~= nil then
						local var_706_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_703_1.actors_[var_706_3.prefab_name].transform, "story_v_out_322021", "322021173", "story_v_out_322021.awb")

						arg_703_1:RecordAudio("322021173", var_706_8)
						arg_703_1:RecordAudio("322021173", var_706_8)
					else
						arg_703_1:AudioAction("play", "voice", "story_v_out_322021", "322021173", "story_v_out_322021.awb")
					end

					arg_703_1:RecordHistoryTalkVoice("story_v_out_322021", "322021173", "story_v_out_322021.awb")
				end

				arg_703_1:RecordContent(arg_703_1.text_.text)
			end

			local var_706_9 = math.max(var_706_2, arg_703_1.talkMaxDuration)

			if var_706_1 <= arg_703_1.time_ and arg_703_1.time_ < var_706_1 + var_706_9 then
				arg_703_1.typewritter.percent = (arg_703_1.time_ - var_706_1) / var_706_9

				arg_703_1.typewritter:SetDirty()
			end

			if arg_703_1.time_ >= var_706_1 + var_706_9 and arg_703_1.time_ < var_706_1 + var_706_9 + arg_706_0 then
				arg_703_1.typewritter.percent = 1

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(true)
			end
		end

		arg_703_1.nodeConfigList_ = {}

		arg_703_1:InitPlayNodeList()
	end,
	Play322021174 = function(arg_707_0, arg_707_1)
		arg_707_1.time_ = 0
		arg_707_1.frameCnt_ = 0
		arg_707_1.state_ = "playing"
		arg_707_1.curTalkId_ = 322021174
		arg_707_1.duration_ = 5

		SetActive(arg_707_1.tipsGo_, false)

		function arg_707_1.onSingleLineFinish_()
			arg_707_1.onSingleLineUpdate_ = nil
			arg_707_1.onSingleLineFinish_ = nil
			arg_707_1.state_ = "waiting"
		end

		function arg_707_1.playNext_(arg_709_0)
			if arg_709_0 == 1 then
				arg_707_0:Play322021175(arg_707_1)
			end
		end

		function arg_707_1.onSingleLineUpdate_(arg_710_0)
			if 0 < arg_707_1.time_ and arg_707_1.time_ <= 0 + arg_710_0 then
				arg_707_1.var_.moveOldPos404001ui_story = arg_707_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_710_0 = 0.001

			if 0 <= arg_707_1.time_ and arg_707_1.time_ < 0 + var_710_0 then
				arg_707_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_707_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_707_1.time_ - 0) / var_710_0)
				arg_707_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_707_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_707_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_707_1.actors_["404001ui_story"].transform.position).z)
				arg_707_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_707_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_707_1.actors_["404001ui_story"].transform.localEulerAngles = arg_707_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_707_1.time_ >= 0 + var_710_0 and arg_707_1.time_ < 0 + var_710_0 + arg_710_0 then
				arg_707_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_707_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_707_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_707_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_707_1.actors_["404001ui_story"].transform.position).z)
				arg_707_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_707_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_707_1.actors_["404001ui_story"].transform.localEulerAngles = arg_707_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if 0.2 < arg_707_1.time_ and arg_707_1.time_ <= 0.2 + arg_710_0 then
				arg_707_1:AudioAction("play", "effect", "se_story_134_02", "se_story_134_02_jump", "")
			end

			local var_710_2 = manager.ui.mainCamera.transform

			if 0.2 < arg_707_1.time_ and arg_707_1.time_ <= 0.2 + arg_710_0 then
				arg_707_1.var_.shakeOldPos = var_710_2.localPosition
			end

			local var_710_3 = 0.3

			if 0.2 <= arg_707_1.time_ and arg_707_1.time_ < 0.2 + var_710_3 then
				local var_710_4, var_710_5 = math.modf((arg_707_1.time_ - 0.2) / 0.132)

				var_710_2.localPosition = Vector3.New(var_710_5 * 0.13, var_710_5 * 0.13, var_710_5 * 0.13) + arg_707_1.var_.shakeOldPos
			end

			if arg_707_1.time_ >= 0.2 + var_710_3 and arg_707_1.time_ < 0.2 + var_710_3 + arg_710_0 then
				var_710_2.localPosition = arg_707_1.var_.shakeOldPos
			end

			local var_710_6 = 0
			local var_710_7 = 1.775

			if 0 < arg_707_1.time_ and arg_707_1.time_ <= var_710_6 + arg_710_0 then
				arg_707_1.talkMaxDuration = 0
				arg_707_1.dialogCg_.alpha = 1

				arg_707_1.dialog_:SetActive(true)
				SetActive(arg_707_1.leftNameGo_, false)

				arg_707_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_707_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_707_1:RecordName(arg_707_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_707_1.iconTrs_.gameObject, false)
				arg_707_1.callingController_:SetSelectedState("normal")

				local var_710_8 = arg_707_1:FormatText(arg_707_1:GetWordFromCfg(322021174).content)

				arg_707_1.text_.text = var_710_8

				LuaForUtil.ClearLinePrefixSymbol(arg_707_1.text_)

				local var_710_10 = 71 <= 0 and var_710_7 or var_710_7 * (utf8.len(var_710_8) / 71)

				if (71 <= 0 and var_710_7 or var_710_7 * (utf8.len(var_710_8) / 71)) > 0 and var_710_7 < var_710_10 then
					arg_707_1.talkMaxDuration = var_710_10

					if var_710_10 + var_710_6 > arg_707_1.duration_ then
						arg_707_1.duration_ = var_710_10 + var_710_6
					end
				end

				arg_707_1.text_.text = var_710_8
				arg_707_1.typewritter.percent = 0

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(false)
				arg_707_1:RecordContent(arg_707_1.text_.text)
			end

			local var_710_11 = math.max(var_710_7, arg_707_1.talkMaxDuration)

			if var_710_6 <= arg_707_1.time_ and arg_707_1.time_ < var_710_6 + var_710_11 then
				arg_707_1.typewritter.percent = (arg_707_1.time_ - var_710_6) / var_710_11

				arg_707_1.typewritter:SetDirty()
			end

			if arg_707_1.time_ >= var_710_6 + var_710_11 and arg_707_1.time_ < var_710_6 + var_710_11 + arg_710_0 then
				arg_707_1.typewritter.percent = 1

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(true)
			end
		end

		arg_707_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_707_1:InitPlayNodeList()
	end,
	Play322021175 = function(arg_711_0, arg_711_1)
		arg_711_1.time_ = 0
		arg_711_1.frameCnt_ = 0
		arg_711_1.state_ = "playing"
		arg_711_1.curTalkId_ = 322021175
		arg_711_1.duration_ = 7

		local var_711_0 = {
			zh = 7,
			ja = 6.9
		}
		local var_711_1 = manager.audio:GetLocalizationFlag()

		if var_711_0[var_711_1] ~= nil then
			arg_711_1.duration_ = var_711_0[var_711_1]
		end

		SetActive(arg_711_1.tipsGo_, false)

		function arg_711_1.onSingleLineFinish_()
			arg_711_1.onSingleLineUpdate_ = nil
			arg_711_1.onSingleLineFinish_ = nil
			arg_711_1.state_ = "waiting"
			arg_711_1.auto_ = false
		end

		function arg_711_1.playNext_(arg_713_0)
			arg_711_1.onStoryFinished_()
		end

		function arg_711_1.onSingleLineUpdate_(arg_714_0)
			if 0 < arg_711_1.time_ and arg_711_1.time_ <= 0 + arg_714_0 then
				arg_711_1.var_.moveOldPos404001ui_story = arg_711_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_714_0 = 0.001

			if 0 <= arg_711_1.time_ and arg_711_1.time_ < 0 + var_714_0 then
				arg_711_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_711_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_711_1.time_ - 0) / var_714_0)
				arg_711_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_711_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_711_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_711_1.actors_["404001ui_story"].transform.position).z)
				arg_711_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_711_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_711_1.actors_["404001ui_story"].transform.localEulerAngles = arg_711_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_711_1.time_ >= 0 + var_714_0 and arg_711_1.time_ < 0 + var_714_0 + arg_714_0 then
				arg_711_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_711_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_711_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_711_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_711_1.actors_["404001ui_story"].transform.position).z)
				arg_711_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_711_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_711_1.actors_["404001ui_story"].transform.localEulerAngles = arg_711_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_714_1 = arg_711_1.actors_["404001ui_story"]

			if 0 < arg_711_1.time_ and arg_711_1.time_ <= 0 + arg_714_0 and not isNil(var_714_1) and arg_711_1.var_.characterEffect404001ui_story == nil then
				arg_711_1.var_.characterEffect404001ui_story = var_714_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_714_2 = 0.200000002980232

			if 0 <= arg_711_1.time_ and arg_711_1.time_ < 0 + var_714_2 and not isNil(var_714_1) then
				if arg_711_1.var_.characterEffect404001ui_story and not isNil(var_714_1) then
					arg_711_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_711_1.time_ >= 0 + var_714_2 and arg_711_1.time_ < 0 + var_714_2 + arg_714_0 and not isNil(var_714_1) and arg_711_1.var_.characterEffect404001ui_story then
				arg_711_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_711_1.time_ and arg_711_1.time_ <= 0 + arg_714_0 then
				arg_711_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_711_1.time_ and arg_711_1.time_ <= 0 + arg_714_0 then
				arg_711_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_714_4 = 0
			local var_714_5 = 0.55

			if 0 < arg_711_1.time_ and arg_711_1.time_ <= var_714_4 + arg_714_0 then
				arg_711_1.talkMaxDuration = 0
				arg_711_1.dialogCg_.alpha = 1

				arg_711_1.dialog_:SetActive(true)
				SetActive(arg_711_1.leftNameGo_, true)

				arg_711_1.leftNameTxt_.text = arg_711_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_711_1.leftNameTxt_.transform)

				arg_711_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_711_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_711_1:RecordName(arg_711_1.leftNameTxt_.text)
				SetActive(arg_711_1.iconTrs_.gameObject, false)
				arg_711_1.callingController_:SetSelectedState("normal")

				local var_714_6 = arg_711_1:GetWordFromCfg(322021175)
				local var_714_7 = arg_711_1:FormatText(var_714_6.content)

				arg_711_1.text_.text = var_714_7

				LuaForUtil.ClearLinePrefixSymbol(arg_711_1.text_)

				local var_714_9 = 22 <= 0 and var_714_5 or var_714_5 * (utf8.len(var_714_7) / 22)

				if (22 <= 0 and var_714_5 or var_714_5 * (utf8.len(var_714_7) / 22)) > 0 and var_714_5 < var_714_9 then
					arg_711_1.talkMaxDuration = var_714_9

					if var_714_9 + var_714_4 > arg_711_1.duration_ then
						arg_711_1.duration_ = var_714_9 + var_714_4
					end
				end

				arg_711_1.text_.text = var_714_7
				arg_711_1.typewritter.percent = 0

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021175", "story_v_out_322021.awb") ~= 0 then
					local var_714_10 = manager.audio:GetVoiceLength("story_v_out_322021", "322021175", "story_v_out_322021.awb") / 1000

					if var_714_10 + var_714_4 > arg_711_1.duration_ then
						arg_711_1.duration_ = var_714_10 + var_714_4
					end

					if var_714_6.prefab_name ~= "" and arg_711_1.actors_[var_714_6.prefab_name] ~= nil then
						local var_714_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_711_1.actors_[var_714_6.prefab_name].transform, "story_v_out_322021", "322021175", "story_v_out_322021.awb")

						arg_711_1:RecordAudio("322021175", var_714_11)
						arg_711_1:RecordAudio("322021175", var_714_11)
					else
						arg_711_1:AudioAction("play", "voice", "story_v_out_322021", "322021175", "story_v_out_322021.awb")
					end

					arg_711_1:RecordHistoryTalkVoice("story_v_out_322021", "322021175", "story_v_out_322021.awb")
				end

				arg_711_1:RecordContent(arg_711_1.text_.text)
			end

			local var_714_12 = math.max(var_714_5, arg_711_1.talkMaxDuration)

			if var_714_4 <= arg_711_1.time_ and arg_711_1.time_ < var_714_4 + var_714_12 then
				arg_711_1.typewritter.percent = (arg_711_1.time_ - var_714_4) / var_714_12

				arg_711_1.typewritter:SetDirty()
			end

			if arg_711_1.time_ >= var_714_4 + var_714_12 and arg_711_1.time_ < var_714_4 + var_714_12 + arg_714_0 then
				arg_711_1.typewritter.percent = 1

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(true)
			end
		end

		arg_711_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_711_1:InitPlayNodeList()
	end,
	Play322021009 = function(arg_715_0, arg_715_1)
		arg_715_1.time_ = 0
		arg_715_1.frameCnt_ = 0
		arg_715_1.state_ = "playing"
		arg_715_1.curTalkId_ = 322021009
		arg_715_1.duration_ = 6.1

		local var_715_0 = {
			zh = 4.566,
			ja = 6.1
		}
		local var_715_1 = manager.audio:GetLocalizationFlag()

		if var_715_0[var_715_1] ~= nil then
			arg_715_1.duration_ = var_715_0[var_715_1]
		end

		SetActive(arg_715_1.tipsGo_, false)

		function arg_715_1.onSingleLineFinish_()
			arg_715_1.onSingleLineUpdate_ = nil
			arg_715_1.onSingleLineFinish_ = nil
			arg_715_1.state_ = "waiting"
		end

		function arg_715_1.playNext_(arg_717_0)
			if arg_717_0 == 1 then
				arg_715_0:Play322021011(arg_715_1)
			end
		end

		function arg_715_1.onSingleLineUpdate_(arg_718_0)
			if arg_715_1.actors_["1061ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1061ui_story"))) then
				local var_718_0 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_715_1.stage_.transform)

				var_718_0.name = "1061ui_story"
				var_718_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_715_1.actors_["1061ui_story"] = var_718_0

				local var_718_1 = var_718_0:GetComponentInChildren(typeof(CharacterEffect))

				var_718_1.enabled = true

				local var_718_2 = GameObjectTools.GetOrAddComponent(var_718_0, typeof(DynamicBoneHelper))

				if var_718_2 then
					var_718_2:EnableDynamicBone(false)
				end

				arg_715_1:ShowWeapon(var_718_1.transform, false)

				arg_715_1.var_["1061ui_story" .. "Animator"] = var_718_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_715_1.var_["1061ui_story" .. "Animator"].applyRootMotion = true
				arg_715_1.var_["1061ui_story" .. "LipSync"] = var_718_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_715_1.time_ and arg_715_1.time_ <= 0 + arg_718_0 then
				arg_715_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_2")
			end

			local var_718_3 = arg_715_1.actors_["1061ui_story"]

			if 0 < arg_715_1.time_ and arg_715_1.time_ <= 0 + arg_718_0 and not isNil(var_718_3) and arg_715_1.var_.characterEffect1061ui_story == nil then
				arg_715_1.var_.characterEffect1061ui_story = var_718_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_718_4 = 0.200000002980232

			if 0 <= arg_715_1.time_ and arg_715_1.time_ < 0 + var_718_4 and not isNil(var_718_3) then
				if arg_715_1.var_.characterEffect1061ui_story and not isNil(var_718_3) then
					arg_715_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_715_1.time_ >= 0 + var_718_4 and arg_715_1.time_ < 0 + var_718_4 + arg_718_0 and not isNil(var_718_3) and arg_715_1.var_.characterEffect1061ui_story then
				arg_715_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_718_6 = 0
			local var_718_7 = 0.525

			if 0 < arg_715_1.time_ and arg_715_1.time_ <= var_718_6 + arg_718_0 then
				arg_715_1.talkMaxDuration = 0
				arg_715_1.dialogCg_.alpha = 1

				arg_715_1.dialog_:SetActive(true)
				SetActive(arg_715_1.leftNameGo_, true)

				arg_715_1.leftNameTxt_.text = arg_715_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_715_1.leftNameTxt_.transform)

				arg_715_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_715_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_715_1:RecordName(arg_715_1.leftNameTxt_.text)
				SetActive(arg_715_1.iconTrs_.gameObject, false)
				arg_715_1.callingController_:SetSelectedState("normal")

				local var_718_8 = arg_715_1:GetWordFromCfg(322021009)
				local var_718_9 = arg_715_1:FormatText(var_718_8.content)

				arg_715_1.text_.text = var_718_9

				LuaForUtil.ClearLinePrefixSymbol(arg_715_1.text_)

				local var_718_11 = 21 <= 0 and var_718_7 or var_718_7 * (utf8.len(var_718_9) / 21)

				if (21 <= 0 and var_718_7 or var_718_7 * (utf8.len(var_718_9) / 21)) > 0 and var_718_7 < var_718_11 then
					arg_715_1.talkMaxDuration = var_718_11

					if var_718_11 + var_718_6 > arg_715_1.duration_ then
						arg_715_1.duration_ = var_718_11 + var_718_6
					end
				end

				arg_715_1.text_.text = var_718_9
				arg_715_1.typewritter.percent = 0

				arg_715_1.typewritter:SetDirty()
				arg_715_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021009", "story_v_out_322021.awb") ~= 0 then
					local var_718_12 = manager.audio:GetVoiceLength("story_v_out_322021", "322021009", "story_v_out_322021.awb") / 1000

					if var_718_12 + var_718_6 > arg_715_1.duration_ then
						arg_715_1.duration_ = var_718_12 + var_718_6
					end

					if var_718_8.prefab_name ~= "" and arg_715_1.actors_[var_718_8.prefab_name] ~= nil then
						local var_718_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_715_1.actors_[var_718_8.prefab_name].transform, "story_v_out_322021", "322021009", "story_v_out_322021.awb")

						arg_715_1:RecordAudio("322021009", var_718_13)
						arg_715_1:RecordAudio("322021009", var_718_13)
					else
						arg_715_1:AudioAction("play", "voice", "story_v_out_322021", "322021009", "story_v_out_322021.awb")
					end

					arg_715_1:RecordHistoryTalkVoice("story_v_out_322021", "322021009", "story_v_out_322021.awb")
				end

				arg_715_1:RecordContent(arg_715_1.text_.text)
			end

			local var_718_14 = math.max(var_718_7, arg_715_1.talkMaxDuration)

			if var_718_6 <= arg_715_1.time_ and arg_715_1.time_ < var_718_6 + var_718_14 then
				arg_715_1.typewritter.percent = (arg_715_1.time_ - var_718_6) / var_718_14

				arg_715_1.typewritter:SetDirty()
			end

			if arg_715_1.time_ >= var_718_6 + var_718_14 and arg_715_1.time_ < var_718_6 + var_718_14 + arg_718_0 then
				arg_715_1.typewritter.percent = 1

				arg_715_1.typewritter:SetDirty()
				arg_715_1:ShowNextGo(true)
			end
		end

		arg_715_1.nodeConfigList_ = {}

		arg_715_1:InitPlayNodeList()
	end,
	Play322021010 = function(arg_719_0, arg_719_1)
		arg_719_1.time_ = 0
		arg_719_1.frameCnt_ = 0
		arg_719_1.state_ = "playing"
		arg_719_1.curTalkId_ = 322021010
		arg_719_1.duration_ = 8.5

		local var_719_0 = {
			zh = 4.766,
			ja = 8.5
		}
		local var_719_1 = manager.audio:GetLocalizationFlag()

		if var_719_0[var_719_1] ~= nil then
			arg_719_1.duration_ = var_719_0[var_719_1]
		end

		SetActive(arg_719_1.tipsGo_, false)

		function arg_719_1.onSingleLineFinish_()
			arg_719_1.onSingleLineUpdate_ = nil
			arg_719_1.onSingleLineFinish_ = nil
			arg_719_1.state_ = "waiting"
		end

		function arg_719_1.playNext_(arg_721_0)
			if arg_721_0 == 1 then
				arg_719_0:Play322021011(arg_719_1)
			end
		end

		function arg_719_1.onSingleLineUpdate_(arg_722_0)
			if arg_719_1.actors_["1061ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1061ui_story"))) then
				local var_722_0 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_719_1.stage_.transform)

				var_722_0.name = "1061ui_story"
				var_722_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_719_1.actors_["1061ui_story"] = var_722_0

				local var_722_1 = var_722_0:GetComponentInChildren(typeof(CharacterEffect))

				var_722_1.enabled = true

				local var_722_2 = GameObjectTools.GetOrAddComponent(var_722_0, typeof(DynamicBoneHelper))

				if var_722_2 then
					var_722_2:EnableDynamicBone(false)
				end

				arg_719_1:ShowWeapon(var_722_1.transform, false)

				arg_719_1.var_["1061ui_story" .. "Animator"] = var_722_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_719_1.var_["1061ui_story" .. "Animator"].applyRootMotion = true
				arg_719_1.var_["1061ui_story" .. "LipSync"] = var_722_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_719_1.time_ and arg_719_1.time_ <= 0 + arg_722_0 then
				arg_719_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_2")
			end

			local var_722_3 = arg_719_1.actors_["1061ui_story"]

			if 0 < arg_719_1.time_ and arg_719_1.time_ <= 0 + arg_722_0 and not isNil(var_722_3) and arg_719_1.var_.characterEffect1061ui_story == nil then
				arg_719_1.var_.characterEffect1061ui_story = var_722_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_722_4 = 0.200000002980232

			if 0 <= arg_719_1.time_ and arg_719_1.time_ < 0 + var_722_4 and not isNil(var_722_3) then
				if arg_719_1.var_.characterEffect1061ui_story and not isNil(var_722_3) then
					arg_719_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_719_1.time_ >= 0 + var_722_4 and arg_719_1.time_ < 0 + var_722_4 + arg_722_0 and not isNil(var_722_3) and arg_719_1.var_.characterEffect1061ui_story then
				arg_719_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_722_6 = 0
			local var_722_7 = 0.6

			if 0 < arg_719_1.time_ and arg_719_1.time_ <= var_722_6 + arg_722_0 then
				arg_719_1.talkMaxDuration = 0
				arg_719_1.dialogCg_.alpha = 1

				arg_719_1.dialog_:SetActive(true)
				SetActive(arg_719_1.leftNameGo_, true)

				arg_719_1.leftNameTxt_.text = arg_719_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_719_1.leftNameTxt_.transform)

				arg_719_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_719_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_719_1:RecordName(arg_719_1.leftNameTxt_.text)
				SetActive(arg_719_1.iconTrs_.gameObject, false)
				arg_719_1.callingController_:SetSelectedState("normal")

				local var_722_8 = arg_719_1:GetWordFromCfg(322021010)
				local var_722_9 = arg_719_1:FormatText(var_722_8.content)

				arg_719_1.text_.text = var_722_9

				LuaForUtil.ClearLinePrefixSymbol(arg_719_1.text_)

				local var_722_11 = 24 <= 0 and var_722_7 or var_722_7 * (utf8.len(var_722_9) / 24)

				if (24 <= 0 and var_722_7 or var_722_7 * (utf8.len(var_722_9) / 24)) > 0 and var_722_7 < var_722_11 then
					arg_719_1.talkMaxDuration = var_722_11

					if var_722_11 + var_722_6 > arg_719_1.duration_ then
						arg_719_1.duration_ = var_722_11 + var_722_6
					end
				end

				arg_719_1.text_.text = var_722_9
				arg_719_1.typewritter.percent = 0

				arg_719_1.typewritter:SetDirty()
				arg_719_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322021", "322021010", "story_v_out_322021.awb") ~= 0 then
					local var_722_12 = manager.audio:GetVoiceLength("story_v_out_322021", "322021010", "story_v_out_322021.awb") / 1000

					if var_722_12 + var_722_6 > arg_719_1.duration_ then
						arg_719_1.duration_ = var_722_12 + var_722_6
					end

					if var_722_8.prefab_name ~= "" and arg_719_1.actors_[var_722_8.prefab_name] ~= nil then
						local var_722_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_719_1.actors_[var_722_8.prefab_name].transform, "story_v_out_322021", "322021010", "story_v_out_322021.awb")

						arg_719_1:RecordAudio("322021010", var_722_13)
						arg_719_1:RecordAudio("322021010", var_722_13)
					else
						arg_719_1:AudioAction("play", "voice", "story_v_out_322021", "322021010", "story_v_out_322021.awb")
					end

					arg_719_1:RecordHistoryTalkVoice("story_v_out_322021", "322021010", "story_v_out_322021.awb")
				end

				arg_719_1:RecordContent(arg_719_1.text_.text)
			end

			local var_722_14 = math.max(var_722_7, arg_719_1.talkMaxDuration)

			if var_722_6 <= arg_719_1.time_ and arg_719_1.time_ < var_722_6 + var_722_14 then
				arg_719_1.typewritter.percent = (arg_719_1.time_ - var_722_6) / var_722_14

				arg_719_1.typewritter:SetDirty()
			end

			if arg_719_1.time_ >= var_722_6 + var_722_14 and arg_719_1.time_ < var_722_6 + var_722_14 + arg_722_0 then
				arg_719_1.typewritter.percent = 1

				arg_719_1.typewritter:SetDirty()
				arg_719_1:ShowNextGo(true)
			end
		end

		arg_719_1.nodeConfigList_ = {}

		arg_719_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST73a",
		"TextureConfig/Background/ST61a",
		"TextureConfig/Background/L14f",
		"TextureConfig/Background/L15"
	},
	voices = {
		"story_v_out_322021.awb"
	}
}
