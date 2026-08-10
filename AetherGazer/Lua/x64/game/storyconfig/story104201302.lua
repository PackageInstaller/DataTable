return {
	Play420132001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 420132001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play420132002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST61"

			if arg_1_1.bgs_[var_4_0] == nil then
				local var_4_1 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_0)
				var_4_1.name = var_4_0
				var_4_1.transform.parent = arg_1_1.stage_.transform
				var_4_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_0] = var_4_1
			end

			local var_4_2 = 0

			if var_4_2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_2 + arg_4_0 then
				local var_4_3 = manager.ui.mainCamera.transform.localPosition
				local var_4_4 = Vector3.New(0, 0, 10) + Vector3.New(var_4_3.x, var_4_3.y, 0)
				local var_4_5 = arg_1_1.bgs_.ST61

				var_4_5.transform.localPosition = var_4_4
				var_4_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_6 = var_4_5:GetComponent("SpriteRenderer")

				if var_4_6 and var_4_6.sprite then
					local var_4_7 = (var_4_5.transform.localPosition - var_4_3).z
					local var_4_8 = manager.ui.mainCameraCom_
					local var_4_9 = 2 * var_4_7 * Mathf.Tan(var_4_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_10 = var_4_9 * var_4_8.aspect
					local var_4_11 = var_4_6.sprite.bounds.size.x
					local var_4_12 = var_4_6.sprite.bounds.size.y
					local var_4_13 = var_4_10 / var_4_11
					local var_4_14 = var_4_9 / var_4_12
					local var_4_15 = var_4_14 < var_4_13 and var_4_13 or var_4_14

					var_4_5.transform.localScale = Vector3.New(var_4_15, var_4_15, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST61" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 2

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_17 = 0.3

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_18 = 0

			if var_4_18 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_19 = 2

			if var_4_18 <= arg_1_1.time_ and arg_1_1.time_ < var_4_18 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_18) / var_4_19
				local var_4_21 = Color.New(0, 0, 0)

				var_4_21.a = Mathf.Lerp(1, 0, var_4_20)
				arg_1_1.mask_.color = var_4_21
			end

			if arg_1_1.time_ >= var_4_18 + var_4_19 and arg_1_1.time_ < var_4_18 + var_4_19 + arg_4_0 then
				local var_4_22 = Color.New(0, 0, 0)
				local var_4_23 = 0

				arg_1_1.mask_.enabled = false
				var_4_22.a = var_4_23
				arg_1_1.mask_.color = var_4_22
			end

			local var_4_24 = 0
			local var_4_25 = 0.2

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "music"

				arg_1_1:AudioAction(var_4_26, var_4_27, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_28 = ""
				local var_4_29 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_29 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_29 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_29

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_29
						arg_1_1.bgmTxt2_.text = var_4_29
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

			local var_4_30 = 0.333333333333333
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano")

				if var_4_35 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_35 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_35

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_35
						arg_1_1.bgmTxt2_.text = var_4_35
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

			local var_4_36 = 2
			local var_4_37 = 0.375

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_38 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_38:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_39 = arg_1_1:FormatText(StoryNameCfg[7].name)

				arg_1_1.leftNameTxt_.text = var_4_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_40 = arg_1_1:GetWordFromCfg(420132001)
				local var_4_41 = arg_1_1:FormatText(var_4_40.content)

				arg_1_1.text_.text = var_4_41

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_42 = 15
				local var_4_43 = utf8.len(var_4_41)
				local var_4_44 = var_4_42 <= 0 and var_4_37 or var_4_37 * (var_4_43 / var_4_42)

				if var_4_44 > 0 and var_4_37 < var_4_44 then
					arg_1_1.talkMaxDuration = var_4_44
					var_4_36 = var_4_36 + 0.3

					if var_4_44 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_44 + var_4_36
					end
				end

				arg_1_1.text_.text = var_4_41
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_45 = var_4_36 + 0.3
			local var_4_46 = math.max(var_4_37, arg_1_1.talkMaxDuration)

			if var_4_45 <= arg_1_1.time_ and arg_1_1.time_ < var_4_45 + var_4_46 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_45) / var_4_46

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_45 + var_4_46 and arg_1_1.time_ < var_4_45 + var_4_46 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play420132002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 420132002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play420132003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.05
			local var_12_1 = 1

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				local var_12_2 = "play"
				local var_12_3 = "effect"

				arg_9_1:AudioAction(var_12_2, var_12_3, "se_story_11", "se_story_11_foot", "")
			end

			local var_12_4 = 0
			local var_12_5 = 1

			if var_12_4 < arg_9_1.time_ and arg_9_1.time_ <= var_12_4 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_6 = arg_9_1:GetWordFromCfg(420132002)
				local var_12_7 = arg_9_1:FormatText(var_12_6.content)

				arg_9_1.text_.text = var_12_7

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_8 = 40
				local var_12_9 = utf8.len(var_12_7)
				local var_12_10 = var_12_8 <= 0 and var_12_5 or var_12_5 * (var_12_9 / var_12_8)

				if var_12_10 > 0 and var_12_5 < var_12_10 then
					arg_9_1.talkMaxDuration = var_12_10

					if var_12_10 + var_12_4 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_10 + var_12_4
					end
				end

				arg_9_1.text_.text = var_12_7
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_11 = math.max(var_12_5, arg_9_1.talkMaxDuration)

			if var_12_4 <= arg_9_1.time_ and arg_9_1.time_ < var_12_4 + var_12_11 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_4) / var_12_11

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_4 + var_12_11 and arg_9_1.time_ < var_12_4 + var_12_11 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play420132003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 420132003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play420132004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.175

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[7].name)

				arg_13_1.leftNameTxt_.text = var_16_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:GetWordFromCfg(420132003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 7
				local var_16_6 = utf8.len(var_16_4)
				local var_16_7 = var_16_5 <= 0 and var_16_1 or var_16_1 * (var_16_6 / var_16_5)

				if var_16_7 > 0 and var_16_1 < var_16_7 then
					arg_13_1.talkMaxDuration = var_16_7

					if var_16_7 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_0
					end
				end

				arg_13_1.text_.text = var_16_4
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_8 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_8 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_8

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_8 and arg_13_1.time_ < var_16_0 + var_16_8 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play420132004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 420132004
		arg_17_1.duration_ = 3.9

		local var_17_0 = {
			zh = 3.8,
			ja = 3.9
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play420132005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "404001ui_story"

			if arg_17_1.actors_[var_20_0] == nil then
				local var_20_1 = Asset.Load("Char/" .. "404001ui_story")

				if not isNil(var_20_1) then
					local var_20_2 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_17_1.stage_.transform)

					var_20_2.name = var_20_0
					var_20_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_17_1.actors_[var_20_0] = var_20_2

					local var_20_3 = var_20_2:GetComponentInChildren(typeof(CharacterEffect))

					var_20_3.enabled = true

					local var_20_4 = GameObjectTools.GetOrAddComponent(var_20_2, typeof(DynamicBoneHelper))

					if var_20_4 then
						var_20_4:EnableDynamicBone(false)
					end

					arg_17_1:ShowWeapon(var_20_3.transform, false)

					arg_17_1.var_[var_20_0 .. "Animator"] = var_20_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_17_1.var_[var_20_0 .. "Animator"].applyRootMotion = true
					arg_17_1.var_[var_20_0 .. "LipSync"] = var_20_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_20_5 = arg_17_1.actors_["404001ui_story"].transform
			local var_20_6 = 0

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.var_.moveOldPos404001ui_story = var_20_5.localPosition
			end

			local var_20_7 = 0.001

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_7 then
				local var_20_8 = (arg_17_1.time_ - var_20_6) / var_20_7
				local var_20_9 = Vector3.New(0, -1.55, -5.5)

				var_20_5.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos404001ui_story, var_20_9, var_20_8)

				local var_20_10 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_10.x, var_20_10.y, var_20_10.z)

				local var_20_11 = var_20_5.localEulerAngles

				var_20_11.z = 0
				var_20_11.x = 0
				var_20_5.localEulerAngles = var_20_11
			end

			if arg_17_1.time_ >= var_20_6 + var_20_7 and arg_17_1.time_ < var_20_6 + var_20_7 + arg_20_0 then
				var_20_5.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_20_12 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_12.x, var_20_12.y, var_20_12.z)

				local var_20_13 = var_20_5.localEulerAngles

				var_20_13.z = 0
				var_20_13.x = 0
				var_20_5.localEulerAngles = var_20_13
			end

			local var_20_14 = arg_17_1.actors_["404001ui_story"]
			local var_20_15 = 0

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.characterEffect404001ui_story == nil then
				arg_17_1.var_.characterEffect404001ui_story = var_20_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_16 = 0.200000002980232

			if var_20_15 <= arg_17_1.time_ and arg_17_1.time_ < var_20_15 + var_20_16 and not isNil(var_20_14) then
				local var_20_17 = (arg_17_1.time_ - var_20_15) / var_20_16

				if arg_17_1.var_.characterEffect404001ui_story and not isNil(var_20_14) then
					arg_17_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_15 + var_20_16 and arg_17_1.time_ < var_20_15 + var_20_16 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.characterEffect404001ui_story then
				arg_17_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_20_18 = 0

			if var_20_18 < arg_17_1.time_ and arg_17_1.time_ <= var_20_18 + arg_20_0 then
				arg_17_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_20_19 = 0

			if var_20_19 < arg_17_1.time_ and arg_17_1.time_ <= var_20_19 + arg_20_0 then
				arg_17_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_20_20 = 0
			local var_20_21 = 0.525

			if var_20_20 < arg_17_1.time_ and arg_17_1.time_ <= var_20_20 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_22 = arg_17_1:FormatText(StoryNameCfg[668].name)

				arg_17_1.leftNameTxt_.text = var_20_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_23 = arg_17_1:GetWordFromCfg(420132004)
				local var_20_24 = arg_17_1:FormatText(var_20_23.content)

				arg_17_1.text_.text = var_20_24

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_25 = 21
				local var_20_26 = utf8.len(var_20_24)
				local var_20_27 = var_20_25 <= 0 and var_20_21 or var_20_21 * (var_20_26 / var_20_25)

				if var_20_27 > 0 and var_20_21 < var_20_27 then
					arg_17_1.talkMaxDuration = var_20_27

					if var_20_27 + var_20_20 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_27 + var_20_20
					end
				end

				arg_17_1.text_.text = var_20_24
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132004", "story_v_out_420132.awb") ~= 0 then
					local var_20_28 = manager.audio:GetVoiceLength("story_v_out_420132", "420132004", "story_v_out_420132.awb") / 1000

					if var_20_28 + var_20_20 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_28 + var_20_20
					end

					if var_20_23.prefab_name ~= "" and arg_17_1.actors_[var_20_23.prefab_name] ~= nil then
						local var_20_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_23.prefab_name].transform, "story_v_out_420132", "420132004", "story_v_out_420132.awb")

						arg_17_1:RecordAudio("420132004", var_20_29)
						arg_17_1:RecordAudio("420132004", var_20_29)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_420132", "420132004", "story_v_out_420132.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_420132", "420132004", "story_v_out_420132.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_30 = math.max(var_20_21, arg_17_1.talkMaxDuration)

			if var_20_20 <= arg_17_1.time_ and arg_17_1.time_ < var_20_20 + var_20_30 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_20) / var_20_30

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_20 + var_20_30 and arg_17_1.time_ < var_20_20 + var_20_30 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
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

		arg_17_1:InitPlayNodeList()
	end,
	Play420132005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 420132005
		arg_21_1.duration_ = 4.87

		local var_21_0 = {
			zh = 2.3,
			ja = 4.866
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play420132006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.325

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[668].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_3 = arg_21_1:GetWordFromCfg(420132005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 13
				local var_24_6 = utf8.len(var_24_4)
				local var_24_7 = var_24_5 <= 0 and var_24_1 or var_24_1 * (var_24_6 / var_24_5)

				if var_24_7 > 0 and var_24_1 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_0
					end
				end

				arg_21_1.text_.text = var_24_4
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132005", "story_v_out_420132.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_420132", "420132005", "story_v_out_420132.awb") / 1000

					if var_24_8 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_0
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_420132", "420132005", "story_v_out_420132.awb")

						arg_21_1:RecordAudio("420132005", var_24_9)
						arg_21_1:RecordAudio("420132005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_420132", "420132005", "story_v_out_420132.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_420132", "420132005", "story_v_out_420132.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_10 = math.max(var_24_1, arg_21_1.talkMaxDuration)

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_10 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_0) / var_24_10

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_0 + var_24_10 and arg_21_1.time_ < var_24_0 + var_24_10 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play420132006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 420132006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play420132007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["404001ui_story"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos404001ui_story = var_28_0.localPosition
			end

			local var_28_2 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2
				local var_28_4 = Vector3.New(0, 100, 0)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos404001ui_story, var_28_4, var_28_3)

				local var_28_5 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_5.x, var_28_5.y, var_28_5.z)

				local var_28_6 = var_28_0.localEulerAngles

				var_28_6.z = 0
				var_28_6.x = 0
				var_28_0.localEulerAngles = var_28_6
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(0, 100, 0)

				local var_28_7 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_7.x, var_28_7.y, var_28_7.z)

				local var_28_8 = var_28_0.localEulerAngles

				var_28_8.z = 0
				var_28_8.x = 0
				var_28_0.localEulerAngles = var_28_8
			end

			local var_28_9 = 0
			local var_28_10 = 0.475

			if var_28_9 < arg_25_1.time_ and arg_25_1.time_ <= var_28_9 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_11 = arg_25_1:FormatText(StoryNameCfg[7].name)

				arg_25_1.leftNameTxt_.text = var_28_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_12 = arg_25_1:GetWordFromCfg(420132006)
				local var_28_13 = arg_25_1:FormatText(var_28_12.content)

				arg_25_1.text_.text = var_28_13

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_14 = 19
				local var_28_15 = utf8.len(var_28_13)
				local var_28_16 = var_28_14 <= 0 and var_28_10 or var_28_10 * (var_28_15 / var_28_14)

				if var_28_16 > 0 and var_28_10 < var_28_16 then
					arg_25_1.talkMaxDuration = var_28_16

					if var_28_16 + var_28_9 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_16 + var_28_9
					end
				end

				arg_25_1.text_.text = var_28_13
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_17 = math.max(var_28_10, arg_25_1.talkMaxDuration)

			if var_28_9 <= arg_25_1.time_ and arg_25_1.time_ < var_28_9 + var_28_17 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_9) / var_28_17

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_9 + var_28_17 and arg_25_1.time_ < var_28_9 + var_28_17 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
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

		arg_25_1:InitPlayNodeList()
	end,
	Play420132007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 420132007
		arg_29_1.duration_ = 2

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play420132008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = "1089ui_story"

			if arg_29_1.actors_[var_32_0] == nil then
				local var_32_1 = Asset.Load("Char/" .. "1089ui_story")

				if not isNil(var_32_1) then
					local var_32_2 = Object.Instantiate(Asset.Load("Char/" .. "1089ui_story"), arg_29_1.stage_.transform)

					var_32_2.name = var_32_0
					var_32_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_29_1.actors_[var_32_0] = var_32_2

					local var_32_3 = var_32_2:GetComponentInChildren(typeof(CharacterEffect))

					var_32_3.enabled = true

					local var_32_4 = GameObjectTools.GetOrAddComponent(var_32_2, typeof(DynamicBoneHelper))

					if var_32_4 then
						var_32_4:EnableDynamicBone(false)
					end

					arg_29_1:ShowWeapon(var_32_3.transform, false)

					arg_29_1.var_[var_32_0 .. "Animator"] = var_32_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_29_1.var_[var_32_0 .. "Animator"].applyRootMotion = true
					arg_29_1.var_[var_32_0 .. "LipSync"] = var_32_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_32_5 = arg_29_1.actors_["1089ui_story"].transform
			local var_32_6 = 0

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1.var_.moveOldPos1089ui_story = var_32_5.localPosition
			end

			local var_32_7 = 0.001

			if var_32_6 <= arg_29_1.time_ and arg_29_1.time_ < var_32_6 + var_32_7 then
				local var_32_8 = (arg_29_1.time_ - var_32_6) / var_32_7
				local var_32_9 = Vector3.New(0, -1.1, -6.17)

				var_32_5.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1089ui_story, var_32_9, var_32_8)

				local var_32_10 = manager.ui.mainCamera.transform.position - var_32_5.position

				var_32_5.forward = Vector3.New(var_32_10.x, var_32_10.y, var_32_10.z)

				local var_32_11 = var_32_5.localEulerAngles

				var_32_11.z = 0
				var_32_11.x = 0
				var_32_5.localEulerAngles = var_32_11
			end

			if arg_29_1.time_ >= var_32_6 + var_32_7 and arg_29_1.time_ < var_32_6 + var_32_7 + arg_32_0 then
				var_32_5.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_32_12 = manager.ui.mainCamera.transform.position - var_32_5.position

				var_32_5.forward = Vector3.New(var_32_12.x, var_32_12.y, var_32_12.z)

				local var_32_13 = var_32_5.localEulerAngles

				var_32_13.z = 0
				var_32_13.x = 0
				var_32_5.localEulerAngles = var_32_13
			end

			local var_32_14 = arg_29_1.actors_["1089ui_story"]
			local var_32_15 = 0

			if var_32_15 < arg_29_1.time_ and arg_29_1.time_ <= var_32_15 + arg_32_0 and not isNil(var_32_14) and arg_29_1.var_.characterEffect1089ui_story == nil then
				arg_29_1.var_.characterEffect1089ui_story = var_32_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_16 = 0.200000002980232

			if var_32_15 <= arg_29_1.time_ and arg_29_1.time_ < var_32_15 + var_32_16 and not isNil(var_32_14) then
				local var_32_17 = (arg_29_1.time_ - var_32_15) / var_32_16

				if arg_29_1.var_.characterEffect1089ui_story and not isNil(var_32_14) then
					arg_29_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_15 + var_32_16 and arg_29_1.time_ < var_32_15 + var_32_16 + arg_32_0 and not isNil(var_32_14) and arg_29_1.var_.characterEffect1089ui_story then
				arg_29_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_32_18 = 0

			if var_32_18 < arg_29_1.time_ and arg_29_1.time_ <= var_32_18 + arg_32_0 then
				arg_29_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_1")
			end

			local var_32_19 = 0

			if var_32_19 < arg_29_1.time_ and arg_29_1.time_ <= var_32_19 + arg_32_0 then
				arg_29_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_32_20 = 0
			local var_32_21 = 0.075

			if var_32_20 < arg_29_1.time_ and arg_29_1.time_ <= var_32_20 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_22 = arg_29_1:FormatText(StoryNameCfg[1031].name)

				arg_29_1.leftNameTxt_.text = var_32_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_23 = arg_29_1:GetWordFromCfg(420132007)
				local var_32_24 = arg_29_1:FormatText(var_32_23.content)

				arg_29_1.text_.text = var_32_24

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_25 = 3
				local var_32_26 = utf8.len(var_32_24)
				local var_32_27 = var_32_25 <= 0 and var_32_21 or var_32_21 * (var_32_26 / var_32_25)

				if var_32_27 > 0 and var_32_21 < var_32_27 then
					arg_29_1.talkMaxDuration = var_32_27

					if var_32_27 + var_32_20 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_27 + var_32_20
					end
				end

				arg_29_1.text_.text = var_32_24
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132007", "story_v_out_420132.awb") ~= 0 then
					local var_32_28 = manager.audio:GetVoiceLength("story_v_out_420132", "420132007", "story_v_out_420132.awb") / 1000

					if var_32_28 + var_32_20 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_28 + var_32_20
					end

					if var_32_23.prefab_name ~= "" and arg_29_1.actors_[var_32_23.prefab_name] ~= nil then
						local var_32_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_23.prefab_name].transform, "story_v_out_420132", "420132007", "story_v_out_420132.awb")

						arg_29_1:RecordAudio("420132007", var_32_29)
						arg_29_1:RecordAudio("420132007", var_32_29)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_420132", "420132007", "story_v_out_420132.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_420132", "420132007", "story_v_out_420132.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_30 = math.max(var_32_21, arg_29_1.talkMaxDuration)

			if var_32_20 <= arg_29_1.time_ and arg_29_1.time_ < var_32_20 + var_32_30 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_20) / var_32_30

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_20 + var_32_30 and arg_29_1.time_ < var_32_20 + var_32_30 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play420132008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 420132008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play420132009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1089ui_story"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos1089ui_story = var_36_0.localPosition
			end

			local var_36_2 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2
				local var_36_4 = Vector3.New(0, 100, 0)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1089ui_story, var_36_4, var_36_3)

				local var_36_5 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_5.x, var_36_5.y, var_36_5.z)

				local var_36_6 = var_36_0.localEulerAngles

				var_36_6.z = 0
				var_36_6.x = 0
				var_36_0.localEulerAngles = var_36_6
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(0, 100, 0)

				local var_36_7 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_7.x, var_36_7.y, var_36_7.z)

				local var_36_8 = var_36_0.localEulerAngles

				var_36_8.z = 0
				var_36_8.x = 0
				var_36_0.localEulerAngles = var_36_8
			end

			local var_36_9 = 0
			local var_36_10 = 1.475

			if var_36_9 < arg_33_1.time_ and arg_33_1.time_ <= var_36_9 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_11 = arg_33_1:GetWordFromCfg(420132008)
				local var_36_12 = arg_33_1:FormatText(var_36_11.content)

				arg_33_1.text_.text = var_36_12

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_13 = 59
				local var_36_14 = utf8.len(var_36_12)
				local var_36_15 = var_36_13 <= 0 and var_36_10 or var_36_10 * (var_36_14 / var_36_13)

				if var_36_15 > 0 and var_36_10 < var_36_15 then
					arg_33_1.talkMaxDuration = var_36_15

					if var_36_15 + var_36_9 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_15 + var_36_9
					end
				end

				arg_33_1.text_.text = var_36_12
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_16 = math.max(var_36_10, arg_33_1.talkMaxDuration)

			if var_36_9 <= arg_33_1.time_ and arg_33_1.time_ < var_36_9 + var_36_16 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_9) / var_36_16

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_9 + var_36_16 and arg_33_1.time_ < var_36_9 + var_36_16 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play420132009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 420132009
		arg_37_1.duration_ = 5.77

		local var_37_0 = {
			zh = 4.666,
			ja = 5.766
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play420132010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.7

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[668].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:GetWordFromCfg(420132009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 28
				local var_40_6 = utf8.len(var_40_4)
				local var_40_7 = var_40_5 <= 0 and var_40_1 or var_40_1 * (var_40_6 / var_40_5)

				if var_40_7 > 0 and var_40_1 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_0
					end
				end

				arg_37_1.text_.text = var_40_4
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132009", "story_v_out_420132.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_out_420132", "420132009", "story_v_out_420132.awb") / 1000

					if var_40_8 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_0
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_out_420132", "420132009", "story_v_out_420132.awb")

						arg_37_1:RecordAudio("420132009", var_40_9)
						arg_37_1:RecordAudio("420132009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_420132", "420132009", "story_v_out_420132.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_420132", "420132009", "story_v_out_420132.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_10 = math.max(var_40_1, arg_37_1.talkMaxDuration)

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_10 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_0) / var_40_10

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_0 + var_40_10 and arg_37_1.time_ < var_40_0 + var_40_10 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play420132010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 420132010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play420132011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 1.175

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_2 = arg_41_1:GetWordFromCfg(420132010)
				local var_44_3 = arg_41_1:FormatText(var_44_2.content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 47
				local var_44_5 = utf8.len(var_44_3)
				local var_44_6 = var_44_4 <= 0 and var_44_1 or var_44_1 * (var_44_5 / var_44_4)

				if var_44_6 > 0 and var_44_1 < var_44_6 then
					arg_41_1.talkMaxDuration = var_44_6

					if var_44_6 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_6 + var_44_0
					end
				end

				arg_41_1.text_.text = var_44_3
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_7 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_7 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_0) / var_44_7

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_7 and arg_41_1.time_ < var_44_0 + var_44_7 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play420132011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 420132011
		arg_45_1.duration_ = 3.83

		local var_45_0 = {
			zh = 3.833,
			ja = 3.5
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play420132012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1089ui_story"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos1089ui_story = var_48_0.localPosition
			end

			local var_48_2 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2
				local var_48_4 = Vector3.New(0, -1.1, -6.17)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1089ui_story, var_48_4, var_48_3)

				local var_48_5 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_5.x, var_48_5.y, var_48_5.z)

				local var_48_6 = var_48_0.localEulerAngles

				var_48_6.z = 0
				var_48_6.x = 0
				var_48_0.localEulerAngles = var_48_6
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_48_7 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_7.x, var_48_7.y, var_48_7.z)

				local var_48_8 = var_48_0.localEulerAngles

				var_48_8.z = 0
				var_48_8.x = 0
				var_48_0.localEulerAngles = var_48_8
			end

			local var_48_9 = arg_45_1.actors_["1089ui_story"]
			local var_48_10 = 0

			if var_48_10 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 and not isNil(var_48_9) and arg_45_1.var_.characterEffect1089ui_story == nil then
				arg_45_1.var_.characterEffect1089ui_story = var_48_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_11 = 0.200000002980232

			if var_48_10 <= arg_45_1.time_ and arg_45_1.time_ < var_48_10 + var_48_11 and not isNil(var_48_9) then
				local var_48_12 = (arg_45_1.time_ - var_48_10) / var_48_11

				if arg_45_1.var_.characterEffect1089ui_story and not isNil(var_48_9) then
					arg_45_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_10 + var_48_11 and arg_45_1.time_ < var_48_10 + var_48_11 + arg_48_0 and not isNil(var_48_9) and arg_45_1.var_.characterEffect1089ui_story then
				arg_45_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_48_13 = 0
			local var_48_14 = 0.375

			if var_48_13 < arg_45_1.time_ and arg_45_1.time_ <= var_48_13 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_15 = arg_45_1:FormatText(StoryNameCfg[1031].name)

				arg_45_1.leftNameTxt_.text = var_48_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_16 = arg_45_1:GetWordFromCfg(420132011)
				local var_48_17 = arg_45_1:FormatText(var_48_16.content)

				arg_45_1.text_.text = var_48_17

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_18 = 15
				local var_48_19 = utf8.len(var_48_17)
				local var_48_20 = var_48_18 <= 0 and var_48_14 or var_48_14 * (var_48_19 / var_48_18)

				if var_48_20 > 0 and var_48_14 < var_48_20 then
					arg_45_1.talkMaxDuration = var_48_20

					if var_48_20 + var_48_13 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_20 + var_48_13
					end
				end

				arg_45_1.text_.text = var_48_17
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132011", "story_v_out_420132.awb") ~= 0 then
					local var_48_21 = manager.audio:GetVoiceLength("story_v_out_420132", "420132011", "story_v_out_420132.awb") / 1000

					if var_48_21 + var_48_13 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_21 + var_48_13
					end

					if var_48_16.prefab_name ~= "" and arg_45_1.actors_[var_48_16.prefab_name] ~= nil then
						local var_48_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_16.prefab_name].transform, "story_v_out_420132", "420132011", "story_v_out_420132.awb")

						arg_45_1:RecordAudio("420132011", var_48_22)
						arg_45_1:RecordAudio("420132011", var_48_22)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_420132", "420132011", "story_v_out_420132.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_420132", "420132011", "story_v_out_420132.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_23 = math.max(var_48_14, arg_45_1.talkMaxDuration)

			if var_48_13 <= arg_45_1.time_ and arg_45_1.time_ < var_48_13 + var_48_23 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_13) / var_48_23

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_13 + var_48_23 and arg_45_1.time_ < var_48_13 + var_48_23 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play420132012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 420132012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play420132013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1089ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1089ui_story == nil then
				arg_49_1.var_.characterEffect1089ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect1089ui_story and not isNil(var_52_0) then
					local var_52_4 = Mathf.Lerp(0, 0.5, var_52_3)

					arg_49_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1089ui_story.fillRatio = var_52_4
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1089ui_story then
				local var_52_5 = 0.5

				arg_49_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1089ui_story.fillRatio = var_52_5
			end

			local var_52_6 = 0
			local var_52_7 = 0.225

			if var_52_6 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_8 = arg_49_1:FormatText(StoryNameCfg[7].name)

				arg_49_1.leftNameTxt_.text = var_52_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_9 = arg_49_1:GetWordFromCfg(420132012)
				local var_52_10 = arg_49_1:FormatText(var_52_9.content)

				arg_49_1.text_.text = var_52_10

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_11 = 9
				local var_52_12 = utf8.len(var_52_10)
				local var_52_13 = var_52_11 <= 0 and var_52_7 or var_52_7 * (var_52_12 / var_52_11)

				if var_52_13 > 0 and var_52_7 < var_52_13 then
					arg_49_1.talkMaxDuration = var_52_13

					if var_52_13 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_13 + var_52_6
					end
				end

				arg_49_1.text_.text = var_52_10
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_14 = math.max(var_52_7, arg_49_1.talkMaxDuration)

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_14 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_6) / var_52_14

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_6 + var_52_14 and arg_49_1.time_ < var_52_6 + var_52_14 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play420132013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 420132013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play420132014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1089ui_story"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos1089ui_story = var_56_0.localPosition
			end

			local var_56_2 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2
				local var_56_4 = Vector3.New(0, 100, 0)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1089ui_story, var_56_4, var_56_3)

				local var_56_5 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_5.x, var_56_5.y, var_56_5.z)

				local var_56_6 = var_56_0.localEulerAngles

				var_56_6.z = 0
				var_56_6.x = 0
				var_56_0.localEulerAngles = var_56_6
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 then
				var_56_0.localPosition = Vector3.New(0, 100, 0)

				local var_56_7 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_7.x, var_56_7.y, var_56_7.z)

				local var_56_8 = var_56_0.localEulerAngles

				var_56_8.z = 0
				var_56_8.x = 0
				var_56_0.localEulerAngles = var_56_8
			end

			local var_56_9 = 0
			local var_56_10 = 0.2

			if var_56_9 < arg_53_1.time_ and arg_53_1.time_ <= var_56_9 + arg_56_0 then
				local var_56_11 = "play"
				local var_56_12 = "music"

				arg_53_1:AudioAction(var_56_11, var_56_12, "ui_battle", "ui_battle_stopbgm", "")

				local var_56_13 = ""
				local var_56_14 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_56_14 ~= "" then
					if arg_53_1.bgmTxt_.text ~= var_56_14 and arg_53_1.bgmTxt_.text ~= "" then
						if arg_53_1.bgmTxt2_.text ~= "" then
							arg_53_1.bgmTxt_.text = arg_53_1.bgmTxt2_.text
						end

						arg_53_1.bgmTxt2_.text = var_56_14

						arg_53_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_53_1.bgmTxt_.text = var_56_14
						arg_53_1.bgmTxt2_.text = var_56_14
					end

					if arg_53_1.bgmTimer then
						arg_53_1.bgmTimer:Stop()

						arg_53_1.bgmTimer = nil
					end

					if arg_53_1.settingData.show_music_name == 1 then
						arg_53_1.musicController:SetSelectedState("show")
						arg_53_1.musicAnimator_:Play("open", 0, 0)

						if arg_53_1.settingData.music_time ~= 0 then
							arg_53_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_53_1.settingData.music_time), function()
								if arg_53_1 == nil or isNil(arg_53_1.bgmTxt_) then
									return
								end

								arg_53_1.musicController:SetSelectedState("hide")
								arg_53_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_56_15 = 0
			local var_56_16 = 0.875

			if var_56_15 < arg_53_1.time_ and arg_53_1.time_ <= var_56_15 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_17 = arg_53_1:GetWordFromCfg(420132013)
				local var_56_18 = arg_53_1:FormatText(var_56_17.content)

				arg_53_1.text_.text = var_56_18

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_19 = 35
				local var_56_20 = utf8.len(var_56_18)
				local var_56_21 = var_56_19 <= 0 and var_56_16 or var_56_16 * (var_56_20 / var_56_19)

				if var_56_21 > 0 and var_56_16 < var_56_21 then
					arg_53_1.talkMaxDuration = var_56_21

					if var_56_21 + var_56_15 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_21 + var_56_15
					end
				end

				arg_53_1.text_.text = var_56_18
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_22 = math.max(var_56_16, arg_53_1.talkMaxDuration)

			if var_56_15 <= arg_53_1.time_ and arg_53_1.time_ < var_56_15 + var_56_22 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_15) / var_56_22

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_15 + var_56_22 and arg_53_1.time_ < var_56_15 + var_56_22 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play420132014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 420132014
		arg_58_1.duration_ = 5.9

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play420132015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = "STblack"

			if arg_58_1.bgs_[var_61_0] == nil then
				local var_61_1 = Object.Instantiate(arg_58_1.paintGo_)

				var_61_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_61_0)
				var_61_1.name = var_61_0
				var_61_1.transform.parent = arg_58_1.stage_.transform
				var_61_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_58_1.bgs_[var_61_0] = var_61_1
			end

			local var_61_2 = 0

			if var_61_2 < arg_58_1.time_ and arg_58_1.time_ <= var_61_2 + arg_61_0 then
				local var_61_3 = manager.ui.mainCamera.transform.localPosition
				local var_61_4 = Vector3.New(0, 0, 10) + Vector3.New(var_61_3.x, var_61_3.y, 0)
				local var_61_5 = arg_58_1.bgs_.STblack

				var_61_5.transform.localPosition = var_61_4
				var_61_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_61_6 = var_61_5:GetComponent("SpriteRenderer")

				if var_61_6 and var_61_6.sprite then
					local var_61_7 = (var_61_5.transform.localPosition - var_61_3).z
					local var_61_8 = manager.ui.mainCameraCom_
					local var_61_9 = 2 * var_61_7 * Mathf.Tan(var_61_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_61_10 = var_61_9 * var_61_8.aspect
					local var_61_11 = var_61_6.sprite.bounds.size.x
					local var_61_12 = var_61_6.sprite.bounds.size.y
					local var_61_13 = var_61_10 / var_61_11
					local var_61_14 = var_61_9 / var_61_12
					local var_61_15 = var_61_14 < var_61_13 and var_61_13 or var_61_14

					var_61_5.transform.localScale = Vector3.New(var_61_15, var_61_15, 0)
				end

				for iter_61_0, iter_61_1 in pairs(arg_58_1.bgs_) do
					if iter_61_0 ~= "STblack" then
						iter_61_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_61_16 = 2

			if var_61_16 < arg_58_1.time_ and arg_58_1.time_ <= var_61_16 + arg_61_0 then
				arg_58_1.allBtn_.enabled = false
			end

			local var_61_17 = 0.3

			if arg_58_1.time_ >= var_61_16 + var_61_17 and arg_58_1.time_ < var_61_16 + var_61_17 + arg_61_0 then
				arg_58_1.allBtn_.enabled = true
			end

			local var_61_18 = 0

			if var_61_18 < arg_58_1.time_ and arg_58_1.time_ <= var_61_18 + arg_61_0 then
				arg_58_1.mask_.enabled = true
				arg_58_1.mask_.raycastTarget = true

				arg_58_1:SetGaussion(false)
			end

			local var_61_19 = 2

			if var_61_18 <= arg_58_1.time_ and arg_58_1.time_ < var_61_18 + var_61_19 then
				local var_61_20 = (arg_58_1.time_ - var_61_18) / var_61_19
				local var_61_21 = Color.New(0, 0, 0)

				var_61_21.a = Mathf.Lerp(1, 0, var_61_20)
				arg_58_1.mask_.color = var_61_21
			end

			if arg_58_1.time_ >= var_61_18 + var_61_19 and arg_58_1.time_ < var_61_18 + var_61_19 + arg_61_0 then
				local var_61_22 = Color.New(0, 0, 0)
				local var_61_23 = 0

				arg_58_1.mask_.enabled = false
				var_61_22.a = var_61_23
				arg_58_1.mask_.color = var_61_22
			end

			local var_61_24 = 0

			if var_61_24 < arg_58_1.time_ and arg_58_1.time_ <= var_61_24 + arg_61_0 then
				arg_58_1.cswbg_:SetActive(true)

				local var_61_25 = arg_58_1.cswt_:GetComponent("RectTransform")

				arg_58_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_61_25.offsetMin = Vector2.New(0, 0)
				var_61_25.offsetMax = Vector2.New(0, 130)

				local var_61_26 = arg_58_1:GetWordFromCfg(419150)
				local var_61_27 = arg_58_1:FormatText(var_61_26.content)

				arg_58_1.cswt_.text = var_61_27

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.cswt_)

				arg_58_1.cswt_.fontSize = 120
				arg_58_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_58_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_58_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_61_28 = 0

			if var_61_28 < arg_58_1.time_ and arg_58_1.time_ <= var_61_28 + arg_61_0 then
				arg_58_1.fswbg_:SetActive(true)
				arg_58_1.dialog_:SetActive(false)

				arg_58_1.fswtw_.percent = 0

				local var_61_29 = arg_58_1:GetWordFromCfg(420132014)
				local var_61_30 = arg_58_1:FormatText(var_61_29.content)

				arg_58_1.fswt_.text = var_61_30

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.fswt_)

				arg_58_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_58_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_58_1.fswtw_:SetDirty()

				arg_58_1.typewritterCharCountI18N = 0

				SetActive(arg_58_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_58_1:ShowNextGo(false)
			end

			local var_61_31 = 1.3

			if var_61_31 < arg_58_1.time_ and arg_58_1.time_ <= var_61_31 + arg_61_0 then
				arg_58_1.var_.oldValueTypewriter = arg_58_1.fswtw_.percent

				SetActive(arg_58_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_58_1:ShowNextGo(false)
			end

			local var_61_32 = 21
			local var_61_33 = 1.4
			local var_61_34 = arg_58_1:GetWordFromCfg(420132014)
			local var_61_35 = arg_58_1:FormatText(var_61_34.content)
			local var_61_36, var_61_37 = arg_58_1:GetPercentByPara(var_61_35, 1)

			if var_61_31 < arg_58_1.time_ and arg_58_1.time_ <= var_61_31 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0

				local var_61_38 = var_61_32 <= 0 and var_61_33 or var_61_33 * ((var_61_37 - arg_58_1.typewritterCharCountI18N) / var_61_32)

				if var_61_38 > 0 and var_61_33 < var_61_38 then
					arg_58_1.talkMaxDuration = var_61_38

					if var_61_38 + var_61_31 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_38 + var_61_31
					end
				end
			end

			local var_61_39 = 1.4
			local var_61_40 = math.max(var_61_39, arg_58_1.talkMaxDuration)

			if var_61_31 <= arg_58_1.time_ and arg_58_1.time_ < var_61_31 + var_61_40 then
				local var_61_41 = (arg_58_1.time_ - var_61_31) / var_61_40

				arg_58_1.fswtw_.percent = Mathf.Lerp(arg_58_1.var_.oldValueTypewriter, var_61_36, var_61_41)
				arg_58_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_58_1.fswtw_:SetDirty()
			end

			if arg_58_1.time_ >= var_61_31 + var_61_40 and arg_58_1.time_ < var_61_31 + var_61_40 + arg_61_0 then
				arg_58_1.fswtw_.percent = var_61_36

				arg_58_1.fswtw_:SetDirty()
				arg_58_1:ShowNextGo(true)

				arg_58_1.typewritterCharCountI18N = var_61_37
			end

			local var_61_42 = 0

			if var_61_42 < arg_58_1.time_ and arg_58_1.time_ <= var_61_42 + arg_61_0 then
				local var_61_43 = arg_58_1.fswbg_.transform:Find("textbox/adapt/content") or arg_58_1.fswbg_.transform:Find("textbox/content")
				local var_61_44 = arg_58_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_61_45 = var_61_43:GetComponent("Text")
				local var_61_46 = var_61_43:GetComponent("RectTransform")

				var_61_45.alignment = UnityEngine.TextAnchor.LowerCenter
				var_61_46.offsetMin = Vector2.New(0, -70)
				var_61_46.offsetMax = Vector2.New(0, 0)
			end

			local var_61_47 = 1.3
			local var_61_48 = 4.6
			local var_61_49 = manager.audio:GetVoiceLength("story_v_out_420132", "420132014", "story_v_out_420132.awb") / 1000

			if var_61_49 > 0 and var_61_48 < var_61_49 and var_61_49 + var_61_47 > arg_58_1.duration_ then
				local var_61_50 = var_61_49

				arg_58_1.duration_ = var_61_49 + var_61_47
			end

			if var_61_47 < arg_58_1.time_ and arg_58_1.time_ <= var_61_47 + arg_61_0 then
				local var_61_51 = "play"
				local var_61_52 = "voice"

				arg_58_1:AudioAction(var_61_51, var_61_52, "story_v_out_420132", "420132014", "story_v_out_420132.awb")
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play420132015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 420132015
		arg_62_1.duration_ = 2.6

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play420132016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0

			if var_65_0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_0 + arg_65_0 then
				arg_62_1.fswbg_:SetActive(true)
				arg_62_1.dialog_:SetActive(false)

				arg_62_1.fswtw_.percent = 0

				local var_65_1 = arg_62_1:GetWordFromCfg(420132015)
				local var_65_2 = arg_62_1:FormatText(var_65_1.content)

				arg_62_1.fswt_.text = var_65_2

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.fswt_)

				arg_62_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_62_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_62_1.fswtw_:SetDirty()

				arg_62_1.typewritterCharCountI18N = 0

				SetActive(arg_62_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_62_1:ShowNextGo(false)
			end

			local var_65_3 = 0.0666666666666669

			if var_65_3 < arg_62_1.time_ and arg_62_1.time_ <= var_65_3 + arg_65_0 then
				arg_62_1.var_.oldValueTypewriter = arg_62_1.fswtw_.percent

				SetActive(arg_62_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_62_1:ShowNextGo(false)
			end

			local var_65_4 = 38
			local var_65_5 = 2.53333333333333
			local var_65_6 = arg_62_1:GetWordFromCfg(420132015)
			local var_65_7 = arg_62_1:FormatText(var_65_6.content)
			local var_65_8, var_65_9 = arg_62_1:GetPercentByPara(var_65_7, 1)

			if var_65_3 < arg_62_1.time_ and arg_62_1.time_ <= var_65_3 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0

				local var_65_10 = var_65_4 <= 0 and var_65_5 or var_65_5 * ((var_65_9 - arg_62_1.typewritterCharCountI18N) / var_65_4)

				if var_65_10 > 0 and var_65_5 < var_65_10 then
					arg_62_1.talkMaxDuration = var_65_10

					if var_65_10 + var_65_3 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_10 + var_65_3
					end
				end
			end

			local var_65_11 = 2.53333333333333
			local var_65_12 = math.max(var_65_11, arg_62_1.talkMaxDuration)

			if var_65_3 <= arg_62_1.time_ and arg_62_1.time_ < var_65_3 + var_65_12 then
				local var_65_13 = (arg_62_1.time_ - var_65_3) / var_65_12

				arg_62_1.fswtw_.percent = Mathf.Lerp(arg_62_1.var_.oldValueTypewriter, var_65_8, var_65_13)
				arg_62_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_62_1.fswtw_:SetDirty()
			end

			if arg_62_1.time_ >= var_65_3 + var_65_12 and arg_62_1.time_ < var_65_3 + var_65_12 + arg_65_0 then
				arg_62_1.fswtw_.percent = var_65_8

				arg_62_1.fswtw_:SetDirty()
				arg_62_1:ShowNextGo(true)

				arg_62_1.typewritterCharCountI18N = var_65_9
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play420132016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 420132016
		arg_66_1.duration_ = 8.37

		local var_66_0 = {
			zh = 7.6,
			ja = 8.366
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
				arg_66_0:Play420132017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = "ST67"

			if arg_66_1.bgs_[var_69_0] == nil then
				local var_69_1 = Object.Instantiate(arg_66_1.paintGo_)

				var_69_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_69_0)
				var_69_1.name = var_69_0
				var_69_1.transform.parent = arg_66_1.stage_.transform
				var_69_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_66_1.bgs_[var_69_0] = var_69_1
			end

			local var_69_2 = 0

			if var_69_2 < arg_66_1.time_ and arg_66_1.time_ <= var_69_2 + arg_69_0 then
				local var_69_3 = manager.ui.mainCamera.transform.localPosition
				local var_69_4 = Vector3.New(0, 0, 10) + Vector3.New(var_69_3.x, var_69_3.y, 0)
				local var_69_5 = arg_66_1.bgs_.ST67

				var_69_5.transform.localPosition = var_69_4
				var_69_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_69_6 = var_69_5:GetComponent("SpriteRenderer")

				if var_69_6 and var_69_6.sprite then
					local var_69_7 = (var_69_5.transform.localPosition - var_69_3).z
					local var_69_8 = manager.ui.mainCameraCom_
					local var_69_9 = 2 * var_69_7 * Mathf.Tan(var_69_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_69_10 = var_69_9 * var_69_8.aspect
					local var_69_11 = var_69_6.sprite.bounds.size.x
					local var_69_12 = var_69_6.sprite.bounds.size.y
					local var_69_13 = var_69_10 / var_69_11
					local var_69_14 = var_69_9 / var_69_12
					local var_69_15 = var_69_14 < var_69_13 and var_69_13 or var_69_14

					var_69_5.transform.localScale = Vector3.New(var_69_15, var_69_15, 0)
				end

				for iter_69_0, iter_69_1 in pairs(arg_66_1.bgs_) do
					if iter_69_0 ~= "ST67" then
						iter_69_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_69_16 = 2

			if var_69_16 < arg_66_1.time_ and arg_66_1.time_ <= var_69_16 + arg_69_0 then
				arg_66_1.allBtn_.enabled = false
			end

			local var_69_17 = 0.3

			if arg_66_1.time_ >= var_69_16 + var_69_17 and arg_66_1.time_ < var_69_16 + var_69_17 + arg_69_0 then
				arg_66_1.allBtn_.enabled = true
			end

			local var_69_18 = 0

			if var_69_18 < arg_66_1.time_ and arg_66_1.time_ <= var_69_18 + arg_69_0 then
				arg_66_1.mask_.enabled = true
				arg_66_1.mask_.raycastTarget = true

				arg_66_1:SetGaussion(false)
			end

			local var_69_19 = 2

			if var_69_18 <= arg_66_1.time_ and arg_66_1.time_ < var_69_18 + var_69_19 then
				local var_69_20 = (arg_66_1.time_ - var_69_18) / var_69_19
				local var_69_21 = Color.New(0, 0, 0)

				var_69_21.a = Mathf.Lerp(1, 0, var_69_20)
				arg_66_1.mask_.color = var_69_21
			end

			if arg_66_1.time_ >= var_69_18 + var_69_19 and arg_66_1.time_ < var_69_18 + var_69_19 + arg_69_0 then
				local var_69_22 = Color.New(0, 0, 0)
				local var_69_23 = 0

				arg_66_1.mask_.enabled = false
				var_69_22.a = var_69_23
				arg_66_1.mask_.color = var_69_22
			end

			local var_69_24 = "1061ui_story"

			if arg_66_1.actors_[var_69_24] == nil then
				local var_69_25 = Asset.Load("Char/" .. "1061ui_story")

				if not isNil(var_69_25) then
					local var_69_26 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_66_1.stage_.transform)

					var_69_26.name = var_69_24
					var_69_26.transform.localPosition = Vector3.New(0, 100, 0)
					arg_66_1.actors_[var_69_24] = var_69_26

					local var_69_27 = var_69_26:GetComponentInChildren(typeof(CharacterEffect))

					var_69_27.enabled = true

					local var_69_28 = GameObjectTools.GetOrAddComponent(var_69_26, typeof(DynamicBoneHelper))

					if var_69_28 then
						var_69_28:EnableDynamicBone(false)
					end

					arg_66_1:ShowWeapon(var_69_27.transform, false)

					arg_66_1.var_[var_69_24 .. "Animator"] = var_69_27.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_66_1.var_[var_69_24 .. "Animator"].applyRootMotion = true
					arg_66_1.var_[var_69_24 .. "LipSync"] = var_69_27.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_69_29 = arg_66_1.actors_["1061ui_story"].transform
			local var_69_30 = 1.86666666666667

			if var_69_30 < arg_66_1.time_ and arg_66_1.time_ <= var_69_30 + arg_69_0 then
				arg_66_1.var_.moveOldPos1061ui_story = var_69_29.localPosition
			end

			local var_69_31 = 0.001

			if var_69_30 <= arg_66_1.time_ and arg_66_1.time_ < var_69_30 + var_69_31 then
				local var_69_32 = (arg_66_1.time_ - var_69_30) / var_69_31
				local var_69_33 = Vector3.New(0, -1.18, -6.15)

				var_69_29.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1061ui_story, var_69_33, var_69_32)

				local var_69_34 = manager.ui.mainCamera.transform.position - var_69_29.position

				var_69_29.forward = Vector3.New(var_69_34.x, var_69_34.y, var_69_34.z)

				local var_69_35 = var_69_29.localEulerAngles

				var_69_35.z = 0
				var_69_35.x = 0
				var_69_29.localEulerAngles = var_69_35
			end

			if arg_66_1.time_ >= var_69_30 + var_69_31 and arg_66_1.time_ < var_69_30 + var_69_31 + arg_69_0 then
				var_69_29.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_69_36 = manager.ui.mainCamera.transform.position - var_69_29.position

				var_69_29.forward = Vector3.New(var_69_36.x, var_69_36.y, var_69_36.z)

				local var_69_37 = var_69_29.localEulerAngles

				var_69_37.z = 0
				var_69_37.x = 0
				var_69_29.localEulerAngles = var_69_37
			end

			local var_69_38 = arg_66_1.actors_["1061ui_story"]
			local var_69_39 = 1.86666666666667

			if var_69_39 < arg_66_1.time_ and arg_66_1.time_ <= var_69_39 + arg_69_0 and not isNil(var_69_38) and arg_66_1.var_.characterEffect1061ui_story == nil then
				arg_66_1.var_.characterEffect1061ui_story = var_69_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_40 = 0.200000002980232

			if var_69_39 <= arg_66_1.time_ and arg_66_1.time_ < var_69_39 + var_69_40 and not isNil(var_69_38) then
				local var_69_41 = (arg_66_1.time_ - var_69_39) / var_69_40

				if arg_66_1.var_.characterEffect1061ui_story and not isNil(var_69_38) then
					arg_66_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= var_69_39 + var_69_40 and arg_66_1.time_ < var_69_39 + var_69_40 + arg_69_0 and not isNil(var_69_38) and arg_66_1.var_.characterEffect1061ui_story then
				arg_66_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_69_42 = 1.86666666666667

			if var_69_42 < arg_66_1.time_ and arg_66_1.time_ <= var_69_42 + arg_69_0 then
				arg_66_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			local var_69_43 = 1.86666666666667

			if var_69_43 < arg_66_1.time_ and arg_66_1.time_ <= var_69_43 + arg_69_0 then
				arg_66_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_69_44 = 0

			if var_69_44 < arg_66_1.time_ and arg_66_1.time_ <= var_69_44 + arg_69_0 then
				arg_66_1.fswbg_:SetActive(false)
				arg_66_1.dialog_:SetActive(false)
				SetActive(arg_66_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_66_1:ShowNextGo(false)
			end

			local var_69_45 = 0

			if var_69_45 < arg_66_1.time_ and arg_66_1.time_ <= var_69_45 + arg_69_0 then
				arg_66_1.cswbg_:SetActive(false)
			end

			local var_69_46 = 0
			local var_69_47 = 0.2

			if var_69_46 < arg_66_1.time_ and arg_66_1.time_ <= var_69_46 + arg_69_0 then
				local var_69_48 = "play"
				local var_69_49 = "music"

				arg_66_1:AudioAction(var_69_48, var_69_49, "ui_battle", "ui_battle_stopbgm", "")

				local var_69_50 = ""
				local var_69_51 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_69_51 ~= "" then
					if arg_66_1.bgmTxt_.text ~= var_69_51 and arg_66_1.bgmTxt_.text ~= "" then
						if arg_66_1.bgmTxt2_.text ~= "" then
							arg_66_1.bgmTxt_.text = arg_66_1.bgmTxt2_.text
						end

						arg_66_1.bgmTxt2_.text = var_69_51

						arg_66_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_66_1.bgmTxt_.text = var_69_51
						arg_66_1.bgmTxt2_.text = var_69_51
					end

					if arg_66_1.bgmTimer then
						arg_66_1.bgmTimer:Stop()

						arg_66_1.bgmTimer = nil
					end

					if arg_66_1.settingData.show_music_name == 1 then
						arg_66_1.musicController:SetSelectedState("show")
						arg_66_1.musicAnimator_:Play("open", 0, 0)

						if arg_66_1.settingData.music_time ~= 0 then
							arg_66_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_66_1.settingData.music_time), function()
								if arg_66_1 == nil or isNil(arg_66_1.bgmTxt_) then
									return
								end

								arg_66_1.musicController:SetSelectedState("hide")
								arg_66_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_69_52 = 0.333333333333333
			local var_69_53 = 1

			if var_69_52 < arg_66_1.time_ and arg_66_1.time_ <= var_69_52 + arg_69_0 then
				local var_69_54 = "play"
				local var_69_55 = "music"

				arg_66_1:AudioAction(var_69_54, var_69_55, "bgm_activity_4_0_story_lab", "bgm_activity_4_0_story_lab", "bgm_activity_4_0_story_lab.awb")

				local var_69_56 = ""
				local var_69_57 = manager.audio:GetAudioName("bgm_activity_4_0_story_lab", "bgm_activity_4_0_story_lab")

				if var_69_57 ~= "" then
					if arg_66_1.bgmTxt_.text ~= var_69_57 and arg_66_1.bgmTxt_.text ~= "" then
						if arg_66_1.bgmTxt2_.text ~= "" then
							arg_66_1.bgmTxt_.text = arg_66_1.bgmTxt2_.text
						end

						arg_66_1.bgmTxt2_.text = var_69_57

						arg_66_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_66_1.bgmTxt_.text = var_69_57
						arg_66_1.bgmTxt2_.text = var_69_57
					end

					if arg_66_1.bgmTimer then
						arg_66_1.bgmTimer:Stop()

						arg_66_1.bgmTimer = nil
					end

					if arg_66_1.settingData.show_music_name == 1 then
						arg_66_1.musicController:SetSelectedState("show")
						arg_66_1.musicAnimator_:Play("open", 0, 0)

						if arg_66_1.settingData.music_time ~= 0 then
							arg_66_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_66_1.settingData.music_time), function()
								if arg_66_1 == nil or isNil(arg_66_1.bgmTxt_) then
									return
								end

								arg_66_1.musicController:SetSelectedState("hide")
								arg_66_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_69_58 = 0.3
			local var_69_59 = 1

			if var_69_58 < arg_66_1.time_ and arg_66_1.time_ <= var_69_58 + arg_69_0 then
				local var_69_60 = "play"
				local var_69_61 = "effect"

				arg_66_1:AudioAction(var_69_60, var_69_61, "se_story_140", "se_story_140_amb_lab", "")
			end

			if arg_66_1.frameCnt_ <= 1 then
				arg_66_1.dialog_:SetActive(false)
			end

			local var_69_62 = 2
			local var_69_63 = 0.4

			if var_69_62 < arg_66_1.time_ and arg_66_1.time_ <= var_69_62 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0

				arg_66_1.dialog_:SetActive(true)

				arg_66_1.dialogCg_.alpha = 0

				local var_69_64 = LeanTween.value(arg_66_1.dialog_, 0, 1, 0.3)

				var_69_64:setOnUpdate(LuaHelper.FloatAction(function(arg_72_0)
					arg_66_1.dialogCg_.alpha = arg_72_0
				end))
				var_69_64:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_66_1.dialog_)
					var_69_64:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_66_1.duration_ = arg_66_1.duration_ + 0.3

				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_65 = arg_66_1:FormatText(StoryNameCfg[612].name)

				arg_66_1.leftNameTxt_.text = var_69_65

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_66 = arg_66_1:GetWordFromCfg(420132016)
				local var_69_67 = arg_66_1:FormatText(var_69_66.content)

				arg_66_1.text_.text = var_69_67

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_68 = 16
				local var_69_69 = utf8.len(var_69_67)
				local var_69_70 = var_69_68 <= 0 and var_69_63 or var_69_63 * (var_69_69 / var_69_68)

				if var_69_70 > 0 and var_69_63 < var_69_70 then
					arg_66_1.talkMaxDuration = var_69_70
					var_69_62 = var_69_62 + 0.3

					if var_69_70 + var_69_62 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_70 + var_69_62
					end
				end

				arg_66_1.text_.text = var_69_67
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132016", "story_v_out_420132.awb") ~= 0 then
					local var_69_71 = manager.audio:GetVoiceLength("story_v_out_420132", "420132016", "story_v_out_420132.awb") / 1000

					if var_69_71 + var_69_62 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_71 + var_69_62
					end

					if var_69_66.prefab_name ~= "" and arg_66_1.actors_[var_69_66.prefab_name] ~= nil then
						local var_69_72 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_66.prefab_name].transform, "story_v_out_420132", "420132016", "story_v_out_420132.awb")

						arg_66_1:RecordAudio("420132016", var_69_72)
						arg_66_1:RecordAudio("420132016", var_69_72)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_420132", "420132016", "story_v_out_420132.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_420132", "420132016", "story_v_out_420132.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_73 = var_69_62 + 0.3
			local var_69_74 = math.max(var_69_63, arg_66_1.talkMaxDuration)

			if var_69_73 <= arg_66_1.time_ and arg_66_1.time_ < var_69_73 + var_69_74 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_73) / var_69_74

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_73 + var_69_74 and arg_66_1.time_ < var_69_73 + var_69_74 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.86666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play420132017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 420132017
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play420132018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["1061ui_story"].transform
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 then
				arg_74_1.var_.moveOldPos1061ui_story = var_77_0.localPosition
			end

			local var_77_2 = 0.001

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_2 then
				local var_77_3 = (arg_74_1.time_ - var_77_1) / var_77_2
				local var_77_4 = Vector3.New(0, 100, 0)

				var_77_0.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos1061ui_story, var_77_4, var_77_3)

				local var_77_5 = manager.ui.mainCamera.transform.position - var_77_0.position

				var_77_0.forward = Vector3.New(var_77_5.x, var_77_5.y, var_77_5.z)

				local var_77_6 = var_77_0.localEulerAngles

				var_77_6.z = 0
				var_77_6.x = 0
				var_77_0.localEulerAngles = var_77_6
			end

			if arg_74_1.time_ >= var_77_1 + var_77_2 and arg_74_1.time_ < var_77_1 + var_77_2 + arg_77_0 then
				var_77_0.localPosition = Vector3.New(0, 100, 0)

				local var_77_7 = manager.ui.mainCamera.transform.position - var_77_0.position

				var_77_0.forward = Vector3.New(var_77_7.x, var_77_7.y, var_77_7.z)

				local var_77_8 = var_77_0.localEulerAngles

				var_77_8.z = 0
				var_77_8.x = 0
				var_77_0.localEulerAngles = var_77_8
			end

			local var_77_9 = 0
			local var_77_10 = 1.225

			if var_77_9 < arg_74_1.time_ and arg_74_1.time_ <= var_77_9 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, false)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_11 = arg_74_1:GetWordFromCfg(420132017)
				local var_77_12 = arg_74_1:FormatText(var_77_11.content)

				arg_74_1.text_.text = var_77_12

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_13 = 49
				local var_77_14 = utf8.len(var_77_12)
				local var_77_15 = var_77_13 <= 0 and var_77_10 or var_77_10 * (var_77_14 / var_77_13)

				if var_77_15 > 0 and var_77_10 < var_77_15 then
					arg_74_1.talkMaxDuration = var_77_15

					if var_77_15 + var_77_9 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_15 + var_77_9
					end
				end

				arg_74_1.text_.text = var_77_12
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_16 = math.max(var_77_10, arg_74_1.talkMaxDuration)

			if var_77_9 <= arg_74_1.time_ and arg_74_1.time_ < var_77_9 + var_77_16 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_9) / var_77_16

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_9 + var_77_16 and arg_74_1.time_ < var_77_9 + var_77_16 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {
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

		arg_74_1:InitPlayNodeList()
	end,
	Play420132018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 420132018
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play420132019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0
			local var_81_1 = 1.075

			if var_81_0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_2 = arg_78_1:FormatText(StoryNameCfg[7].name)

				arg_78_1.leftNameTxt_.text = var_81_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, true)
				arg_78_1.iconController_:SetSelectedState("hero")

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_78_1.callingController_:SetSelectedState("normal")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_3 = arg_78_1:GetWordFromCfg(420132018)
				local var_81_4 = arg_78_1:FormatText(var_81_3.content)

				arg_78_1.text_.text = var_81_4

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_5 = 43
				local var_81_6 = utf8.len(var_81_4)
				local var_81_7 = var_81_5 <= 0 and var_81_1 or var_81_1 * (var_81_6 / var_81_5)

				if var_81_7 > 0 and var_81_1 < var_81_7 then
					arg_78_1.talkMaxDuration = var_81_7

					if var_81_7 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_7 + var_81_0
					end
				end

				arg_78_1.text_.text = var_81_4
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_8 = math.max(var_81_1, arg_78_1.talkMaxDuration)

			if var_81_0 <= arg_78_1.time_ and arg_78_1.time_ < var_81_0 + var_81_8 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_0) / var_81_8

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_0 + var_81_8 and arg_78_1.time_ < var_81_0 + var_81_8 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play420132019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 420132019
		arg_82_1.duration_ = 3.27

		local var_82_0 = {
			zh = 2.366,
			ja = 3.266
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play420132020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["1061ui_story"].transform
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 then
				arg_82_1.var_.moveOldPos1061ui_story = var_85_0.localPosition
			end

			local var_85_2 = 0.001

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2
				local var_85_4 = Vector3.New(0, -1.18, -6.15)

				var_85_0.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos1061ui_story, var_85_4, var_85_3)

				local var_85_5 = manager.ui.mainCamera.transform.position - var_85_0.position

				var_85_0.forward = Vector3.New(var_85_5.x, var_85_5.y, var_85_5.z)

				local var_85_6 = var_85_0.localEulerAngles

				var_85_6.z = 0
				var_85_6.x = 0
				var_85_0.localEulerAngles = var_85_6
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 then
				var_85_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_85_7 = manager.ui.mainCamera.transform.position - var_85_0.position

				var_85_0.forward = Vector3.New(var_85_7.x, var_85_7.y, var_85_7.z)

				local var_85_8 = var_85_0.localEulerAngles

				var_85_8.z = 0
				var_85_8.x = 0
				var_85_0.localEulerAngles = var_85_8
			end

			local var_85_9 = arg_82_1.actors_["1061ui_story"]
			local var_85_10 = 0

			if var_85_10 < arg_82_1.time_ and arg_82_1.time_ <= var_85_10 + arg_85_0 and not isNil(var_85_9) and arg_82_1.var_.characterEffect1061ui_story == nil then
				arg_82_1.var_.characterEffect1061ui_story = var_85_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_11 = 0.200000002980232

			if var_85_10 <= arg_82_1.time_ and arg_82_1.time_ < var_85_10 + var_85_11 and not isNil(var_85_9) then
				local var_85_12 = (arg_82_1.time_ - var_85_10) / var_85_11

				if arg_82_1.var_.characterEffect1061ui_story and not isNil(var_85_9) then
					arg_82_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= var_85_10 + var_85_11 and arg_82_1.time_ < var_85_10 + var_85_11 + arg_85_0 and not isNil(var_85_9) and arg_82_1.var_.characterEffect1061ui_story then
				arg_82_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_85_13 = 0

			if var_85_13 < arg_82_1.time_ and arg_82_1.time_ <= var_85_13 + arg_85_0 then
				arg_82_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_1")
			end

			local var_85_14 = 0

			if var_85_14 < arg_82_1.time_ and arg_82_1.time_ <= var_85_14 + arg_85_0 then
				arg_82_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva", "EmotionTimelineAnimator")
			end

			local var_85_15 = 0
			local var_85_16 = 0.3

			if var_85_15 < arg_82_1.time_ and arg_82_1.time_ <= var_85_15 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_17 = arg_82_1:FormatText(StoryNameCfg[612].name)

				arg_82_1.leftNameTxt_.text = var_85_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_18 = arg_82_1:GetWordFromCfg(420132019)
				local var_85_19 = arg_82_1:FormatText(var_85_18.content)

				arg_82_1.text_.text = var_85_19

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_20 = 12
				local var_85_21 = utf8.len(var_85_19)
				local var_85_22 = var_85_20 <= 0 and var_85_16 or var_85_16 * (var_85_21 / var_85_20)

				if var_85_22 > 0 and var_85_16 < var_85_22 then
					arg_82_1.talkMaxDuration = var_85_22

					if var_85_22 + var_85_15 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_22 + var_85_15
					end
				end

				arg_82_1.text_.text = var_85_19
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132019", "story_v_out_420132.awb") ~= 0 then
					local var_85_23 = manager.audio:GetVoiceLength("story_v_out_420132", "420132019", "story_v_out_420132.awb") / 1000

					if var_85_23 + var_85_15 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_23 + var_85_15
					end

					if var_85_18.prefab_name ~= "" and arg_82_1.actors_[var_85_18.prefab_name] ~= nil then
						local var_85_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_18.prefab_name].transform, "story_v_out_420132", "420132019", "story_v_out_420132.awb")

						arg_82_1:RecordAudio("420132019", var_85_24)
						arg_82_1:RecordAudio("420132019", var_85_24)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_420132", "420132019", "story_v_out_420132.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_420132", "420132019", "story_v_out_420132.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_25 = math.max(var_85_16, arg_82_1.talkMaxDuration)

			if var_85_15 <= arg_82_1.time_ and arg_82_1.time_ < var_85_15 + var_85_25 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_15) / var_85_25

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_15 + var_85_25 and arg_82_1.time_ < var_85_15 + var_85_25 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
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

		arg_82_1:InitPlayNodeList()
	end,
	Play420132020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 420132020
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play420132021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["1061ui_story"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect1061ui_story == nil then
				arg_86_1.var_.characterEffect1061ui_story = var_89_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_2 = 0.200000002980232

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.characterEffect1061ui_story and not isNil(var_89_0) then
					local var_89_4 = Mathf.Lerp(0, 0.5, var_89_3)

					arg_86_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_86_1.var_.characterEffect1061ui_story.fillRatio = var_89_4
				end
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect1061ui_story then
				local var_89_5 = 0.5

				arg_86_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_86_1.var_.characterEffect1061ui_story.fillRatio = var_89_5
			end

			local var_89_6 = 0
			local var_89_7 = 1.025

			if var_89_6 < arg_86_1.time_ and arg_86_1.time_ <= var_89_6 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_8 = arg_86_1:FormatText(StoryNameCfg[7].name)

				arg_86_1.leftNameTxt_.text = var_89_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, true)
				arg_86_1.iconController_:SetSelectedState("hero")

				arg_86_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_86_1.callingController_:SetSelectedState("normal")

				arg_86_1.keyicon_.color = Color.New(1, 1, 1)
				arg_86_1.icon_.color = Color.New(1, 1, 1)

				local var_89_9 = arg_86_1:GetWordFromCfg(420132020)
				local var_89_10 = arg_86_1:FormatText(var_89_9.content)

				arg_86_1.text_.text = var_89_10

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_11 = 41
				local var_89_12 = utf8.len(var_89_10)
				local var_89_13 = var_89_11 <= 0 and var_89_7 or var_89_7 * (var_89_12 / var_89_11)

				if var_89_13 > 0 and var_89_7 < var_89_13 then
					arg_86_1.talkMaxDuration = var_89_13

					if var_89_13 + var_89_6 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_13 + var_89_6
					end
				end

				arg_86_1.text_.text = var_89_10
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_14 = math.max(var_89_7, arg_86_1.talkMaxDuration)

			if var_89_6 <= arg_86_1.time_ and arg_86_1.time_ < var_89_6 + var_89_14 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_6) / var_89_14

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_6 + var_89_14 and arg_86_1.time_ < var_89_6 + var_89_14 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play420132021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 420132021
		arg_90_1.duration_ = 4.87

		local var_90_0 = {
			zh = 3.8,
			ja = 4.866
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play420132022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["1061ui_story"]
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect1061ui_story == nil then
				arg_90_1.var_.characterEffect1061ui_story = var_93_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_2 = 0.200000002980232

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 and not isNil(var_93_0) then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2

				if arg_90_1.var_.characterEffect1061ui_story and not isNil(var_93_0) then
					arg_90_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect1061ui_story then
				arg_90_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_93_4 = 0
			local var_93_5 = 0.45

			if var_93_4 < arg_90_1.time_ and arg_90_1.time_ <= var_93_4 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_6 = arg_90_1:FormatText(StoryNameCfg[612].name)

				arg_90_1.leftNameTxt_.text = var_93_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_7 = arg_90_1:GetWordFromCfg(420132021)
				local var_93_8 = arg_90_1:FormatText(var_93_7.content)

				arg_90_1.text_.text = var_93_8

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_9 = 17
				local var_93_10 = utf8.len(var_93_8)
				local var_93_11 = var_93_9 <= 0 and var_93_5 or var_93_5 * (var_93_10 / var_93_9)

				if var_93_11 > 0 and var_93_5 < var_93_11 then
					arg_90_1.talkMaxDuration = var_93_11

					if var_93_11 + var_93_4 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_11 + var_93_4
					end
				end

				arg_90_1.text_.text = var_93_8
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132021", "story_v_out_420132.awb") ~= 0 then
					local var_93_12 = manager.audio:GetVoiceLength("story_v_out_420132", "420132021", "story_v_out_420132.awb") / 1000

					if var_93_12 + var_93_4 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_12 + var_93_4
					end

					if var_93_7.prefab_name ~= "" and arg_90_1.actors_[var_93_7.prefab_name] ~= nil then
						local var_93_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_7.prefab_name].transform, "story_v_out_420132", "420132021", "story_v_out_420132.awb")

						arg_90_1:RecordAudio("420132021", var_93_13)
						arg_90_1:RecordAudio("420132021", var_93_13)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_420132", "420132021", "story_v_out_420132.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_420132", "420132021", "story_v_out_420132.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_14 = math.max(var_93_5, arg_90_1.talkMaxDuration)

			if var_93_4 <= arg_90_1.time_ and arg_90_1.time_ < var_93_4 + var_93_14 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_4) / var_93_14

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_4 + var_93_14 and arg_90_1.time_ < var_93_4 + var_93_14 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play420132022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 420132022
		arg_94_1.duration_ = 13.17

		local var_94_0 = {
			zh = 7.7,
			ja = 13.166
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play420132023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_2")
			end

			local var_97_1 = 0
			local var_97_2 = 0.925

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_3 = arg_94_1:FormatText(StoryNameCfg[612].name)

				arg_94_1.leftNameTxt_.text = var_97_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_4 = arg_94_1:GetWordFromCfg(420132022)
				local var_97_5 = arg_94_1:FormatText(var_97_4.content)

				arg_94_1.text_.text = var_97_5

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_6 = 37
				local var_97_7 = utf8.len(var_97_5)
				local var_97_8 = var_97_6 <= 0 and var_97_2 or var_97_2 * (var_97_7 / var_97_6)

				if var_97_8 > 0 and var_97_2 < var_97_8 then
					arg_94_1.talkMaxDuration = var_97_8

					if var_97_8 + var_97_1 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_8 + var_97_1
					end
				end

				arg_94_1.text_.text = var_97_5
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132022", "story_v_out_420132.awb") ~= 0 then
					local var_97_9 = manager.audio:GetVoiceLength("story_v_out_420132", "420132022", "story_v_out_420132.awb") / 1000

					if var_97_9 + var_97_1 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_9 + var_97_1
					end

					if var_97_4.prefab_name ~= "" and arg_94_1.actors_[var_97_4.prefab_name] ~= nil then
						local var_97_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_4.prefab_name].transform, "story_v_out_420132", "420132022", "story_v_out_420132.awb")

						arg_94_1:RecordAudio("420132022", var_97_10)
						arg_94_1:RecordAudio("420132022", var_97_10)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_420132", "420132022", "story_v_out_420132.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_420132", "420132022", "story_v_out_420132.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_11 = math.max(var_97_2, arg_94_1.talkMaxDuration)

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_11 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_1) / var_97_11

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_1 + var_97_11 and arg_94_1.time_ < var_97_1 + var_97_11 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play420132023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 420132023
		arg_98_1.duration_ = 13.77

		local var_98_0 = {
			zh = 11.733,
			ja = 13.766
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play420132024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0
			local var_101_1 = 1.275

			if var_101_0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_2 = arg_98_1:FormatText(StoryNameCfg[612].name)

				arg_98_1.leftNameTxt_.text = var_101_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_3 = arg_98_1:GetWordFromCfg(420132023)
				local var_101_4 = arg_98_1:FormatText(var_101_3.content)

				arg_98_1.text_.text = var_101_4

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_5 = 51
				local var_101_6 = utf8.len(var_101_4)
				local var_101_7 = var_101_5 <= 0 and var_101_1 or var_101_1 * (var_101_6 / var_101_5)

				if var_101_7 > 0 and var_101_1 < var_101_7 then
					arg_98_1.talkMaxDuration = var_101_7

					if var_101_7 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_7 + var_101_0
					end
				end

				arg_98_1.text_.text = var_101_4
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132023", "story_v_out_420132.awb") ~= 0 then
					local var_101_8 = manager.audio:GetVoiceLength("story_v_out_420132", "420132023", "story_v_out_420132.awb") / 1000

					if var_101_8 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_8 + var_101_0
					end

					if var_101_3.prefab_name ~= "" and arg_98_1.actors_[var_101_3.prefab_name] ~= nil then
						local var_101_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_3.prefab_name].transform, "story_v_out_420132", "420132023", "story_v_out_420132.awb")

						arg_98_1:RecordAudio("420132023", var_101_9)
						arg_98_1:RecordAudio("420132023", var_101_9)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_420132", "420132023", "story_v_out_420132.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_420132", "420132023", "story_v_out_420132.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_10 = math.max(var_101_1, arg_98_1.talkMaxDuration)

			if var_101_0 <= arg_98_1.time_ and arg_98_1.time_ < var_101_0 + var_101_10 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_0) / var_101_10

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_0 + var_101_10 and arg_98_1.time_ < var_101_0 + var_101_10 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play420132024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 420132024
		arg_102_1.duration_ = 9.8

		local var_102_0 = {
			zh = 5.8,
			ja = 9.8
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play420132025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0
			local var_105_1 = 0.75

			if var_105_0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_2 = arg_102_1:FormatText(StoryNameCfg[612].name)

				arg_102_1.leftNameTxt_.text = var_105_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_3 = arg_102_1:GetWordFromCfg(420132024)
				local var_105_4 = arg_102_1:FormatText(var_105_3.content)

				arg_102_1.text_.text = var_105_4

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_5 = 30
				local var_105_6 = utf8.len(var_105_4)
				local var_105_7 = var_105_5 <= 0 and var_105_1 or var_105_1 * (var_105_6 / var_105_5)

				if var_105_7 > 0 and var_105_1 < var_105_7 then
					arg_102_1.talkMaxDuration = var_105_7

					if var_105_7 + var_105_0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_7 + var_105_0
					end
				end

				arg_102_1.text_.text = var_105_4
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132024", "story_v_out_420132.awb") ~= 0 then
					local var_105_8 = manager.audio:GetVoiceLength("story_v_out_420132", "420132024", "story_v_out_420132.awb") / 1000

					if var_105_8 + var_105_0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_8 + var_105_0
					end

					if var_105_3.prefab_name ~= "" and arg_102_1.actors_[var_105_3.prefab_name] ~= nil then
						local var_105_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_3.prefab_name].transform, "story_v_out_420132", "420132024", "story_v_out_420132.awb")

						arg_102_1:RecordAudio("420132024", var_105_9)
						arg_102_1:RecordAudio("420132024", var_105_9)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_420132", "420132024", "story_v_out_420132.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_420132", "420132024", "story_v_out_420132.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_10 = math.max(var_105_1, arg_102_1.talkMaxDuration)

			if var_105_0 <= arg_102_1.time_ and arg_102_1.time_ < var_105_0 + var_105_10 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_0) / var_105_10

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_0 + var_105_10 and arg_102_1.time_ < var_105_0 + var_105_10 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play420132025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 420132025
		arg_106_1.duration_ = 7.63

		local var_106_0 = {
			zh = 5.233,
			ja = 7.633
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play420132026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0

			if var_109_0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				arg_106_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_1")
			end

			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 then
				arg_106_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_109_2 = 0
			local var_109_3 = 0.65

			if var_109_2 < arg_106_1.time_ and arg_106_1.time_ <= var_109_2 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_4 = arg_106_1:FormatText(StoryNameCfg[612].name)

				arg_106_1.leftNameTxt_.text = var_109_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_5 = arg_106_1:GetWordFromCfg(420132025)
				local var_109_6 = arg_106_1:FormatText(var_109_5.content)

				arg_106_1.text_.text = var_109_6

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_7 = 26
				local var_109_8 = utf8.len(var_109_6)
				local var_109_9 = var_109_7 <= 0 and var_109_3 or var_109_3 * (var_109_8 / var_109_7)

				if var_109_9 > 0 and var_109_3 < var_109_9 then
					arg_106_1.talkMaxDuration = var_109_9

					if var_109_9 + var_109_2 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_9 + var_109_2
					end
				end

				arg_106_1.text_.text = var_109_6
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132025", "story_v_out_420132.awb") ~= 0 then
					local var_109_10 = manager.audio:GetVoiceLength("story_v_out_420132", "420132025", "story_v_out_420132.awb") / 1000

					if var_109_10 + var_109_2 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_10 + var_109_2
					end

					if var_109_5.prefab_name ~= "" and arg_106_1.actors_[var_109_5.prefab_name] ~= nil then
						local var_109_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_5.prefab_name].transform, "story_v_out_420132", "420132025", "story_v_out_420132.awb")

						arg_106_1:RecordAudio("420132025", var_109_11)
						arg_106_1:RecordAudio("420132025", var_109_11)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_420132", "420132025", "story_v_out_420132.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_420132", "420132025", "story_v_out_420132.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_12 = math.max(var_109_3, arg_106_1.talkMaxDuration)

			if var_109_2 <= arg_106_1.time_ and arg_106_1.time_ < var_109_2 + var_109_12 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_2) / var_109_12

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_2 + var_109_12 and arg_106_1.time_ < var_109_2 + var_109_12 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play420132026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 420132026
		arg_110_1.duration_ = 9.7

		local var_110_0 = {
			zh = 6.033,
			ja = 9.7
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play420132027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["1061ui_story"].transform
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 then
				arg_110_1.var_.moveOldPos1061ui_story = var_113_0.localPosition
			end

			local var_113_2 = 0.001

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2
				local var_113_4 = Vector3.New(-0.7, -1.18, -6.15)

				var_113_0.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1061ui_story, var_113_4, var_113_3)

				local var_113_5 = manager.ui.mainCamera.transform.position - var_113_0.position

				var_113_0.forward = Vector3.New(var_113_5.x, var_113_5.y, var_113_5.z)

				local var_113_6 = var_113_0.localEulerAngles

				var_113_6.z = 0
				var_113_6.x = 0
				var_113_0.localEulerAngles = var_113_6
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 then
				var_113_0.localPosition = Vector3.New(-0.7, -1.18, -6.15)

				local var_113_7 = manager.ui.mainCamera.transform.position - var_113_0.position

				var_113_0.forward = Vector3.New(var_113_7.x, var_113_7.y, var_113_7.z)

				local var_113_8 = var_113_0.localEulerAngles

				var_113_8.z = 0
				var_113_8.x = 0
				var_113_0.localEulerAngles = var_113_8
			end

			local var_113_9 = "1085ui_story"

			if arg_110_1.actors_[var_113_9] == nil then
				local var_113_10 = Asset.Load("Char/" .. "1085ui_story")

				if not isNil(var_113_10) then
					local var_113_11 = Object.Instantiate(Asset.Load("Char/" .. "1085ui_story"), arg_110_1.stage_.transform)

					var_113_11.name = var_113_9
					var_113_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_110_1.actors_[var_113_9] = var_113_11

					local var_113_12 = var_113_11:GetComponentInChildren(typeof(CharacterEffect))

					var_113_12.enabled = true

					local var_113_13 = GameObjectTools.GetOrAddComponent(var_113_11, typeof(DynamicBoneHelper))

					if var_113_13 then
						var_113_13:EnableDynamicBone(false)
					end

					arg_110_1:ShowWeapon(var_113_12.transform, false)

					arg_110_1.var_[var_113_9 .. "Animator"] = var_113_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_110_1.var_[var_113_9 .. "Animator"].applyRootMotion = true
					arg_110_1.var_[var_113_9 .. "LipSync"] = var_113_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_113_14 = arg_110_1.actors_["1085ui_story"].transform
			local var_113_15 = 0

			if var_113_15 < arg_110_1.time_ and arg_110_1.time_ <= var_113_15 + arg_113_0 then
				arg_110_1.var_.moveOldPos1085ui_story = var_113_14.localPosition
			end

			local var_113_16 = 0.001

			if var_113_15 <= arg_110_1.time_ and arg_110_1.time_ < var_113_15 + var_113_16 then
				local var_113_17 = (arg_110_1.time_ - var_113_15) / var_113_16
				local var_113_18 = Vector3.New(0.75, -1.01, -5.83)

				var_113_14.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1085ui_story, var_113_18, var_113_17)

				local var_113_19 = manager.ui.mainCamera.transform.position - var_113_14.position

				var_113_14.forward = Vector3.New(var_113_19.x, var_113_19.y, var_113_19.z)

				local var_113_20 = var_113_14.localEulerAngles

				var_113_20.z = 0
				var_113_20.x = 0
				var_113_14.localEulerAngles = var_113_20
			end

			if arg_110_1.time_ >= var_113_15 + var_113_16 and arg_110_1.time_ < var_113_15 + var_113_16 + arg_113_0 then
				var_113_14.localPosition = Vector3.New(0.75, -1.01, -5.83)

				local var_113_21 = manager.ui.mainCamera.transform.position - var_113_14.position

				var_113_14.forward = Vector3.New(var_113_21.x, var_113_21.y, var_113_21.z)

				local var_113_22 = var_113_14.localEulerAngles

				var_113_22.z = 0
				var_113_22.x = 0
				var_113_14.localEulerAngles = var_113_22
			end

			local var_113_23 = arg_110_1.actors_["1085ui_story"]
			local var_113_24 = 0

			if var_113_24 < arg_110_1.time_ and arg_110_1.time_ <= var_113_24 + arg_113_0 and not isNil(var_113_23) and arg_110_1.var_.characterEffect1085ui_story == nil then
				arg_110_1.var_.characterEffect1085ui_story = var_113_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_25 = 0.200000002980232

			if var_113_24 <= arg_110_1.time_ and arg_110_1.time_ < var_113_24 + var_113_25 and not isNil(var_113_23) then
				local var_113_26 = (arg_110_1.time_ - var_113_24) / var_113_25

				if arg_110_1.var_.characterEffect1085ui_story and not isNil(var_113_23) then
					arg_110_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= var_113_24 + var_113_25 and arg_110_1.time_ < var_113_24 + var_113_25 + arg_113_0 and not isNil(var_113_23) and arg_110_1.var_.characterEffect1085ui_story then
				arg_110_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_113_27 = arg_110_1.actors_["1061ui_story"]
			local var_113_28 = 0

			if var_113_28 < arg_110_1.time_ and arg_110_1.time_ <= var_113_28 + arg_113_0 and not isNil(var_113_27) and arg_110_1.var_.characterEffect1061ui_story == nil then
				arg_110_1.var_.characterEffect1061ui_story = var_113_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_29 = 0.200000002980232

			if var_113_28 <= arg_110_1.time_ and arg_110_1.time_ < var_113_28 + var_113_29 and not isNil(var_113_27) then
				local var_113_30 = (arg_110_1.time_ - var_113_28) / var_113_29

				if arg_110_1.var_.characterEffect1061ui_story and not isNil(var_113_27) then
					local var_113_31 = Mathf.Lerp(0, 0.5, var_113_30)

					arg_110_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1061ui_story.fillRatio = var_113_31
				end
			end

			if arg_110_1.time_ >= var_113_28 + var_113_29 and arg_110_1.time_ < var_113_28 + var_113_29 + arg_113_0 and not isNil(var_113_27) and arg_110_1.var_.characterEffect1061ui_story then
				local var_113_32 = 0.5

				arg_110_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1061ui_story.fillRatio = var_113_32
			end

			local var_113_33 = 0

			if var_113_33 < arg_110_1.time_ and arg_110_1.time_ <= var_113_33 + arg_113_0 then
				arg_110_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_113_34 = 0

			if var_113_34 < arg_110_1.time_ and arg_110_1.time_ <= var_113_34 + arg_113_0 then
				arg_110_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_113_35 = 0
			local var_113_36 = 0.65

			if var_113_35 < arg_110_1.time_ and arg_110_1.time_ <= var_113_35 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_37 = arg_110_1:FormatText(StoryNameCfg[328].name)

				arg_110_1.leftNameTxt_.text = var_113_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_38 = arg_110_1:GetWordFromCfg(420132026)
				local var_113_39 = arg_110_1:FormatText(var_113_38.content)

				arg_110_1.text_.text = var_113_39

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_40 = 26
				local var_113_41 = utf8.len(var_113_39)
				local var_113_42 = var_113_40 <= 0 and var_113_36 or var_113_36 * (var_113_41 / var_113_40)

				if var_113_42 > 0 and var_113_36 < var_113_42 then
					arg_110_1.talkMaxDuration = var_113_42

					if var_113_42 + var_113_35 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_42 + var_113_35
					end
				end

				arg_110_1.text_.text = var_113_39
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132026", "story_v_out_420132.awb") ~= 0 then
					local var_113_43 = manager.audio:GetVoiceLength("story_v_out_420132", "420132026", "story_v_out_420132.awb") / 1000

					if var_113_43 + var_113_35 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_43 + var_113_35
					end

					if var_113_38.prefab_name ~= "" and arg_110_1.actors_[var_113_38.prefab_name] ~= nil then
						local var_113_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_38.prefab_name].transform, "story_v_out_420132", "420132026", "story_v_out_420132.awb")

						arg_110_1:RecordAudio("420132026", var_113_44)
						arg_110_1:RecordAudio("420132026", var_113_44)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_420132", "420132026", "story_v_out_420132.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_420132", "420132026", "story_v_out_420132.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_45 = math.max(var_113_36, arg_110_1.talkMaxDuration)

			if var_113_35 <= arg_110_1.time_ and arg_110_1.time_ < var_113_35 + var_113_45 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_35) / var_113_45

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_35 + var_113_45 and arg_110_1.time_ < var_113_35 + var_113_45 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
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
				actorName = "1085ui_story",
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
	Play420132027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 420132027
		arg_114_1.duration_ = 7.4

		local var_114_0 = {
			zh = 2.766,
			ja = 7.4
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play420132028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["1061ui_story"]
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect1061ui_story == nil then
				arg_114_1.var_.characterEffect1061ui_story = var_117_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_2 = 0.200000002980232

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 and not isNil(var_117_0) then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2

				if arg_114_1.var_.characterEffect1061ui_story and not isNil(var_117_0) then
					arg_114_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect1061ui_story then
				arg_114_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_117_4 = arg_114_1.actors_["1085ui_story"]
			local var_117_5 = 0

			if var_117_5 < arg_114_1.time_ and arg_114_1.time_ <= var_117_5 + arg_117_0 and not isNil(var_117_4) and arg_114_1.var_.characterEffect1085ui_story == nil then
				arg_114_1.var_.characterEffect1085ui_story = var_117_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_6 = 0.200000002980232

			if var_117_5 <= arg_114_1.time_ and arg_114_1.time_ < var_117_5 + var_117_6 and not isNil(var_117_4) then
				local var_117_7 = (arg_114_1.time_ - var_117_5) / var_117_6

				if arg_114_1.var_.characterEffect1085ui_story and not isNil(var_117_4) then
					local var_117_8 = Mathf.Lerp(0, 0.5, var_117_7)

					arg_114_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_114_1.var_.characterEffect1085ui_story.fillRatio = var_117_8
				end
			end

			if arg_114_1.time_ >= var_117_5 + var_117_6 and arg_114_1.time_ < var_117_5 + var_117_6 + arg_117_0 and not isNil(var_117_4) and arg_114_1.var_.characterEffect1085ui_story then
				local var_117_9 = 0.5

				arg_114_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_114_1.var_.characterEffect1085ui_story.fillRatio = var_117_9
			end

			local var_117_10 = 0
			local var_117_11 = 0.35

			if var_117_10 < arg_114_1.time_ and arg_114_1.time_ <= var_117_10 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_12 = arg_114_1:FormatText(StoryNameCfg[612].name)

				arg_114_1.leftNameTxt_.text = var_117_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_13 = arg_114_1:GetWordFromCfg(420132027)
				local var_117_14 = arg_114_1:FormatText(var_117_13.content)

				arg_114_1.text_.text = var_117_14

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_15 = 14
				local var_117_16 = utf8.len(var_117_14)
				local var_117_17 = var_117_15 <= 0 and var_117_11 or var_117_11 * (var_117_16 / var_117_15)

				if var_117_17 > 0 and var_117_11 < var_117_17 then
					arg_114_1.talkMaxDuration = var_117_17

					if var_117_17 + var_117_10 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_17 + var_117_10
					end
				end

				arg_114_1.text_.text = var_117_14
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132027", "story_v_out_420132.awb") ~= 0 then
					local var_117_18 = manager.audio:GetVoiceLength("story_v_out_420132", "420132027", "story_v_out_420132.awb") / 1000

					if var_117_18 + var_117_10 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_18 + var_117_10
					end

					if var_117_13.prefab_name ~= "" and arg_114_1.actors_[var_117_13.prefab_name] ~= nil then
						local var_117_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_13.prefab_name].transform, "story_v_out_420132", "420132027", "story_v_out_420132.awb")

						arg_114_1:RecordAudio("420132027", var_117_19)
						arg_114_1:RecordAudio("420132027", var_117_19)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_420132", "420132027", "story_v_out_420132.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_420132", "420132027", "story_v_out_420132.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_20 = math.max(var_117_11, arg_114_1.talkMaxDuration)

			if var_117_10 <= arg_114_1.time_ and arg_114_1.time_ < var_117_10 + var_117_20 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_10) / var_117_20

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_10 + var_117_20 and arg_114_1.time_ < var_117_10 + var_117_20 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play420132028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 420132028
		arg_118_1.duration_ = 14.33

		local var_118_0 = {
			zh = 7.966,
			ja = 14.333
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
				arg_118_0:Play420132029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["1085ui_story"]
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect1085ui_story == nil then
				arg_118_1.var_.characterEffect1085ui_story = var_121_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_2 = 0.200000002980232

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 and not isNil(var_121_0) then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2

				if arg_118_1.var_.characterEffect1085ui_story and not isNil(var_121_0) then
					arg_118_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect1085ui_story then
				arg_118_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_121_4 = arg_118_1.actors_["1061ui_story"]
			local var_121_5 = 0

			if var_121_5 < arg_118_1.time_ and arg_118_1.time_ <= var_121_5 + arg_121_0 and not isNil(var_121_4) and arg_118_1.var_.characterEffect1061ui_story == nil then
				arg_118_1.var_.characterEffect1061ui_story = var_121_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_6 = 0.200000002980232

			if var_121_5 <= arg_118_1.time_ and arg_118_1.time_ < var_121_5 + var_121_6 and not isNil(var_121_4) then
				local var_121_7 = (arg_118_1.time_ - var_121_5) / var_121_6

				if arg_118_1.var_.characterEffect1061ui_story and not isNil(var_121_4) then
					local var_121_8 = Mathf.Lerp(0, 0.5, var_121_7)

					arg_118_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_118_1.var_.characterEffect1061ui_story.fillRatio = var_121_8
				end
			end

			if arg_118_1.time_ >= var_121_5 + var_121_6 and arg_118_1.time_ < var_121_5 + var_121_6 + arg_121_0 and not isNil(var_121_4) and arg_118_1.var_.characterEffect1061ui_story then
				local var_121_9 = 0.5

				arg_118_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_118_1.var_.characterEffect1061ui_story.fillRatio = var_121_9
			end

			local var_121_10 = 0

			if var_121_10 < arg_118_1.time_ and arg_118_1.time_ <= var_121_10 + arg_121_0 then
				arg_118_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_121_11 = 0
			local var_121_12 = 0.75

			if var_121_11 < arg_118_1.time_ and arg_118_1.time_ <= var_121_11 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_13 = arg_118_1:FormatText(StoryNameCfg[328].name)

				arg_118_1.leftNameTxt_.text = var_121_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_14 = arg_118_1:GetWordFromCfg(420132028)
				local var_121_15 = arg_118_1:FormatText(var_121_14.content)

				arg_118_1.text_.text = var_121_15

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_16 = 30
				local var_121_17 = utf8.len(var_121_15)
				local var_121_18 = var_121_16 <= 0 and var_121_12 or var_121_12 * (var_121_17 / var_121_16)

				if var_121_18 > 0 and var_121_12 < var_121_18 then
					arg_118_1.talkMaxDuration = var_121_18

					if var_121_18 + var_121_11 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_18 + var_121_11
					end
				end

				arg_118_1.text_.text = var_121_15
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132028", "story_v_out_420132.awb") ~= 0 then
					local var_121_19 = manager.audio:GetVoiceLength("story_v_out_420132", "420132028", "story_v_out_420132.awb") / 1000

					if var_121_19 + var_121_11 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_19 + var_121_11
					end

					if var_121_14.prefab_name ~= "" and arg_118_1.actors_[var_121_14.prefab_name] ~= nil then
						local var_121_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_14.prefab_name].transform, "story_v_out_420132", "420132028", "story_v_out_420132.awb")

						arg_118_1:RecordAudio("420132028", var_121_20)
						arg_118_1:RecordAudio("420132028", var_121_20)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_420132", "420132028", "story_v_out_420132.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_420132", "420132028", "story_v_out_420132.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_21 = math.max(var_121_12, arg_118_1.talkMaxDuration)

			if var_121_11 <= arg_118_1.time_ and arg_118_1.time_ < var_121_11 + var_121_21 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_11) / var_121_21

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_11 + var_121_21 and arg_118_1.time_ < var_121_11 + var_121_21 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play420132029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 420132029
		arg_122_1.duration_ = 13.83

		local var_122_0 = {
			zh = 9.066,
			ja = 13.833
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
				arg_122_0:Play420132030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["1061ui_story"]
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect1061ui_story == nil then
				arg_122_1.var_.characterEffect1061ui_story = var_125_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_2 = 0.200000002980232

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 and not isNil(var_125_0) then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2

				if arg_122_1.var_.characterEffect1061ui_story and not isNil(var_125_0) then
					arg_122_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect1061ui_story then
				arg_122_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_125_4 = arg_122_1.actors_["1085ui_story"]
			local var_125_5 = 0

			if var_125_5 < arg_122_1.time_ and arg_122_1.time_ <= var_125_5 + arg_125_0 and not isNil(var_125_4) and arg_122_1.var_.characterEffect1085ui_story == nil then
				arg_122_1.var_.characterEffect1085ui_story = var_125_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_6 = 0.200000002980232

			if var_125_5 <= arg_122_1.time_ and arg_122_1.time_ < var_125_5 + var_125_6 and not isNil(var_125_4) then
				local var_125_7 = (arg_122_1.time_ - var_125_5) / var_125_6

				if arg_122_1.var_.characterEffect1085ui_story and not isNil(var_125_4) then
					local var_125_8 = Mathf.Lerp(0, 0.5, var_125_7)

					arg_122_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1085ui_story.fillRatio = var_125_8
				end
			end

			if arg_122_1.time_ >= var_125_5 + var_125_6 and arg_122_1.time_ < var_125_5 + var_125_6 + arg_125_0 and not isNil(var_125_4) and arg_122_1.var_.characterEffect1085ui_story then
				local var_125_9 = 0.5

				arg_122_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1085ui_story.fillRatio = var_125_9
			end

			local var_125_10 = 0
			local var_125_11 = 1.025

			if var_125_10 < arg_122_1.time_ and arg_122_1.time_ <= var_125_10 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_12 = arg_122_1:FormatText(StoryNameCfg[612].name)

				arg_122_1.leftNameTxt_.text = var_125_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_13 = arg_122_1:GetWordFromCfg(420132029)
				local var_125_14 = arg_122_1:FormatText(var_125_13.content)

				arg_122_1.text_.text = var_125_14

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_15 = 41
				local var_125_16 = utf8.len(var_125_14)
				local var_125_17 = var_125_15 <= 0 and var_125_11 or var_125_11 * (var_125_16 / var_125_15)

				if var_125_17 > 0 and var_125_11 < var_125_17 then
					arg_122_1.talkMaxDuration = var_125_17

					if var_125_17 + var_125_10 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_17 + var_125_10
					end
				end

				arg_122_1.text_.text = var_125_14
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132029", "story_v_out_420132.awb") ~= 0 then
					local var_125_18 = manager.audio:GetVoiceLength("story_v_out_420132", "420132029", "story_v_out_420132.awb") / 1000

					if var_125_18 + var_125_10 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_18 + var_125_10
					end

					if var_125_13.prefab_name ~= "" and arg_122_1.actors_[var_125_13.prefab_name] ~= nil then
						local var_125_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_13.prefab_name].transform, "story_v_out_420132", "420132029", "story_v_out_420132.awb")

						arg_122_1:RecordAudio("420132029", var_125_19)
						arg_122_1:RecordAudio("420132029", var_125_19)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_420132", "420132029", "story_v_out_420132.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_420132", "420132029", "story_v_out_420132.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_20 = math.max(var_125_11, arg_122_1.talkMaxDuration)

			if var_125_10 <= arg_122_1.time_ and arg_122_1.time_ < var_125_10 + var_125_20 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_10) / var_125_20

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_10 + var_125_20 and arg_122_1.time_ < var_125_10 + var_125_20 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play420132030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 420132030
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play420132031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["1061ui_story"]
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect1061ui_story == nil then
				arg_126_1.var_.characterEffect1061ui_story = var_129_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_2 = 0.200000002980232

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 and not isNil(var_129_0) then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / var_129_2

				if arg_126_1.var_.characterEffect1061ui_story and not isNil(var_129_0) then
					local var_129_4 = Mathf.Lerp(0, 0.5, var_129_3)

					arg_126_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_126_1.var_.characterEffect1061ui_story.fillRatio = var_129_4
				end
			end

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect1061ui_story then
				local var_129_5 = 0.5

				arg_126_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_126_1.var_.characterEffect1061ui_story.fillRatio = var_129_5
			end

			local var_129_6 = 0
			local var_129_7 = 0.2

			if var_129_6 < arg_126_1.time_ and arg_126_1.time_ <= var_129_6 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_8 = arg_126_1:FormatText(StoryNameCfg[7].name)

				arg_126_1.leftNameTxt_.text = var_129_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, true)
				arg_126_1.iconController_:SetSelectedState("hero")

				arg_126_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_126_1.callingController_:SetSelectedState("normal")

				arg_126_1.keyicon_.color = Color.New(1, 1, 1)
				arg_126_1.icon_.color = Color.New(1, 1, 1)

				local var_129_9 = arg_126_1:GetWordFromCfg(420132030)
				local var_129_10 = arg_126_1:FormatText(var_129_9.content)

				arg_126_1.text_.text = var_129_10

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_11 = 8
				local var_129_12 = utf8.len(var_129_10)
				local var_129_13 = var_129_11 <= 0 and var_129_7 or var_129_7 * (var_129_12 / var_129_11)

				if var_129_13 > 0 and var_129_7 < var_129_13 then
					arg_126_1.talkMaxDuration = var_129_13

					if var_129_13 + var_129_6 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_13 + var_129_6
					end
				end

				arg_126_1.text_.text = var_129_10
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_14 = math.max(var_129_7, arg_126_1.talkMaxDuration)

			if var_129_6 <= arg_126_1.time_ and arg_126_1.time_ < var_129_6 + var_129_14 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_6) / var_129_14

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_6 + var_129_14 and arg_126_1.time_ < var_129_6 + var_129_14 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play420132031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 420132031
		arg_130_1.duration_ = 2

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play420132032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.actors_["1085ui_story"]
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect1085ui_story == nil then
				arg_130_1.var_.characterEffect1085ui_story = var_133_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_2 = 0.200000002980232

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_2 and not isNil(var_133_0) then
				local var_133_3 = (arg_130_1.time_ - var_133_1) / var_133_2

				if arg_130_1.var_.characterEffect1085ui_story and not isNil(var_133_0) then
					arg_130_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= var_133_1 + var_133_2 and arg_130_1.time_ < var_133_1 + var_133_2 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect1085ui_story then
				arg_130_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_133_4 = 0

			if var_133_4 < arg_130_1.time_ and arg_130_1.time_ <= var_133_4 + arg_133_0 then
				arg_130_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			local var_133_5 = 0
			local var_133_6 = 0.05

			if var_133_5 < arg_130_1.time_ and arg_130_1.time_ <= var_133_5 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_7 = arg_130_1:FormatText(StoryNameCfg[328].name)

				arg_130_1.leftNameTxt_.text = var_133_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_8 = arg_130_1:GetWordFromCfg(420132031)
				local var_133_9 = arg_130_1:FormatText(var_133_8.content)

				arg_130_1.text_.text = var_133_9

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_10 = 2
				local var_133_11 = utf8.len(var_133_9)
				local var_133_12 = var_133_10 <= 0 and var_133_6 or var_133_6 * (var_133_11 / var_133_10)

				if var_133_12 > 0 and var_133_6 < var_133_12 then
					arg_130_1.talkMaxDuration = var_133_12

					if var_133_12 + var_133_5 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_12 + var_133_5
					end
				end

				arg_130_1.text_.text = var_133_9
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132031", "story_v_out_420132.awb") ~= 0 then
					local var_133_13 = manager.audio:GetVoiceLength("story_v_out_420132", "420132031", "story_v_out_420132.awb") / 1000

					if var_133_13 + var_133_5 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_13 + var_133_5
					end

					if var_133_8.prefab_name ~= "" and arg_130_1.actors_[var_133_8.prefab_name] ~= nil then
						local var_133_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_8.prefab_name].transform, "story_v_out_420132", "420132031", "story_v_out_420132.awb")

						arg_130_1:RecordAudio("420132031", var_133_14)
						arg_130_1:RecordAudio("420132031", var_133_14)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_420132", "420132031", "story_v_out_420132.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_420132", "420132031", "story_v_out_420132.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_15 = math.max(var_133_6, arg_130_1.talkMaxDuration)

			if var_133_5 <= arg_130_1.time_ and arg_130_1.time_ < var_133_5 + var_133_15 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_5) / var_133_15

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_5 + var_133_15 and arg_130_1.time_ < var_133_5 + var_133_15 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play420132032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 420132032
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play420132033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["1085ui_story"]
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect1085ui_story == nil then
				arg_134_1.var_.characterEffect1085ui_story = var_137_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_2 = 0.200000002980232

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_2 and not isNil(var_137_0) then
				local var_137_3 = (arg_134_1.time_ - var_137_1) / var_137_2

				if arg_134_1.var_.characterEffect1085ui_story and not isNil(var_137_0) then
					local var_137_4 = Mathf.Lerp(0, 0.5, var_137_3)

					arg_134_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_134_1.var_.characterEffect1085ui_story.fillRatio = var_137_4
				end
			end

			if arg_134_1.time_ >= var_137_1 + var_137_2 and arg_134_1.time_ < var_137_1 + var_137_2 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect1085ui_story then
				local var_137_5 = 0.5

				arg_134_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_134_1.var_.characterEffect1085ui_story.fillRatio = var_137_5
			end

			local var_137_6 = 0
			local var_137_7 = 0.25

			if var_137_6 < arg_134_1.time_ and arg_134_1.time_ <= var_137_6 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_8 = arg_134_1:FormatText(StoryNameCfg[7].name)

				arg_134_1.leftNameTxt_.text = var_137_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, true)
				arg_134_1.iconController_:SetSelectedState("hero")

				arg_134_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_134_1.callingController_:SetSelectedState("normal")

				arg_134_1.keyicon_.color = Color.New(1, 1, 1)
				arg_134_1.icon_.color = Color.New(1, 1, 1)

				local var_137_9 = arg_134_1:GetWordFromCfg(420132032)
				local var_137_10 = arg_134_1:FormatText(var_137_9.content)

				arg_134_1.text_.text = var_137_10

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_11 = 10
				local var_137_12 = utf8.len(var_137_10)
				local var_137_13 = var_137_11 <= 0 and var_137_7 or var_137_7 * (var_137_12 / var_137_11)

				if var_137_13 > 0 and var_137_7 < var_137_13 then
					arg_134_1.talkMaxDuration = var_137_13

					if var_137_13 + var_137_6 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_13 + var_137_6
					end
				end

				arg_134_1.text_.text = var_137_10
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
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

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play420132033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 420132033
		arg_138_1.duration_ = 7.57

		local var_138_0 = {
			zh = 5.066,
			ja = 7.566
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
				arg_138_0:Play420132034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["1085ui_story"]
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect1085ui_story == nil then
				arg_138_1.var_.characterEffect1085ui_story = var_141_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_2 = 0.200000002980232

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_2 and not isNil(var_141_0) then
				local var_141_3 = (arg_138_1.time_ - var_141_1) / var_141_2

				if arg_138_1.var_.characterEffect1085ui_story and not isNil(var_141_0) then
					arg_138_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= var_141_1 + var_141_2 and arg_138_1.time_ < var_141_1 + var_141_2 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect1085ui_story then
				arg_138_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_141_4 = 0

			if var_141_4 < arg_138_1.time_ and arg_138_1.time_ <= var_141_4 + arg_141_0 then
				arg_138_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_2")
			end

			local var_141_5 = 0
			local var_141_6 = 0.4

			if var_141_5 < arg_138_1.time_ and arg_138_1.time_ <= var_141_5 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_7 = arg_138_1:FormatText(StoryNameCfg[328].name)

				arg_138_1.leftNameTxt_.text = var_141_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_8 = arg_138_1:GetWordFromCfg(420132033)
				local var_141_9 = arg_138_1:FormatText(var_141_8.content)

				arg_138_1.text_.text = var_141_9

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_10 = 16
				local var_141_11 = utf8.len(var_141_9)
				local var_141_12 = var_141_10 <= 0 and var_141_6 or var_141_6 * (var_141_11 / var_141_10)

				if var_141_12 > 0 and var_141_6 < var_141_12 then
					arg_138_1.talkMaxDuration = var_141_12

					if var_141_12 + var_141_5 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_12 + var_141_5
					end
				end

				arg_138_1.text_.text = var_141_9
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132033", "story_v_out_420132.awb") ~= 0 then
					local var_141_13 = manager.audio:GetVoiceLength("story_v_out_420132", "420132033", "story_v_out_420132.awb") / 1000

					if var_141_13 + var_141_5 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_13 + var_141_5
					end

					if var_141_8.prefab_name ~= "" and arg_138_1.actors_[var_141_8.prefab_name] ~= nil then
						local var_141_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_8.prefab_name].transform, "story_v_out_420132", "420132033", "story_v_out_420132.awb")

						arg_138_1:RecordAudio("420132033", var_141_14)
						arg_138_1:RecordAudio("420132033", var_141_14)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_420132", "420132033", "story_v_out_420132.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_420132", "420132033", "story_v_out_420132.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_15 = math.max(var_141_6, arg_138_1.talkMaxDuration)

			if var_141_5 <= arg_138_1.time_ and arg_138_1.time_ < var_141_5 + var_141_15 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_5) / var_141_15

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_5 + var_141_15 and arg_138_1.time_ < var_141_5 + var_141_15 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play420132034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 420132034
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play420132035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = arg_142_1.actors_["1085ui_story"]
			local var_145_1 = 0

			if var_145_1 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.characterEffect1085ui_story == nil then
				arg_142_1.var_.characterEffect1085ui_story = var_145_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_2 = 0.200000002980232

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_2 and not isNil(var_145_0) then
				local var_145_3 = (arg_142_1.time_ - var_145_1) / var_145_2

				if arg_142_1.var_.characterEffect1085ui_story and not isNil(var_145_0) then
					local var_145_4 = Mathf.Lerp(0, 0.5, var_145_3)

					arg_142_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_142_1.var_.characterEffect1085ui_story.fillRatio = var_145_4
				end
			end

			if arg_142_1.time_ >= var_145_1 + var_145_2 and arg_142_1.time_ < var_145_1 + var_145_2 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.characterEffect1085ui_story then
				local var_145_5 = 0.5

				arg_142_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_142_1.var_.characterEffect1085ui_story.fillRatio = var_145_5
			end

			local var_145_6 = 0
			local var_145_7 = 0.125

			if var_145_6 < arg_142_1.time_ and arg_142_1.time_ <= var_145_6 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_8 = arg_142_1:FormatText(StoryNameCfg[7].name)

				arg_142_1.leftNameTxt_.text = var_145_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, true)
				arg_142_1.iconController_:SetSelectedState("hero")

				arg_142_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_142_1.callingController_:SetSelectedState("normal")

				arg_142_1.keyicon_.color = Color.New(1, 1, 1)
				arg_142_1.icon_.color = Color.New(1, 1, 1)

				local var_145_9 = arg_142_1:GetWordFromCfg(420132034)
				local var_145_10 = arg_142_1:FormatText(var_145_9.content)

				arg_142_1.text_.text = var_145_10

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_11 = 5
				local var_145_12 = utf8.len(var_145_10)
				local var_145_13 = var_145_11 <= 0 and var_145_7 or var_145_7 * (var_145_12 / var_145_11)

				if var_145_13 > 0 and var_145_7 < var_145_13 then
					arg_142_1.talkMaxDuration = var_145_13

					if var_145_13 + var_145_6 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_13 + var_145_6
					end
				end

				arg_142_1.text_.text = var_145_10
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_14 = math.max(var_145_7, arg_142_1.talkMaxDuration)

			if var_145_6 <= arg_142_1.time_ and arg_142_1.time_ < var_145_6 + var_145_14 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_6) / var_145_14

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_6 + var_145_14 and arg_142_1.time_ < var_145_6 + var_145_14 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play420132035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 420132035
		arg_146_1.duration_ = 6.43

		local var_146_0 = {
			zh = 5.233,
			ja = 6.433
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play420132036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = arg_146_1.actors_["1061ui_story"]
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.characterEffect1061ui_story == nil then
				arg_146_1.var_.characterEffect1061ui_story = var_149_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_2 = 0.200000002980232

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_2 and not isNil(var_149_0) then
				local var_149_3 = (arg_146_1.time_ - var_149_1) / var_149_2

				if arg_146_1.var_.characterEffect1061ui_story and not isNil(var_149_0) then
					arg_146_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= var_149_1 + var_149_2 and arg_146_1.time_ < var_149_1 + var_149_2 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.characterEffect1061ui_story then
				arg_146_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_149_4 = 0

			if var_149_4 < arg_146_1.time_ and arg_146_1.time_ <= var_149_4 + arg_149_0 then
				arg_146_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_2")
			end

			local var_149_5 = 0

			if var_149_5 < arg_146_1.time_ and arg_146_1.time_ <= var_149_5 + arg_149_0 then
				arg_146_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_149_6 = 0
			local var_149_7 = 0.6

			if var_149_6 < arg_146_1.time_ and arg_146_1.time_ <= var_149_6 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_8 = arg_146_1:FormatText(StoryNameCfg[612].name)

				arg_146_1.leftNameTxt_.text = var_149_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_9 = arg_146_1:GetWordFromCfg(420132035)
				local var_149_10 = arg_146_1:FormatText(var_149_9.content)

				arg_146_1.text_.text = var_149_10

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_11 = 24
				local var_149_12 = utf8.len(var_149_10)
				local var_149_13 = var_149_11 <= 0 and var_149_7 or var_149_7 * (var_149_12 / var_149_11)

				if var_149_13 > 0 and var_149_7 < var_149_13 then
					arg_146_1.talkMaxDuration = var_149_13

					if var_149_13 + var_149_6 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_13 + var_149_6
					end
				end

				arg_146_1.text_.text = var_149_10
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132035", "story_v_out_420132.awb") ~= 0 then
					local var_149_14 = manager.audio:GetVoiceLength("story_v_out_420132", "420132035", "story_v_out_420132.awb") / 1000

					if var_149_14 + var_149_6 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_14 + var_149_6
					end

					if var_149_9.prefab_name ~= "" and arg_146_1.actors_[var_149_9.prefab_name] ~= nil then
						local var_149_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_9.prefab_name].transform, "story_v_out_420132", "420132035", "story_v_out_420132.awb")

						arg_146_1:RecordAudio("420132035", var_149_15)
						arg_146_1:RecordAudio("420132035", var_149_15)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_420132", "420132035", "story_v_out_420132.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_420132", "420132035", "story_v_out_420132.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_16 = math.max(var_149_7, arg_146_1.talkMaxDuration)

			if var_149_6 <= arg_146_1.time_ and arg_146_1.time_ < var_149_6 + var_149_16 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_6) / var_149_16

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_6 + var_149_16 and arg_146_1.time_ < var_149_6 + var_149_16 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play420132036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 420132036
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play420132037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = arg_150_1.actors_["1061ui_story"].transform
			local var_153_1 = 0

			if var_153_1 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 then
				arg_150_1.var_.moveOldPos1061ui_story = var_153_0.localPosition
			end

			local var_153_2 = 0.001

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_2 then
				local var_153_3 = (arg_150_1.time_ - var_153_1) / var_153_2
				local var_153_4 = Vector3.New(0, 100, 0)

				var_153_0.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1061ui_story, var_153_4, var_153_3)

				local var_153_5 = manager.ui.mainCamera.transform.position - var_153_0.position

				var_153_0.forward = Vector3.New(var_153_5.x, var_153_5.y, var_153_5.z)

				local var_153_6 = var_153_0.localEulerAngles

				var_153_6.z = 0
				var_153_6.x = 0
				var_153_0.localEulerAngles = var_153_6
			end

			if arg_150_1.time_ >= var_153_1 + var_153_2 and arg_150_1.time_ < var_153_1 + var_153_2 + arg_153_0 then
				var_153_0.localPosition = Vector3.New(0, 100, 0)

				local var_153_7 = manager.ui.mainCamera.transform.position - var_153_0.position

				var_153_0.forward = Vector3.New(var_153_7.x, var_153_7.y, var_153_7.z)

				local var_153_8 = var_153_0.localEulerAngles

				var_153_8.z = 0
				var_153_8.x = 0
				var_153_0.localEulerAngles = var_153_8
			end

			local var_153_9 = arg_150_1.actors_["1085ui_story"].transform
			local var_153_10 = 0

			if var_153_10 < arg_150_1.time_ and arg_150_1.time_ <= var_153_10 + arg_153_0 then
				arg_150_1.var_.moveOldPos1085ui_story = var_153_9.localPosition
			end

			local var_153_11 = 0.001

			if var_153_10 <= arg_150_1.time_ and arg_150_1.time_ < var_153_10 + var_153_11 then
				local var_153_12 = (arg_150_1.time_ - var_153_10) / var_153_11
				local var_153_13 = Vector3.New(0, 100, 0)

				var_153_9.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1085ui_story, var_153_13, var_153_12)

				local var_153_14 = manager.ui.mainCamera.transform.position - var_153_9.position

				var_153_9.forward = Vector3.New(var_153_14.x, var_153_14.y, var_153_14.z)

				local var_153_15 = var_153_9.localEulerAngles

				var_153_15.z = 0
				var_153_15.x = 0
				var_153_9.localEulerAngles = var_153_15
			end

			if arg_150_1.time_ >= var_153_10 + var_153_11 and arg_150_1.time_ < var_153_10 + var_153_11 + arg_153_0 then
				var_153_9.localPosition = Vector3.New(0, 100, 0)

				local var_153_16 = manager.ui.mainCamera.transform.position - var_153_9.position

				var_153_9.forward = Vector3.New(var_153_16.x, var_153_16.y, var_153_16.z)

				local var_153_17 = var_153_9.localEulerAngles

				var_153_17.z = 0
				var_153_17.x = 0
				var_153_9.localEulerAngles = var_153_17
			end

			local var_153_18 = 0
			local var_153_19 = 0.7

			if var_153_18 < arg_150_1.time_ and arg_150_1.time_ <= var_153_18 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, false)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_20 = arg_150_1:GetWordFromCfg(420132036)
				local var_153_21 = arg_150_1:FormatText(var_153_20.content)

				arg_150_1.text_.text = var_153_21

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_22 = 28
				local var_153_23 = utf8.len(var_153_21)
				local var_153_24 = var_153_22 <= 0 and var_153_19 or var_153_19 * (var_153_23 / var_153_22)

				if var_153_24 > 0 and var_153_19 < var_153_24 then
					arg_150_1.talkMaxDuration = var_153_24

					if var_153_24 + var_153_18 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_24 + var_153_18
					end
				end

				arg_150_1.text_.text = var_153_21
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_25 = math.max(var_153_19, arg_150_1.talkMaxDuration)

			if var_153_18 <= arg_150_1.time_ and arg_150_1.time_ < var_153_18 + var_153_25 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_18) / var_153_25

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_18 + var_153_25 and arg_150_1.time_ < var_153_18 + var_153_25 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
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
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_150_1:InitPlayNodeList()
	end,
	Play420132037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 420132037
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play420132038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 0
			local var_157_1 = 0.725

			if var_157_0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_0 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_2 = arg_154_1:FormatText(StoryNameCfg[7].name)

				arg_154_1.leftNameTxt_.text = var_157_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, true)
				arg_154_1.iconController_:SetSelectedState("hero")

				arg_154_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_154_1.callingController_:SetSelectedState("normal")

				arg_154_1.keyicon_.color = Color.New(1, 1, 1)
				arg_154_1.icon_.color = Color.New(1, 1, 1)

				local var_157_3 = arg_154_1:GetWordFromCfg(420132037)
				local var_157_4 = arg_154_1:FormatText(var_157_3.content)

				arg_154_1.text_.text = var_157_4

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_5 = 29
				local var_157_6 = utf8.len(var_157_4)
				local var_157_7 = var_157_5 <= 0 and var_157_1 or var_157_1 * (var_157_6 / var_157_5)

				if var_157_7 > 0 and var_157_1 < var_157_7 then
					arg_154_1.talkMaxDuration = var_157_7

					if var_157_7 + var_157_0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_7 + var_157_0
					end
				end

				arg_154_1.text_.text = var_157_4
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_8 = math.max(var_157_1, arg_154_1.talkMaxDuration)

			if var_157_0 <= arg_154_1.time_ and arg_154_1.time_ < var_157_0 + var_157_8 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_0) / var_157_8

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_0 + var_157_8 and arg_154_1.time_ < var_157_0 + var_157_8 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play420132038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 420132038
		arg_158_1.duration_ = 10.47

		local var_158_0 = {
			zh = 7.1,
			ja = 10.466
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play420132039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = arg_158_1.actors_["1061ui_story"].transform
			local var_161_1 = 0

			if var_161_1 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 then
				arg_158_1.var_.moveOldPos1061ui_story = var_161_0.localPosition
			end

			local var_161_2 = 0.001

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_2 then
				local var_161_3 = (arg_158_1.time_ - var_161_1) / var_161_2
				local var_161_4 = Vector3.New(0, -1.18, -6.15)

				var_161_0.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos1061ui_story, var_161_4, var_161_3)

				local var_161_5 = manager.ui.mainCamera.transform.position - var_161_0.position

				var_161_0.forward = Vector3.New(var_161_5.x, var_161_5.y, var_161_5.z)

				local var_161_6 = var_161_0.localEulerAngles

				var_161_6.z = 0
				var_161_6.x = 0
				var_161_0.localEulerAngles = var_161_6
			end

			if arg_158_1.time_ >= var_161_1 + var_161_2 and arg_158_1.time_ < var_161_1 + var_161_2 + arg_161_0 then
				var_161_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_161_7 = manager.ui.mainCamera.transform.position - var_161_0.position

				var_161_0.forward = Vector3.New(var_161_7.x, var_161_7.y, var_161_7.z)

				local var_161_8 = var_161_0.localEulerAngles

				var_161_8.z = 0
				var_161_8.x = 0
				var_161_0.localEulerAngles = var_161_8
			end

			local var_161_9 = arg_158_1.actors_["1061ui_story"]
			local var_161_10 = 0

			if var_161_10 < arg_158_1.time_ and arg_158_1.time_ <= var_161_10 + arg_161_0 and not isNil(var_161_9) and arg_158_1.var_.characterEffect1061ui_story == nil then
				arg_158_1.var_.characterEffect1061ui_story = var_161_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_11 = 0.200000002980232

			if var_161_10 <= arg_158_1.time_ and arg_158_1.time_ < var_161_10 + var_161_11 and not isNil(var_161_9) then
				local var_161_12 = (arg_158_1.time_ - var_161_10) / var_161_11

				if arg_158_1.var_.characterEffect1061ui_story and not isNil(var_161_9) then
					arg_158_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_158_1.time_ >= var_161_10 + var_161_11 and arg_158_1.time_ < var_161_10 + var_161_11 + arg_161_0 and not isNil(var_161_9) and arg_158_1.var_.characterEffect1061ui_story then
				arg_158_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_161_13 = 0

			if var_161_13 < arg_158_1.time_ and arg_158_1.time_ <= var_161_13 + arg_161_0 then
				arg_158_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			local var_161_14 = 0

			if var_161_14 < arg_158_1.time_ and arg_158_1.time_ <= var_161_14 + arg_161_0 then
				arg_158_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_161_15 = 0
			local var_161_16 = 0.825

			if var_161_15 < arg_158_1.time_ and arg_158_1.time_ <= var_161_15 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_17 = arg_158_1:FormatText(StoryNameCfg[612].name)

				arg_158_1.leftNameTxt_.text = var_161_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_18 = arg_158_1:GetWordFromCfg(420132038)
				local var_161_19 = arg_158_1:FormatText(var_161_18.content)

				arg_158_1.text_.text = var_161_19

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_20 = 33
				local var_161_21 = utf8.len(var_161_19)
				local var_161_22 = var_161_20 <= 0 and var_161_16 or var_161_16 * (var_161_21 / var_161_20)

				if var_161_22 > 0 and var_161_16 < var_161_22 then
					arg_158_1.talkMaxDuration = var_161_22

					if var_161_22 + var_161_15 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_22 + var_161_15
					end
				end

				arg_158_1.text_.text = var_161_19
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132038", "story_v_out_420132.awb") ~= 0 then
					local var_161_23 = manager.audio:GetVoiceLength("story_v_out_420132", "420132038", "story_v_out_420132.awb") / 1000

					if var_161_23 + var_161_15 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_23 + var_161_15
					end

					if var_161_18.prefab_name ~= "" and arg_158_1.actors_[var_161_18.prefab_name] ~= nil then
						local var_161_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_18.prefab_name].transform, "story_v_out_420132", "420132038", "story_v_out_420132.awb")

						arg_158_1:RecordAudio("420132038", var_161_24)
						arg_158_1:RecordAudio("420132038", var_161_24)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_420132", "420132038", "story_v_out_420132.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_420132", "420132038", "story_v_out_420132.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_25 = math.max(var_161_16, arg_158_1.talkMaxDuration)

			if var_161_15 <= arg_158_1.time_ and arg_158_1.time_ < var_161_15 + var_161_25 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_15) / var_161_25

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_15 + var_161_25 and arg_158_1.time_ < var_161_15 + var_161_25 + arg_161_0 then
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
	Play420132039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 420132039
		arg_162_1.duration_ = 8.5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play420132040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = arg_162_1.actors_["1061ui_story"].transform
			local var_165_1 = 0

			if var_165_1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 then
				arg_162_1.var_.moveOldPos1061ui_story = var_165_0.localPosition
			end

			local var_165_2 = 0.001

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_2 then
				local var_165_3 = (arg_162_1.time_ - var_165_1) / var_165_2
				local var_165_4 = Vector3.New(-0.7, -1.18, -6.15)

				var_165_0.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos1061ui_story, var_165_4, var_165_3)

				local var_165_5 = manager.ui.mainCamera.transform.position - var_165_0.position

				var_165_0.forward = Vector3.New(var_165_5.x, var_165_5.y, var_165_5.z)

				local var_165_6 = var_165_0.localEulerAngles

				var_165_6.z = 0
				var_165_6.x = 0
				var_165_0.localEulerAngles = var_165_6
			end

			if arg_162_1.time_ >= var_165_1 + var_165_2 and arg_162_1.time_ < var_165_1 + var_165_2 + arg_165_0 then
				var_165_0.localPosition = Vector3.New(-0.7, -1.18, -6.15)

				local var_165_7 = manager.ui.mainCamera.transform.position - var_165_0.position

				var_165_0.forward = Vector3.New(var_165_7.x, var_165_7.y, var_165_7.z)

				local var_165_8 = var_165_0.localEulerAngles

				var_165_8.z = 0
				var_165_8.x = 0
				var_165_0.localEulerAngles = var_165_8
			end

			local var_165_9 = arg_162_1.actors_["1085ui_story"].transform
			local var_165_10 = 0

			if var_165_10 < arg_162_1.time_ and arg_162_1.time_ <= var_165_10 + arg_165_0 then
				arg_162_1.var_.moveOldPos1085ui_story = var_165_9.localPosition
			end

			local var_165_11 = 0.001

			if var_165_10 <= arg_162_1.time_ and arg_162_1.time_ < var_165_10 + var_165_11 then
				local var_165_12 = (arg_162_1.time_ - var_165_10) / var_165_11
				local var_165_13 = Vector3.New(0.75, -1.01, -5.83)

				var_165_9.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos1085ui_story, var_165_13, var_165_12)

				local var_165_14 = manager.ui.mainCamera.transform.position - var_165_9.position

				var_165_9.forward = Vector3.New(var_165_14.x, var_165_14.y, var_165_14.z)

				local var_165_15 = var_165_9.localEulerAngles

				var_165_15.z = 0
				var_165_15.x = 0
				var_165_9.localEulerAngles = var_165_15
			end

			if arg_162_1.time_ >= var_165_10 + var_165_11 and arg_162_1.time_ < var_165_10 + var_165_11 + arg_165_0 then
				var_165_9.localPosition = Vector3.New(0.75, -1.01, -5.83)

				local var_165_16 = manager.ui.mainCamera.transform.position - var_165_9.position

				var_165_9.forward = Vector3.New(var_165_16.x, var_165_16.y, var_165_16.z)

				local var_165_17 = var_165_9.localEulerAngles

				var_165_17.z = 0
				var_165_17.x = 0
				var_165_9.localEulerAngles = var_165_17
			end

			local var_165_18 = arg_162_1.actors_["1085ui_story"]
			local var_165_19 = 0

			if var_165_19 < arg_162_1.time_ and arg_162_1.time_ <= var_165_19 + arg_165_0 and not isNil(var_165_18) and arg_162_1.var_.characterEffect1085ui_story == nil then
				arg_162_1.var_.characterEffect1085ui_story = var_165_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_20 = 0.200000002980232

			if var_165_19 <= arg_162_1.time_ and arg_162_1.time_ < var_165_19 + var_165_20 and not isNil(var_165_18) then
				local var_165_21 = (arg_162_1.time_ - var_165_19) / var_165_20

				if arg_162_1.var_.characterEffect1085ui_story and not isNil(var_165_18) then
					arg_162_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_162_1.time_ >= var_165_19 + var_165_20 and arg_162_1.time_ < var_165_19 + var_165_20 + arg_165_0 and not isNil(var_165_18) and arg_162_1.var_.characterEffect1085ui_story then
				arg_162_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_165_22 = arg_162_1.actors_["1061ui_story"]
			local var_165_23 = 0

			if var_165_23 < arg_162_1.time_ and arg_162_1.time_ <= var_165_23 + arg_165_0 and not isNil(var_165_22) and arg_162_1.var_.characterEffect1061ui_story == nil then
				arg_162_1.var_.characterEffect1061ui_story = var_165_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_24 = 0.200000002980232

			if var_165_23 <= arg_162_1.time_ and arg_162_1.time_ < var_165_23 + var_165_24 and not isNil(var_165_22) then
				local var_165_25 = (arg_162_1.time_ - var_165_23) / var_165_24

				if arg_162_1.var_.characterEffect1061ui_story and not isNil(var_165_22) then
					local var_165_26 = Mathf.Lerp(0, 0.5, var_165_25)

					arg_162_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_162_1.var_.characterEffect1061ui_story.fillRatio = var_165_26
				end
			end

			if arg_162_1.time_ >= var_165_23 + var_165_24 and arg_162_1.time_ < var_165_23 + var_165_24 + arg_165_0 and not isNil(var_165_22) and arg_162_1.var_.characterEffect1061ui_story then
				local var_165_27 = 0.5

				arg_162_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_162_1.var_.characterEffect1061ui_story.fillRatio = var_165_27
			end

			local var_165_28 = 0

			if var_165_28 < arg_162_1.time_ and arg_162_1.time_ <= var_165_28 + arg_165_0 then
				arg_162_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action2_1")
			end

			local var_165_29 = 0
			local var_165_30 = 0.625

			if var_165_29 < arg_162_1.time_ and arg_162_1.time_ <= var_165_29 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_31 = arg_162_1:FormatText(StoryNameCfg[328].name)

				arg_162_1.leftNameTxt_.text = var_165_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_32 = arg_162_1:GetWordFromCfg(420132039)
				local var_165_33 = arg_162_1:FormatText(var_165_32.content)

				arg_162_1.text_.text = var_165_33

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_34 = 25
				local var_165_35 = utf8.len(var_165_33)
				local var_165_36 = var_165_34 <= 0 and var_165_30 or var_165_30 * (var_165_35 / var_165_34)

				if var_165_36 > 0 and var_165_30 < var_165_36 then
					arg_162_1.talkMaxDuration = var_165_36

					if var_165_36 + var_165_29 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_36 + var_165_29
					end
				end

				arg_162_1.text_.text = var_165_33
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132039", "story_v_out_420132.awb") ~= 0 then
					local var_165_37 = manager.audio:GetVoiceLength("story_v_out_420132", "420132039", "story_v_out_420132.awb") / 1000

					if var_165_37 + var_165_29 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_37 + var_165_29
					end

					if var_165_32.prefab_name ~= "" and arg_162_1.actors_[var_165_32.prefab_name] ~= nil then
						local var_165_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_32.prefab_name].transform, "story_v_out_420132", "420132039", "story_v_out_420132.awb")

						arg_162_1:RecordAudio("420132039", var_165_38)
						arg_162_1:RecordAudio("420132039", var_165_38)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_420132", "420132039", "story_v_out_420132.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_420132", "420132039", "story_v_out_420132.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_39 = math.max(var_165_30, arg_162_1.talkMaxDuration)

			if var_165_29 <= arg_162_1.time_ and arg_162_1.time_ < var_165_29 + var_165_39 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_29) / var_165_39

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_29 + var_165_39 and arg_162_1.time_ < var_165_29 + var_165_39 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {
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
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_162_1:InitPlayNodeList()
	end,
	Play420132040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 420132040
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play420132041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = arg_166_1.actors_["1061ui_story"].transform
			local var_169_1 = 0

			if var_169_1 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 then
				arg_166_1.var_.moveOldPos1061ui_story = var_169_0.localPosition
			end

			local var_169_2 = 0.001

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_2 then
				local var_169_3 = (arg_166_1.time_ - var_169_1) / var_169_2
				local var_169_4 = Vector3.New(0, 100, 0)

				var_169_0.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1061ui_story, var_169_4, var_169_3)

				local var_169_5 = manager.ui.mainCamera.transform.position - var_169_0.position

				var_169_0.forward = Vector3.New(var_169_5.x, var_169_5.y, var_169_5.z)

				local var_169_6 = var_169_0.localEulerAngles

				var_169_6.z = 0
				var_169_6.x = 0
				var_169_0.localEulerAngles = var_169_6
			end

			if arg_166_1.time_ >= var_169_1 + var_169_2 and arg_166_1.time_ < var_169_1 + var_169_2 + arg_169_0 then
				var_169_0.localPosition = Vector3.New(0, 100, 0)

				local var_169_7 = manager.ui.mainCamera.transform.position - var_169_0.position

				var_169_0.forward = Vector3.New(var_169_7.x, var_169_7.y, var_169_7.z)

				local var_169_8 = var_169_0.localEulerAngles

				var_169_8.z = 0
				var_169_8.x = 0
				var_169_0.localEulerAngles = var_169_8
			end

			local var_169_9 = arg_166_1.actors_["1085ui_story"].transform
			local var_169_10 = 0

			if var_169_10 < arg_166_1.time_ and arg_166_1.time_ <= var_169_10 + arg_169_0 then
				arg_166_1.var_.moveOldPos1085ui_story = var_169_9.localPosition
			end

			local var_169_11 = 0.001

			if var_169_10 <= arg_166_1.time_ and arg_166_1.time_ < var_169_10 + var_169_11 then
				local var_169_12 = (arg_166_1.time_ - var_169_10) / var_169_11
				local var_169_13 = Vector3.New(0, 100, 0)

				var_169_9.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1085ui_story, var_169_13, var_169_12)

				local var_169_14 = manager.ui.mainCamera.transform.position - var_169_9.position

				var_169_9.forward = Vector3.New(var_169_14.x, var_169_14.y, var_169_14.z)

				local var_169_15 = var_169_9.localEulerAngles

				var_169_15.z = 0
				var_169_15.x = 0
				var_169_9.localEulerAngles = var_169_15
			end

			if arg_166_1.time_ >= var_169_10 + var_169_11 and arg_166_1.time_ < var_169_10 + var_169_11 + arg_169_0 then
				var_169_9.localPosition = Vector3.New(0, 100, 0)

				local var_169_16 = manager.ui.mainCamera.transform.position - var_169_9.position

				var_169_9.forward = Vector3.New(var_169_16.x, var_169_16.y, var_169_16.z)

				local var_169_17 = var_169_9.localEulerAngles

				var_169_17.z = 0
				var_169_17.x = 0
				var_169_9.localEulerAngles = var_169_17
			end

			local var_169_18 = 0
			local var_169_19 = 0.45

			if var_169_18 < arg_166_1.time_ and arg_166_1.time_ <= var_169_18 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_20 = arg_166_1:FormatText(StoryNameCfg[7].name)

				arg_166_1.leftNameTxt_.text = var_169_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, true)
				arg_166_1.iconController_:SetSelectedState("hero")

				arg_166_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_166_1.callingController_:SetSelectedState("normal")

				arg_166_1.keyicon_.color = Color.New(1, 1, 1)
				arg_166_1.icon_.color = Color.New(1, 1, 1)

				local var_169_21 = arg_166_1:GetWordFromCfg(420132040)
				local var_169_22 = arg_166_1:FormatText(var_169_21.content)

				arg_166_1.text_.text = var_169_22

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_23 = 18
				local var_169_24 = utf8.len(var_169_22)
				local var_169_25 = var_169_23 <= 0 and var_169_19 or var_169_19 * (var_169_24 / var_169_23)

				if var_169_25 > 0 and var_169_19 < var_169_25 then
					arg_166_1.talkMaxDuration = var_169_25

					if var_169_25 + var_169_18 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_25 + var_169_18
					end
				end

				arg_166_1.text_.text = var_169_22
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_26 = math.max(var_169_19, arg_166_1.talkMaxDuration)

			if var_169_18 <= arg_166_1.time_ and arg_166_1.time_ < var_169_18 + var_169_26 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_18) / var_169_26

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_18 + var_169_26 and arg_166_1.time_ < var_169_18 + var_169_26 + arg_169_0 then
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
				actorName = "1085ui_story",
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
	Play420132041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 420132041
		arg_170_1.duration_ = 3.47

		local var_170_0 = {
			zh = 2.4,
			ja = 3.466
		}
		local var_170_1 = manager.audio:GetLocalizationFlag()

		if var_170_0[var_170_1] ~= nil then
			arg_170_1.duration_ = var_170_0[var_170_1]
		end

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play420132042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = arg_170_1.actors_["1061ui_story"].transform
			local var_173_1 = 0

			if var_173_1 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 then
				arg_170_1.var_.moveOldPos1061ui_story = var_173_0.localPosition
			end

			local var_173_2 = 0.001

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_2 then
				local var_173_3 = (arg_170_1.time_ - var_173_1) / var_173_2
				local var_173_4 = Vector3.New(0, -1.18, -6.15)

				var_173_0.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos1061ui_story, var_173_4, var_173_3)

				local var_173_5 = manager.ui.mainCamera.transform.position - var_173_0.position

				var_173_0.forward = Vector3.New(var_173_5.x, var_173_5.y, var_173_5.z)

				local var_173_6 = var_173_0.localEulerAngles

				var_173_6.z = 0
				var_173_6.x = 0
				var_173_0.localEulerAngles = var_173_6
			end

			if arg_170_1.time_ >= var_173_1 + var_173_2 and arg_170_1.time_ < var_173_1 + var_173_2 + arg_173_0 then
				var_173_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_173_7 = manager.ui.mainCamera.transform.position - var_173_0.position

				var_173_0.forward = Vector3.New(var_173_7.x, var_173_7.y, var_173_7.z)

				local var_173_8 = var_173_0.localEulerAngles

				var_173_8.z = 0
				var_173_8.x = 0
				var_173_0.localEulerAngles = var_173_8
			end

			local var_173_9 = arg_170_1.actors_["1061ui_story"]
			local var_173_10 = 0

			if var_173_10 < arg_170_1.time_ and arg_170_1.time_ <= var_173_10 + arg_173_0 and not isNil(var_173_9) and arg_170_1.var_.characterEffect1061ui_story == nil then
				arg_170_1.var_.characterEffect1061ui_story = var_173_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_11 = 0.200000002980232

			if var_173_10 <= arg_170_1.time_ and arg_170_1.time_ < var_173_10 + var_173_11 and not isNil(var_173_9) then
				local var_173_12 = (arg_170_1.time_ - var_173_10) / var_173_11

				if arg_170_1.var_.characterEffect1061ui_story and not isNil(var_173_9) then
					arg_170_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_170_1.time_ >= var_173_10 + var_173_11 and arg_170_1.time_ < var_173_10 + var_173_11 + arg_173_0 and not isNil(var_173_9) and arg_170_1.var_.characterEffect1061ui_story then
				arg_170_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_173_13 = 0

			if var_173_13 < arg_170_1.time_ and arg_170_1.time_ <= var_173_13 + arg_173_0 then
				arg_170_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			local var_173_14 = 0
			local var_173_15 = 0.3

			if var_173_14 < arg_170_1.time_ and arg_170_1.time_ <= var_173_14 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_16 = arg_170_1:FormatText(StoryNameCfg[612].name)

				arg_170_1.leftNameTxt_.text = var_173_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_17 = arg_170_1:GetWordFromCfg(420132041)
				local var_173_18 = arg_170_1:FormatText(var_173_17.content)

				arg_170_1.text_.text = var_173_18

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_19 = 12
				local var_173_20 = utf8.len(var_173_18)
				local var_173_21 = var_173_19 <= 0 and var_173_15 or var_173_15 * (var_173_20 / var_173_19)

				if var_173_21 > 0 and var_173_15 < var_173_21 then
					arg_170_1.talkMaxDuration = var_173_21

					if var_173_21 + var_173_14 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_21 + var_173_14
					end
				end

				arg_170_1.text_.text = var_173_18
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132041", "story_v_out_420132.awb") ~= 0 then
					local var_173_22 = manager.audio:GetVoiceLength("story_v_out_420132", "420132041", "story_v_out_420132.awb") / 1000

					if var_173_22 + var_173_14 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_22 + var_173_14
					end

					if var_173_17.prefab_name ~= "" and arg_170_1.actors_[var_173_17.prefab_name] ~= nil then
						local var_173_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_17.prefab_name].transform, "story_v_out_420132", "420132041", "story_v_out_420132.awb")

						arg_170_1:RecordAudio("420132041", var_173_23)
						arg_170_1:RecordAudio("420132041", var_173_23)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_420132", "420132041", "story_v_out_420132.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_420132", "420132041", "story_v_out_420132.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_24 = math.max(var_173_15, arg_170_1.talkMaxDuration)

			if var_173_14 <= arg_170_1.time_ and arg_170_1.time_ < var_173_14 + var_173_24 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_14) / var_173_24

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_14 + var_173_24 and arg_170_1.time_ < var_173_14 + var_173_24 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
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

		arg_170_1:InitPlayNodeList()
	end,
	Play420132042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 420132042
		arg_174_1.duration_ = 18.83

		local var_174_0 = {
			zh = 12.133,
			ja = 18.833
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play420132043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = 0
			local var_177_1 = 1.55

			if var_177_0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_0 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_2 = arg_174_1:FormatText(StoryNameCfg[612].name)

				arg_174_1.leftNameTxt_.text = var_177_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_3 = arg_174_1:GetWordFromCfg(420132042)
				local var_177_4 = arg_174_1:FormatText(var_177_3.content)

				arg_174_1.text_.text = var_177_4

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_5 = 62
				local var_177_6 = utf8.len(var_177_4)
				local var_177_7 = var_177_5 <= 0 and var_177_1 or var_177_1 * (var_177_6 / var_177_5)

				if var_177_7 > 0 and var_177_1 < var_177_7 then
					arg_174_1.talkMaxDuration = var_177_7

					if var_177_7 + var_177_0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_7 + var_177_0
					end
				end

				arg_174_1.text_.text = var_177_4
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132042", "story_v_out_420132.awb") ~= 0 then
					local var_177_8 = manager.audio:GetVoiceLength("story_v_out_420132", "420132042", "story_v_out_420132.awb") / 1000

					if var_177_8 + var_177_0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_8 + var_177_0
					end

					if var_177_3.prefab_name ~= "" and arg_174_1.actors_[var_177_3.prefab_name] ~= nil then
						local var_177_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_3.prefab_name].transform, "story_v_out_420132", "420132042", "story_v_out_420132.awb")

						arg_174_1:RecordAudio("420132042", var_177_9)
						arg_174_1:RecordAudio("420132042", var_177_9)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_420132", "420132042", "story_v_out_420132.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_420132", "420132042", "story_v_out_420132.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_10 = math.max(var_177_1, arg_174_1.talkMaxDuration)

			if var_177_0 <= arg_174_1.time_ and arg_174_1.time_ < var_177_0 + var_177_10 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_0) / var_177_10

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_0 + var_177_10 and arg_174_1.time_ < var_177_0 + var_177_10 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play420132043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 420132043
		arg_178_1.duration_ = 9.4

		local var_178_0 = {
			zh = 6.933,
			ja = 9.4
		}
		local var_178_1 = manager.audio:GetLocalizationFlag()

		if var_178_0[var_178_1] ~= nil then
			arg_178_1.duration_ = var_178_0[var_178_1]
		end

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play420132044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 0
			local var_181_1 = 0.65

			if var_181_0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_0 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_2 = arg_178_1:FormatText(StoryNameCfg[612].name)

				arg_178_1.leftNameTxt_.text = var_181_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_3 = arg_178_1:GetWordFromCfg(420132043)
				local var_181_4 = arg_178_1:FormatText(var_181_3.content)

				arg_178_1.text_.text = var_181_4

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_5 = 26
				local var_181_6 = utf8.len(var_181_4)
				local var_181_7 = var_181_5 <= 0 and var_181_1 or var_181_1 * (var_181_6 / var_181_5)

				if var_181_7 > 0 and var_181_1 < var_181_7 then
					arg_178_1.talkMaxDuration = var_181_7

					if var_181_7 + var_181_0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_7 + var_181_0
					end
				end

				arg_178_1.text_.text = var_181_4
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132043", "story_v_out_420132.awb") ~= 0 then
					local var_181_8 = manager.audio:GetVoiceLength("story_v_out_420132", "420132043", "story_v_out_420132.awb") / 1000

					if var_181_8 + var_181_0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_8 + var_181_0
					end

					if var_181_3.prefab_name ~= "" and arg_178_1.actors_[var_181_3.prefab_name] ~= nil then
						local var_181_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_3.prefab_name].transform, "story_v_out_420132", "420132043", "story_v_out_420132.awb")

						arg_178_1:RecordAudio("420132043", var_181_9)
						arg_178_1:RecordAudio("420132043", var_181_9)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_420132", "420132043", "story_v_out_420132.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_420132", "420132043", "story_v_out_420132.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_10 = math.max(var_181_1, arg_178_1.talkMaxDuration)

			if var_181_0 <= arg_178_1.time_ and arg_178_1.time_ < var_181_0 + var_181_10 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_0) / var_181_10

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_0 + var_181_10 and arg_178_1.time_ < var_181_0 + var_181_10 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play420132044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 420132044
		arg_182_1.duration_ = 8.8

		local var_182_0 = {
			zh = 8.433,
			ja = 8.8
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
				arg_182_0:Play420132045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = 0
			local var_185_1 = 0.925

			if var_185_0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_0 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_2 = arg_182_1:FormatText(StoryNameCfg[612].name)

				arg_182_1.leftNameTxt_.text = var_185_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_3 = arg_182_1:GetWordFromCfg(420132044)
				local var_185_4 = arg_182_1:FormatText(var_185_3.content)

				arg_182_1.text_.text = var_185_4

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_5 = 37
				local var_185_6 = utf8.len(var_185_4)
				local var_185_7 = var_185_5 <= 0 and var_185_1 or var_185_1 * (var_185_6 / var_185_5)

				if var_185_7 > 0 and var_185_1 < var_185_7 then
					arg_182_1.talkMaxDuration = var_185_7

					if var_185_7 + var_185_0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_7 + var_185_0
					end
				end

				arg_182_1.text_.text = var_185_4
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132044", "story_v_out_420132.awb") ~= 0 then
					local var_185_8 = manager.audio:GetVoiceLength("story_v_out_420132", "420132044", "story_v_out_420132.awb") / 1000

					if var_185_8 + var_185_0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_8 + var_185_0
					end

					if var_185_3.prefab_name ~= "" and arg_182_1.actors_[var_185_3.prefab_name] ~= nil then
						local var_185_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_3.prefab_name].transform, "story_v_out_420132", "420132044", "story_v_out_420132.awb")

						arg_182_1:RecordAudio("420132044", var_185_9)
						arg_182_1:RecordAudio("420132044", var_185_9)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_420132", "420132044", "story_v_out_420132.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_420132", "420132044", "story_v_out_420132.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_10 = math.max(var_185_1, arg_182_1.talkMaxDuration)

			if var_185_0 <= arg_182_1.time_ and arg_182_1.time_ < var_185_0 + var_185_10 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_0) / var_185_10

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_0 + var_185_10 and arg_182_1.time_ < var_185_0 + var_185_10 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play420132045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 420132045
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play420132046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = arg_186_1.actors_["1061ui_story"].transform
			local var_189_1 = 0

			if var_189_1 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 then
				arg_186_1.var_.moveOldPos1061ui_story = var_189_0.localPosition
			end

			local var_189_2 = 0.001

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_2 then
				local var_189_3 = (arg_186_1.time_ - var_189_1) / var_189_2
				local var_189_4 = Vector3.New(0, 100, 0)

				var_189_0.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos1061ui_story, var_189_4, var_189_3)

				local var_189_5 = manager.ui.mainCamera.transform.position - var_189_0.position

				var_189_0.forward = Vector3.New(var_189_5.x, var_189_5.y, var_189_5.z)

				local var_189_6 = var_189_0.localEulerAngles

				var_189_6.z = 0
				var_189_6.x = 0
				var_189_0.localEulerAngles = var_189_6
			end

			if arg_186_1.time_ >= var_189_1 + var_189_2 and arg_186_1.time_ < var_189_1 + var_189_2 + arg_189_0 then
				var_189_0.localPosition = Vector3.New(0, 100, 0)

				local var_189_7 = manager.ui.mainCamera.transform.position - var_189_0.position

				var_189_0.forward = Vector3.New(var_189_7.x, var_189_7.y, var_189_7.z)

				local var_189_8 = var_189_0.localEulerAngles

				var_189_8.z = 0
				var_189_8.x = 0
				var_189_0.localEulerAngles = var_189_8
			end

			local var_189_9 = 0
			local var_189_10 = 1.1

			if var_189_9 < arg_186_1.time_ and arg_186_1.time_ <= var_189_9 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, false)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_11 = arg_186_1:GetWordFromCfg(420132045)
				local var_189_12 = arg_186_1:FormatText(var_189_11.content)

				arg_186_1.text_.text = var_189_12

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_13 = 44
				local var_189_14 = utf8.len(var_189_12)
				local var_189_15 = var_189_13 <= 0 and var_189_10 or var_189_10 * (var_189_14 / var_189_13)

				if var_189_15 > 0 and var_189_10 < var_189_15 then
					arg_186_1.talkMaxDuration = var_189_15

					if var_189_15 + var_189_9 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_15 + var_189_9
					end
				end

				arg_186_1.text_.text = var_189_12
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_16 = math.max(var_189_10, arg_186_1.talkMaxDuration)

			if var_189_9 <= arg_186_1.time_ and arg_186_1.time_ < var_189_9 + var_189_16 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_9) / var_189_16

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_9 + var_189_16 and arg_186_1.time_ < var_189_9 + var_189_16 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
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

		arg_186_1:InitPlayNodeList()
	end,
	Play420132046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 420132046
		arg_190_1.duration_ = 5.47

		local var_190_0 = {
			zh = 3.866,
			ja = 5.466
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
				arg_190_0:Play420132047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = arg_190_1.actors_["1085ui_story"].transform
			local var_193_1 = 0

			if var_193_1 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 then
				arg_190_1.var_.moveOldPos1085ui_story = var_193_0.localPosition
			end

			local var_193_2 = 0.001

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_2 then
				local var_193_3 = (arg_190_1.time_ - var_193_1) / var_193_2
				local var_193_4 = Vector3.New(0, -1.01, -5.83)

				var_193_0.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos1085ui_story, var_193_4, var_193_3)

				local var_193_5 = manager.ui.mainCamera.transform.position - var_193_0.position

				var_193_0.forward = Vector3.New(var_193_5.x, var_193_5.y, var_193_5.z)

				local var_193_6 = var_193_0.localEulerAngles

				var_193_6.z = 0
				var_193_6.x = 0
				var_193_0.localEulerAngles = var_193_6
			end

			if arg_190_1.time_ >= var_193_1 + var_193_2 and arg_190_1.time_ < var_193_1 + var_193_2 + arg_193_0 then
				var_193_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_193_7 = manager.ui.mainCamera.transform.position - var_193_0.position

				var_193_0.forward = Vector3.New(var_193_7.x, var_193_7.y, var_193_7.z)

				local var_193_8 = var_193_0.localEulerAngles

				var_193_8.z = 0
				var_193_8.x = 0
				var_193_0.localEulerAngles = var_193_8
			end

			local var_193_9 = arg_190_1.actors_["1085ui_story"]
			local var_193_10 = 0

			if var_193_10 < arg_190_1.time_ and arg_190_1.time_ <= var_193_10 + arg_193_0 and not isNil(var_193_9) and arg_190_1.var_.characterEffect1085ui_story == nil then
				arg_190_1.var_.characterEffect1085ui_story = var_193_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_11 = 0.200000002980232

			if var_193_10 <= arg_190_1.time_ and arg_190_1.time_ < var_193_10 + var_193_11 and not isNil(var_193_9) then
				local var_193_12 = (arg_190_1.time_ - var_193_10) / var_193_11

				if arg_190_1.var_.characterEffect1085ui_story and not isNil(var_193_9) then
					arg_190_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= var_193_10 + var_193_11 and arg_190_1.time_ < var_193_10 + var_193_11 + arg_193_0 and not isNil(var_193_9) and arg_190_1.var_.characterEffect1085ui_story then
				arg_190_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_193_13 = 0

			if var_193_13 < arg_190_1.time_ and arg_190_1.time_ <= var_193_13 + arg_193_0 then
				arg_190_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_193_14 = 0
			local var_193_15 = 0.25

			if var_193_14 < arg_190_1.time_ and arg_190_1.time_ <= var_193_14 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_16 = arg_190_1:FormatText(StoryNameCfg[328].name)

				arg_190_1.leftNameTxt_.text = var_193_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_17 = arg_190_1:GetWordFromCfg(420132046)
				local var_193_18 = arg_190_1:FormatText(var_193_17.content)

				arg_190_1.text_.text = var_193_18

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_19 = 10
				local var_193_20 = utf8.len(var_193_18)
				local var_193_21 = var_193_19 <= 0 and var_193_15 or var_193_15 * (var_193_20 / var_193_19)

				if var_193_21 > 0 and var_193_15 < var_193_21 then
					arg_190_1.talkMaxDuration = var_193_21

					if var_193_21 + var_193_14 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_21 + var_193_14
					end
				end

				arg_190_1.text_.text = var_193_18
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132046", "story_v_out_420132.awb") ~= 0 then
					local var_193_22 = manager.audio:GetVoiceLength("story_v_out_420132", "420132046", "story_v_out_420132.awb") / 1000

					if var_193_22 + var_193_14 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_22 + var_193_14
					end

					if var_193_17.prefab_name ~= "" and arg_190_1.actors_[var_193_17.prefab_name] ~= nil then
						local var_193_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_17.prefab_name].transform, "story_v_out_420132", "420132046", "story_v_out_420132.awb")

						arg_190_1:RecordAudio("420132046", var_193_23)
						arg_190_1:RecordAudio("420132046", var_193_23)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_420132", "420132046", "story_v_out_420132.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_420132", "420132046", "story_v_out_420132.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_24 = math.max(var_193_15, arg_190_1.talkMaxDuration)

			if var_193_14 <= arg_190_1.time_ and arg_190_1.time_ < var_193_14 + var_193_24 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_14) / var_193_24

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_14 + var_193_24 and arg_190_1.time_ < var_193_14 + var_193_24 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_190_1:InitPlayNodeList()
	end,
	Play420132047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 420132047
		arg_194_1.duration_ = 8.67

		local var_194_0 = {
			zh = 5.1,
			ja = 8.666
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
				arg_194_0:Play420132048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = arg_194_1.actors_["1085ui_story"].transform
			local var_197_1 = 0

			if var_197_1 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 then
				arg_194_1.var_.moveOldPos1085ui_story = var_197_0.localPosition
			end

			local var_197_2 = 0.001

			if var_197_1 <= arg_194_1.time_ and arg_194_1.time_ < var_197_1 + var_197_2 then
				local var_197_3 = (arg_194_1.time_ - var_197_1) / var_197_2
				local var_197_4 = Vector3.New(0, 100, 0)

				var_197_0.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos1085ui_story, var_197_4, var_197_3)

				local var_197_5 = manager.ui.mainCamera.transform.position - var_197_0.position

				var_197_0.forward = Vector3.New(var_197_5.x, var_197_5.y, var_197_5.z)

				local var_197_6 = var_197_0.localEulerAngles

				var_197_6.z = 0
				var_197_6.x = 0
				var_197_0.localEulerAngles = var_197_6
			end

			if arg_194_1.time_ >= var_197_1 + var_197_2 and arg_194_1.time_ < var_197_1 + var_197_2 + arg_197_0 then
				var_197_0.localPosition = Vector3.New(0, 100, 0)

				local var_197_7 = manager.ui.mainCamera.transform.position - var_197_0.position

				var_197_0.forward = Vector3.New(var_197_7.x, var_197_7.y, var_197_7.z)

				local var_197_8 = var_197_0.localEulerAngles

				var_197_8.z = 0
				var_197_8.x = 0
				var_197_0.localEulerAngles = var_197_8
			end

			local var_197_9 = arg_194_1.actors_["1061ui_story"].transform
			local var_197_10 = 0

			if var_197_10 < arg_194_1.time_ and arg_194_1.time_ <= var_197_10 + arg_197_0 then
				arg_194_1.var_.moveOldPos1061ui_story = var_197_9.localPosition
			end

			local var_197_11 = 0.001

			if var_197_10 <= arg_194_1.time_ and arg_194_1.time_ < var_197_10 + var_197_11 then
				local var_197_12 = (arg_194_1.time_ - var_197_10) / var_197_11
				local var_197_13 = Vector3.New(0, -1.18, -6.15)

				var_197_9.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos1061ui_story, var_197_13, var_197_12)

				local var_197_14 = manager.ui.mainCamera.transform.position - var_197_9.position

				var_197_9.forward = Vector3.New(var_197_14.x, var_197_14.y, var_197_14.z)

				local var_197_15 = var_197_9.localEulerAngles

				var_197_15.z = 0
				var_197_15.x = 0
				var_197_9.localEulerAngles = var_197_15
			end

			if arg_194_1.time_ >= var_197_10 + var_197_11 and arg_194_1.time_ < var_197_10 + var_197_11 + arg_197_0 then
				var_197_9.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_197_16 = manager.ui.mainCamera.transform.position - var_197_9.position

				var_197_9.forward = Vector3.New(var_197_16.x, var_197_16.y, var_197_16.z)

				local var_197_17 = var_197_9.localEulerAngles

				var_197_17.z = 0
				var_197_17.x = 0
				var_197_9.localEulerAngles = var_197_17
			end

			local var_197_18 = arg_194_1.actors_["1061ui_story"]
			local var_197_19 = 0

			if var_197_19 < arg_194_1.time_ and arg_194_1.time_ <= var_197_19 + arg_197_0 and not isNil(var_197_18) and arg_194_1.var_.characterEffect1061ui_story == nil then
				arg_194_1.var_.characterEffect1061ui_story = var_197_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_20 = 0.200000002980232

			if var_197_19 <= arg_194_1.time_ and arg_194_1.time_ < var_197_19 + var_197_20 and not isNil(var_197_18) then
				local var_197_21 = (arg_194_1.time_ - var_197_19) / var_197_20

				if arg_194_1.var_.characterEffect1061ui_story and not isNil(var_197_18) then
					arg_194_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= var_197_19 + var_197_20 and arg_194_1.time_ < var_197_19 + var_197_20 + arg_197_0 and not isNil(var_197_18) and arg_194_1.var_.characterEffect1061ui_story then
				arg_194_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_197_22 = arg_194_1.actors_["1085ui_story"]
			local var_197_23 = 0

			if var_197_23 < arg_194_1.time_ and arg_194_1.time_ <= var_197_23 + arg_197_0 and not isNil(var_197_22) and arg_194_1.var_.characterEffect1085ui_story == nil then
				arg_194_1.var_.characterEffect1085ui_story = var_197_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_24 = 0.200000002980232

			if var_197_23 <= arg_194_1.time_ and arg_194_1.time_ < var_197_23 + var_197_24 and not isNil(var_197_22) then
				local var_197_25 = (arg_194_1.time_ - var_197_23) / var_197_24

				if arg_194_1.var_.characterEffect1085ui_story and not isNil(var_197_22) then
					local var_197_26 = Mathf.Lerp(0, 0.5, var_197_25)

					arg_194_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_194_1.var_.characterEffect1085ui_story.fillRatio = var_197_26
				end
			end

			if arg_194_1.time_ >= var_197_23 + var_197_24 and arg_194_1.time_ < var_197_23 + var_197_24 + arg_197_0 and not isNil(var_197_22) and arg_194_1.var_.characterEffect1085ui_story then
				local var_197_27 = 0.5

				arg_194_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_194_1.var_.characterEffect1085ui_story.fillRatio = var_197_27
			end

			local var_197_28 = 0
			local var_197_29 = 0.475

			if var_197_28 < arg_194_1.time_ and arg_194_1.time_ <= var_197_28 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_30 = arg_194_1:FormatText(StoryNameCfg[612].name)

				arg_194_1.leftNameTxt_.text = var_197_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_31 = arg_194_1:GetWordFromCfg(420132047)
				local var_197_32 = arg_194_1:FormatText(var_197_31.content)

				arg_194_1.text_.text = var_197_32

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_33 = 19
				local var_197_34 = utf8.len(var_197_32)
				local var_197_35 = var_197_33 <= 0 and var_197_29 or var_197_29 * (var_197_34 / var_197_33)

				if var_197_35 > 0 and var_197_29 < var_197_35 then
					arg_194_1.talkMaxDuration = var_197_35

					if var_197_35 + var_197_28 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_35 + var_197_28
					end
				end

				arg_194_1.text_.text = var_197_32
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132047", "story_v_out_420132.awb") ~= 0 then
					local var_197_36 = manager.audio:GetVoiceLength("story_v_out_420132", "420132047", "story_v_out_420132.awb") / 1000

					if var_197_36 + var_197_28 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_36 + var_197_28
					end

					if var_197_31.prefab_name ~= "" and arg_194_1.actors_[var_197_31.prefab_name] ~= nil then
						local var_197_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_31.prefab_name].transform, "story_v_out_420132", "420132047", "story_v_out_420132.awb")

						arg_194_1:RecordAudio("420132047", var_197_37)
						arg_194_1:RecordAudio("420132047", var_197_37)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_420132", "420132047", "story_v_out_420132.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_420132", "420132047", "story_v_out_420132.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_38 = math.max(var_197_29, arg_194_1.talkMaxDuration)

			if var_197_28 <= arg_194_1.time_ and arg_194_1.time_ < var_197_28 + var_197_38 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_28) / var_197_38

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_28 + var_197_38 and arg_194_1.time_ < var_197_28 + var_197_38 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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

		arg_194_1:InitPlayNodeList()
	end,
	Play420132048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 420132048
		arg_198_1.duration_ = 12.27

		local var_198_0 = {
			zh = 9.5,
			ja = 12.266
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play420132049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = arg_198_1.actors_["1061ui_story"].transform
			local var_201_1 = 0

			if var_201_1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 then
				arg_198_1.var_.moveOldPos1061ui_story = var_201_0.localPosition
			end

			local var_201_2 = 0.001

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_2 then
				local var_201_3 = (arg_198_1.time_ - var_201_1) / var_201_2
				local var_201_4 = Vector3.New(-0.7, -1.18, -6.15)

				var_201_0.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos1061ui_story, var_201_4, var_201_3)

				local var_201_5 = manager.ui.mainCamera.transform.position - var_201_0.position

				var_201_0.forward = Vector3.New(var_201_5.x, var_201_5.y, var_201_5.z)

				local var_201_6 = var_201_0.localEulerAngles

				var_201_6.z = 0
				var_201_6.x = 0
				var_201_0.localEulerAngles = var_201_6
			end

			if arg_198_1.time_ >= var_201_1 + var_201_2 and arg_198_1.time_ < var_201_1 + var_201_2 + arg_201_0 then
				var_201_0.localPosition = Vector3.New(-0.7, -1.18, -6.15)

				local var_201_7 = manager.ui.mainCamera.transform.position - var_201_0.position

				var_201_0.forward = Vector3.New(var_201_7.x, var_201_7.y, var_201_7.z)

				local var_201_8 = var_201_0.localEulerAngles

				var_201_8.z = 0
				var_201_8.x = 0
				var_201_0.localEulerAngles = var_201_8
			end

			local var_201_9 = arg_198_1.actors_["1085ui_story"].transform
			local var_201_10 = 0

			if var_201_10 < arg_198_1.time_ and arg_198_1.time_ <= var_201_10 + arg_201_0 then
				arg_198_1.var_.moveOldPos1085ui_story = var_201_9.localPosition
			end

			local var_201_11 = 0.001

			if var_201_10 <= arg_198_1.time_ and arg_198_1.time_ < var_201_10 + var_201_11 then
				local var_201_12 = (arg_198_1.time_ - var_201_10) / var_201_11
				local var_201_13 = Vector3.New(0.75, -1.01, -5.83)

				var_201_9.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos1085ui_story, var_201_13, var_201_12)

				local var_201_14 = manager.ui.mainCamera.transform.position - var_201_9.position

				var_201_9.forward = Vector3.New(var_201_14.x, var_201_14.y, var_201_14.z)

				local var_201_15 = var_201_9.localEulerAngles

				var_201_15.z = 0
				var_201_15.x = 0
				var_201_9.localEulerAngles = var_201_15
			end

			if arg_198_1.time_ >= var_201_10 + var_201_11 and arg_198_1.time_ < var_201_10 + var_201_11 + arg_201_0 then
				var_201_9.localPosition = Vector3.New(0.75, -1.01, -5.83)

				local var_201_16 = manager.ui.mainCamera.transform.position - var_201_9.position

				var_201_9.forward = Vector3.New(var_201_16.x, var_201_16.y, var_201_16.z)

				local var_201_17 = var_201_9.localEulerAngles

				var_201_17.z = 0
				var_201_17.x = 0
				var_201_9.localEulerAngles = var_201_17
			end

			local var_201_18 = arg_198_1.actors_["1085ui_story"]
			local var_201_19 = 0

			if var_201_19 < arg_198_1.time_ and arg_198_1.time_ <= var_201_19 + arg_201_0 and not isNil(var_201_18) and arg_198_1.var_.characterEffect1085ui_story == nil then
				arg_198_1.var_.characterEffect1085ui_story = var_201_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_20 = 0.200000002980232

			if var_201_19 <= arg_198_1.time_ and arg_198_1.time_ < var_201_19 + var_201_20 and not isNil(var_201_18) then
				local var_201_21 = (arg_198_1.time_ - var_201_19) / var_201_20

				if arg_198_1.var_.characterEffect1085ui_story and not isNil(var_201_18) then
					arg_198_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_198_1.time_ >= var_201_19 + var_201_20 and arg_198_1.time_ < var_201_19 + var_201_20 + arg_201_0 and not isNil(var_201_18) and arg_198_1.var_.characterEffect1085ui_story then
				arg_198_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_201_22 = arg_198_1.actors_["1061ui_story"]
			local var_201_23 = 0

			if var_201_23 < arg_198_1.time_ and arg_198_1.time_ <= var_201_23 + arg_201_0 and not isNil(var_201_22) and arg_198_1.var_.characterEffect1061ui_story == nil then
				arg_198_1.var_.characterEffect1061ui_story = var_201_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_24 = 0.200000002980232

			if var_201_23 <= arg_198_1.time_ and arg_198_1.time_ < var_201_23 + var_201_24 and not isNil(var_201_22) then
				local var_201_25 = (arg_198_1.time_ - var_201_23) / var_201_24

				if arg_198_1.var_.characterEffect1061ui_story and not isNil(var_201_22) then
					local var_201_26 = Mathf.Lerp(0, 0.5, var_201_25)

					arg_198_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_198_1.var_.characterEffect1061ui_story.fillRatio = var_201_26
				end
			end

			if arg_198_1.time_ >= var_201_23 + var_201_24 and arg_198_1.time_ < var_201_23 + var_201_24 + arg_201_0 and not isNil(var_201_22) and arg_198_1.var_.characterEffect1061ui_story then
				local var_201_27 = 0.5

				arg_198_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_198_1.var_.characterEffect1061ui_story.fillRatio = var_201_27
			end

			local var_201_28 = 0
			local var_201_29 = 0.775

			if var_201_28 < arg_198_1.time_ and arg_198_1.time_ <= var_201_28 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				local var_201_30 = arg_198_1:FormatText(StoryNameCfg[328].name)

				arg_198_1.leftNameTxt_.text = var_201_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_31 = arg_198_1:GetWordFromCfg(420132048)
				local var_201_32 = arg_198_1:FormatText(var_201_31.content)

				arg_198_1.text_.text = var_201_32

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_33 = 31
				local var_201_34 = utf8.len(var_201_32)
				local var_201_35 = var_201_33 <= 0 and var_201_29 or var_201_29 * (var_201_34 / var_201_33)

				if var_201_35 > 0 and var_201_29 < var_201_35 then
					arg_198_1.talkMaxDuration = var_201_35

					if var_201_35 + var_201_28 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_35 + var_201_28
					end
				end

				arg_198_1.text_.text = var_201_32
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132048", "story_v_out_420132.awb") ~= 0 then
					local var_201_36 = manager.audio:GetVoiceLength("story_v_out_420132", "420132048", "story_v_out_420132.awb") / 1000

					if var_201_36 + var_201_28 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_36 + var_201_28
					end

					if var_201_31.prefab_name ~= "" and arg_198_1.actors_[var_201_31.prefab_name] ~= nil then
						local var_201_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_31.prefab_name].transform, "story_v_out_420132", "420132048", "story_v_out_420132.awb")

						arg_198_1:RecordAudio("420132048", var_201_37)
						arg_198_1:RecordAudio("420132048", var_201_37)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_420132", "420132048", "story_v_out_420132.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_420132", "420132048", "story_v_out_420132.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_38 = math.max(var_201_29, arg_198_1.talkMaxDuration)

			if var_201_28 <= arg_198_1.time_ and arg_198_1.time_ < var_201_28 + var_201_38 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_28) / var_201_38

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_28 + var_201_38 and arg_198_1.time_ < var_201_28 + var_201_38 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
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
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_198_1:InitPlayNodeList()
	end,
	Play420132049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 420132049
		arg_202_1.duration_ = 12.83

		local var_202_0 = {
			zh = 7.133,
			ja = 12.833
		}
		local var_202_1 = manager.audio:GetLocalizationFlag()

		if var_202_0[var_202_1] ~= nil then
			arg_202_1.duration_ = var_202_0[var_202_1]
		end

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play420132050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = arg_202_1.actors_["1061ui_story"]
			local var_205_1 = 0

			if var_205_1 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.characterEffect1061ui_story == nil then
				arg_202_1.var_.characterEffect1061ui_story = var_205_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_2 = 0.200000002980232

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_2 and not isNil(var_205_0) then
				local var_205_3 = (arg_202_1.time_ - var_205_1) / var_205_2

				if arg_202_1.var_.characterEffect1061ui_story and not isNil(var_205_0) then
					arg_202_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_202_1.time_ >= var_205_1 + var_205_2 and arg_202_1.time_ < var_205_1 + var_205_2 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.characterEffect1061ui_story then
				arg_202_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_205_4 = arg_202_1.actors_["1085ui_story"]
			local var_205_5 = 0

			if var_205_5 < arg_202_1.time_ and arg_202_1.time_ <= var_205_5 + arg_205_0 and not isNil(var_205_4) and arg_202_1.var_.characterEffect1085ui_story == nil then
				arg_202_1.var_.characterEffect1085ui_story = var_205_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_6 = 0.200000002980232

			if var_205_5 <= arg_202_1.time_ and arg_202_1.time_ < var_205_5 + var_205_6 and not isNil(var_205_4) then
				local var_205_7 = (arg_202_1.time_ - var_205_5) / var_205_6

				if arg_202_1.var_.characterEffect1085ui_story and not isNil(var_205_4) then
					local var_205_8 = Mathf.Lerp(0, 0.5, var_205_7)

					arg_202_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_202_1.var_.characterEffect1085ui_story.fillRatio = var_205_8
				end
			end

			if arg_202_1.time_ >= var_205_5 + var_205_6 and arg_202_1.time_ < var_205_5 + var_205_6 + arg_205_0 and not isNil(var_205_4) and arg_202_1.var_.characterEffect1085ui_story then
				local var_205_9 = 0.5

				arg_202_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_202_1.var_.characterEffect1085ui_story.fillRatio = var_205_9
			end

			local var_205_10 = 0
			local var_205_11 = 0.775

			if var_205_10 < arg_202_1.time_ and arg_202_1.time_ <= var_205_10 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_12 = arg_202_1:FormatText(StoryNameCfg[612].name)

				arg_202_1.leftNameTxt_.text = var_205_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_13 = arg_202_1:GetWordFromCfg(420132049)
				local var_205_14 = arg_202_1:FormatText(var_205_13.content)

				arg_202_1.text_.text = var_205_14

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_15 = 31
				local var_205_16 = utf8.len(var_205_14)
				local var_205_17 = var_205_15 <= 0 and var_205_11 or var_205_11 * (var_205_16 / var_205_15)

				if var_205_17 > 0 and var_205_11 < var_205_17 then
					arg_202_1.talkMaxDuration = var_205_17

					if var_205_17 + var_205_10 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_17 + var_205_10
					end
				end

				arg_202_1.text_.text = var_205_14
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132049", "story_v_out_420132.awb") ~= 0 then
					local var_205_18 = manager.audio:GetVoiceLength("story_v_out_420132", "420132049", "story_v_out_420132.awb") / 1000

					if var_205_18 + var_205_10 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_18 + var_205_10
					end

					if var_205_13.prefab_name ~= "" and arg_202_1.actors_[var_205_13.prefab_name] ~= nil then
						local var_205_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_13.prefab_name].transform, "story_v_out_420132", "420132049", "story_v_out_420132.awb")

						arg_202_1:RecordAudio("420132049", var_205_19)
						arg_202_1:RecordAudio("420132049", var_205_19)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_420132", "420132049", "story_v_out_420132.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_420132", "420132049", "story_v_out_420132.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_20 = math.max(var_205_11, arg_202_1.talkMaxDuration)

			if var_205_10 <= arg_202_1.time_ and arg_202_1.time_ < var_205_10 + var_205_20 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_10) / var_205_20

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_10 + var_205_20 and arg_202_1.time_ < var_205_10 + var_205_20 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play420132050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 420132050
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play420132051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = arg_206_1.actors_["1061ui_story"].transform
			local var_209_1 = 0

			if var_209_1 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 then
				arg_206_1.var_.moveOldPos1061ui_story = var_209_0.localPosition
			end

			local var_209_2 = 0.001

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_2 then
				local var_209_3 = (arg_206_1.time_ - var_209_1) / var_209_2
				local var_209_4 = Vector3.New(0, 100, 0)

				var_209_0.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1061ui_story, var_209_4, var_209_3)

				local var_209_5 = manager.ui.mainCamera.transform.position - var_209_0.position

				var_209_0.forward = Vector3.New(var_209_5.x, var_209_5.y, var_209_5.z)

				local var_209_6 = var_209_0.localEulerAngles

				var_209_6.z = 0
				var_209_6.x = 0
				var_209_0.localEulerAngles = var_209_6
			end

			if arg_206_1.time_ >= var_209_1 + var_209_2 and arg_206_1.time_ < var_209_1 + var_209_2 + arg_209_0 then
				var_209_0.localPosition = Vector3.New(0, 100, 0)

				local var_209_7 = manager.ui.mainCamera.transform.position - var_209_0.position

				var_209_0.forward = Vector3.New(var_209_7.x, var_209_7.y, var_209_7.z)

				local var_209_8 = var_209_0.localEulerAngles

				var_209_8.z = 0
				var_209_8.x = 0
				var_209_0.localEulerAngles = var_209_8
			end

			local var_209_9 = arg_206_1.actors_["1085ui_story"].transform
			local var_209_10 = 0

			if var_209_10 < arg_206_1.time_ and arg_206_1.time_ <= var_209_10 + arg_209_0 then
				arg_206_1.var_.moveOldPos1085ui_story = var_209_9.localPosition
			end

			local var_209_11 = 0.001

			if var_209_10 <= arg_206_1.time_ and arg_206_1.time_ < var_209_10 + var_209_11 then
				local var_209_12 = (arg_206_1.time_ - var_209_10) / var_209_11
				local var_209_13 = Vector3.New(0, 100, 0)

				var_209_9.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1085ui_story, var_209_13, var_209_12)

				local var_209_14 = manager.ui.mainCamera.transform.position - var_209_9.position

				var_209_9.forward = Vector3.New(var_209_14.x, var_209_14.y, var_209_14.z)

				local var_209_15 = var_209_9.localEulerAngles

				var_209_15.z = 0
				var_209_15.x = 0
				var_209_9.localEulerAngles = var_209_15
			end

			if arg_206_1.time_ >= var_209_10 + var_209_11 and arg_206_1.time_ < var_209_10 + var_209_11 + arg_209_0 then
				var_209_9.localPosition = Vector3.New(0, 100, 0)

				local var_209_16 = manager.ui.mainCamera.transform.position - var_209_9.position

				var_209_9.forward = Vector3.New(var_209_16.x, var_209_16.y, var_209_16.z)

				local var_209_17 = var_209_9.localEulerAngles

				var_209_17.z = 0
				var_209_17.x = 0
				var_209_9.localEulerAngles = var_209_17
			end

			local var_209_18 = 0
			local var_209_19 = 1.9

			if var_209_18 < arg_206_1.time_ and arg_206_1.time_ <= var_209_18 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, false)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_20 = arg_206_1:GetWordFromCfg(420132050)
				local var_209_21 = arg_206_1:FormatText(var_209_20.content)

				arg_206_1.text_.text = var_209_21

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_22 = 76
				local var_209_23 = utf8.len(var_209_21)
				local var_209_24 = var_209_22 <= 0 and var_209_19 or var_209_19 * (var_209_23 / var_209_22)

				if var_209_24 > 0 and var_209_19 < var_209_24 then
					arg_206_1.talkMaxDuration = var_209_24

					if var_209_24 + var_209_18 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_24 + var_209_18
					end
				end

				arg_206_1.text_.text = var_209_21
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_25 = math.max(var_209_19, arg_206_1.talkMaxDuration)

			if var_209_18 <= arg_206_1.time_ and arg_206_1.time_ < var_209_18 + var_209_25 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_18) / var_209_25

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_18 + var_209_25 and arg_206_1.time_ < var_209_18 + var_209_25 + arg_209_0 then
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
				actorName = "1085ui_story",
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
	Play420132051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 420132051
		arg_210_1.duration_ = 6.77

		local var_210_0 = {
			zh = 4,
			ja = 6.766
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play420132052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = arg_210_1.actors_["1061ui_story"].transform
			local var_213_1 = 0

			if var_213_1 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 then
				arg_210_1.var_.moveOldPos1061ui_story = var_213_0.localPosition
			end

			local var_213_2 = 0.001

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_2 then
				local var_213_3 = (arg_210_1.time_ - var_213_1) / var_213_2
				local var_213_4 = Vector3.New(0, -1.18, -6.15)

				var_213_0.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos1061ui_story, var_213_4, var_213_3)

				local var_213_5 = manager.ui.mainCamera.transform.position - var_213_0.position

				var_213_0.forward = Vector3.New(var_213_5.x, var_213_5.y, var_213_5.z)

				local var_213_6 = var_213_0.localEulerAngles

				var_213_6.z = 0
				var_213_6.x = 0
				var_213_0.localEulerAngles = var_213_6
			end

			if arg_210_1.time_ >= var_213_1 + var_213_2 and arg_210_1.time_ < var_213_1 + var_213_2 + arg_213_0 then
				var_213_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_213_7 = manager.ui.mainCamera.transform.position - var_213_0.position

				var_213_0.forward = Vector3.New(var_213_7.x, var_213_7.y, var_213_7.z)

				local var_213_8 = var_213_0.localEulerAngles

				var_213_8.z = 0
				var_213_8.x = 0
				var_213_0.localEulerAngles = var_213_8
			end

			local var_213_9 = arg_210_1.actors_["1061ui_story"]
			local var_213_10 = 0

			if var_213_10 < arg_210_1.time_ and arg_210_1.time_ <= var_213_10 + arg_213_0 and not isNil(var_213_9) and arg_210_1.var_.characterEffect1061ui_story == nil then
				arg_210_1.var_.characterEffect1061ui_story = var_213_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_11 = 0.200000002980232

			if var_213_10 <= arg_210_1.time_ and arg_210_1.time_ < var_213_10 + var_213_11 and not isNil(var_213_9) then
				local var_213_12 = (arg_210_1.time_ - var_213_10) / var_213_11

				if arg_210_1.var_.characterEffect1061ui_story and not isNil(var_213_9) then
					arg_210_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_210_1.time_ >= var_213_10 + var_213_11 and arg_210_1.time_ < var_213_10 + var_213_11 + arg_213_0 and not isNil(var_213_9) and arg_210_1.var_.characterEffect1061ui_story then
				arg_210_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_213_13 = 0

			if var_213_13 < arg_210_1.time_ and arg_210_1.time_ <= var_213_13 + arg_213_0 then
				arg_210_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva", "EmotionTimelineAnimator")
			end

			local var_213_14 = 0
			local var_213_15 = 0.425

			if var_213_14 < arg_210_1.time_ and arg_210_1.time_ <= var_213_14 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				local var_213_16 = arg_210_1:FormatText(StoryNameCfg[612].name)

				arg_210_1.leftNameTxt_.text = var_213_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_17 = arg_210_1:GetWordFromCfg(420132051)
				local var_213_18 = arg_210_1:FormatText(var_213_17.content)

				arg_210_1.text_.text = var_213_18

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_19 = 17
				local var_213_20 = utf8.len(var_213_18)
				local var_213_21 = var_213_19 <= 0 and var_213_15 or var_213_15 * (var_213_20 / var_213_19)

				if var_213_21 > 0 and var_213_15 < var_213_21 then
					arg_210_1.talkMaxDuration = var_213_21

					if var_213_21 + var_213_14 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_21 + var_213_14
					end
				end

				arg_210_1.text_.text = var_213_18
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132051", "story_v_out_420132.awb") ~= 0 then
					local var_213_22 = manager.audio:GetVoiceLength("story_v_out_420132", "420132051", "story_v_out_420132.awb") / 1000

					if var_213_22 + var_213_14 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_22 + var_213_14
					end

					if var_213_17.prefab_name ~= "" and arg_210_1.actors_[var_213_17.prefab_name] ~= nil then
						local var_213_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_17.prefab_name].transform, "story_v_out_420132", "420132051", "story_v_out_420132.awb")

						arg_210_1:RecordAudio("420132051", var_213_23)
						arg_210_1:RecordAudio("420132051", var_213_23)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_420132", "420132051", "story_v_out_420132.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_420132", "420132051", "story_v_out_420132.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_24 = math.max(var_213_15, arg_210_1.talkMaxDuration)

			if var_213_14 <= arg_210_1.time_ and arg_210_1.time_ < var_213_14 + var_213_24 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_14) / var_213_24

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_14 + var_213_24 and arg_210_1.time_ < var_213_14 + var_213_24 + arg_213_0 then
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
	Play420132052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 420132052
		arg_214_1.duration_ = 2.37

		local var_214_0 = {
			zh = 1.999999999999,
			ja = 2.366
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play420132053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = arg_214_1.actors_["1061ui_story"].transform
			local var_217_1 = 0

			if var_217_1 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 then
				arg_214_1.var_.moveOldPos1061ui_story = var_217_0.localPosition
			end

			local var_217_2 = 0.001

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_2 then
				local var_217_3 = (arg_214_1.time_ - var_217_1) / var_217_2
				local var_217_4 = Vector3.New(-0.7, -1.18, -6.15)

				var_217_0.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos1061ui_story, var_217_4, var_217_3)

				local var_217_5 = manager.ui.mainCamera.transform.position - var_217_0.position

				var_217_0.forward = Vector3.New(var_217_5.x, var_217_5.y, var_217_5.z)

				local var_217_6 = var_217_0.localEulerAngles

				var_217_6.z = 0
				var_217_6.x = 0
				var_217_0.localEulerAngles = var_217_6
			end

			if arg_214_1.time_ >= var_217_1 + var_217_2 and arg_214_1.time_ < var_217_1 + var_217_2 + arg_217_0 then
				var_217_0.localPosition = Vector3.New(-0.7, -1.18, -6.15)

				local var_217_7 = manager.ui.mainCamera.transform.position - var_217_0.position

				var_217_0.forward = Vector3.New(var_217_7.x, var_217_7.y, var_217_7.z)

				local var_217_8 = var_217_0.localEulerAngles

				var_217_8.z = 0
				var_217_8.x = 0
				var_217_0.localEulerAngles = var_217_8
			end

			local var_217_9 = arg_214_1.actors_["1061ui_story"]
			local var_217_10 = 0

			if var_217_10 < arg_214_1.time_ and arg_214_1.time_ <= var_217_10 + arg_217_0 and not isNil(var_217_9) and arg_214_1.var_.characterEffect1061ui_story == nil then
				arg_214_1.var_.characterEffect1061ui_story = var_217_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_11 = 0.200000002980232

			if var_217_10 <= arg_214_1.time_ and arg_214_1.time_ < var_217_10 + var_217_11 and not isNil(var_217_9) then
				local var_217_12 = (arg_214_1.time_ - var_217_10) / var_217_11

				if arg_214_1.var_.characterEffect1061ui_story and not isNil(var_217_9) then
					local var_217_13 = Mathf.Lerp(0, 0.5, var_217_12)

					arg_214_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_214_1.var_.characterEffect1061ui_story.fillRatio = var_217_13
				end
			end

			if arg_214_1.time_ >= var_217_10 + var_217_11 and arg_214_1.time_ < var_217_10 + var_217_11 + arg_217_0 and not isNil(var_217_9) and arg_214_1.var_.characterEffect1061ui_story then
				local var_217_14 = 0.5

				arg_214_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_214_1.var_.characterEffect1061ui_story.fillRatio = var_217_14
			end

			local var_217_15 = arg_214_1.actors_["1085ui_story"].transform
			local var_217_16 = 0

			if var_217_16 < arg_214_1.time_ and arg_214_1.time_ <= var_217_16 + arg_217_0 then
				arg_214_1.var_.moveOldPos1085ui_story = var_217_15.localPosition
			end

			local var_217_17 = 0.001

			if var_217_16 <= arg_214_1.time_ and arg_214_1.time_ < var_217_16 + var_217_17 then
				local var_217_18 = (arg_214_1.time_ - var_217_16) / var_217_17
				local var_217_19 = Vector3.New(0.75, -1.01, -5.83)

				var_217_15.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos1085ui_story, var_217_19, var_217_18)

				local var_217_20 = manager.ui.mainCamera.transform.position - var_217_15.position

				var_217_15.forward = Vector3.New(var_217_20.x, var_217_20.y, var_217_20.z)

				local var_217_21 = var_217_15.localEulerAngles

				var_217_21.z = 0
				var_217_21.x = 0
				var_217_15.localEulerAngles = var_217_21
			end

			if arg_214_1.time_ >= var_217_16 + var_217_17 and arg_214_1.time_ < var_217_16 + var_217_17 + arg_217_0 then
				var_217_15.localPosition = Vector3.New(0.75, -1.01, -5.83)

				local var_217_22 = manager.ui.mainCamera.transform.position - var_217_15.position

				var_217_15.forward = Vector3.New(var_217_22.x, var_217_22.y, var_217_22.z)

				local var_217_23 = var_217_15.localEulerAngles

				var_217_23.z = 0
				var_217_23.x = 0
				var_217_15.localEulerAngles = var_217_23
			end

			local var_217_24 = arg_214_1.actors_["1085ui_story"]
			local var_217_25 = 0

			if var_217_25 < arg_214_1.time_ and arg_214_1.time_ <= var_217_25 + arg_217_0 and not isNil(var_217_24) and arg_214_1.var_.characterEffect1085ui_story == nil then
				arg_214_1.var_.characterEffect1085ui_story = var_217_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_26 = 0.200000002980232

			if var_217_25 <= arg_214_1.time_ and arg_214_1.time_ < var_217_25 + var_217_26 and not isNil(var_217_24) then
				local var_217_27 = (arg_214_1.time_ - var_217_25) / var_217_26

				if arg_214_1.var_.characterEffect1085ui_story and not isNil(var_217_24) then
					arg_214_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_214_1.time_ >= var_217_25 + var_217_26 and arg_214_1.time_ < var_217_25 + var_217_26 + arg_217_0 and not isNil(var_217_24) and arg_214_1.var_.characterEffect1085ui_story then
				arg_214_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_217_28 = 0

			if var_217_28 < arg_214_1.time_ and arg_214_1.time_ <= var_217_28 + arg_217_0 then
				arg_214_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_1")
			end

			local var_217_29 = 0

			if var_217_29 < arg_214_1.time_ and arg_214_1.time_ <= var_217_29 + arg_217_0 then
				arg_214_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_217_30 = 0
			local var_217_31 = 0.15

			if var_217_30 < arg_214_1.time_ and arg_214_1.time_ <= var_217_30 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_32 = arg_214_1:FormatText(StoryNameCfg[328].name)

				arg_214_1.leftNameTxt_.text = var_217_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_33 = arg_214_1:GetWordFromCfg(420132052)
				local var_217_34 = arg_214_1:FormatText(var_217_33.content)

				arg_214_1.text_.text = var_217_34

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_35 = 6
				local var_217_36 = utf8.len(var_217_34)
				local var_217_37 = var_217_35 <= 0 and var_217_31 or var_217_31 * (var_217_36 / var_217_35)

				if var_217_37 > 0 and var_217_31 < var_217_37 then
					arg_214_1.talkMaxDuration = var_217_37

					if var_217_37 + var_217_30 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_37 + var_217_30
					end
				end

				arg_214_1.text_.text = var_217_34
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132052", "story_v_out_420132.awb") ~= 0 then
					local var_217_38 = manager.audio:GetVoiceLength("story_v_out_420132", "420132052", "story_v_out_420132.awb") / 1000

					if var_217_38 + var_217_30 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_38 + var_217_30
					end

					if var_217_33.prefab_name ~= "" and arg_214_1.actors_[var_217_33.prefab_name] ~= nil then
						local var_217_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_33.prefab_name].transform, "story_v_out_420132", "420132052", "story_v_out_420132.awb")

						arg_214_1:RecordAudio("420132052", var_217_39)
						arg_214_1:RecordAudio("420132052", var_217_39)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_420132", "420132052", "story_v_out_420132.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_420132", "420132052", "story_v_out_420132.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_40 = math.max(var_217_31, arg_214_1.talkMaxDuration)

			if var_217_30 <= arg_214_1.time_ and arg_214_1.time_ < var_217_30 + var_217_40 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_30) / var_217_40

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_30 + var_217_40 and arg_214_1.time_ < var_217_30 + var_217_40 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
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
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_214_1:InitPlayNodeList()
	end,
	Play420132053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 420132053
		arg_218_1.duration_ = 11.2

		local var_218_0 = {
			zh = 8.866,
			ja = 11.2
		}
		local var_218_1 = manager.audio:GetLocalizationFlag()

		if var_218_0[var_218_1] ~= nil then
			arg_218_1.duration_ = var_218_0[var_218_1]
		end

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play420132054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = arg_218_1.actors_["1061ui_story"]
			local var_221_1 = 0

			if var_221_1 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 and not isNil(var_221_0) and arg_218_1.var_.characterEffect1061ui_story == nil then
				arg_218_1.var_.characterEffect1061ui_story = var_221_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_2 = 0.200000002980232

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_2 and not isNil(var_221_0) then
				local var_221_3 = (arg_218_1.time_ - var_221_1) / var_221_2

				if arg_218_1.var_.characterEffect1061ui_story and not isNil(var_221_0) then
					arg_218_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_218_1.time_ >= var_221_1 + var_221_2 and arg_218_1.time_ < var_221_1 + var_221_2 + arg_221_0 and not isNil(var_221_0) and arg_218_1.var_.characterEffect1061ui_story then
				arg_218_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_221_4 = arg_218_1.actors_["1061ui_story"].transform
			local var_221_5 = 0

			if var_221_5 < arg_218_1.time_ and arg_218_1.time_ <= var_221_5 + arg_221_0 then
				arg_218_1.var_.moveOldPos1061ui_story = var_221_4.localPosition
			end

			local var_221_6 = 0.001

			if var_221_5 <= arg_218_1.time_ and arg_218_1.time_ < var_221_5 + var_221_6 then
				local var_221_7 = (arg_218_1.time_ - var_221_5) / var_221_6
				local var_221_8 = Vector3.New(0, -1.18, -6.15)

				var_221_4.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1061ui_story, var_221_8, var_221_7)

				local var_221_9 = manager.ui.mainCamera.transform.position - var_221_4.position

				var_221_4.forward = Vector3.New(var_221_9.x, var_221_9.y, var_221_9.z)

				local var_221_10 = var_221_4.localEulerAngles

				var_221_10.z = 0
				var_221_10.x = 0
				var_221_4.localEulerAngles = var_221_10
			end

			if arg_218_1.time_ >= var_221_5 + var_221_6 and arg_218_1.time_ < var_221_5 + var_221_6 + arg_221_0 then
				var_221_4.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_221_11 = manager.ui.mainCamera.transform.position - var_221_4.position

				var_221_4.forward = Vector3.New(var_221_11.x, var_221_11.y, var_221_11.z)

				local var_221_12 = var_221_4.localEulerAngles

				var_221_12.z = 0
				var_221_12.x = 0
				var_221_4.localEulerAngles = var_221_12
			end

			local var_221_13 = arg_218_1.actors_["1085ui_story"].transform
			local var_221_14 = 0

			if var_221_14 < arg_218_1.time_ and arg_218_1.time_ <= var_221_14 + arg_221_0 then
				arg_218_1.var_.moveOldPos1085ui_story = var_221_13.localPosition
			end

			local var_221_15 = 0.001

			if var_221_14 <= arg_218_1.time_ and arg_218_1.time_ < var_221_14 + var_221_15 then
				local var_221_16 = (arg_218_1.time_ - var_221_14) / var_221_15
				local var_221_17 = Vector3.New(0, 100, 0)

				var_221_13.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1085ui_story, var_221_17, var_221_16)

				local var_221_18 = manager.ui.mainCamera.transform.position - var_221_13.position

				var_221_13.forward = Vector3.New(var_221_18.x, var_221_18.y, var_221_18.z)

				local var_221_19 = var_221_13.localEulerAngles

				var_221_19.z = 0
				var_221_19.x = 0
				var_221_13.localEulerAngles = var_221_19
			end

			if arg_218_1.time_ >= var_221_14 + var_221_15 and arg_218_1.time_ < var_221_14 + var_221_15 + arg_221_0 then
				var_221_13.localPosition = Vector3.New(0, 100, 0)

				local var_221_20 = manager.ui.mainCamera.transform.position - var_221_13.position

				var_221_13.forward = Vector3.New(var_221_20.x, var_221_20.y, var_221_20.z)

				local var_221_21 = var_221_13.localEulerAngles

				var_221_21.z = 0
				var_221_21.x = 0
				var_221_13.localEulerAngles = var_221_21
			end

			local var_221_22 = 0
			local var_221_23 = 0.9

			if var_221_22 < arg_218_1.time_ and arg_218_1.time_ <= var_221_22 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_24 = arg_218_1:FormatText(StoryNameCfg[612].name)

				arg_218_1.leftNameTxt_.text = var_221_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_25 = arg_218_1:GetWordFromCfg(420132053)
				local var_221_26 = arg_218_1:FormatText(var_221_25.content)

				arg_218_1.text_.text = var_221_26

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_27 = 36
				local var_221_28 = utf8.len(var_221_26)
				local var_221_29 = var_221_27 <= 0 and var_221_23 or var_221_23 * (var_221_28 / var_221_27)

				if var_221_29 > 0 and var_221_23 < var_221_29 then
					arg_218_1.talkMaxDuration = var_221_29

					if var_221_29 + var_221_22 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_29 + var_221_22
					end
				end

				arg_218_1.text_.text = var_221_26
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132053", "story_v_out_420132.awb") ~= 0 then
					local var_221_30 = manager.audio:GetVoiceLength("story_v_out_420132", "420132053", "story_v_out_420132.awb") / 1000

					if var_221_30 + var_221_22 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_30 + var_221_22
					end

					if var_221_25.prefab_name ~= "" and arg_218_1.actors_[var_221_25.prefab_name] ~= nil then
						local var_221_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_25.prefab_name].transform, "story_v_out_420132", "420132053", "story_v_out_420132.awb")

						arg_218_1:RecordAudio("420132053", var_221_31)
						arg_218_1:RecordAudio("420132053", var_221_31)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_420132", "420132053", "story_v_out_420132.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_420132", "420132053", "story_v_out_420132.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_32 = math.max(var_221_23, arg_218_1.talkMaxDuration)

			if var_221_22 <= arg_218_1.time_ and arg_218_1.time_ < var_221_22 + var_221_32 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_22) / var_221_32

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_22 + var_221_32 and arg_218_1.time_ < var_221_22 + var_221_32 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
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
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play420132054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 420132054
		arg_222_1.duration_ = 13.8

		local var_222_0 = {
			zh = 9.2,
			ja = 13.8
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
				arg_222_0:Play420132055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 0
			local var_225_1 = 1.25

			if var_225_0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_2 = arg_222_1:FormatText(StoryNameCfg[612].name)

				arg_222_1.leftNameTxt_.text = var_225_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_3 = arg_222_1:GetWordFromCfg(420132054)
				local var_225_4 = arg_222_1:FormatText(var_225_3.content)

				arg_222_1.text_.text = var_225_4

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_5 = 50
				local var_225_6 = utf8.len(var_225_4)
				local var_225_7 = var_225_5 <= 0 and var_225_1 or var_225_1 * (var_225_6 / var_225_5)

				if var_225_7 > 0 and var_225_1 < var_225_7 then
					arg_222_1.talkMaxDuration = var_225_7

					if var_225_7 + var_225_0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_7 + var_225_0
					end
				end

				arg_222_1.text_.text = var_225_4
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132054", "story_v_out_420132.awb") ~= 0 then
					local var_225_8 = manager.audio:GetVoiceLength("story_v_out_420132", "420132054", "story_v_out_420132.awb") / 1000

					if var_225_8 + var_225_0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_8 + var_225_0
					end

					if var_225_3.prefab_name ~= "" and arg_222_1.actors_[var_225_3.prefab_name] ~= nil then
						local var_225_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_3.prefab_name].transform, "story_v_out_420132", "420132054", "story_v_out_420132.awb")

						arg_222_1:RecordAudio("420132054", var_225_9)
						arg_222_1:RecordAudio("420132054", var_225_9)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_420132", "420132054", "story_v_out_420132.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_420132", "420132054", "story_v_out_420132.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_10 = math.max(var_225_1, arg_222_1.talkMaxDuration)

			if var_225_0 <= arg_222_1.time_ and arg_222_1.time_ < var_225_0 + var_225_10 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_0) / var_225_10

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_0 + var_225_10 and arg_222_1.time_ < var_225_0 + var_225_10 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play420132055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 420132055
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play420132056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = arg_226_1.actors_["1061ui_story"]
			local var_229_1 = 0

			if var_229_1 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.characterEffect1061ui_story == nil then
				arg_226_1.var_.characterEffect1061ui_story = var_229_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_2 = 0.200000002980232

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_2 and not isNil(var_229_0) then
				local var_229_3 = (arg_226_1.time_ - var_229_1) / var_229_2

				if arg_226_1.var_.characterEffect1061ui_story and not isNil(var_229_0) then
					local var_229_4 = Mathf.Lerp(0, 0.5, var_229_3)

					arg_226_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_226_1.var_.characterEffect1061ui_story.fillRatio = var_229_4
				end
			end

			if arg_226_1.time_ >= var_229_1 + var_229_2 and arg_226_1.time_ < var_229_1 + var_229_2 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.characterEffect1061ui_story then
				local var_229_5 = 0.5

				arg_226_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_226_1.var_.characterEffect1061ui_story.fillRatio = var_229_5
			end

			local var_229_6 = 0
			local var_229_7 = 0.25

			if var_229_6 < arg_226_1.time_ and arg_226_1.time_ <= var_229_6 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_8 = arg_226_1:FormatText(StoryNameCfg[7].name)

				arg_226_1.leftNameTxt_.text = var_229_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, true)
				arg_226_1.iconController_:SetSelectedState("hero")

				arg_226_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_226_1.callingController_:SetSelectedState("normal")

				arg_226_1.keyicon_.color = Color.New(1, 1, 1)
				arg_226_1.icon_.color = Color.New(1, 1, 1)

				local var_229_9 = arg_226_1:GetWordFromCfg(420132055)
				local var_229_10 = arg_226_1:FormatText(var_229_9.content)

				arg_226_1.text_.text = var_229_10

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_11 = 10
				local var_229_12 = utf8.len(var_229_10)
				local var_229_13 = var_229_11 <= 0 and var_229_7 or var_229_7 * (var_229_12 / var_229_11)

				if var_229_13 > 0 and var_229_7 < var_229_13 then
					arg_226_1.talkMaxDuration = var_229_13

					if var_229_13 + var_229_6 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_13 + var_229_6
					end
				end

				arg_226_1.text_.text = var_229_10
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_14 = math.max(var_229_7, arg_226_1.talkMaxDuration)

			if var_229_6 <= arg_226_1.time_ and arg_226_1.time_ < var_229_6 + var_229_14 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_6) / var_229_14

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_6 + var_229_14 and arg_226_1.time_ < var_229_6 + var_229_14 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play420132056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 420132056
		arg_230_1.duration_ = 13.07

		local var_230_0 = {
			zh = 9.8,
			ja = 13.066
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play420132057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = arg_230_1.actors_["1061ui_story"]
			local var_233_1 = 0

			if var_233_1 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.characterEffect1061ui_story == nil then
				arg_230_1.var_.characterEffect1061ui_story = var_233_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_2 = 0.200000002980232

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_2 and not isNil(var_233_0) then
				local var_233_3 = (arg_230_1.time_ - var_233_1) / var_233_2

				if arg_230_1.var_.characterEffect1061ui_story and not isNil(var_233_0) then
					arg_230_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_230_1.time_ >= var_233_1 + var_233_2 and arg_230_1.time_ < var_233_1 + var_233_2 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.characterEffect1061ui_story then
				arg_230_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_233_4 = 0
			local var_233_5 = 1.075

			if var_233_4 < arg_230_1.time_ and arg_230_1.time_ <= var_233_4 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_6 = arg_230_1:FormatText(StoryNameCfg[612].name)

				arg_230_1.leftNameTxt_.text = var_233_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_7 = arg_230_1:GetWordFromCfg(420132056)
				local var_233_8 = arg_230_1:FormatText(var_233_7.content)

				arg_230_1.text_.text = var_233_8

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_9 = 43
				local var_233_10 = utf8.len(var_233_8)
				local var_233_11 = var_233_9 <= 0 and var_233_5 or var_233_5 * (var_233_10 / var_233_9)

				if var_233_11 > 0 and var_233_5 < var_233_11 then
					arg_230_1.talkMaxDuration = var_233_11

					if var_233_11 + var_233_4 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_11 + var_233_4
					end
				end

				arg_230_1.text_.text = var_233_8
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132056", "story_v_out_420132.awb") ~= 0 then
					local var_233_12 = manager.audio:GetVoiceLength("story_v_out_420132", "420132056", "story_v_out_420132.awb") / 1000

					if var_233_12 + var_233_4 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_12 + var_233_4
					end

					if var_233_7.prefab_name ~= "" and arg_230_1.actors_[var_233_7.prefab_name] ~= nil then
						local var_233_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_7.prefab_name].transform, "story_v_out_420132", "420132056", "story_v_out_420132.awb")

						arg_230_1:RecordAudio("420132056", var_233_13)
						arg_230_1:RecordAudio("420132056", var_233_13)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_420132", "420132056", "story_v_out_420132.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_420132", "420132056", "story_v_out_420132.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_14 = math.max(var_233_5, arg_230_1.talkMaxDuration)

			if var_233_4 <= arg_230_1.time_ and arg_230_1.time_ < var_233_4 + var_233_14 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_4) / var_233_14

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_4 + var_233_14 and arg_230_1.time_ < var_233_4 + var_233_14 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play420132057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 420132057
		arg_234_1.duration_ = 9.27

		local var_234_0 = {
			zh = 5.433,
			ja = 9.266
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play420132058(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = 0
			local var_237_1 = 0.65

			if var_237_0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_0 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				local var_237_2 = arg_234_1:FormatText(StoryNameCfg[612].name)

				arg_234_1.leftNameTxt_.text = var_237_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_3 = arg_234_1:GetWordFromCfg(420132057)
				local var_237_4 = arg_234_1:FormatText(var_237_3.content)

				arg_234_1.text_.text = var_237_4

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_5 = 26
				local var_237_6 = utf8.len(var_237_4)
				local var_237_7 = var_237_5 <= 0 and var_237_1 or var_237_1 * (var_237_6 / var_237_5)

				if var_237_7 > 0 and var_237_1 < var_237_7 then
					arg_234_1.talkMaxDuration = var_237_7

					if var_237_7 + var_237_0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_7 + var_237_0
					end
				end

				arg_234_1.text_.text = var_237_4
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132057", "story_v_out_420132.awb") ~= 0 then
					local var_237_8 = manager.audio:GetVoiceLength("story_v_out_420132", "420132057", "story_v_out_420132.awb") / 1000

					if var_237_8 + var_237_0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_8 + var_237_0
					end

					if var_237_3.prefab_name ~= "" and arg_234_1.actors_[var_237_3.prefab_name] ~= nil then
						local var_237_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_3.prefab_name].transform, "story_v_out_420132", "420132057", "story_v_out_420132.awb")

						arg_234_1:RecordAudio("420132057", var_237_9)
						arg_234_1:RecordAudio("420132057", var_237_9)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_420132", "420132057", "story_v_out_420132.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_420132", "420132057", "story_v_out_420132.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_10 = math.max(var_237_1, arg_234_1.talkMaxDuration)

			if var_237_0 <= arg_234_1.time_ and arg_234_1.time_ < var_237_0 + var_237_10 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_0) / var_237_10

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_0 + var_237_10 and arg_234_1.time_ < var_237_0 + var_237_10 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play420132058 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 420132058
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play420132059(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = arg_238_1.actors_["1061ui_story"].transform
			local var_241_1 = 0

			if var_241_1 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 then
				arg_238_1.var_.moveOldPos1061ui_story = var_241_0.localPosition
			end

			local var_241_2 = 0.001

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_2 then
				local var_241_3 = (arg_238_1.time_ - var_241_1) / var_241_2
				local var_241_4 = Vector3.New(0, 100, 0)

				var_241_0.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos1061ui_story, var_241_4, var_241_3)

				local var_241_5 = manager.ui.mainCamera.transform.position - var_241_0.position

				var_241_0.forward = Vector3.New(var_241_5.x, var_241_5.y, var_241_5.z)

				local var_241_6 = var_241_0.localEulerAngles

				var_241_6.z = 0
				var_241_6.x = 0
				var_241_0.localEulerAngles = var_241_6
			end

			if arg_238_1.time_ >= var_241_1 + var_241_2 and arg_238_1.time_ < var_241_1 + var_241_2 + arg_241_0 then
				var_241_0.localPosition = Vector3.New(0, 100, 0)

				local var_241_7 = manager.ui.mainCamera.transform.position - var_241_0.position

				var_241_0.forward = Vector3.New(var_241_7.x, var_241_7.y, var_241_7.z)

				local var_241_8 = var_241_0.localEulerAngles

				var_241_8.z = 0
				var_241_8.x = 0
				var_241_0.localEulerAngles = var_241_8
			end

			local var_241_9 = 0.05
			local var_241_10 = 1

			if var_241_9 < arg_238_1.time_ and arg_238_1.time_ <= var_241_9 + arg_241_0 then
				local var_241_11 = "play"
				local var_241_12 = "effect"

				arg_238_1:AudioAction(var_241_11, var_241_12, "se_story_140", "se_story_140_arrow", "")
			end

			local var_241_13 = 0
			local var_241_14 = 1.15

			if var_241_13 < arg_238_1.time_ and arg_238_1.time_ <= var_241_13 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, false)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_15 = arg_238_1:GetWordFromCfg(420132058)
				local var_241_16 = arg_238_1:FormatText(var_241_15.content)

				arg_238_1.text_.text = var_241_16

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_17 = 46
				local var_241_18 = utf8.len(var_241_16)
				local var_241_19 = var_241_17 <= 0 and var_241_14 or var_241_14 * (var_241_18 / var_241_17)

				if var_241_19 > 0 and var_241_14 < var_241_19 then
					arg_238_1.talkMaxDuration = var_241_19

					if var_241_19 + var_241_13 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_19 + var_241_13
					end
				end

				arg_238_1.text_.text = var_241_16
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_20 = math.max(var_241_14, arg_238_1.talkMaxDuration)

			if var_241_13 <= arg_238_1.time_ and arg_238_1.time_ < var_241_13 + var_241_20 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_13) / var_241_20

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_13 + var_241_20 and arg_238_1.time_ < var_241_13 + var_241_20 + arg_241_0 then
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
	Play420132059 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 420132059
		arg_242_1.duration_ = 17.4

		local var_242_0 = {
			zh = 11.933,
			ja = 17.4
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play420132060(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = arg_242_1.actors_["1061ui_story"]
			local var_245_1 = 0

			if var_245_1 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.characterEffect1061ui_story == nil then
				arg_242_1.var_.characterEffect1061ui_story = var_245_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_2 = 0.200000002980232

			if var_245_1 <= arg_242_1.time_ and arg_242_1.time_ < var_245_1 + var_245_2 and not isNil(var_245_0) then
				local var_245_3 = (arg_242_1.time_ - var_245_1) / var_245_2

				if arg_242_1.var_.characterEffect1061ui_story and not isNil(var_245_0) then
					arg_242_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= var_245_1 + var_245_2 and arg_242_1.time_ < var_245_1 + var_245_2 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.characterEffect1061ui_story then
				arg_242_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_245_4 = arg_242_1.actors_["1061ui_story"].transform
			local var_245_5 = 0

			if var_245_5 < arg_242_1.time_ and arg_242_1.time_ <= var_245_5 + arg_245_0 then
				arg_242_1.var_.moveOldPos1061ui_story = var_245_4.localPosition
			end

			local var_245_6 = 0.001

			if var_245_5 <= arg_242_1.time_ and arg_242_1.time_ < var_245_5 + var_245_6 then
				local var_245_7 = (arg_242_1.time_ - var_245_5) / var_245_6
				local var_245_8 = Vector3.New(0, -1.18, -6.15)

				var_245_4.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos1061ui_story, var_245_8, var_245_7)

				local var_245_9 = manager.ui.mainCamera.transform.position - var_245_4.position

				var_245_4.forward = Vector3.New(var_245_9.x, var_245_9.y, var_245_9.z)

				local var_245_10 = var_245_4.localEulerAngles

				var_245_10.z = 0
				var_245_10.x = 0
				var_245_4.localEulerAngles = var_245_10
			end

			if arg_242_1.time_ >= var_245_5 + var_245_6 and arg_242_1.time_ < var_245_5 + var_245_6 + arg_245_0 then
				var_245_4.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_245_11 = manager.ui.mainCamera.transform.position - var_245_4.position

				var_245_4.forward = Vector3.New(var_245_11.x, var_245_11.y, var_245_11.z)

				local var_245_12 = var_245_4.localEulerAngles

				var_245_12.z = 0
				var_245_12.x = 0
				var_245_4.localEulerAngles = var_245_12
			end

			local var_245_13 = 0

			if var_245_13 < arg_242_1.time_ and arg_242_1.time_ <= var_245_13 + arg_245_0 then
				arg_242_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_245_14 = 0
			local var_245_15 = 1.35

			if var_245_14 < arg_242_1.time_ and arg_242_1.time_ <= var_245_14 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				local var_245_16 = arg_242_1:FormatText(StoryNameCfg[612].name)

				arg_242_1.leftNameTxt_.text = var_245_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_17 = arg_242_1:GetWordFromCfg(420132059)
				local var_245_18 = arg_242_1:FormatText(var_245_17.content)

				arg_242_1.text_.text = var_245_18

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_19 = 54
				local var_245_20 = utf8.len(var_245_18)
				local var_245_21 = var_245_19 <= 0 and var_245_15 or var_245_15 * (var_245_20 / var_245_19)

				if var_245_21 > 0 and var_245_15 < var_245_21 then
					arg_242_1.talkMaxDuration = var_245_21

					if var_245_21 + var_245_14 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_21 + var_245_14
					end
				end

				arg_242_1.text_.text = var_245_18
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132059", "story_v_out_420132.awb") ~= 0 then
					local var_245_22 = manager.audio:GetVoiceLength("story_v_out_420132", "420132059", "story_v_out_420132.awb") / 1000

					if var_245_22 + var_245_14 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_22 + var_245_14
					end

					if var_245_17.prefab_name ~= "" and arg_242_1.actors_[var_245_17.prefab_name] ~= nil then
						local var_245_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_17.prefab_name].transform, "story_v_out_420132", "420132059", "story_v_out_420132.awb")

						arg_242_1:RecordAudio("420132059", var_245_23)
						arg_242_1:RecordAudio("420132059", var_245_23)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_420132", "420132059", "story_v_out_420132.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_420132", "420132059", "story_v_out_420132.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_24 = math.max(var_245_15, arg_242_1.talkMaxDuration)

			if var_245_14 <= arg_242_1.time_ and arg_242_1.time_ < var_245_14 + var_245_24 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_14) / var_245_24

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_14 + var_245_24 and arg_242_1.time_ < var_245_14 + var_245_24 + arg_245_0 then
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
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play420132060 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 420132060
		arg_246_1.duration_ = 20.1

		local var_246_0 = {
			zh = 13.966,
			ja = 20.1
		}
		local var_246_1 = manager.audio:GetLocalizationFlag()

		if var_246_0[var_246_1] ~= nil then
			arg_246_1.duration_ = var_246_0[var_246_1]
		end

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play420132061(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 0
			local var_249_1 = 1.75

			if var_249_0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_0 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				local var_249_2 = arg_246_1:FormatText(StoryNameCfg[612].name)

				arg_246_1.leftNameTxt_.text = var_249_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_3 = arg_246_1:GetWordFromCfg(420132060)
				local var_249_4 = arg_246_1:FormatText(var_249_3.content)

				arg_246_1.text_.text = var_249_4

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_5 = 70
				local var_249_6 = utf8.len(var_249_4)
				local var_249_7 = var_249_5 <= 0 and var_249_1 or var_249_1 * (var_249_6 / var_249_5)

				if var_249_7 > 0 and var_249_1 < var_249_7 then
					arg_246_1.talkMaxDuration = var_249_7

					if var_249_7 + var_249_0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_7 + var_249_0
					end
				end

				arg_246_1.text_.text = var_249_4
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132060", "story_v_out_420132.awb") ~= 0 then
					local var_249_8 = manager.audio:GetVoiceLength("story_v_out_420132", "420132060", "story_v_out_420132.awb") / 1000

					if var_249_8 + var_249_0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_8 + var_249_0
					end

					if var_249_3.prefab_name ~= "" and arg_246_1.actors_[var_249_3.prefab_name] ~= nil then
						local var_249_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_3.prefab_name].transform, "story_v_out_420132", "420132060", "story_v_out_420132.awb")

						arg_246_1:RecordAudio("420132060", var_249_9)
						arg_246_1:RecordAudio("420132060", var_249_9)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_420132", "420132060", "story_v_out_420132.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_420132", "420132060", "story_v_out_420132.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_10 = math.max(var_249_1, arg_246_1.talkMaxDuration)

			if var_249_0 <= arg_246_1.time_ and arg_246_1.time_ < var_249_0 + var_249_10 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_0) / var_249_10

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_0 + var_249_10 and arg_246_1.time_ < var_249_0 + var_249_10 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play420132061 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 420132061
		arg_250_1.duration_ = 10.93

		local var_250_0 = {
			zh = 9.333,
			ja = 10.933
		}
		local var_250_1 = manager.audio:GetLocalizationFlag()

		if var_250_0[var_250_1] ~= nil then
			arg_250_1.duration_ = var_250_0[var_250_1]
		end

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play420132062(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 0
			local var_253_1 = 0.875

			if var_253_0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_0 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				local var_253_2 = arg_250_1:FormatText(StoryNameCfg[612].name)

				arg_250_1.leftNameTxt_.text = var_253_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_3 = arg_250_1:GetWordFromCfg(420132061)
				local var_253_4 = arg_250_1:FormatText(var_253_3.content)

				arg_250_1.text_.text = var_253_4

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_5 = 35
				local var_253_6 = utf8.len(var_253_4)
				local var_253_7 = var_253_5 <= 0 and var_253_1 or var_253_1 * (var_253_6 / var_253_5)

				if var_253_7 > 0 and var_253_1 < var_253_7 then
					arg_250_1.talkMaxDuration = var_253_7

					if var_253_7 + var_253_0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_7 + var_253_0
					end
				end

				arg_250_1.text_.text = var_253_4
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132061", "story_v_out_420132.awb") ~= 0 then
					local var_253_8 = manager.audio:GetVoiceLength("story_v_out_420132", "420132061", "story_v_out_420132.awb") / 1000

					if var_253_8 + var_253_0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_8 + var_253_0
					end

					if var_253_3.prefab_name ~= "" and arg_250_1.actors_[var_253_3.prefab_name] ~= nil then
						local var_253_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_3.prefab_name].transform, "story_v_out_420132", "420132061", "story_v_out_420132.awb")

						arg_250_1:RecordAudio("420132061", var_253_9)
						arg_250_1:RecordAudio("420132061", var_253_9)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_420132", "420132061", "story_v_out_420132.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_420132", "420132061", "story_v_out_420132.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_10 = math.max(var_253_1, arg_250_1.talkMaxDuration)

			if var_253_0 <= arg_250_1.time_ and arg_250_1.time_ < var_253_0 + var_253_10 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_0) / var_253_10

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_0 + var_253_10 and arg_250_1.time_ < var_253_0 + var_253_10 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play420132062 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 420132062
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play420132063(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = arg_254_1.actors_["1061ui_story"]
			local var_257_1 = 0

			if var_257_1 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.characterEffect1061ui_story == nil then
				arg_254_1.var_.characterEffect1061ui_story = var_257_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_2 = 0.200000002980232

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_2 and not isNil(var_257_0) then
				local var_257_3 = (arg_254_1.time_ - var_257_1) / var_257_2

				if arg_254_1.var_.characterEffect1061ui_story and not isNil(var_257_0) then
					local var_257_4 = Mathf.Lerp(0, 0.5, var_257_3)

					arg_254_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_254_1.var_.characterEffect1061ui_story.fillRatio = var_257_4
				end
			end

			if arg_254_1.time_ >= var_257_1 + var_257_2 and arg_254_1.time_ < var_257_1 + var_257_2 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.characterEffect1061ui_story then
				local var_257_5 = 0.5

				arg_254_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_254_1.var_.characterEffect1061ui_story.fillRatio = var_257_5
			end

			local var_257_6 = 0
			local var_257_7 = 1.05

			if var_257_6 < arg_254_1.time_ and arg_254_1.time_ <= var_257_6 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, false)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_8 = arg_254_1:GetWordFromCfg(420132062)
				local var_257_9 = arg_254_1:FormatText(var_257_8.content)

				arg_254_1.text_.text = var_257_9

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_10 = 42
				local var_257_11 = utf8.len(var_257_9)
				local var_257_12 = var_257_10 <= 0 and var_257_7 or var_257_7 * (var_257_11 / var_257_10)

				if var_257_12 > 0 and var_257_7 < var_257_12 then
					arg_254_1.talkMaxDuration = var_257_12

					if var_257_12 + var_257_6 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_12 + var_257_6
					end
				end

				arg_254_1.text_.text = var_257_9
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_13 = math.max(var_257_7, arg_254_1.talkMaxDuration)

			if var_257_6 <= arg_254_1.time_ and arg_254_1.time_ < var_257_6 + var_257_13 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_6) / var_257_13

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_6 + var_257_13 and arg_254_1.time_ < var_257_6 + var_257_13 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play420132063 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 420132063
		arg_258_1.duration_ = 15.7

		local var_258_0 = {
			zh = 13.1,
			ja = 15.7
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play420132064(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = arg_258_1.actors_["1061ui_story"].transform
			local var_261_1 = 0

			if var_261_1 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 then
				arg_258_1.var_.moveOldPos1061ui_story = var_261_0.localPosition
			end

			local var_261_2 = 0.001

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_2 then
				local var_261_3 = (arg_258_1.time_ - var_261_1) / var_261_2
				local var_261_4 = Vector3.New(0, -1.18, -6.15)

				var_261_0.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1061ui_story, var_261_4, var_261_3)

				local var_261_5 = manager.ui.mainCamera.transform.position - var_261_0.position

				var_261_0.forward = Vector3.New(var_261_5.x, var_261_5.y, var_261_5.z)

				local var_261_6 = var_261_0.localEulerAngles

				var_261_6.z = 0
				var_261_6.x = 0
				var_261_0.localEulerAngles = var_261_6
			end

			if arg_258_1.time_ >= var_261_1 + var_261_2 and arg_258_1.time_ < var_261_1 + var_261_2 + arg_261_0 then
				var_261_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_261_7 = manager.ui.mainCamera.transform.position - var_261_0.position

				var_261_0.forward = Vector3.New(var_261_7.x, var_261_7.y, var_261_7.z)

				local var_261_8 = var_261_0.localEulerAngles

				var_261_8.z = 0
				var_261_8.x = 0
				var_261_0.localEulerAngles = var_261_8
			end

			local var_261_9 = arg_258_1.actors_["1061ui_story"]
			local var_261_10 = 0

			if var_261_10 < arg_258_1.time_ and arg_258_1.time_ <= var_261_10 + arg_261_0 and not isNil(var_261_9) and arg_258_1.var_.characterEffect1061ui_story == nil then
				arg_258_1.var_.characterEffect1061ui_story = var_261_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_11 = 0.200000002980232

			if var_261_10 <= arg_258_1.time_ and arg_258_1.time_ < var_261_10 + var_261_11 and not isNil(var_261_9) then
				local var_261_12 = (arg_258_1.time_ - var_261_10) / var_261_11

				if arg_258_1.var_.characterEffect1061ui_story and not isNil(var_261_9) then
					arg_258_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_258_1.time_ >= var_261_10 + var_261_11 and arg_258_1.time_ < var_261_10 + var_261_11 + arg_261_0 and not isNil(var_261_9) and arg_258_1.var_.characterEffect1061ui_story then
				arg_258_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_261_13 = 0
			local var_261_14 = 1.55

			if var_261_13 < arg_258_1.time_ and arg_258_1.time_ <= var_261_13 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_15 = arg_258_1:FormatText(StoryNameCfg[612].name)

				arg_258_1.leftNameTxt_.text = var_261_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_16 = arg_258_1:GetWordFromCfg(420132063)
				local var_261_17 = arg_258_1:FormatText(var_261_16.content)

				arg_258_1.text_.text = var_261_17

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_18 = 62
				local var_261_19 = utf8.len(var_261_17)
				local var_261_20 = var_261_18 <= 0 and var_261_14 or var_261_14 * (var_261_19 / var_261_18)

				if var_261_20 > 0 and var_261_14 < var_261_20 then
					arg_258_1.talkMaxDuration = var_261_20

					if var_261_20 + var_261_13 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_20 + var_261_13
					end
				end

				arg_258_1.text_.text = var_261_17
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132063", "story_v_out_420132.awb") ~= 0 then
					local var_261_21 = manager.audio:GetVoiceLength("story_v_out_420132", "420132063", "story_v_out_420132.awb") / 1000

					if var_261_21 + var_261_13 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_21 + var_261_13
					end

					if var_261_16.prefab_name ~= "" and arg_258_1.actors_[var_261_16.prefab_name] ~= nil then
						local var_261_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_16.prefab_name].transform, "story_v_out_420132", "420132063", "story_v_out_420132.awb")

						arg_258_1:RecordAudio("420132063", var_261_22)
						arg_258_1:RecordAudio("420132063", var_261_22)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_420132", "420132063", "story_v_out_420132.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_420132", "420132063", "story_v_out_420132.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_23 = math.max(var_261_14, arg_258_1.talkMaxDuration)

			if var_261_13 <= arg_258_1.time_ and arg_258_1.time_ < var_261_13 + var_261_23 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_13) / var_261_23

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_13 + var_261_23 and arg_258_1.time_ < var_261_13 + var_261_23 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
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

		arg_258_1:InitPlayNodeList()
	end,
	Play420132064 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 420132064
		arg_262_1.duration_ = 6.67

		local var_262_0 = {
			zh = 6.666,
			ja = 6.566
		}
		local var_262_1 = manager.audio:GetLocalizationFlag()

		if var_262_0[var_262_1] ~= nil then
			arg_262_1.duration_ = var_262_0[var_262_1]
		end

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play420132065(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = arg_262_1.actors_["1061ui_story"]
			local var_265_1 = 0

			if var_265_1 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.characterEffect1061ui_story == nil then
				arg_262_1.var_.characterEffect1061ui_story = var_265_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_2 = 0.200000002980232

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_2 and not isNil(var_265_0) then
				local var_265_3 = (arg_262_1.time_ - var_265_1) / var_265_2

				if arg_262_1.var_.characterEffect1061ui_story and not isNil(var_265_0) then
					local var_265_4 = Mathf.Lerp(0, 0.5, var_265_3)

					arg_262_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_262_1.var_.characterEffect1061ui_story.fillRatio = var_265_4
				end
			end

			if arg_262_1.time_ >= var_265_1 + var_265_2 and arg_262_1.time_ < var_265_1 + var_265_2 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.characterEffect1061ui_story then
				local var_265_5 = 0.5

				arg_262_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_262_1.var_.characterEffect1061ui_story.fillRatio = var_265_5
			end

			local var_265_6 = arg_262_1.actors_["1085ui_story"].transform
			local var_265_7 = 0

			if var_265_7 < arg_262_1.time_ and arg_262_1.time_ <= var_265_7 + arg_265_0 then
				arg_262_1.var_.moveOldPos1085ui_story = var_265_6.localPosition
			end

			local var_265_8 = 0.001

			if var_265_7 <= arg_262_1.time_ and arg_262_1.time_ < var_265_7 + var_265_8 then
				local var_265_9 = (arg_262_1.time_ - var_265_7) / var_265_8
				local var_265_10 = Vector3.New(0.75, -1.01, -5.83)

				var_265_6.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos1085ui_story, var_265_10, var_265_9)

				local var_265_11 = manager.ui.mainCamera.transform.position - var_265_6.position

				var_265_6.forward = Vector3.New(var_265_11.x, var_265_11.y, var_265_11.z)

				local var_265_12 = var_265_6.localEulerAngles

				var_265_12.z = 0
				var_265_12.x = 0
				var_265_6.localEulerAngles = var_265_12
			end

			if arg_262_1.time_ >= var_265_7 + var_265_8 and arg_262_1.time_ < var_265_7 + var_265_8 + arg_265_0 then
				var_265_6.localPosition = Vector3.New(0.75, -1.01, -5.83)

				local var_265_13 = manager.ui.mainCamera.transform.position - var_265_6.position

				var_265_6.forward = Vector3.New(var_265_13.x, var_265_13.y, var_265_13.z)

				local var_265_14 = var_265_6.localEulerAngles

				var_265_14.z = 0
				var_265_14.x = 0
				var_265_6.localEulerAngles = var_265_14
			end

			local var_265_15 = arg_262_1.actors_["1085ui_story"]
			local var_265_16 = 0

			if var_265_16 < arg_262_1.time_ and arg_262_1.time_ <= var_265_16 + arg_265_0 and not isNil(var_265_15) and arg_262_1.var_.characterEffect1085ui_story == nil then
				arg_262_1.var_.characterEffect1085ui_story = var_265_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_17 = 0.200000002980232

			if var_265_16 <= arg_262_1.time_ and arg_262_1.time_ < var_265_16 + var_265_17 and not isNil(var_265_15) then
				local var_265_18 = (arg_262_1.time_ - var_265_16) / var_265_17

				if arg_262_1.var_.characterEffect1085ui_story and not isNil(var_265_15) then
					arg_262_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_262_1.time_ >= var_265_16 + var_265_17 and arg_262_1.time_ < var_265_16 + var_265_17 + arg_265_0 and not isNil(var_265_15) and arg_262_1.var_.characterEffect1085ui_story then
				arg_262_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_265_19 = arg_262_1.actors_["1061ui_story"].transform
			local var_265_20 = 0

			if var_265_20 < arg_262_1.time_ and arg_262_1.time_ <= var_265_20 + arg_265_0 then
				arg_262_1.var_.moveOldPos1061ui_story = var_265_19.localPosition
			end

			local var_265_21 = 0.001

			if var_265_20 <= arg_262_1.time_ and arg_262_1.time_ < var_265_20 + var_265_21 then
				local var_265_22 = (arg_262_1.time_ - var_265_20) / var_265_21
				local var_265_23 = Vector3.New(-0.7, -1.18, -6.15)

				var_265_19.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos1061ui_story, var_265_23, var_265_22)

				local var_265_24 = manager.ui.mainCamera.transform.position - var_265_19.position

				var_265_19.forward = Vector3.New(var_265_24.x, var_265_24.y, var_265_24.z)

				local var_265_25 = var_265_19.localEulerAngles

				var_265_25.z = 0
				var_265_25.x = 0
				var_265_19.localEulerAngles = var_265_25
			end

			if arg_262_1.time_ >= var_265_20 + var_265_21 and arg_262_1.time_ < var_265_20 + var_265_21 + arg_265_0 then
				var_265_19.localPosition = Vector3.New(-0.7, -1.18, -6.15)

				local var_265_26 = manager.ui.mainCamera.transform.position - var_265_19.position

				var_265_19.forward = Vector3.New(var_265_26.x, var_265_26.y, var_265_26.z)

				local var_265_27 = var_265_19.localEulerAngles

				var_265_27.z = 0
				var_265_27.x = 0
				var_265_19.localEulerAngles = var_265_27
			end

			local var_265_28 = 0
			local var_265_29 = 0.4

			if var_265_28 < arg_262_1.time_ and arg_262_1.time_ <= var_265_28 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				local var_265_30 = arg_262_1:FormatText(StoryNameCfg[328].name)

				arg_262_1.leftNameTxt_.text = var_265_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_31 = arg_262_1:GetWordFromCfg(420132064)
				local var_265_32 = arg_262_1:FormatText(var_265_31.content)

				arg_262_1.text_.text = var_265_32

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_33 = 16
				local var_265_34 = utf8.len(var_265_32)
				local var_265_35 = var_265_33 <= 0 and var_265_29 or var_265_29 * (var_265_34 / var_265_33)

				if var_265_35 > 0 and var_265_29 < var_265_35 then
					arg_262_1.talkMaxDuration = var_265_35

					if var_265_35 + var_265_28 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_35 + var_265_28
					end
				end

				arg_262_1.text_.text = var_265_32
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132064", "story_v_out_420132.awb") ~= 0 then
					local var_265_36 = manager.audio:GetVoiceLength("story_v_out_420132", "420132064", "story_v_out_420132.awb") / 1000

					if var_265_36 + var_265_28 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_36 + var_265_28
					end

					if var_265_31.prefab_name ~= "" and arg_262_1.actors_[var_265_31.prefab_name] ~= nil then
						local var_265_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_31.prefab_name].transform, "story_v_out_420132", "420132064", "story_v_out_420132.awb")

						arg_262_1:RecordAudio("420132064", var_265_37)
						arg_262_1:RecordAudio("420132064", var_265_37)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_420132", "420132064", "story_v_out_420132.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_420132", "420132064", "story_v_out_420132.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_38 = math.max(var_265_29, arg_262_1.talkMaxDuration)

			if var_265_28 <= arg_262_1.time_ and arg_262_1.time_ < var_265_28 + var_265_38 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_28) / var_265_38

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_28 + var_265_38 and arg_262_1.time_ < var_265_28 + var_265_38 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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

		arg_262_1:InitPlayNodeList()
	end,
	Play420132065 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 420132065
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play420132066(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = arg_266_1.actors_["1061ui_story"].transform
			local var_269_1 = 0

			if var_269_1 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 then
				arg_266_1.var_.moveOldPos1061ui_story = var_269_0.localPosition
			end

			local var_269_2 = 0.001

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_2 then
				local var_269_3 = (arg_266_1.time_ - var_269_1) / var_269_2
				local var_269_4 = Vector3.New(0, 100, 0)

				var_269_0.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos1061ui_story, var_269_4, var_269_3)

				local var_269_5 = manager.ui.mainCamera.transform.position - var_269_0.position

				var_269_0.forward = Vector3.New(var_269_5.x, var_269_5.y, var_269_5.z)

				local var_269_6 = var_269_0.localEulerAngles

				var_269_6.z = 0
				var_269_6.x = 0
				var_269_0.localEulerAngles = var_269_6
			end

			if arg_266_1.time_ >= var_269_1 + var_269_2 and arg_266_1.time_ < var_269_1 + var_269_2 + arg_269_0 then
				var_269_0.localPosition = Vector3.New(0, 100, 0)

				local var_269_7 = manager.ui.mainCamera.transform.position - var_269_0.position

				var_269_0.forward = Vector3.New(var_269_7.x, var_269_7.y, var_269_7.z)

				local var_269_8 = var_269_0.localEulerAngles

				var_269_8.z = 0
				var_269_8.x = 0
				var_269_0.localEulerAngles = var_269_8
			end

			local var_269_9 = arg_266_1.actors_["1085ui_story"].transform
			local var_269_10 = 0

			if var_269_10 < arg_266_1.time_ and arg_266_1.time_ <= var_269_10 + arg_269_0 then
				arg_266_1.var_.moveOldPos1085ui_story = var_269_9.localPosition
			end

			local var_269_11 = 0.001

			if var_269_10 <= arg_266_1.time_ and arg_266_1.time_ < var_269_10 + var_269_11 then
				local var_269_12 = (arg_266_1.time_ - var_269_10) / var_269_11
				local var_269_13 = Vector3.New(0, 100, 0)

				var_269_9.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos1085ui_story, var_269_13, var_269_12)

				local var_269_14 = manager.ui.mainCamera.transform.position - var_269_9.position

				var_269_9.forward = Vector3.New(var_269_14.x, var_269_14.y, var_269_14.z)

				local var_269_15 = var_269_9.localEulerAngles

				var_269_15.z = 0
				var_269_15.x = 0
				var_269_9.localEulerAngles = var_269_15
			end

			if arg_266_1.time_ >= var_269_10 + var_269_11 and arg_266_1.time_ < var_269_10 + var_269_11 + arg_269_0 then
				var_269_9.localPosition = Vector3.New(0, 100, 0)

				local var_269_16 = manager.ui.mainCamera.transform.position - var_269_9.position

				var_269_9.forward = Vector3.New(var_269_16.x, var_269_16.y, var_269_16.z)

				local var_269_17 = var_269_9.localEulerAngles

				var_269_17.z = 0
				var_269_17.x = 0
				var_269_9.localEulerAngles = var_269_17
			end

			local var_269_18 = 0
			local var_269_19 = 1.35

			if var_269_18 < arg_266_1.time_ and arg_266_1.time_ <= var_269_18 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, false)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_20 = arg_266_1:GetWordFromCfg(420132065)
				local var_269_21 = arg_266_1:FormatText(var_269_20.content)

				arg_266_1.text_.text = var_269_21

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_22 = 54
				local var_269_23 = utf8.len(var_269_21)
				local var_269_24 = var_269_22 <= 0 and var_269_19 or var_269_19 * (var_269_23 / var_269_22)

				if var_269_24 > 0 and var_269_19 < var_269_24 then
					arg_266_1.talkMaxDuration = var_269_24

					if var_269_24 + var_269_18 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_24 + var_269_18
					end
				end

				arg_266_1.text_.text = var_269_21
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_25 = math.max(var_269_19, arg_266_1.talkMaxDuration)

			if var_269_18 <= arg_266_1.time_ and arg_266_1.time_ < var_269_18 + var_269_25 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_18) / var_269_25

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_18 + var_269_25 and arg_266_1.time_ < var_269_18 + var_269_25 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
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
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_266_1:InitPlayNodeList()
	end,
	Play420132066 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 420132066
		arg_270_1.duration_ = 2

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play420132067(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = arg_270_1.actors_["1085ui_story"]
			local var_273_1 = 0

			if var_273_1 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.characterEffect1085ui_story == nil then
				arg_270_1.var_.characterEffect1085ui_story = var_273_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_2 = 0.200000002980232

			if var_273_1 <= arg_270_1.time_ and arg_270_1.time_ < var_273_1 + var_273_2 and not isNil(var_273_0) then
				local var_273_3 = (arg_270_1.time_ - var_273_1) / var_273_2

				if arg_270_1.var_.characterEffect1085ui_story and not isNil(var_273_0) then
					arg_270_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_270_1.time_ >= var_273_1 + var_273_2 and arg_270_1.time_ < var_273_1 + var_273_2 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.characterEffect1085ui_story then
				arg_270_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_273_4 = arg_270_1.actors_["1085ui_story"].transform
			local var_273_5 = 0

			if var_273_5 < arg_270_1.time_ and arg_270_1.time_ <= var_273_5 + arg_273_0 then
				arg_270_1.var_.moveOldPos1085ui_story = var_273_4.localPosition
			end

			local var_273_6 = 0.001

			if var_273_5 <= arg_270_1.time_ and arg_270_1.time_ < var_273_5 + var_273_6 then
				local var_273_7 = (arg_270_1.time_ - var_273_5) / var_273_6
				local var_273_8 = Vector3.New(0, -1.01, -5.83)

				var_273_4.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos1085ui_story, var_273_8, var_273_7)

				local var_273_9 = manager.ui.mainCamera.transform.position - var_273_4.position

				var_273_4.forward = Vector3.New(var_273_9.x, var_273_9.y, var_273_9.z)

				local var_273_10 = var_273_4.localEulerAngles

				var_273_10.z = 0
				var_273_10.x = 0
				var_273_4.localEulerAngles = var_273_10
			end

			if arg_270_1.time_ >= var_273_5 + var_273_6 and arg_270_1.time_ < var_273_5 + var_273_6 + arg_273_0 then
				var_273_4.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_273_11 = manager.ui.mainCamera.transform.position - var_273_4.position

				var_273_4.forward = Vector3.New(var_273_11.x, var_273_11.y, var_273_11.z)

				local var_273_12 = var_273_4.localEulerAngles

				var_273_12.z = 0
				var_273_12.x = 0
				var_273_4.localEulerAngles = var_273_12
			end

			local var_273_13 = 0

			if var_273_13 < arg_270_1.time_ and arg_270_1.time_ <= var_273_13 + arg_273_0 then
				arg_270_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_2")
			end

			local var_273_14 = 0

			if var_273_14 < arg_270_1.time_ and arg_270_1.time_ <= var_273_14 + arg_273_0 then
				arg_270_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_273_15 = 0
			local var_273_16 = 0.075

			if var_273_15 < arg_270_1.time_ and arg_270_1.time_ <= var_273_15 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_17 = arg_270_1:FormatText(StoryNameCfg[328].name)

				arg_270_1.leftNameTxt_.text = var_273_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_18 = arg_270_1:GetWordFromCfg(420132066)
				local var_273_19 = arg_270_1:FormatText(var_273_18.content)

				arg_270_1.text_.text = var_273_19

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_20 = 3
				local var_273_21 = utf8.len(var_273_19)
				local var_273_22 = var_273_20 <= 0 and var_273_16 or var_273_16 * (var_273_21 / var_273_20)

				if var_273_22 > 0 and var_273_16 < var_273_22 then
					arg_270_1.talkMaxDuration = var_273_22

					if var_273_22 + var_273_15 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_22 + var_273_15
					end
				end

				arg_270_1.text_.text = var_273_19
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132066", "story_v_out_420132.awb") ~= 0 then
					local var_273_23 = manager.audio:GetVoiceLength("story_v_out_420132", "420132066", "story_v_out_420132.awb") / 1000

					if var_273_23 + var_273_15 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_23 + var_273_15
					end

					if var_273_18.prefab_name ~= "" and arg_270_1.actors_[var_273_18.prefab_name] ~= nil then
						local var_273_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_18.prefab_name].transform, "story_v_out_420132", "420132066", "story_v_out_420132.awb")

						arg_270_1:RecordAudio("420132066", var_273_24)
						arg_270_1:RecordAudio("420132066", var_273_24)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_420132", "420132066", "story_v_out_420132.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_420132", "420132066", "story_v_out_420132.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_25 = math.max(var_273_16, arg_270_1.talkMaxDuration)

			if var_273_15 <= arg_270_1.time_ and arg_270_1.time_ < var_273_15 + var_273_25 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_15) / var_273_25

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_15 + var_273_25 and arg_270_1.time_ < var_273_15 + var_273_25 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_270_1:InitPlayNodeList()
	end,
	Play420132067 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 420132067
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play420132068(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = arg_274_1.actors_["1085ui_story"]
			local var_277_1 = 0

			if var_277_1 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 and not isNil(var_277_0) and arg_274_1.var_.characterEffect1085ui_story == nil then
				arg_274_1.var_.characterEffect1085ui_story = var_277_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_2 = 0.200000002980232

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_2 and not isNil(var_277_0) then
				local var_277_3 = (arg_274_1.time_ - var_277_1) / var_277_2

				if arg_274_1.var_.characterEffect1085ui_story and not isNil(var_277_0) then
					local var_277_4 = Mathf.Lerp(0, 0.5, var_277_3)

					arg_274_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_274_1.var_.characterEffect1085ui_story.fillRatio = var_277_4
				end
			end

			if arg_274_1.time_ >= var_277_1 + var_277_2 and arg_274_1.time_ < var_277_1 + var_277_2 + arg_277_0 and not isNil(var_277_0) and arg_274_1.var_.characterEffect1085ui_story then
				local var_277_5 = 0.5

				arg_274_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_274_1.var_.characterEffect1085ui_story.fillRatio = var_277_5
			end

			local var_277_6 = 0
			local var_277_7 = 0.25

			if var_277_6 < arg_274_1.time_ and arg_274_1.time_ <= var_277_6 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_8 = arg_274_1:FormatText(StoryNameCfg[7].name)

				arg_274_1.leftNameTxt_.text = var_277_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, true)
				arg_274_1.iconController_:SetSelectedState("hero")

				arg_274_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_274_1.callingController_:SetSelectedState("normal")

				arg_274_1.keyicon_.color = Color.New(1, 1, 1)
				arg_274_1.icon_.color = Color.New(1, 1, 1)

				local var_277_9 = arg_274_1:GetWordFromCfg(420132067)
				local var_277_10 = arg_274_1:FormatText(var_277_9.content)

				arg_274_1.text_.text = var_277_10

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_11 = 10
				local var_277_12 = utf8.len(var_277_10)
				local var_277_13 = var_277_11 <= 0 and var_277_7 or var_277_7 * (var_277_12 / var_277_11)

				if var_277_13 > 0 and var_277_7 < var_277_13 then
					arg_274_1.talkMaxDuration = var_277_13

					if var_277_13 + var_277_6 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_13 + var_277_6
					end
				end

				arg_274_1.text_.text = var_277_10
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_14 = math.max(var_277_7, arg_274_1.talkMaxDuration)

			if var_277_6 <= arg_274_1.time_ and arg_274_1.time_ < var_277_6 + var_277_14 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_6) / var_277_14

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_6 + var_277_14 and arg_274_1.time_ < var_277_6 + var_277_14 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play420132068 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 420132068
		arg_278_1.duration_ = 18.17

		local var_278_0 = {
			zh = 13.233,
			ja = 18.166
		}
		local var_278_1 = manager.audio:GetLocalizationFlag()

		if var_278_0[var_278_1] ~= nil then
			arg_278_1.duration_ = var_278_0[var_278_1]
		end

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play420132069(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = arg_278_1.actors_["1085ui_story"]
			local var_281_1 = 0

			if var_281_1 < arg_278_1.time_ and arg_278_1.time_ <= var_281_1 + arg_281_0 and not isNil(var_281_0) and arg_278_1.var_.characterEffect1085ui_story == nil then
				arg_278_1.var_.characterEffect1085ui_story = var_281_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_2 = 0.200000002980232

			if var_281_1 <= arg_278_1.time_ and arg_278_1.time_ < var_281_1 + var_281_2 and not isNil(var_281_0) then
				local var_281_3 = (arg_278_1.time_ - var_281_1) / var_281_2

				if arg_278_1.var_.characterEffect1085ui_story and not isNil(var_281_0) then
					arg_278_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_278_1.time_ >= var_281_1 + var_281_2 and arg_278_1.time_ < var_281_1 + var_281_2 + arg_281_0 and not isNil(var_281_0) and arg_278_1.var_.characterEffect1085ui_story then
				arg_278_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_281_4 = arg_278_1.actors_["1085ui_story"].transform
			local var_281_5 = 0

			if var_281_5 < arg_278_1.time_ and arg_278_1.time_ <= var_281_5 + arg_281_0 then
				arg_278_1.var_.moveOldPos1085ui_story = var_281_4.localPosition
			end

			local var_281_6 = 0.001

			if var_281_5 <= arg_278_1.time_ and arg_278_1.time_ < var_281_5 + var_281_6 then
				local var_281_7 = (arg_278_1.time_ - var_281_5) / var_281_6
				local var_281_8 = Vector3.New(0, -1.01, -5.83)

				var_281_4.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos1085ui_story, var_281_8, var_281_7)

				local var_281_9 = manager.ui.mainCamera.transform.position - var_281_4.position

				var_281_4.forward = Vector3.New(var_281_9.x, var_281_9.y, var_281_9.z)

				local var_281_10 = var_281_4.localEulerAngles

				var_281_10.z = 0
				var_281_10.x = 0
				var_281_4.localEulerAngles = var_281_10
			end

			if arg_278_1.time_ >= var_281_5 + var_281_6 and arg_278_1.time_ < var_281_5 + var_281_6 + arg_281_0 then
				var_281_4.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_281_11 = manager.ui.mainCamera.transform.position - var_281_4.position

				var_281_4.forward = Vector3.New(var_281_11.x, var_281_11.y, var_281_11.z)

				local var_281_12 = var_281_4.localEulerAngles

				var_281_12.z = 0
				var_281_12.x = 0
				var_281_4.localEulerAngles = var_281_12
			end

			local var_281_13 = 0

			if var_281_13 < arg_278_1.time_ and arg_278_1.time_ <= var_281_13 + arg_281_0 then
				arg_278_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			local var_281_14 = 0

			if var_281_14 < arg_278_1.time_ and arg_278_1.time_ <= var_281_14 + arg_281_0 then
				arg_278_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_281_15 = 0
			local var_281_16 = 1.325

			if var_281_15 < arg_278_1.time_ and arg_278_1.time_ <= var_281_15 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_17 = arg_278_1:FormatText(StoryNameCfg[328].name)

				arg_278_1.leftNameTxt_.text = var_281_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_18 = arg_278_1:GetWordFromCfg(420132068)
				local var_281_19 = arg_278_1:FormatText(var_281_18.content)

				arg_278_1.text_.text = var_281_19

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_20 = 53
				local var_281_21 = utf8.len(var_281_19)
				local var_281_22 = var_281_20 <= 0 and var_281_16 or var_281_16 * (var_281_21 / var_281_20)

				if var_281_22 > 0 and var_281_16 < var_281_22 then
					arg_278_1.talkMaxDuration = var_281_22

					if var_281_22 + var_281_15 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_22 + var_281_15
					end
				end

				arg_278_1.text_.text = var_281_19
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132068", "story_v_out_420132.awb") ~= 0 then
					local var_281_23 = manager.audio:GetVoiceLength("story_v_out_420132", "420132068", "story_v_out_420132.awb") / 1000

					if var_281_23 + var_281_15 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_23 + var_281_15
					end

					if var_281_18.prefab_name ~= "" and arg_278_1.actors_[var_281_18.prefab_name] ~= nil then
						local var_281_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_18.prefab_name].transform, "story_v_out_420132", "420132068", "story_v_out_420132.awb")

						arg_278_1:RecordAudio("420132068", var_281_24)
						arg_278_1:RecordAudio("420132068", var_281_24)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_420132", "420132068", "story_v_out_420132.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_420132", "420132068", "story_v_out_420132.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_25 = math.max(var_281_16, arg_278_1.talkMaxDuration)

			if var_281_15 <= arg_278_1.time_ and arg_278_1.time_ < var_281_15 + var_281_25 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_15) / var_281_25

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_15 + var_281_25 and arg_278_1.time_ < var_281_15 + var_281_25 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_278_1:InitPlayNodeList()
	end,
	Play420132069 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 420132069
		arg_282_1.duration_ = 5.67

		local var_282_0 = {
			zh = 3.5,
			ja = 5.666
		}
		local var_282_1 = manager.audio:GetLocalizationFlag()

		if var_282_0[var_282_1] ~= nil then
			arg_282_1.duration_ = var_282_0[var_282_1]
		end

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play420132070(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = 0
			local var_285_1 = 0.3

			if var_285_0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_0 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				local var_285_2 = arg_282_1:FormatText(StoryNameCfg[328].name)

				arg_282_1.leftNameTxt_.text = var_285_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_3 = arg_282_1:GetWordFromCfg(420132069)
				local var_285_4 = arg_282_1:FormatText(var_285_3.content)

				arg_282_1.text_.text = var_285_4

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_5 = 12
				local var_285_6 = utf8.len(var_285_4)
				local var_285_7 = var_285_5 <= 0 and var_285_1 or var_285_1 * (var_285_6 / var_285_5)

				if var_285_7 > 0 and var_285_1 < var_285_7 then
					arg_282_1.talkMaxDuration = var_285_7

					if var_285_7 + var_285_0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_7 + var_285_0
					end
				end

				arg_282_1.text_.text = var_285_4
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132069", "story_v_out_420132.awb") ~= 0 then
					local var_285_8 = manager.audio:GetVoiceLength("story_v_out_420132", "420132069", "story_v_out_420132.awb") / 1000

					if var_285_8 + var_285_0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_8 + var_285_0
					end

					if var_285_3.prefab_name ~= "" and arg_282_1.actors_[var_285_3.prefab_name] ~= nil then
						local var_285_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_3.prefab_name].transform, "story_v_out_420132", "420132069", "story_v_out_420132.awb")

						arg_282_1:RecordAudio("420132069", var_285_9)
						arg_282_1:RecordAudio("420132069", var_285_9)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_420132", "420132069", "story_v_out_420132.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_420132", "420132069", "story_v_out_420132.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_10 = math.max(var_285_1, arg_282_1.talkMaxDuration)

			if var_285_0 <= arg_282_1.time_ and arg_282_1.time_ < var_285_0 + var_285_10 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_0) / var_285_10

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_0 + var_285_10 and arg_282_1.time_ < var_285_0 + var_285_10 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play420132070 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 420132070
		arg_286_1.duration_ = 11.33

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play420132071(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0

			if var_289_0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_0 + arg_289_0 then
				local var_289_1 = manager.ui.mainCamera.transform.localPosition
				local var_289_2 = Vector3.New(0, 0, 10) + Vector3.New(var_289_1.x, var_289_1.y, 0)
				local var_289_3 = arg_286_1.bgs_.STblack

				var_289_3.transform.localPosition = var_289_2
				var_289_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_289_4 = var_289_3:GetComponent("SpriteRenderer")

				if var_289_4 and var_289_4.sprite then
					local var_289_5 = (var_289_3.transform.localPosition - var_289_1).z
					local var_289_6 = manager.ui.mainCameraCom_
					local var_289_7 = 2 * var_289_5 * Mathf.Tan(var_289_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_289_8 = var_289_7 * var_289_6.aspect
					local var_289_9 = var_289_4.sprite.bounds.size.x
					local var_289_10 = var_289_4.sprite.bounds.size.y
					local var_289_11 = var_289_8 / var_289_9
					local var_289_12 = var_289_7 / var_289_10
					local var_289_13 = var_289_12 < var_289_11 and var_289_11 or var_289_12

					var_289_3.transform.localScale = Vector3.New(var_289_13, var_289_13, 0)
				end

				for iter_289_0, iter_289_1 in pairs(arg_286_1.bgs_) do
					if iter_289_0 ~= "STblack" then
						iter_289_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_289_14 = 0

			if var_289_14 < arg_286_1.time_ and arg_286_1.time_ <= var_289_14 + arg_289_0 then
				arg_286_1.mask_.enabled = true
				arg_286_1.mask_.raycastTarget = true

				arg_286_1:SetGaussion(false)
			end

			local var_289_15 = 2

			if var_289_14 <= arg_286_1.time_ and arg_286_1.time_ < var_289_14 + var_289_15 then
				local var_289_16 = (arg_286_1.time_ - var_289_14) / var_289_15
				local var_289_17 = Color.New(0, 0, 0)

				var_289_17.a = Mathf.Lerp(1, 0, var_289_16)
				arg_286_1.mask_.color = var_289_17
			end

			if arg_286_1.time_ >= var_289_14 + var_289_15 and arg_286_1.time_ < var_289_14 + var_289_15 + arg_289_0 then
				local var_289_18 = Color.New(0, 0, 0)
				local var_289_19 = 0

				arg_286_1.mask_.enabled = false
				var_289_18.a = var_289_19
				arg_286_1.mask_.color = var_289_18
			end

			local var_289_20 = 0

			if var_289_20 < arg_286_1.time_ and arg_286_1.time_ <= var_289_20 + arg_289_0 then
				arg_286_1.cswbg_:SetActive(true)

				local var_289_21 = arg_286_1.cswt_:GetComponent("RectTransform")

				arg_286_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_289_21.offsetMin = Vector2.New(0, 0)
				var_289_21.offsetMax = Vector2.New(0, 130)

				local var_289_22 = arg_286_1:GetWordFromCfg(419151)
				local var_289_23 = arg_286_1:FormatText(var_289_22.content)

				arg_286_1.cswt_.text = var_289_23

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.cswt_)

				arg_286_1.cswt_.fontSize = 120
				arg_286_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_286_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_286_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_289_24 = 0
			local var_289_25 = 1

			if var_289_24 < arg_286_1.time_ and arg_286_1.time_ <= var_289_24 + arg_289_0 then
				local var_289_26 = "stop"
				local var_289_27 = "effect"

				arg_286_1:AudioAction(var_289_26, var_289_27, "se_story_140", "se_story_140_amb_lab", "")
			end

			local var_289_28 = 0

			if var_289_28 < arg_286_1.time_ and arg_286_1.time_ <= var_289_28 + arg_289_0 then
				arg_286_1.fswbg_:SetActive(true)
				arg_286_1.dialog_:SetActive(false)

				arg_286_1.fswtw_.percent = 0

				local var_289_29 = arg_286_1:GetWordFromCfg(420132070)
				local var_289_30 = arg_286_1:FormatText(var_289_29.content)

				arg_286_1.fswt_.text = var_289_30

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.fswt_)

				arg_286_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_286_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_286_1.fswtw_:SetDirty()

				arg_286_1.typewritterCharCountI18N = 0

				SetActive(arg_286_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_286_1:ShowNextGo(false)
			end

			local var_289_31 = 1.66666666666667

			if var_289_31 < arg_286_1.time_ and arg_286_1.time_ <= var_289_31 + arg_289_0 then
				arg_286_1.var_.oldValueTypewriter = arg_286_1.fswtw_.percent

				SetActive(arg_286_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_286_1:ShowNextGo(false)
			end

			local var_289_32 = 27
			local var_289_33 = 1.8
			local var_289_34 = arg_286_1:GetWordFromCfg(420132070)
			local var_289_35 = arg_286_1:FormatText(var_289_34.content)
			local var_289_36, var_289_37 = arg_286_1:GetPercentByPara(var_289_35, 1)

			if var_289_31 < arg_286_1.time_ and arg_286_1.time_ <= var_289_31 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0

				local var_289_38 = var_289_32 <= 0 and var_289_33 or var_289_33 * ((var_289_37 - arg_286_1.typewritterCharCountI18N) / var_289_32)

				if var_289_38 > 0 and var_289_33 < var_289_38 then
					arg_286_1.talkMaxDuration = var_289_38

					if var_289_38 + var_289_31 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_38 + var_289_31
					end
				end
			end

			local var_289_39 = 1.8
			local var_289_40 = math.max(var_289_39, arg_286_1.talkMaxDuration)

			if var_289_31 <= arg_286_1.time_ and arg_286_1.time_ < var_289_31 + var_289_40 then
				local var_289_41 = (arg_286_1.time_ - var_289_31) / var_289_40

				arg_286_1.fswtw_.percent = Mathf.Lerp(arg_286_1.var_.oldValueTypewriter, var_289_36, var_289_41)
				arg_286_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_286_1.fswtw_:SetDirty()
			end

			if arg_286_1.time_ >= var_289_31 + var_289_40 and arg_286_1.time_ < var_289_31 + var_289_40 + arg_289_0 then
				arg_286_1.fswtw_.percent = var_289_36

				arg_286_1.fswtw_:SetDirty()
				arg_286_1:ShowNextGo(true)

				arg_286_1.typewritterCharCountI18N = var_289_37
			end

			local var_289_42 = 0

			if var_289_42 < arg_286_1.time_ and arg_286_1.time_ <= var_289_42 + arg_289_0 then
				local var_289_43 = arg_286_1.fswbg_.transform:Find("textbox/adapt/content") or arg_286_1.fswbg_.transform:Find("textbox/content")
				local var_289_44 = arg_286_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_289_45 = var_289_43:GetComponent("Text")
				local var_289_46 = var_289_43:GetComponent("RectTransform")

				var_289_45.alignment = UnityEngine.TextAnchor.LowerCenter
				var_289_46.offsetMin = Vector2.New(0, -70)
				var_289_46.offsetMax = Vector2.New(0, 0)
			end

			local var_289_47 = arg_286_1.actors_["1085ui_story"].transform
			local var_289_48 = 0

			if var_289_48 < arg_286_1.time_ and arg_286_1.time_ <= var_289_48 + arg_289_0 then
				arg_286_1.var_.moveOldPos1085ui_story = var_289_47.localPosition
			end

			local var_289_49 = 0.001

			if var_289_48 <= arg_286_1.time_ and arg_286_1.time_ < var_289_48 + var_289_49 then
				local var_289_50 = (arg_286_1.time_ - var_289_48) / var_289_49
				local var_289_51 = Vector3.New(0, 100, 0)

				var_289_47.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos1085ui_story, var_289_51, var_289_50)

				local var_289_52 = manager.ui.mainCamera.transform.position - var_289_47.position

				var_289_47.forward = Vector3.New(var_289_52.x, var_289_52.y, var_289_52.z)

				local var_289_53 = var_289_47.localEulerAngles

				var_289_53.z = 0
				var_289_53.x = 0
				var_289_47.localEulerAngles = var_289_53
			end

			if arg_286_1.time_ >= var_289_48 + var_289_49 and arg_286_1.time_ < var_289_48 + var_289_49 + arg_289_0 then
				var_289_47.localPosition = Vector3.New(0, 100, 0)

				local var_289_54 = manager.ui.mainCamera.transform.position - var_289_47.position

				var_289_47.forward = Vector3.New(var_289_54.x, var_289_54.y, var_289_54.z)

				local var_289_55 = var_289_47.localEulerAngles

				var_289_55.z = 0
				var_289_55.x = 0
				var_289_47.localEulerAngles = var_289_55
			end

			local var_289_56 = 1.66666666666667
			local var_289_57 = 9.666
			local var_289_58 = manager.audio:GetVoiceLength("story_v_out_420132", "420132070", "story_v_out_420132.awb") / 1000

			if var_289_58 > 0 and var_289_57 < var_289_58 and var_289_58 + var_289_56 > arg_286_1.duration_ then
				local var_289_59 = var_289_58

				arg_286_1.duration_ = var_289_58 + var_289_56
			end

			if var_289_56 < arg_286_1.time_ and arg_286_1.time_ <= var_289_56 + arg_289_0 then
				local var_289_60 = "play"
				local var_289_61 = "voice"

				arg_286_1:AudioAction(var_289_60, var_289_61, "story_v_out_420132", "420132070", "story_v_out_420132.awb")
			end
		end

		arg_286_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_286_1:InitPlayNodeList()
	end,
	Play420132071 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 420132071
		arg_290_1.duration_ = 11.23

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play420132072(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 0

			if var_293_0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_0 + arg_293_0 then
				arg_290_1.fswbg_:SetActive(true)
				arg_290_1.dialog_:SetActive(false)

				arg_290_1.fswtw_.percent = 0

				local var_293_1 = arg_290_1:GetWordFromCfg(420132071)
				local var_293_2 = arg_290_1:FormatText(var_293_1.content)

				arg_290_1.fswt_.text = var_293_2

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.fswt_)

				arg_290_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_290_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_290_1.fswtw_:SetDirty()

				arg_290_1.typewritterCharCountI18N = 0

				SetActive(arg_290_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_290_1:ShowNextGo(false)
			end

			local var_293_3 = 0.0666666666666669

			if var_293_3 < arg_290_1.time_ and arg_290_1.time_ <= var_293_3 + arg_293_0 then
				arg_290_1.var_.oldValueTypewriter = arg_290_1.fswtw_.percent

				SetActive(arg_290_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_290_1:ShowNextGo(false)
			end

			local var_293_4 = 31
			local var_293_5 = 2.06666666666667
			local var_293_6 = arg_290_1:GetWordFromCfg(420132071)
			local var_293_7 = arg_290_1:FormatText(var_293_6.content)
			local var_293_8, var_293_9 = arg_290_1:GetPercentByPara(var_293_7, 1)

			if var_293_3 < arg_290_1.time_ and arg_290_1.time_ <= var_293_3 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0

				local var_293_10 = var_293_4 <= 0 and var_293_5 or var_293_5 * ((var_293_9 - arg_290_1.typewritterCharCountI18N) / var_293_4)

				if var_293_10 > 0 and var_293_5 < var_293_10 then
					arg_290_1.talkMaxDuration = var_293_10

					if var_293_10 + var_293_3 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_10 + var_293_3
					end
				end
			end

			local var_293_11 = 2.06666666666667
			local var_293_12 = math.max(var_293_11, arg_290_1.talkMaxDuration)

			if var_293_3 <= arg_290_1.time_ and arg_290_1.time_ < var_293_3 + var_293_12 then
				local var_293_13 = (arg_290_1.time_ - var_293_3) / var_293_12

				arg_290_1.fswtw_.percent = Mathf.Lerp(arg_290_1.var_.oldValueTypewriter, var_293_8, var_293_13)
				arg_290_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_290_1.fswtw_:SetDirty()
			end

			if arg_290_1.time_ >= var_293_3 + var_293_12 and arg_290_1.time_ < var_293_3 + var_293_12 + arg_293_0 then
				arg_290_1.fswtw_.percent = var_293_8

				arg_290_1.fswtw_:SetDirty()
				arg_290_1:ShowNextGo(true)

				arg_290_1.typewritterCharCountI18N = var_293_9
			end

			local var_293_14 = 0
			local var_293_15 = 11.233
			local var_293_16 = manager.audio:GetVoiceLength("story_v_out_420132", "420132071", "story_v_out_420132.awb") / 1000

			if var_293_16 > 0 and var_293_15 < var_293_16 and var_293_16 + var_293_14 > arg_290_1.duration_ then
				local var_293_17 = var_293_16

				arg_290_1.duration_ = var_293_16 + var_293_14
			end

			if var_293_14 < arg_290_1.time_ and arg_290_1.time_ <= var_293_14 + arg_293_0 then
				local var_293_18 = "play"
				local var_293_19 = "voice"

				arg_290_1:AudioAction(var_293_18, var_293_19, "story_v_out_420132", "420132071", "story_v_out_420132.awb")
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play420132072 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 420132072
		arg_294_1.duration_ = 11.27

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play420132073(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = 0

			if var_297_0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_0 + arg_297_0 then
				arg_294_1.fswbg_:SetActive(true)
				arg_294_1.dialog_:SetActive(false)

				arg_294_1.fswtw_.percent = 0

				local var_297_1 = arg_294_1:GetWordFromCfg(420132072)
				local var_297_2 = arg_294_1:FormatText(var_297_1.content)

				arg_294_1.fswt_.text = var_297_2

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.fswt_)

				arg_294_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_294_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_294_1.fswtw_:SetDirty()

				arg_294_1.typewritterCharCountI18N = 0

				SetActive(arg_294_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_294_1:ShowNextGo(false)
			end

			local var_297_3 = 0.0666666666666669

			if var_297_3 < arg_294_1.time_ and arg_294_1.time_ <= var_297_3 + arg_297_0 then
				arg_294_1.var_.oldValueTypewriter = arg_294_1.fswtw_.percent

				SetActive(arg_294_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_294_1:ShowNextGo(false)
			end

			local var_297_4 = 38
			local var_297_5 = 2.53333333333333
			local var_297_6 = arg_294_1:GetWordFromCfg(420132072)
			local var_297_7 = arg_294_1:FormatText(var_297_6.content)
			local var_297_8, var_297_9 = arg_294_1:GetPercentByPara(var_297_7, 1)

			if var_297_3 < arg_294_1.time_ and arg_294_1.time_ <= var_297_3 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0

				local var_297_10 = var_297_4 <= 0 and var_297_5 or var_297_5 * ((var_297_9 - arg_294_1.typewritterCharCountI18N) / var_297_4)

				if var_297_10 > 0 and var_297_5 < var_297_10 then
					arg_294_1.talkMaxDuration = var_297_10

					if var_297_10 + var_297_3 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_10 + var_297_3
					end
				end
			end

			local var_297_11 = 2.53333333333333
			local var_297_12 = math.max(var_297_11, arg_294_1.talkMaxDuration)

			if var_297_3 <= arg_294_1.time_ and arg_294_1.time_ < var_297_3 + var_297_12 then
				local var_297_13 = (arg_294_1.time_ - var_297_3) / var_297_12

				arg_294_1.fswtw_.percent = Mathf.Lerp(arg_294_1.var_.oldValueTypewriter, var_297_8, var_297_13)
				arg_294_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_294_1.fswtw_:SetDirty()
			end

			if arg_294_1.time_ >= var_297_3 + var_297_12 and arg_294_1.time_ < var_297_3 + var_297_12 + arg_297_0 then
				arg_294_1.fswtw_.percent = var_297_8

				arg_294_1.fswtw_:SetDirty()
				arg_294_1:ShowNextGo(true)

				arg_294_1.typewritterCharCountI18N = var_297_9
			end

			local var_297_14 = 0
			local var_297_15 = 11.266
			local var_297_16 = manager.audio:GetVoiceLength("story_v_out_420132", "420132072", "story_v_out_420132.awb") / 1000

			if var_297_16 > 0 and var_297_15 < var_297_16 and var_297_16 + var_297_14 > arg_294_1.duration_ then
				local var_297_17 = var_297_16

				arg_294_1.duration_ = var_297_16 + var_297_14
			end

			if var_297_14 < arg_294_1.time_ and arg_294_1.time_ <= var_297_14 + arg_297_0 then
				local var_297_18 = "play"
				local var_297_19 = "voice"

				arg_294_1:AudioAction(var_297_18, var_297_19, "story_v_out_420132", "420132072", "story_v_out_420132.awb")
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play420132073 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 420132073
		arg_298_1.duration_ = 4.63

		local var_298_0 = {
			zh = 4.1,
			ja = 4.633
		}
		local var_298_1 = manager.audio:GetLocalizationFlag()

		if var_298_0[var_298_1] ~= nil then
			arg_298_1.duration_ = var_298_0[var_298_1]
		end

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play420132074(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 0

			if var_301_0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_0 + arg_301_0 then
				local var_301_1 = manager.ui.mainCamera.transform.localPosition
				local var_301_2 = Vector3.New(0, 0, 10) + Vector3.New(var_301_1.x, var_301_1.y, 0)
				local var_301_3 = arg_298_1.bgs_.ST67

				var_301_3.transform.localPosition = var_301_2
				var_301_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_301_4 = var_301_3:GetComponent("SpriteRenderer")

				if var_301_4 and var_301_4.sprite then
					local var_301_5 = (var_301_3.transform.localPosition - var_301_1).z
					local var_301_6 = manager.ui.mainCameraCom_
					local var_301_7 = 2 * var_301_5 * Mathf.Tan(var_301_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_301_8 = var_301_7 * var_301_6.aspect
					local var_301_9 = var_301_4.sprite.bounds.size.x
					local var_301_10 = var_301_4.sprite.bounds.size.y
					local var_301_11 = var_301_8 / var_301_9
					local var_301_12 = var_301_7 / var_301_10
					local var_301_13 = var_301_12 < var_301_11 and var_301_11 or var_301_12

					var_301_3.transform.localScale = Vector3.New(var_301_13, var_301_13, 0)
				end

				for iter_301_0, iter_301_1 in pairs(arg_298_1.bgs_) do
					if iter_301_0 ~= "ST67" then
						iter_301_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_301_14 = 0

			if var_301_14 < arg_298_1.time_ and arg_298_1.time_ <= var_301_14 + arg_301_0 then
				arg_298_1.mask_.enabled = true
				arg_298_1.mask_.raycastTarget = true

				arg_298_1:SetGaussion(false)
			end

			local var_301_15 = 2

			if var_301_14 <= arg_298_1.time_ and arg_298_1.time_ < var_301_14 + var_301_15 then
				local var_301_16 = (arg_298_1.time_ - var_301_14) / var_301_15
				local var_301_17 = Color.New(0, 0, 0)

				var_301_17.a = Mathf.Lerp(1, 0, var_301_16)
				arg_298_1.mask_.color = var_301_17
			end

			if arg_298_1.time_ >= var_301_14 + var_301_15 and arg_298_1.time_ < var_301_14 + var_301_15 + arg_301_0 then
				local var_301_18 = Color.New(0, 0, 0)
				local var_301_19 = 0

				arg_298_1.mask_.enabled = false
				var_301_18.a = var_301_19
				arg_298_1.mask_.color = var_301_18
			end

			local var_301_20 = arg_298_1.actors_["1061ui_story"].transform
			local var_301_21 = 1.86666666666667

			if var_301_21 < arg_298_1.time_ and arg_298_1.time_ <= var_301_21 + arg_301_0 then
				arg_298_1.var_.moveOldPos1061ui_story = var_301_20.localPosition
			end

			local var_301_22 = 0.001

			if var_301_21 <= arg_298_1.time_ and arg_298_1.time_ < var_301_21 + var_301_22 then
				local var_301_23 = (arg_298_1.time_ - var_301_21) / var_301_22
				local var_301_24 = Vector3.New(0, -1.18, -6.15)

				var_301_20.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos1061ui_story, var_301_24, var_301_23)

				local var_301_25 = manager.ui.mainCamera.transform.position - var_301_20.position

				var_301_20.forward = Vector3.New(var_301_25.x, var_301_25.y, var_301_25.z)

				local var_301_26 = var_301_20.localEulerAngles

				var_301_26.z = 0
				var_301_26.x = 0
				var_301_20.localEulerAngles = var_301_26
			end

			if arg_298_1.time_ >= var_301_21 + var_301_22 and arg_298_1.time_ < var_301_21 + var_301_22 + arg_301_0 then
				var_301_20.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_301_27 = manager.ui.mainCamera.transform.position - var_301_20.position

				var_301_20.forward = Vector3.New(var_301_27.x, var_301_27.y, var_301_27.z)

				local var_301_28 = var_301_20.localEulerAngles

				var_301_28.z = 0
				var_301_28.x = 0
				var_301_20.localEulerAngles = var_301_28
			end

			local var_301_29 = arg_298_1.actors_["1061ui_story"]
			local var_301_30 = 1.86666666666667

			if var_301_30 < arg_298_1.time_ and arg_298_1.time_ <= var_301_30 + arg_301_0 and not isNil(var_301_29) and arg_298_1.var_.characterEffect1061ui_story == nil then
				arg_298_1.var_.characterEffect1061ui_story = var_301_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_301_31 = 0.200000002980232

			if var_301_30 <= arg_298_1.time_ and arg_298_1.time_ < var_301_30 + var_301_31 and not isNil(var_301_29) then
				local var_301_32 = (arg_298_1.time_ - var_301_30) / var_301_31

				if arg_298_1.var_.characterEffect1061ui_story and not isNil(var_301_29) then
					arg_298_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_298_1.time_ >= var_301_30 + var_301_31 and arg_298_1.time_ < var_301_30 + var_301_31 + arg_301_0 and not isNil(var_301_29) and arg_298_1.var_.characterEffect1061ui_story then
				arg_298_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_301_33 = 1.86666666666667

			if var_301_33 < arg_298_1.time_ and arg_298_1.time_ <= var_301_33 + arg_301_0 then
				arg_298_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			local var_301_34 = 1.86666666666667

			if var_301_34 < arg_298_1.time_ and arg_298_1.time_ <= var_301_34 + arg_301_0 then
				arg_298_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva", "EmotionTimelineAnimator")
			end

			local var_301_35 = 0

			if var_301_35 < arg_298_1.time_ and arg_298_1.time_ <= var_301_35 + arg_301_0 then
				arg_298_1.cswbg_:SetActive(false)
			end

			local var_301_36 = 0

			if var_301_36 < arg_298_1.time_ and arg_298_1.time_ <= var_301_36 + arg_301_0 then
				arg_298_1.fswbg_:SetActive(false)
				arg_298_1.dialog_:SetActive(false)
				SetActive(arg_298_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_298_1:ShowNextGo(false)
			end

			local var_301_37 = 0.05
			local var_301_38 = 1

			if var_301_37 < arg_298_1.time_ and arg_298_1.time_ <= var_301_37 + arg_301_0 then
				local var_301_39 = "play"
				local var_301_40 = "effect"

				arg_298_1:AudioAction(var_301_39, var_301_40, "se_story_140", "se_story_140_amb_lab", "")
			end

			if arg_298_1.frameCnt_ <= 1 then
				arg_298_1.dialog_:SetActive(false)
			end

			local var_301_41 = 2
			local var_301_42 = 0.225

			if var_301_41 < arg_298_1.time_ and arg_298_1.time_ <= var_301_41 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0

				arg_298_1.dialog_:SetActive(true)

				arg_298_1.dialogCg_.alpha = 0

				local var_301_43 = LeanTween.value(arg_298_1.dialog_, 0, 1, 0.3)

				var_301_43:setOnUpdate(LuaHelper.FloatAction(function(arg_302_0)
					arg_298_1.dialogCg_.alpha = arg_302_0
				end))
				var_301_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_298_1.dialog_)
					var_301_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_298_1.duration_ = arg_298_1.duration_ + 0.3

				SetActive(arg_298_1.leftNameGo_, true)

				local var_301_44 = arg_298_1:FormatText(StoryNameCfg[612].name)

				arg_298_1.leftNameTxt_.text = var_301_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_45 = arg_298_1:GetWordFromCfg(420132073)
				local var_301_46 = arg_298_1:FormatText(var_301_45.content)

				arg_298_1.text_.text = var_301_46

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_47 = 9
				local var_301_48 = utf8.len(var_301_46)
				local var_301_49 = var_301_47 <= 0 and var_301_42 or var_301_42 * (var_301_48 / var_301_47)

				if var_301_49 > 0 and var_301_42 < var_301_49 then
					arg_298_1.talkMaxDuration = var_301_49
					var_301_41 = var_301_41 + 0.3

					if var_301_49 + var_301_41 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_49 + var_301_41
					end
				end

				arg_298_1.text_.text = var_301_46
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132073", "story_v_out_420132.awb") ~= 0 then
					local var_301_50 = manager.audio:GetVoiceLength("story_v_out_420132", "420132073", "story_v_out_420132.awb") / 1000

					if var_301_50 + var_301_41 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_50 + var_301_41
					end

					if var_301_45.prefab_name ~= "" and arg_298_1.actors_[var_301_45.prefab_name] ~= nil then
						local var_301_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_45.prefab_name].transform, "story_v_out_420132", "420132073", "story_v_out_420132.awb")

						arg_298_1:RecordAudio("420132073", var_301_51)
						arg_298_1:RecordAudio("420132073", var_301_51)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_out_420132", "420132073", "story_v_out_420132.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_out_420132", "420132073", "story_v_out_420132.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_52 = var_301_41 + 0.3
			local var_301_53 = math.max(var_301_42, arg_298_1.talkMaxDuration)

			if var_301_52 <= arg_298_1.time_ and arg_298_1.time_ < var_301_52 + var_301_53 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_52) / var_301_53

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_52 + var_301_53 and arg_298_1.time_ < var_301_52 + var_301_53 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.86666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_298_1:InitPlayNodeList()
	end,
	Play420132074 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 420132074
		arg_304_1.duration_ = 7.27

		local var_304_0 = {
			zh = 5.9,
			ja = 7.266
		}
		local var_304_1 = manager.audio:GetLocalizationFlag()

		if var_304_0[var_304_1] ~= nil then
			arg_304_1.duration_ = var_304_0[var_304_1]
		end

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play420132075(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = arg_304_1.actors_["1061ui_story"].transform
			local var_307_1 = 0

			if var_307_1 < arg_304_1.time_ and arg_304_1.time_ <= var_307_1 + arg_307_0 then
				arg_304_1.var_.moveOldPos1061ui_story = var_307_0.localPosition
			end

			local var_307_2 = 0.001

			if var_307_1 <= arg_304_1.time_ and arg_304_1.time_ < var_307_1 + var_307_2 then
				local var_307_3 = (arg_304_1.time_ - var_307_1) / var_307_2
				local var_307_4 = Vector3.New(0, 100, 0)

				var_307_0.localPosition = Vector3.Lerp(arg_304_1.var_.moveOldPos1061ui_story, var_307_4, var_307_3)

				local var_307_5 = manager.ui.mainCamera.transform.position - var_307_0.position

				var_307_0.forward = Vector3.New(var_307_5.x, var_307_5.y, var_307_5.z)

				local var_307_6 = var_307_0.localEulerAngles

				var_307_6.z = 0
				var_307_6.x = 0
				var_307_0.localEulerAngles = var_307_6
			end

			if arg_304_1.time_ >= var_307_1 + var_307_2 and arg_304_1.time_ < var_307_1 + var_307_2 + arg_307_0 then
				var_307_0.localPosition = Vector3.New(0, 100, 0)

				local var_307_7 = manager.ui.mainCamera.transform.position - var_307_0.position

				var_307_0.forward = Vector3.New(var_307_7.x, var_307_7.y, var_307_7.z)

				local var_307_8 = var_307_0.localEulerAngles

				var_307_8.z = 0
				var_307_8.x = 0
				var_307_0.localEulerAngles = var_307_8
			end

			local var_307_9 = arg_304_1.actors_["1085ui_story"].transform
			local var_307_10 = 0

			if var_307_10 < arg_304_1.time_ and arg_304_1.time_ <= var_307_10 + arg_307_0 then
				arg_304_1.var_.moveOldPos1085ui_story = var_307_9.localPosition
			end

			local var_307_11 = 0.001

			if var_307_10 <= arg_304_1.time_ and arg_304_1.time_ < var_307_10 + var_307_11 then
				local var_307_12 = (arg_304_1.time_ - var_307_10) / var_307_11
				local var_307_13 = Vector3.New(0, -1.01, -5.83)

				var_307_9.localPosition = Vector3.Lerp(arg_304_1.var_.moveOldPos1085ui_story, var_307_13, var_307_12)

				local var_307_14 = manager.ui.mainCamera.transform.position - var_307_9.position

				var_307_9.forward = Vector3.New(var_307_14.x, var_307_14.y, var_307_14.z)

				local var_307_15 = var_307_9.localEulerAngles

				var_307_15.z = 0
				var_307_15.x = 0
				var_307_9.localEulerAngles = var_307_15
			end

			if arg_304_1.time_ >= var_307_10 + var_307_11 and arg_304_1.time_ < var_307_10 + var_307_11 + arg_307_0 then
				var_307_9.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_307_16 = manager.ui.mainCamera.transform.position - var_307_9.position

				var_307_9.forward = Vector3.New(var_307_16.x, var_307_16.y, var_307_16.z)

				local var_307_17 = var_307_9.localEulerAngles

				var_307_17.z = 0
				var_307_17.x = 0
				var_307_9.localEulerAngles = var_307_17
			end

			local var_307_18 = arg_304_1.actors_["1085ui_story"]
			local var_307_19 = 0

			if var_307_19 < arg_304_1.time_ and arg_304_1.time_ <= var_307_19 + arg_307_0 and not isNil(var_307_18) and arg_304_1.var_.characterEffect1085ui_story == nil then
				arg_304_1.var_.characterEffect1085ui_story = var_307_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_307_20 = 0.200000002980232

			if var_307_19 <= arg_304_1.time_ and arg_304_1.time_ < var_307_19 + var_307_20 and not isNil(var_307_18) then
				local var_307_21 = (arg_304_1.time_ - var_307_19) / var_307_20

				if arg_304_1.var_.characterEffect1085ui_story and not isNil(var_307_18) then
					arg_304_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_304_1.time_ >= var_307_19 + var_307_20 and arg_304_1.time_ < var_307_19 + var_307_20 + arg_307_0 and not isNil(var_307_18) and arg_304_1.var_.characterEffect1085ui_story then
				arg_304_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_307_22 = 0

			if var_307_22 < arg_304_1.time_ and arg_304_1.time_ <= var_307_22 + arg_307_0 then
				arg_304_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_307_23 = 0

			if var_307_23 < arg_304_1.time_ and arg_304_1.time_ <= var_307_23 + arg_307_0 then
				arg_304_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_307_24 = 0
			local var_307_25 = 0.475

			if var_307_24 < arg_304_1.time_ and arg_304_1.time_ <= var_307_24 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				local var_307_26 = arg_304_1:FormatText(StoryNameCfg[328].name)

				arg_304_1.leftNameTxt_.text = var_307_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_27 = arg_304_1:GetWordFromCfg(420132074)
				local var_307_28 = arg_304_1:FormatText(var_307_27.content)

				arg_304_1.text_.text = var_307_28

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_29 = 19
				local var_307_30 = utf8.len(var_307_28)
				local var_307_31 = var_307_29 <= 0 and var_307_25 or var_307_25 * (var_307_30 / var_307_29)

				if var_307_31 > 0 and var_307_25 < var_307_31 then
					arg_304_1.talkMaxDuration = var_307_31

					if var_307_31 + var_307_24 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_31 + var_307_24
					end
				end

				arg_304_1.text_.text = var_307_28
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132074", "story_v_out_420132.awb") ~= 0 then
					local var_307_32 = manager.audio:GetVoiceLength("story_v_out_420132", "420132074", "story_v_out_420132.awb") / 1000

					if var_307_32 + var_307_24 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_32 + var_307_24
					end

					if var_307_27.prefab_name ~= "" and arg_304_1.actors_[var_307_27.prefab_name] ~= nil then
						local var_307_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_27.prefab_name].transform, "story_v_out_420132", "420132074", "story_v_out_420132.awb")

						arg_304_1:RecordAudio("420132074", var_307_33)
						arg_304_1:RecordAudio("420132074", var_307_33)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_420132", "420132074", "story_v_out_420132.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_420132", "420132074", "story_v_out_420132.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_34 = math.max(var_307_25, arg_304_1.talkMaxDuration)

			if var_307_24 <= arg_304_1.time_ and arg_304_1.time_ < var_307_24 + var_307_34 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_24) / var_307_34

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_24 + var_307_34 and arg_304_1.time_ < var_307_24 + var_307_34 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {
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
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_304_1:InitPlayNodeList()
	end,
	Play420132075 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 420132075
		arg_308_1.duration_ = 5

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play420132076(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = arg_308_1.actors_["1085ui_story"].transform
			local var_311_1 = 0

			if var_311_1 < arg_308_1.time_ and arg_308_1.time_ <= var_311_1 + arg_311_0 then
				arg_308_1.var_.moveOldPos1085ui_story = var_311_0.localPosition
			end

			local var_311_2 = 0.001

			if var_311_1 <= arg_308_1.time_ and arg_308_1.time_ < var_311_1 + var_311_2 then
				local var_311_3 = (arg_308_1.time_ - var_311_1) / var_311_2
				local var_311_4 = Vector3.New(0, 100, 0)

				var_311_0.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos1085ui_story, var_311_4, var_311_3)

				local var_311_5 = manager.ui.mainCamera.transform.position - var_311_0.position

				var_311_0.forward = Vector3.New(var_311_5.x, var_311_5.y, var_311_5.z)

				local var_311_6 = var_311_0.localEulerAngles

				var_311_6.z = 0
				var_311_6.x = 0
				var_311_0.localEulerAngles = var_311_6
			end

			if arg_308_1.time_ >= var_311_1 + var_311_2 and arg_308_1.time_ < var_311_1 + var_311_2 + arg_311_0 then
				var_311_0.localPosition = Vector3.New(0, 100, 0)

				local var_311_7 = manager.ui.mainCamera.transform.position - var_311_0.position

				var_311_0.forward = Vector3.New(var_311_7.x, var_311_7.y, var_311_7.z)

				local var_311_8 = var_311_0.localEulerAngles

				var_311_8.z = 0
				var_311_8.x = 0
				var_311_0.localEulerAngles = var_311_8
			end

			local var_311_9 = 0
			local var_311_10 = 1.2

			if var_311_9 < arg_308_1.time_ and arg_308_1.time_ <= var_311_9 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, false)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_11 = arg_308_1:GetWordFromCfg(420132075)
				local var_311_12 = arg_308_1:FormatText(var_311_11.content)

				arg_308_1.text_.text = var_311_12

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_13 = 48
				local var_311_14 = utf8.len(var_311_12)
				local var_311_15 = var_311_13 <= 0 and var_311_10 or var_311_10 * (var_311_14 / var_311_13)

				if var_311_15 > 0 and var_311_10 < var_311_15 then
					arg_308_1.talkMaxDuration = var_311_15

					if var_311_15 + var_311_9 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_15 + var_311_9
					end
				end

				arg_308_1.text_.text = var_311_12
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)
				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_16 = math.max(var_311_10, arg_308_1.talkMaxDuration)

			if var_311_9 <= arg_308_1.time_ and arg_308_1.time_ < var_311_9 + var_311_16 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_9) / var_311_16

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_9 + var_311_16 and arg_308_1.time_ < var_311_9 + var_311_16 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_308_1:InitPlayNodeList()
	end,
	Play420132076 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 420132076
		arg_312_1.duration_ = 5.2

		local var_312_0 = {
			zh = 4.466,
			ja = 5.2
		}
		local var_312_1 = manager.audio:GetLocalizationFlag()

		if var_312_0[var_312_1] ~= nil then
			arg_312_1.duration_ = var_312_0[var_312_1]
		end

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play420132077(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = arg_312_1.actors_["1061ui_story"].transform
			local var_315_1 = 0

			if var_315_1 < arg_312_1.time_ and arg_312_1.time_ <= var_315_1 + arg_315_0 then
				arg_312_1.var_.moveOldPos1061ui_story = var_315_0.localPosition
			end

			local var_315_2 = 0.001

			if var_315_1 <= arg_312_1.time_ and arg_312_1.time_ < var_315_1 + var_315_2 then
				local var_315_3 = (arg_312_1.time_ - var_315_1) / var_315_2
				local var_315_4 = Vector3.New(0, -1.18, -6.15)

				var_315_0.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos1061ui_story, var_315_4, var_315_3)

				local var_315_5 = manager.ui.mainCamera.transform.position - var_315_0.position

				var_315_0.forward = Vector3.New(var_315_5.x, var_315_5.y, var_315_5.z)

				local var_315_6 = var_315_0.localEulerAngles

				var_315_6.z = 0
				var_315_6.x = 0
				var_315_0.localEulerAngles = var_315_6
			end

			if arg_312_1.time_ >= var_315_1 + var_315_2 and arg_312_1.time_ < var_315_1 + var_315_2 + arg_315_0 then
				var_315_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_315_7 = manager.ui.mainCamera.transform.position - var_315_0.position

				var_315_0.forward = Vector3.New(var_315_7.x, var_315_7.y, var_315_7.z)

				local var_315_8 = var_315_0.localEulerAngles

				var_315_8.z = 0
				var_315_8.x = 0
				var_315_0.localEulerAngles = var_315_8
			end

			local var_315_9 = arg_312_1.actors_["1061ui_story"]
			local var_315_10 = 0

			if var_315_10 < arg_312_1.time_ and arg_312_1.time_ <= var_315_10 + arg_315_0 and not isNil(var_315_9) and arg_312_1.var_.characterEffect1061ui_story == nil then
				arg_312_1.var_.characterEffect1061ui_story = var_315_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_11 = 0.200000002980232

			if var_315_10 <= arg_312_1.time_ and arg_312_1.time_ < var_315_10 + var_315_11 and not isNil(var_315_9) then
				local var_315_12 = (arg_312_1.time_ - var_315_10) / var_315_11

				if arg_312_1.var_.characterEffect1061ui_story and not isNil(var_315_9) then
					arg_312_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_312_1.time_ >= var_315_10 + var_315_11 and arg_312_1.time_ < var_315_10 + var_315_11 + arg_315_0 and not isNil(var_315_9) and arg_312_1.var_.characterEffect1061ui_story then
				arg_312_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_315_13 = 0

			if var_315_13 < arg_312_1.time_ and arg_312_1.time_ <= var_315_13 + arg_315_0 then
				arg_312_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			local var_315_14 = 0

			if var_315_14 < arg_312_1.time_ and arg_312_1.time_ <= var_315_14 + arg_315_0 then
				arg_312_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_315_15 = 0
			local var_315_16 = 0.45

			if var_315_15 < arg_312_1.time_ and arg_312_1.time_ <= var_315_15 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				local var_315_17 = arg_312_1:FormatText(StoryNameCfg[612].name)

				arg_312_1.leftNameTxt_.text = var_315_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_18 = arg_312_1:GetWordFromCfg(420132076)
				local var_315_19 = arg_312_1:FormatText(var_315_18.content)

				arg_312_1.text_.text = var_315_19

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_20 = 18
				local var_315_21 = utf8.len(var_315_19)
				local var_315_22 = var_315_20 <= 0 and var_315_16 or var_315_16 * (var_315_21 / var_315_20)

				if var_315_22 > 0 and var_315_16 < var_315_22 then
					arg_312_1.talkMaxDuration = var_315_22

					if var_315_22 + var_315_15 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_22 + var_315_15
					end
				end

				arg_312_1.text_.text = var_315_19
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132076", "story_v_out_420132.awb") ~= 0 then
					local var_315_23 = manager.audio:GetVoiceLength("story_v_out_420132", "420132076", "story_v_out_420132.awb") / 1000

					if var_315_23 + var_315_15 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_23 + var_315_15
					end

					if var_315_18.prefab_name ~= "" and arg_312_1.actors_[var_315_18.prefab_name] ~= nil then
						local var_315_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_18.prefab_name].transform, "story_v_out_420132", "420132076", "story_v_out_420132.awb")

						arg_312_1:RecordAudio("420132076", var_315_24)
						arg_312_1:RecordAudio("420132076", var_315_24)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_420132", "420132076", "story_v_out_420132.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_420132", "420132076", "story_v_out_420132.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_25 = math.max(var_315_16, arg_312_1.talkMaxDuration)

			if var_315_15 <= arg_312_1.time_ and arg_312_1.time_ < var_315_15 + var_315_25 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_15) / var_315_25

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_15 + var_315_25 and arg_312_1.time_ < var_315_15 + var_315_25 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
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

		arg_312_1:InitPlayNodeList()
	end,
	Play420132077 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 420132077
		arg_316_1.duration_ = 5.13

		local var_316_0 = {
			zh = 3.3,
			ja = 5.133
		}
		local var_316_1 = manager.audio:GetLocalizationFlag()

		if var_316_0[var_316_1] ~= nil then
			arg_316_1.duration_ = var_316_0[var_316_1]
		end

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play420132078(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = arg_316_1.actors_["1085ui_story"]
			local var_319_1 = 0

			if var_319_1 < arg_316_1.time_ and arg_316_1.time_ <= var_319_1 + arg_319_0 and not isNil(var_319_0) and arg_316_1.var_.characterEffect1085ui_story == nil then
				arg_316_1.var_.characterEffect1085ui_story = var_319_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_2 = 0.200000002980232

			if var_319_1 <= arg_316_1.time_ and arg_316_1.time_ < var_319_1 + var_319_2 and not isNil(var_319_0) then
				local var_319_3 = (arg_316_1.time_ - var_319_1) / var_319_2

				if arg_316_1.var_.characterEffect1085ui_story and not isNil(var_319_0) then
					arg_316_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_316_1.time_ >= var_319_1 + var_319_2 and arg_316_1.time_ < var_319_1 + var_319_2 + arg_319_0 and not isNil(var_319_0) and arg_316_1.var_.characterEffect1085ui_story then
				arg_316_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_319_4 = arg_316_1.actors_["1061ui_story"]
			local var_319_5 = 0

			if var_319_5 < arg_316_1.time_ and arg_316_1.time_ <= var_319_5 + arg_319_0 and not isNil(var_319_4) and arg_316_1.var_.characterEffect1061ui_story == nil then
				arg_316_1.var_.characterEffect1061ui_story = var_319_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_6 = 0.200000002980232

			if var_319_5 <= arg_316_1.time_ and arg_316_1.time_ < var_319_5 + var_319_6 and not isNil(var_319_4) then
				local var_319_7 = (arg_316_1.time_ - var_319_5) / var_319_6

				if arg_316_1.var_.characterEffect1061ui_story and not isNil(var_319_4) then
					local var_319_8 = Mathf.Lerp(0, 0.5, var_319_7)

					arg_316_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_316_1.var_.characterEffect1061ui_story.fillRatio = var_319_8
				end
			end

			if arg_316_1.time_ >= var_319_5 + var_319_6 and arg_316_1.time_ < var_319_5 + var_319_6 + arg_319_0 and not isNil(var_319_4) and arg_316_1.var_.characterEffect1061ui_story then
				local var_319_9 = 0.5

				arg_316_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_316_1.var_.characterEffect1061ui_story.fillRatio = var_319_9
			end

			local var_319_10 = arg_316_1.actors_["1061ui_story"].transform
			local var_319_11 = 0

			if var_319_11 < arg_316_1.time_ and arg_316_1.time_ <= var_319_11 + arg_319_0 then
				arg_316_1.var_.moveOldPos1061ui_story = var_319_10.localPosition
			end

			local var_319_12 = 0.001

			if var_319_11 <= arg_316_1.time_ and arg_316_1.time_ < var_319_11 + var_319_12 then
				local var_319_13 = (arg_316_1.time_ - var_319_11) / var_319_12
				local var_319_14 = Vector3.New(-0.7, -1.18, -6.15)

				var_319_10.localPosition = Vector3.Lerp(arg_316_1.var_.moveOldPos1061ui_story, var_319_14, var_319_13)

				local var_319_15 = manager.ui.mainCamera.transform.position - var_319_10.position

				var_319_10.forward = Vector3.New(var_319_15.x, var_319_15.y, var_319_15.z)

				local var_319_16 = var_319_10.localEulerAngles

				var_319_16.z = 0
				var_319_16.x = 0
				var_319_10.localEulerAngles = var_319_16
			end

			if arg_316_1.time_ >= var_319_11 + var_319_12 and arg_316_1.time_ < var_319_11 + var_319_12 + arg_319_0 then
				var_319_10.localPosition = Vector3.New(-0.7, -1.18, -6.15)

				local var_319_17 = manager.ui.mainCamera.transform.position - var_319_10.position

				var_319_10.forward = Vector3.New(var_319_17.x, var_319_17.y, var_319_17.z)

				local var_319_18 = var_319_10.localEulerAngles

				var_319_18.z = 0
				var_319_18.x = 0
				var_319_10.localEulerAngles = var_319_18
			end

			local var_319_19 = 0

			if var_319_19 < arg_316_1.time_ and arg_316_1.time_ <= var_319_19 + arg_319_0 then
				arg_316_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action2_1")
			end

			local var_319_20 = arg_316_1.actors_["1085ui_story"].transform
			local var_319_21 = 0

			if var_319_21 < arg_316_1.time_ and arg_316_1.time_ <= var_319_21 + arg_319_0 then
				arg_316_1.var_.moveOldPos1085ui_story = var_319_20.localPosition
			end

			local var_319_22 = 0.001

			if var_319_21 <= arg_316_1.time_ and arg_316_1.time_ < var_319_21 + var_319_22 then
				local var_319_23 = (arg_316_1.time_ - var_319_21) / var_319_22
				local var_319_24 = Vector3.New(0.75, -1.01, -5.83)

				var_319_20.localPosition = Vector3.Lerp(arg_316_1.var_.moveOldPos1085ui_story, var_319_24, var_319_23)

				local var_319_25 = manager.ui.mainCamera.transform.position - var_319_20.position

				var_319_20.forward = Vector3.New(var_319_25.x, var_319_25.y, var_319_25.z)

				local var_319_26 = var_319_20.localEulerAngles

				var_319_26.z = 0
				var_319_26.x = 0
				var_319_20.localEulerAngles = var_319_26
			end

			if arg_316_1.time_ >= var_319_21 + var_319_22 and arg_316_1.time_ < var_319_21 + var_319_22 + arg_319_0 then
				var_319_20.localPosition = Vector3.New(0.75, -1.01, -5.83)

				local var_319_27 = manager.ui.mainCamera.transform.position - var_319_20.position

				var_319_20.forward = Vector3.New(var_319_27.x, var_319_27.y, var_319_27.z)

				local var_319_28 = var_319_20.localEulerAngles

				var_319_28.z = 0
				var_319_28.x = 0
				var_319_20.localEulerAngles = var_319_28
			end

			local var_319_29 = 0
			local var_319_30 = 0.275

			if var_319_29 < arg_316_1.time_ and arg_316_1.time_ <= var_319_29 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				local var_319_31 = arg_316_1:FormatText(StoryNameCfg[328].name)

				arg_316_1.leftNameTxt_.text = var_319_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_32 = arg_316_1:GetWordFromCfg(420132077)
				local var_319_33 = arg_316_1:FormatText(var_319_32.content)

				arg_316_1.text_.text = var_319_33

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_34 = 11
				local var_319_35 = utf8.len(var_319_33)
				local var_319_36 = var_319_34 <= 0 and var_319_30 or var_319_30 * (var_319_35 / var_319_34)

				if var_319_36 > 0 and var_319_30 < var_319_36 then
					arg_316_1.talkMaxDuration = var_319_36

					if var_319_36 + var_319_29 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_36 + var_319_29
					end
				end

				arg_316_1.text_.text = var_319_33
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132077", "story_v_out_420132.awb") ~= 0 then
					local var_319_37 = manager.audio:GetVoiceLength("story_v_out_420132", "420132077", "story_v_out_420132.awb") / 1000

					if var_319_37 + var_319_29 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_37 + var_319_29
					end

					if var_319_32.prefab_name ~= "" and arg_316_1.actors_[var_319_32.prefab_name] ~= nil then
						local var_319_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_32.prefab_name].transform, "story_v_out_420132", "420132077", "story_v_out_420132.awb")

						arg_316_1:RecordAudio("420132077", var_319_38)
						arg_316_1:RecordAudio("420132077", var_319_38)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_420132", "420132077", "story_v_out_420132.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_420132", "420132077", "story_v_out_420132.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_39 = math.max(var_319_30, arg_316_1.talkMaxDuration)

			if var_319_29 <= arg_316_1.time_ and arg_316_1.time_ < var_319_29 + var_319_39 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_29) / var_319_39

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_29 + var_319_39 and arg_316_1.time_ < var_319_29 + var_319_39 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {
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
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_316_1:InitPlayNodeList()
	end,
	Play420132078 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 420132078
		arg_320_1.duration_ = 5

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play420132079(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = arg_320_1.actors_["1085ui_story"]
			local var_323_1 = 0

			if var_323_1 < arg_320_1.time_ and arg_320_1.time_ <= var_323_1 + arg_323_0 and not isNil(var_323_0) and arg_320_1.var_.characterEffect1085ui_story == nil then
				arg_320_1.var_.characterEffect1085ui_story = var_323_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_323_2 = 0.200000002980232

			if var_323_1 <= arg_320_1.time_ and arg_320_1.time_ < var_323_1 + var_323_2 and not isNil(var_323_0) then
				local var_323_3 = (arg_320_1.time_ - var_323_1) / var_323_2

				if arg_320_1.var_.characterEffect1085ui_story and not isNil(var_323_0) then
					local var_323_4 = Mathf.Lerp(0, 0.5, var_323_3)

					arg_320_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_320_1.var_.characterEffect1085ui_story.fillRatio = var_323_4
				end
			end

			if arg_320_1.time_ >= var_323_1 + var_323_2 and arg_320_1.time_ < var_323_1 + var_323_2 + arg_323_0 and not isNil(var_323_0) and arg_320_1.var_.characterEffect1085ui_story then
				local var_323_5 = 0.5

				arg_320_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_320_1.var_.characterEffect1085ui_story.fillRatio = var_323_5
			end

			local var_323_6 = 0
			local var_323_7 = 0.925

			if var_323_6 < arg_320_1.time_ and arg_320_1.time_ <= var_323_6 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, false)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_8 = arg_320_1:GetWordFromCfg(420132078)
				local var_323_9 = arg_320_1:FormatText(var_323_8.content)

				arg_320_1.text_.text = var_323_9

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_10 = 37
				local var_323_11 = utf8.len(var_323_9)
				local var_323_12 = var_323_10 <= 0 and var_323_7 or var_323_7 * (var_323_11 / var_323_10)

				if var_323_12 > 0 and var_323_7 < var_323_12 then
					arg_320_1.talkMaxDuration = var_323_12

					if var_323_12 + var_323_6 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_12 + var_323_6
					end
				end

				arg_320_1.text_.text = var_323_9
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)
				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_13 = math.max(var_323_7, arg_320_1.talkMaxDuration)

			if var_323_6 <= arg_320_1.time_ and arg_320_1.time_ < var_323_6 + var_323_13 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_6) / var_323_13

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_6 + var_323_13 and arg_320_1.time_ < var_323_6 + var_323_13 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play420132079 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 420132079
		arg_324_1.duration_ = 21.37

		local var_324_0 = {
			zh = 10.2,
			ja = 21.366
		}
		local var_324_1 = manager.audio:GetLocalizationFlag()

		if var_324_0[var_324_1] ~= nil then
			arg_324_1.duration_ = var_324_0[var_324_1]
		end

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play420132080(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = arg_324_1.actors_["1085ui_story"]
			local var_327_1 = 0

			if var_327_1 < arg_324_1.time_ and arg_324_1.time_ <= var_327_1 + arg_327_0 and not isNil(var_327_0) and arg_324_1.var_.characterEffect1085ui_story == nil then
				arg_324_1.var_.characterEffect1085ui_story = var_327_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_2 = 0.200000002980232

			if var_327_1 <= arg_324_1.time_ and arg_324_1.time_ < var_327_1 + var_327_2 and not isNil(var_327_0) then
				local var_327_3 = (arg_324_1.time_ - var_327_1) / var_327_2

				if arg_324_1.var_.characterEffect1085ui_story and not isNil(var_327_0) then
					arg_324_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_324_1.time_ >= var_327_1 + var_327_2 and arg_324_1.time_ < var_327_1 + var_327_2 + arg_327_0 and not isNil(var_327_0) and arg_324_1.var_.characterEffect1085ui_story then
				arg_324_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_327_4 = 0
			local var_327_5 = 0.95

			if var_327_4 < arg_324_1.time_ and arg_324_1.time_ <= var_327_4 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				local var_327_6 = arg_324_1:FormatText(StoryNameCfg[328].name)

				arg_324_1.leftNameTxt_.text = var_327_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_7 = arg_324_1:GetWordFromCfg(420132079)
				local var_327_8 = arg_324_1:FormatText(var_327_7.content)

				arg_324_1.text_.text = var_327_8

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_9 = 38
				local var_327_10 = utf8.len(var_327_8)
				local var_327_11 = var_327_9 <= 0 and var_327_5 or var_327_5 * (var_327_10 / var_327_9)

				if var_327_11 > 0 and var_327_5 < var_327_11 then
					arg_324_1.talkMaxDuration = var_327_11

					if var_327_11 + var_327_4 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_11 + var_327_4
					end
				end

				arg_324_1.text_.text = var_327_8
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132079", "story_v_out_420132.awb") ~= 0 then
					local var_327_12 = manager.audio:GetVoiceLength("story_v_out_420132", "420132079", "story_v_out_420132.awb") / 1000

					if var_327_12 + var_327_4 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_12 + var_327_4
					end

					if var_327_7.prefab_name ~= "" and arg_324_1.actors_[var_327_7.prefab_name] ~= nil then
						local var_327_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_7.prefab_name].transform, "story_v_out_420132", "420132079", "story_v_out_420132.awb")

						arg_324_1:RecordAudio("420132079", var_327_13)
						arg_324_1:RecordAudio("420132079", var_327_13)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_420132", "420132079", "story_v_out_420132.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_420132", "420132079", "story_v_out_420132.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_14 = math.max(var_327_5, arg_324_1.talkMaxDuration)

			if var_327_4 <= arg_324_1.time_ and arg_324_1.time_ < var_327_4 + var_327_14 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_4) / var_327_14

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_4 + var_327_14 and arg_324_1.time_ < var_327_4 + var_327_14 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play420132080 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 420132080
		arg_328_1.duration_ = 15.63

		local var_328_0 = {
			zh = 9.2,
			ja = 15.633
		}
		local var_328_1 = manager.audio:GetLocalizationFlag()

		if var_328_0[var_328_1] ~= nil then
			arg_328_1.duration_ = var_328_0[var_328_1]
		end

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play420132081(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = 0

			if var_331_0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_0 + arg_331_0 then
				arg_328_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action2_2")
			end

			local var_331_1 = 0
			local var_331_2 = 0.875

			if var_331_1 < arg_328_1.time_ and arg_328_1.time_ <= var_331_1 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				local var_331_3 = arg_328_1:FormatText(StoryNameCfg[328].name)

				arg_328_1.leftNameTxt_.text = var_331_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_4 = arg_328_1:GetWordFromCfg(420132080)
				local var_331_5 = arg_328_1:FormatText(var_331_4.content)

				arg_328_1.text_.text = var_331_5

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_6 = 35
				local var_331_7 = utf8.len(var_331_5)
				local var_331_8 = var_331_6 <= 0 and var_331_2 or var_331_2 * (var_331_7 / var_331_6)

				if var_331_8 > 0 and var_331_2 < var_331_8 then
					arg_328_1.talkMaxDuration = var_331_8

					if var_331_8 + var_331_1 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_8 + var_331_1
					end
				end

				arg_328_1.text_.text = var_331_5
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132080", "story_v_out_420132.awb") ~= 0 then
					local var_331_9 = manager.audio:GetVoiceLength("story_v_out_420132", "420132080", "story_v_out_420132.awb") / 1000

					if var_331_9 + var_331_1 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_9 + var_331_1
					end

					if var_331_4.prefab_name ~= "" and arg_328_1.actors_[var_331_4.prefab_name] ~= nil then
						local var_331_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_4.prefab_name].transform, "story_v_out_420132", "420132080", "story_v_out_420132.awb")

						arg_328_1:RecordAudio("420132080", var_331_10)
						arg_328_1:RecordAudio("420132080", var_331_10)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_420132", "420132080", "story_v_out_420132.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_420132", "420132080", "story_v_out_420132.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_11 = math.max(var_331_2, arg_328_1.talkMaxDuration)

			if var_331_1 <= arg_328_1.time_ and arg_328_1.time_ < var_331_1 + var_331_11 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_1) / var_331_11

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_1 + var_331_11 and arg_328_1.time_ < var_331_1 + var_331_11 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play420132081 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 420132081
		arg_332_1.duration_ = 5

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play420132082(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = arg_332_1.actors_["1085ui_story"].transform
			local var_335_1 = 0

			if var_335_1 < arg_332_1.time_ and arg_332_1.time_ <= var_335_1 + arg_335_0 then
				arg_332_1.var_.moveOldPos1085ui_story = var_335_0.localPosition
			end

			local var_335_2 = 0.001

			if var_335_1 <= arg_332_1.time_ and arg_332_1.time_ < var_335_1 + var_335_2 then
				local var_335_3 = (arg_332_1.time_ - var_335_1) / var_335_2
				local var_335_4 = Vector3.New(0, 100, 0)

				var_335_0.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos1085ui_story, var_335_4, var_335_3)

				local var_335_5 = manager.ui.mainCamera.transform.position - var_335_0.position

				var_335_0.forward = Vector3.New(var_335_5.x, var_335_5.y, var_335_5.z)

				local var_335_6 = var_335_0.localEulerAngles

				var_335_6.z = 0
				var_335_6.x = 0
				var_335_0.localEulerAngles = var_335_6
			end

			if arg_332_1.time_ >= var_335_1 + var_335_2 and arg_332_1.time_ < var_335_1 + var_335_2 + arg_335_0 then
				var_335_0.localPosition = Vector3.New(0, 100, 0)

				local var_335_7 = manager.ui.mainCamera.transform.position - var_335_0.position

				var_335_0.forward = Vector3.New(var_335_7.x, var_335_7.y, var_335_7.z)

				local var_335_8 = var_335_0.localEulerAngles

				var_335_8.z = 0
				var_335_8.x = 0
				var_335_0.localEulerAngles = var_335_8
			end

			local var_335_9 = arg_332_1.actors_["1061ui_story"].transform
			local var_335_10 = 0

			if var_335_10 < arg_332_1.time_ and arg_332_1.time_ <= var_335_10 + arg_335_0 then
				arg_332_1.var_.moveOldPos1061ui_story = var_335_9.localPosition
			end

			local var_335_11 = 0.001

			if var_335_10 <= arg_332_1.time_ and arg_332_1.time_ < var_335_10 + var_335_11 then
				local var_335_12 = (arg_332_1.time_ - var_335_10) / var_335_11
				local var_335_13 = Vector3.New(0, 100, 0)

				var_335_9.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos1061ui_story, var_335_13, var_335_12)

				local var_335_14 = manager.ui.mainCamera.transform.position - var_335_9.position

				var_335_9.forward = Vector3.New(var_335_14.x, var_335_14.y, var_335_14.z)

				local var_335_15 = var_335_9.localEulerAngles

				var_335_15.z = 0
				var_335_15.x = 0
				var_335_9.localEulerAngles = var_335_15
			end

			if arg_332_1.time_ >= var_335_10 + var_335_11 and arg_332_1.time_ < var_335_10 + var_335_11 + arg_335_0 then
				var_335_9.localPosition = Vector3.New(0, 100, 0)

				local var_335_16 = manager.ui.mainCamera.transform.position - var_335_9.position

				var_335_9.forward = Vector3.New(var_335_16.x, var_335_16.y, var_335_16.z)

				local var_335_17 = var_335_9.localEulerAngles

				var_335_17.z = 0
				var_335_17.x = 0
				var_335_9.localEulerAngles = var_335_17
			end

			local var_335_18 = 0
			local var_335_19 = 0.5

			if var_335_18 < arg_332_1.time_ and arg_332_1.time_ <= var_335_18 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, false)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_20 = arg_332_1:GetWordFromCfg(420132081)
				local var_335_21 = arg_332_1:FormatText(var_335_20.content)

				arg_332_1.text_.text = var_335_21

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_22 = 20
				local var_335_23 = utf8.len(var_335_21)
				local var_335_24 = var_335_22 <= 0 and var_335_19 or var_335_19 * (var_335_23 / var_335_22)

				if var_335_24 > 0 and var_335_19 < var_335_24 then
					arg_332_1.talkMaxDuration = var_335_24

					if var_335_24 + var_335_18 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_24 + var_335_18
					end
				end

				arg_332_1.text_.text = var_335_21
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)
				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_25 = math.max(var_335_19, arg_332_1.talkMaxDuration)

			if var_335_18 <= arg_332_1.time_ and arg_332_1.time_ < var_335_18 + var_335_25 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_18) / var_335_25

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_18 + var_335_25 and arg_332_1.time_ < var_335_18 + var_335_25 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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

		arg_332_1:InitPlayNodeList()
	end,
	Play420132082 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 420132082
		arg_336_1.duration_ = 7.97

		local var_336_0 = {
			zh = 5.033,
			ja = 7.966
		}
		local var_336_1 = manager.audio:GetLocalizationFlag()

		if var_336_0[var_336_1] ~= nil then
			arg_336_1.duration_ = var_336_0[var_336_1]
		end

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play420132083(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = 0

			if var_339_0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_0 + arg_339_0 then
				local var_339_1 = manager.ui.mainCamera.transform.localPosition
				local var_339_2 = Vector3.New(0, 0, 10) + Vector3.New(var_339_1.x, var_339_1.y, 0)
				local var_339_3 = arg_336_1.bgs_.ST67

				var_339_3.transform.localPosition = var_339_2
				var_339_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_339_4 = var_339_3:GetComponent("SpriteRenderer")

				if var_339_4 and var_339_4.sprite then
					local var_339_5 = (var_339_3.transform.localPosition - var_339_1).z
					local var_339_6 = manager.ui.mainCameraCom_
					local var_339_7 = 2 * var_339_5 * Mathf.Tan(var_339_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_339_8 = var_339_7 * var_339_6.aspect
					local var_339_9 = var_339_4.sprite.bounds.size.x
					local var_339_10 = var_339_4.sprite.bounds.size.y
					local var_339_11 = var_339_8 / var_339_9
					local var_339_12 = var_339_7 / var_339_10
					local var_339_13 = var_339_12 < var_339_11 and var_339_11 or var_339_12

					var_339_3.transform.localScale = Vector3.New(var_339_13, var_339_13, 0)
				end

				for iter_339_0, iter_339_1 in pairs(arg_336_1.bgs_) do
					if iter_339_0 ~= "ST67" then
						iter_339_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_339_14 = 2

			if var_339_14 < arg_336_1.time_ and arg_336_1.time_ <= var_339_14 + arg_339_0 then
				arg_336_1.allBtn_.enabled = false
			end

			local var_339_15 = 0.3

			if arg_336_1.time_ >= var_339_14 + var_339_15 and arg_336_1.time_ < var_339_14 + var_339_15 + arg_339_0 then
				arg_336_1.allBtn_.enabled = true
			end

			local var_339_16 = 0

			if var_339_16 < arg_336_1.time_ and arg_336_1.time_ <= var_339_16 + arg_339_0 then
				arg_336_1.mask_.enabled = true
				arg_336_1.mask_.raycastTarget = true

				arg_336_1:SetGaussion(false)
			end

			local var_339_17 = 1

			if var_339_16 <= arg_336_1.time_ and arg_336_1.time_ < var_339_16 + var_339_17 then
				local var_339_18 = (arg_336_1.time_ - var_339_16) / var_339_17
				local var_339_19 = Color.New(0, 0, 0)

				var_339_19.a = Mathf.Lerp(0, 1, var_339_18)
				arg_336_1.mask_.color = var_339_19
			end

			if arg_336_1.time_ >= var_339_16 + var_339_17 and arg_336_1.time_ < var_339_16 + var_339_17 + arg_339_0 then
				local var_339_20 = Color.New(0, 0, 0)

				var_339_20.a = 1
				arg_336_1.mask_.color = var_339_20
			end

			local var_339_21 = 1

			if var_339_21 < arg_336_1.time_ and arg_336_1.time_ <= var_339_21 + arg_339_0 then
				arg_336_1.mask_.enabled = true
				arg_336_1.mask_.raycastTarget = true

				arg_336_1:SetGaussion(false)
			end

			local var_339_22 = 1

			if var_339_21 <= arg_336_1.time_ and arg_336_1.time_ < var_339_21 + var_339_22 then
				local var_339_23 = (arg_336_1.time_ - var_339_21) / var_339_22
				local var_339_24 = Color.New(0, 0, 0)

				var_339_24.a = Mathf.Lerp(1, 0, var_339_23)
				arg_336_1.mask_.color = var_339_24
			end

			if arg_336_1.time_ >= var_339_21 + var_339_22 and arg_336_1.time_ < var_339_21 + var_339_22 + arg_339_0 then
				local var_339_25 = Color.New(0, 0, 0)
				local var_339_26 = 0

				arg_336_1.mask_.enabled = false
				var_339_25.a = var_339_26
				arg_336_1.mask_.color = var_339_25
			end

			local var_339_27 = arg_336_1.actors_["1061ui_story"]
			local var_339_28 = 1.79999999701977

			if var_339_28 < arg_336_1.time_ and arg_336_1.time_ <= var_339_28 + arg_339_0 and not isNil(var_339_27) and arg_336_1.var_.characterEffect1061ui_story == nil then
				arg_336_1.var_.characterEffect1061ui_story = var_339_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_29 = 0.200000002980232

			if var_339_28 <= arg_336_1.time_ and arg_336_1.time_ < var_339_28 + var_339_29 and not isNil(var_339_27) then
				local var_339_30 = (arg_336_1.time_ - var_339_28) / var_339_29

				if arg_336_1.var_.characterEffect1061ui_story and not isNil(var_339_27) then
					arg_336_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_336_1.time_ >= var_339_28 + var_339_29 and arg_336_1.time_ < var_339_28 + var_339_29 + arg_339_0 and not isNil(var_339_27) and arg_336_1.var_.characterEffect1061ui_story then
				arg_336_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_339_31 = arg_336_1.actors_["1061ui_story"].transform
			local var_339_32 = 1.79999999701977

			if var_339_32 < arg_336_1.time_ and arg_336_1.time_ <= var_339_32 + arg_339_0 then
				arg_336_1.var_.moveOldPos1061ui_story = var_339_31.localPosition
			end

			local var_339_33 = 0.001

			if var_339_32 <= arg_336_1.time_ and arg_336_1.time_ < var_339_32 + var_339_33 then
				local var_339_34 = (arg_336_1.time_ - var_339_32) / var_339_33
				local var_339_35 = Vector3.New(0, -1.18, -6.15)

				var_339_31.localPosition = Vector3.Lerp(arg_336_1.var_.moveOldPos1061ui_story, var_339_35, var_339_34)

				local var_339_36 = manager.ui.mainCamera.transform.position - var_339_31.position

				var_339_31.forward = Vector3.New(var_339_36.x, var_339_36.y, var_339_36.z)

				local var_339_37 = var_339_31.localEulerAngles

				var_339_37.z = 0
				var_339_37.x = 0
				var_339_31.localEulerAngles = var_339_37
			end

			if arg_336_1.time_ >= var_339_32 + var_339_33 and arg_336_1.time_ < var_339_32 + var_339_33 + arg_339_0 then
				var_339_31.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_339_38 = manager.ui.mainCamera.transform.position - var_339_31.position

				var_339_31.forward = Vector3.New(var_339_38.x, var_339_38.y, var_339_38.z)

				local var_339_39 = var_339_31.localEulerAngles

				var_339_39.z = 0
				var_339_39.x = 0
				var_339_31.localEulerAngles = var_339_39
			end

			local var_339_40 = 1.79999999701977

			if var_339_40 < arg_336_1.time_ and arg_336_1.time_ <= var_339_40 + arg_339_0 then
				arg_336_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			local var_339_41 = 1.79999999701977

			if var_339_41 < arg_336_1.time_ and arg_336_1.time_ <= var_339_41 + arg_339_0 then
				arg_336_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_339_42 = 1

			arg_336_1.isInRecall_ = false

			if var_339_42 < arg_336_1.time_ and arg_336_1.time_ <= var_339_42 + arg_339_0 then
				arg_336_1.screenFilterGo_:SetActive(true)

				arg_336_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_339_2, iter_339_3 in pairs(arg_336_1.actors_) do
					local var_339_43 = iter_339_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_339_4, iter_339_5 in ipairs(var_339_43) do
						if iter_339_5.color.r > 0.51 then
							iter_339_5.color = Color.New(1, 1, 1)
						else
							iter_339_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_339_44 = 0.2

			if var_339_42 <= arg_336_1.time_ and arg_336_1.time_ < var_339_42 + var_339_44 then
				local var_339_45 = (arg_336_1.time_ - var_339_42) / var_339_44

				arg_336_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_339_45)
			end

			if arg_336_1.time_ >= var_339_42 + var_339_44 and arg_336_1.time_ < var_339_42 + var_339_44 + arg_339_0 then
				arg_336_1.screenFilterEffect_.weight = 1
			end

			if arg_336_1.frameCnt_ <= 1 then
				arg_336_1.dialog_:SetActive(false)
			end

			local var_339_46 = 2
			local var_339_47 = 0.375

			if var_339_46 < arg_336_1.time_ and arg_336_1.time_ <= var_339_46 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0

				arg_336_1.dialog_:SetActive(true)

				arg_336_1.dialogCg_.alpha = 0

				local var_339_48 = LeanTween.value(arg_336_1.dialog_, 0, 1, 0.3)

				var_339_48:setOnUpdate(LuaHelper.FloatAction(function(arg_340_0)
					arg_336_1.dialogCg_.alpha = arg_340_0
				end))
				var_339_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_336_1.dialog_)
					var_339_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_336_1.duration_ = arg_336_1.duration_ + 0.3

				SetActive(arg_336_1.leftNameGo_, true)

				local var_339_49 = arg_336_1:FormatText(StoryNameCfg[612].name)

				arg_336_1.leftNameTxt_.text = var_339_49

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_50 = arg_336_1:GetWordFromCfg(420132082)
				local var_339_51 = arg_336_1:FormatText(var_339_50.content)

				arg_336_1.text_.text = var_339_51

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_52 = 15
				local var_339_53 = utf8.len(var_339_51)
				local var_339_54 = var_339_52 <= 0 and var_339_47 or var_339_47 * (var_339_53 / var_339_52)

				if var_339_54 > 0 and var_339_47 < var_339_54 then
					arg_336_1.talkMaxDuration = var_339_54
					var_339_46 = var_339_46 + 0.3

					if var_339_54 + var_339_46 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_54 + var_339_46
					end
				end

				arg_336_1.text_.text = var_339_51
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132082", "story_v_out_420132.awb") ~= 0 then
					local var_339_55 = manager.audio:GetVoiceLength("story_v_out_420132", "420132082", "story_v_out_420132.awb") / 1000

					if var_339_55 + var_339_46 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_55 + var_339_46
					end

					if var_339_50.prefab_name ~= "" and arg_336_1.actors_[var_339_50.prefab_name] ~= nil then
						local var_339_56 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_50.prefab_name].transform, "story_v_out_420132", "420132082", "story_v_out_420132.awb")

						arg_336_1:RecordAudio("420132082", var_339_56)
						arg_336_1:RecordAudio("420132082", var_339_56)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_420132", "420132082", "story_v_out_420132.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_420132", "420132082", "story_v_out_420132.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_57 = var_339_46 + 0.3
			local var_339_58 = math.max(var_339_47, arg_336_1.talkMaxDuration)

			if var_339_57 <= arg_336_1.time_ and arg_336_1.time_ < var_339_57 + var_339_58 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_57) / var_339_58

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_57 + var_339_58 and arg_336_1.time_ < var_339_57 + var_339_58 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.79999999701977,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_336_1:InitPlayNodeList()
	end,
	Play420132083 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 420132083
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play420132084(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = arg_342_1.actors_["1061ui_story"].transform
			local var_345_1 = 0

			if var_345_1 < arg_342_1.time_ and arg_342_1.time_ <= var_345_1 + arg_345_0 then
				arg_342_1.var_.moveOldPos1061ui_story = var_345_0.localPosition
			end

			local var_345_2 = 0.001

			if var_345_1 <= arg_342_1.time_ and arg_342_1.time_ < var_345_1 + var_345_2 then
				local var_345_3 = (arg_342_1.time_ - var_345_1) / var_345_2
				local var_345_4 = Vector3.New(0, 100, 0)

				var_345_0.localPosition = Vector3.Lerp(arg_342_1.var_.moveOldPos1061ui_story, var_345_4, var_345_3)

				local var_345_5 = manager.ui.mainCamera.transform.position - var_345_0.position

				var_345_0.forward = Vector3.New(var_345_5.x, var_345_5.y, var_345_5.z)

				local var_345_6 = var_345_0.localEulerAngles

				var_345_6.z = 0
				var_345_6.x = 0
				var_345_0.localEulerAngles = var_345_6
			end

			if arg_342_1.time_ >= var_345_1 + var_345_2 and arg_342_1.time_ < var_345_1 + var_345_2 + arg_345_0 then
				var_345_0.localPosition = Vector3.New(0, 100, 0)

				local var_345_7 = manager.ui.mainCamera.transform.position - var_345_0.position

				var_345_0.forward = Vector3.New(var_345_7.x, var_345_7.y, var_345_7.z)

				local var_345_8 = var_345_0.localEulerAngles

				var_345_8.z = 0
				var_345_8.x = 0
				var_345_0.localEulerAngles = var_345_8
			end

			local var_345_9 = 0
			local var_345_10 = 1.15

			if var_345_9 < arg_342_1.time_ and arg_342_1.time_ <= var_345_9 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				local var_345_11 = arg_342_1:FormatText(StoryNameCfg[7].name)

				arg_342_1.leftNameTxt_.text = var_345_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, true)
				arg_342_1.iconController_:SetSelectedState("hero")

				arg_342_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_342_1.callingController_:SetSelectedState("normal")

				arg_342_1.keyicon_.color = Color.New(1, 1, 1)
				arg_342_1.icon_.color = Color.New(1, 1, 1)

				local var_345_12 = arg_342_1:GetWordFromCfg(420132083)
				local var_345_13 = arg_342_1:FormatText(var_345_12.content)

				arg_342_1.text_.text = var_345_13

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_14 = 46
				local var_345_15 = utf8.len(var_345_13)
				local var_345_16 = var_345_14 <= 0 and var_345_10 or var_345_10 * (var_345_15 / var_345_14)

				if var_345_16 > 0 and var_345_10 < var_345_16 then
					arg_342_1.talkMaxDuration = var_345_16

					if var_345_16 + var_345_9 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_16 + var_345_9
					end
				end

				arg_342_1.text_.text = var_345_13
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_17 = math.max(var_345_10, arg_342_1.talkMaxDuration)

			if var_345_9 <= arg_342_1.time_ and arg_342_1.time_ < var_345_9 + var_345_17 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_9) / var_345_17

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_9 + var_345_17 and arg_342_1.time_ < var_345_9 + var_345_17 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {
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

		arg_342_1:InitPlayNodeList()
	end,
	Play420132084 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 420132084
		arg_346_1.duration_ = 7

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play420132085(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = 2

			if var_349_0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_0 + arg_349_0 then
				arg_346_1.allBtn_.enabled = false
			end

			local var_349_1 = 0.3

			if arg_346_1.time_ >= var_349_0 + var_349_1 and arg_346_1.time_ < var_349_0 + var_349_1 + arg_349_0 then
				arg_346_1.allBtn_.enabled = true
			end

			local var_349_2 = 1

			if var_349_2 < arg_346_1.time_ and arg_346_1.time_ <= var_349_2 + arg_349_0 then
				local var_349_3 = manager.ui.mainCamera.transform.localPosition
				local var_349_4 = Vector3.New(0, 0, 10) + Vector3.New(var_349_3.x, var_349_3.y, 0)
				local var_349_5 = arg_346_1.bgs_.ST67

				var_349_5.transform.localPosition = var_349_4
				var_349_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_349_6 = var_349_5:GetComponent("SpriteRenderer")

				if var_349_6 and var_349_6.sprite then
					local var_349_7 = (var_349_5.transform.localPosition - var_349_3).z
					local var_349_8 = manager.ui.mainCameraCom_
					local var_349_9 = 2 * var_349_7 * Mathf.Tan(var_349_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_349_10 = var_349_9 * var_349_8.aspect
					local var_349_11 = var_349_6.sprite.bounds.size.x
					local var_349_12 = var_349_6.sprite.bounds.size.y
					local var_349_13 = var_349_10 / var_349_11
					local var_349_14 = var_349_9 / var_349_12
					local var_349_15 = var_349_14 < var_349_13 and var_349_13 or var_349_14

					var_349_5.transform.localScale = Vector3.New(var_349_15, var_349_15, 0)
				end

				for iter_349_0, iter_349_1 in pairs(arg_346_1.bgs_) do
					if iter_349_0 ~= "ST67" then
						iter_349_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_349_16 = 0

			if var_349_16 < arg_346_1.time_ and arg_346_1.time_ <= var_349_16 + arg_349_0 then
				arg_346_1.mask_.enabled = true
				arg_346_1.mask_.raycastTarget = true

				arg_346_1:SetGaussion(false)
			end

			local var_349_17 = 1

			if var_349_16 <= arg_346_1.time_ and arg_346_1.time_ < var_349_16 + var_349_17 then
				local var_349_18 = (arg_346_1.time_ - var_349_16) / var_349_17
				local var_349_19 = Color.New(0, 0, 0)

				var_349_19.a = Mathf.Lerp(0, 1, var_349_18)
				arg_346_1.mask_.color = var_349_19
			end

			if arg_346_1.time_ >= var_349_16 + var_349_17 and arg_346_1.time_ < var_349_16 + var_349_17 + arg_349_0 then
				local var_349_20 = Color.New(0, 0, 0)

				var_349_20.a = 1
				arg_346_1.mask_.color = var_349_20
			end

			local var_349_21 = 1

			if var_349_21 < arg_346_1.time_ and arg_346_1.time_ <= var_349_21 + arg_349_0 then
				arg_346_1.mask_.enabled = true
				arg_346_1.mask_.raycastTarget = true

				arg_346_1:SetGaussion(false)
			end

			local var_349_22 = 1

			if var_349_21 <= arg_346_1.time_ and arg_346_1.time_ < var_349_21 + var_349_22 then
				local var_349_23 = (arg_346_1.time_ - var_349_21) / var_349_22
				local var_349_24 = Color.New(0, 0, 0)

				var_349_24.a = Mathf.Lerp(1, 0, var_349_23)
				arg_346_1.mask_.color = var_349_24
			end

			if arg_346_1.time_ >= var_349_21 + var_349_22 and arg_346_1.time_ < var_349_21 + var_349_22 + arg_349_0 then
				local var_349_25 = Color.New(0, 0, 0)
				local var_349_26 = 0

				arg_346_1.mask_.enabled = false
				var_349_25.a = var_349_26
				arg_346_1.mask_.color = var_349_25
			end

			local var_349_27 = 0.9

			arg_346_1.isInRecall_ = false

			if var_349_27 < arg_346_1.time_ and arg_346_1.time_ <= var_349_27 + arg_349_0 then
				arg_346_1.screenFilterGo_:SetActive(false)

				for iter_349_2, iter_349_3 in pairs(arg_346_1.actors_) do
					local var_349_28 = iter_349_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_349_4, iter_349_5 in ipairs(var_349_28) do
						if iter_349_5.color.r > 0.51 then
							iter_349_5.color = Color.New(1, 1, 1)
						else
							iter_349_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_349_29 = 0.1

			if var_349_27 <= arg_346_1.time_ and arg_346_1.time_ < var_349_27 + var_349_29 then
				local var_349_30 = (arg_346_1.time_ - var_349_27) / var_349_29

				arg_346_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_349_30)
			end

			if arg_346_1.time_ >= var_349_27 + var_349_29 and arg_346_1.time_ < var_349_27 + var_349_29 + arg_349_0 then
				arg_346_1.screenFilterEffect_.weight = 0
			end

			if arg_346_1.frameCnt_ <= 1 then
				arg_346_1.dialog_:SetActive(false)
			end

			local var_349_31 = 2
			local var_349_32 = 0.375

			if var_349_31 < arg_346_1.time_ and arg_346_1.time_ <= var_349_31 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0

				arg_346_1.dialog_:SetActive(true)

				arg_346_1.dialogCg_.alpha = 0

				local var_349_33 = LeanTween.value(arg_346_1.dialog_, 0, 1, 0.3)

				var_349_33:setOnUpdate(LuaHelper.FloatAction(function(arg_350_0)
					arg_346_1.dialogCg_.alpha = arg_350_0
				end))
				var_349_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_346_1.dialog_)
					var_349_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_346_1.duration_ = arg_346_1.duration_ + 0.3

				SetActive(arg_346_1.leftNameGo_, true)

				local var_349_34 = arg_346_1:FormatText(StoryNameCfg[7].name)

				arg_346_1.leftNameTxt_.text = var_349_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, true)
				arg_346_1.iconController_:SetSelectedState("hero")

				arg_346_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_346_1.callingController_:SetSelectedState("normal")

				arg_346_1.keyicon_.color = Color.New(1, 1, 1)
				arg_346_1.icon_.color = Color.New(1, 1, 1)

				local var_349_35 = arg_346_1:GetWordFromCfg(420132084)
				local var_349_36 = arg_346_1:FormatText(var_349_35.content)

				arg_346_1.text_.text = var_349_36

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_37 = 15
				local var_349_38 = utf8.len(var_349_36)
				local var_349_39 = var_349_37 <= 0 and var_349_32 or var_349_32 * (var_349_38 / var_349_37)

				if var_349_39 > 0 and var_349_32 < var_349_39 then
					arg_346_1.talkMaxDuration = var_349_39
					var_349_31 = var_349_31 + 0.3

					if var_349_39 + var_349_31 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_39 + var_349_31
					end
				end

				arg_346_1.text_.text = var_349_36
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)
				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_40 = var_349_31 + 0.3
			local var_349_41 = math.max(var_349_32, arg_346_1.talkMaxDuration)

			if var_349_40 <= arg_346_1.time_ and arg_346_1.time_ < var_349_40 + var_349_41 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_40) / var_349_41

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_40 + var_349_41 and arg_346_1.time_ < var_349_40 + var_349_41 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play420132085 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 420132085
		arg_352_1.duration_ = 9.17

		local var_352_0 = {
			zh = 7.1,
			ja = 9.166
		}
		local var_352_1 = manager.audio:GetLocalizationFlag()

		if var_352_0[var_352_1] ~= nil then
			arg_352_1.duration_ = var_352_0[var_352_1]
		end

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play420132086(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = arg_352_1.actors_["1061ui_story"]
			local var_355_1 = 0

			if var_355_1 < arg_352_1.time_ and arg_352_1.time_ <= var_355_1 + arg_355_0 and not isNil(var_355_0) and arg_352_1.var_.characterEffect1061ui_story == nil then
				arg_352_1.var_.characterEffect1061ui_story = var_355_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_2 = 0.200000002980232

			if var_355_1 <= arg_352_1.time_ and arg_352_1.time_ < var_355_1 + var_355_2 and not isNil(var_355_0) then
				local var_355_3 = (arg_352_1.time_ - var_355_1) / var_355_2

				if arg_352_1.var_.characterEffect1061ui_story and not isNil(var_355_0) then
					arg_352_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_352_1.time_ >= var_355_1 + var_355_2 and arg_352_1.time_ < var_355_1 + var_355_2 + arg_355_0 and not isNil(var_355_0) and arg_352_1.var_.characterEffect1061ui_story then
				arg_352_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_355_4 = arg_352_1.actors_["1061ui_story"].transform
			local var_355_5 = 0

			if var_355_5 < arg_352_1.time_ and arg_352_1.time_ <= var_355_5 + arg_355_0 then
				arg_352_1.var_.moveOldPos1061ui_story = var_355_4.localPosition
			end

			local var_355_6 = 0.001

			if var_355_5 <= arg_352_1.time_ and arg_352_1.time_ < var_355_5 + var_355_6 then
				local var_355_7 = (arg_352_1.time_ - var_355_5) / var_355_6
				local var_355_8 = Vector3.New(0, -1.18, -6.15)

				var_355_4.localPosition = Vector3.Lerp(arg_352_1.var_.moveOldPos1061ui_story, var_355_8, var_355_7)

				local var_355_9 = manager.ui.mainCamera.transform.position - var_355_4.position

				var_355_4.forward = Vector3.New(var_355_9.x, var_355_9.y, var_355_9.z)

				local var_355_10 = var_355_4.localEulerAngles

				var_355_10.z = 0
				var_355_10.x = 0
				var_355_4.localEulerAngles = var_355_10
			end

			if arg_352_1.time_ >= var_355_5 + var_355_6 and arg_352_1.time_ < var_355_5 + var_355_6 + arg_355_0 then
				var_355_4.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_355_11 = manager.ui.mainCamera.transform.position - var_355_4.position

				var_355_4.forward = Vector3.New(var_355_11.x, var_355_11.y, var_355_11.z)

				local var_355_12 = var_355_4.localEulerAngles

				var_355_12.z = 0
				var_355_12.x = 0
				var_355_4.localEulerAngles = var_355_12
			end

			local var_355_13 = 0

			if var_355_13 < arg_352_1.time_ and arg_352_1.time_ <= var_355_13 + arg_355_0 then
				arg_352_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_355_14 = 0
			local var_355_15 = 0.5

			if var_355_14 < arg_352_1.time_ and arg_352_1.time_ <= var_355_14 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				local var_355_16 = arg_352_1:FormatText(StoryNameCfg[612].name)

				arg_352_1.leftNameTxt_.text = var_355_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_17 = arg_352_1:GetWordFromCfg(420132085)
				local var_355_18 = arg_352_1:FormatText(var_355_17.content)

				arg_352_1.text_.text = var_355_18

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_19 = 20
				local var_355_20 = utf8.len(var_355_18)
				local var_355_21 = var_355_19 <= 0 and var_355_15 or var_355_15 * (var_355_20 / var_355_19)

				if var_355_21 > 0 and var_355_15 < var_355_21 then
					arg_352_1.talkMaxDuration = var_355_21

					if var_355_21 + var_355_14 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_21 + var_355_14
					end
				end

				arg_352_1.text_.text = var_355_18
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132085", "story_v_out_420132.awb") ~= 0 then
					local var_355_22 = manager.audio:GetVoiceLength("story_v_out_420132", "420132085", "story_v_out_420132.awb") / 1000

					if var_355_22 + var_355_14 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_22 + var_355_14
					end

					if var_355_17.prefab_name ~= "" and arg_352_1.actors_[var_355_17.prefab_name] ~= nil then
						local var_355_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_17.prefab_name].transform, "story_v_out_420132", "420132085", "story_v_out_420132.awb")

						arg_352_1:RecordAudio("420132085", var_355_23)
						arg_352_1:RecordAudio("420132085", var_355_23)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_420132", "420132085", "story_v_out_420132.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_420132", "420132085", "story_v_out_420132.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_24 = math.max(var_355_15, arg_352_1.talkMaxDuration)

			if var_355_14 <= arg_352_1.time_ and arg_352_1.time_ < var_355_14 + var_355_24 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_14) / var_355_24

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_14 + var_355_24 and arg_352_1.time_ < var_355_14 + var_355_24 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {
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

		arg_352_1:InitPlayNodeList()
	end,
	Play420132086 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 420132086
		arg_356_1.duration_ = 5

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play420132087(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = arg_356_1.actors_["1061ui_story"]
			local var_359_1 = 0

			if var_359_1 < arg_356_1.time_ and arg_356_1.time_ <= var_359_1 + arg_359_0 and not isNil(var_359_0) and arg_356_1.var_.characterEffect1061ui_story == nil then
				arg_356_1.var_.characterEffect1061ui_story = var_359_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_359_2 = 0.200000002980232

			if var_359_1 <= arg_356_1.time_ and arg_356_1.time_ < var_359_1 + var_359_2 and not isNil(var_359_0) then
				local var_359_3 = (arg_356_1.time_ - var_359_1) / var_359_2

				if arg_356_1.var_.characterEffect1061ui_story and not isNil(var_359_0) then
					local var_359_4 = Mathf.Lerp(0, 0.5, var_359_3)

					arg_356_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_356_1.var_.characterEffect1061ui_story.fillRatio = var_359_4
				end
			end

			if arg_356_1.time_ >= var_359_1 + var_359_2 and arg_356_1.time_ < var_359_1 + var_359_2 + arg_359_0 and not isNil(var_359_0) and arg_356_1.var_.characterEffect1061ui_story then
				local var_359_5 = 0.5

				arg_356_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_356_1.var_.characterEffect1061ui_story.fillRatio = var_359_5
			end

			local var_359_6 = 0
			local var_359_7 = 1.025

			if var_359_6 < arg_356_1.time_ and arg_356_1.time_ <= var_359_6 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, false)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_8 = arg_356_1:GetWordFromCfg(420132086)
				local var_359_9 = arg_356_1:FormatText(var_359_8.content)

				arg_356_1.text_.text = var_359_9

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_10 = 41
				local var_359_11 = utf8.len(var_359_9)
				local var_359_12 = var_359_10 <= 0 and var_359_7 or var_359_7 * (var_359_11 / var_359_10)

				if var_359_12 > 0 and var_359_7 < var_359_12 then
					arg_356_1.talkMaxDuration = var_359_12

					if var_359_12 + var_359_6 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_12 + var_359_6
					end
				end

				arg_356_1.text_.text = var_359_9
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)
				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_13 = math.max(var_359_7, arg_356_1.talkMaxDuration)

			if var_359_6 <= arg_356_1.time_ and arg_356_1.time_ < var_359_6 + var_359_13 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_6) / var_359_13

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_6 + var_359_13 and arg_356_1.time_ < var_359_6 + var_359_13 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play420132087 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 420132087
		arg_360_1.duration_ = 10.2

		local var_360_0 = {
			zh = 6.266,
			ja = 10.2
		}
		local var_360_1 = manager.audio:GetLocalizationFlag()

		if var_360_0[var_360_1] ~= nil then
			arg_360_1.duration_ = var_360_0[var_360_1]
		end

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play420132088(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = arg_360_1.actors_["1061ui_story"]
			local var_363_1 = 0

			if var_363_1 < arg_360_1.time_ and arg_360_1.time_ <= var_363_1 + arg_363_0 and not isNil(var_363_0) and arg_360_1.var_.characterEffect1061ui_story == nil then
				arg_360_1.var_.characterEffect1061ui_story = var_363_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_363_2 = 0.200000002980232

			if var_363_1 <= arg_360_1.time_ and arg_360_1.time_ < var_363_1 + var_363_2 and not isNil(var_363_0) then
				local var_363_3 = (arg_360_1.time_ - var_363_1) / var_363_2

				if arg_360_1.var_.characterEffect1061ui_story and not isNil(var_363_0) then
					arg_360_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_360_1.time_ >= var_363_1 + var_363_2 and arg_360_1.time_ < var_363_1 + var_363_2 + arg_363_0 and not isNil(var_363_0) and arg_360_1.var_.characterEffect1061ui_story then
				arg_360_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_363_4 = 0
			local var_363_5 = 0.9

			if var_363_4 < arg_360_1.time_ and arg_360_1.time_ <= var_363_4 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				local var_363_6 = arg_360_1:FormatText(StoryNameCfg[612].name)

				arg_360_1.leftNameTxt_.text = var_363_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_7 = arg_360_1:GetWordFromCfg(420132087)
				local var_363_8 = arg_360_1:FormatText(var_363_7.content)

				arg_360_1.text_.text = var_363_8

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_9 = 36
				local var_363_10 = utf8.len(var_363_8)
				local var_363_11 = var_363_9 <= 0 and var_363_5 or var_363_5 * (var_363_10 / var_363_9)

				if var_363_11 > 0 and var_363_5 < var_363_11 then
					arg_360_1.talkMaxDuration = var_363_11

					if var_363_11 + var_363_4 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_11 + var_363_4
					end
				end

				arg_360_1.text_.text = var_363_8
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132087", "story_v_out_420132.awb") ~= 0 then
					local var_363_12 = manager.audio:GetVoiceLength("story_v_out_420132", "420132087", "story_v_out_420132.awb") / 1000

					if var_363_12 + var_363_4 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_12 + var_363_4
					end

					if var_363_7.prefab_name ~= "" and arg_360_1.actors_[var_363_7.prefab_name] ~= nil then
						local var_363_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_7.prefab_name].transform, "story_v_out_420132", "420132087", "story_v_out_420132.awb")

						arg_360_1:RecordAudio("420132087", var_363_13)
						arg_360_1:RecordAudio("420132087", var_363_13)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_out_420132", "420132087", "story_v_out_420132.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_out_420132", "420132087", "story_v_out_420132.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_14 = math.max(var_363_5, arg_360_1.talkMaxDuration)

			if var_363_4 <= arg_360_1.time_ and arg_360_1.time_ < var_363_4 + var_363_14 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_4) / var_363_14

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_4 + var_363_14 and arg_360_1.time_ < var_363_4 + var_363_14 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play420132088 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 420132088
		arg_364_1.duration_ = 5

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play420132089(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = arg_364_1.actors_["1061ui_story"].transform
			local var_367_1 = 0

			if var_367_1 < arg_364_1.time_ and arg_364_1.time_ <= var_367_1 + arg_367_0 then
				arg_364_1.var_.moveOldPos1061ui_story = var_367_0.localPosition
			end

			local var_367_2 = 0.001

			if var_367_1 <= arg_364_1.time_ and arg_364_1.time_ < var_367_1 + var_367_2 then
				local var_367_3 = (arg_364_1.time_ - var_367_1) / var_367_2
				local var_367_4 = Vector3.New(0, 100, 0)

				var_367_0.localPosition = Vector3.Lerp(arg_364_1.var_.moveOldPos1061ui_story, var_367_4, var_367_3)

				local var_367_5 = manager.ui.mainCamera.transform.position - var_367_0.position

				var_367_0.forward = Vector3.New(var_367_5.x, var_367_5.y, var_367_5.z)

				local var_367_6 = var_367_0.localEulerAngles

				var_367_6.z = 0
				var_367_6.x = 0
				var_367_0.localEulerAngles = var_367_6
			end

			if arg_364_1.time_ >= var_367_1 + var_367_2 and arg_364_1.time_ < var_367_1 + var_367_2 + arg_367_0 then
				var_367_0.localPosition = Vector3.New(0, 100, 0)

				local var_367_7 = manager.ui.mainCamera.transform.position - var_367_0.position

				var_367_0.forward = Vector3.New(var_367_7.x, var_367_7.y, var_367_7.z)

				local var_367_8 = var_367_0.localEulerAngles

				var_367_8.z = 0
				var_367_8.x = 0
				var_367_0.localEulerAngles = var_367_8
			end

			local var_367_9 = 0
			local var_367_10 = 0.6

			if var_367_9 < arg_364_1.time_ and arg_364_1.time_ <= var_367_9 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				local var_367_11 = arg_364_1:FormatText(StoryNameCfg[7].name)

				arg_364_1.leftNameTxt_.text = var_367_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, true)
				arg_364_1.iconController_:SetSelectedState("hero")

				arg_364_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_364_1.callingController_:SetSelectedState("normal")

				arg_364_1.keyicon_.color = Color.New(1, 1, 1)
				arg_364_1.icon_.color = Color.New(1, 1, 1)

				local var_367_12 = arg_364_1:GetWordFromCfg(420132088)
				local var_367_13 = arg_364_1:FormatText(var_367_12.content)

				arg_364_1.text_.text = var_367_13

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_14 = 24
				local var_367_15 = utf8.len(var_367_13)
				local var_367_16 = var_367_14 <= 0 and var_367_10 or var_367_10 * (var_367_15 / var_367_14)

				if var_367_16 > 0 and var_367_10 < var_367_16 then
					arg_364_1.talkMaxDuration = var_367_16

					if var_367_16 + var_367_9 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_16 + var_367_9
					end
				end

				arg_364_1.text_.text = var_367_13
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)
				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_17 = math.max(var_367_10, arg_364_1.talkMaxDuration)

			if var_367_9 <= arg_364_1.time_ and arg_364_1.time_ < var_367_9 + var_367_17 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_9) / var_367_17

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_9 + var_367_17 and arg_364_1.time_ < var_367_9 + var_367_17 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {
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

		arg_364_1:InitPlayNodeList()
	end,
	Play420132089 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 420132089
		arg_368_1.duration_ = 5

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play420132090(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = 0
			local var_371_1 = 0.325

			if var_371_0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_0 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				local var_371_2 = arg_368_1:FormatText(StoryNameCfg[7].name)

				arg_368_1.leftNameTxt_.text = var_371_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, true)
				arg_368_1.iconController_:SetSelectedState("hero")

				arg_368_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_368_1.callingController_:SetSelectedState("normal")

				arg_368_1.keyicon_.color = Color.New(1, 1, 1)
				arg_368_1.icon_.color = Color.New(1, 1, 1)

				local var_371_3 = arg_368_1:GetWordFromCfg(420132089)
				local var_371_4 = arg_368_1:FormatText(var_371_3.content)

				arg_368_1.text_.text = var_371_4

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_5 = 13
				local var_371_6 = utf8.len(var_371_4)
				local var_371_7 = var_371_5 <= 0 and var_371_1 or var_371_1 * (var_371_6 / var_371_5)

				if var_371_7 > 0 and var_371_1 < var_371_7 then
					arg_368_1.talkMaxDuration = var_371_7

					if var_371_7 + var_371_0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_7 + var_371_0
					end
				end

				arg_368_1.text_.text = var_371_4
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)
				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_8 = math.max(var_371_1, arg_368_1.talkMaxDuration)

			if var_371_0 <= arg_368_1.time_ and arg_368_1.time_ < var_371_0 + var_371_8 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_0) / var_371_8

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_0 + var_371_8 and arg_368_1.time_ < var_371_0 + var_371_8 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play420132090 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 420132090
		arg_372_1.duration_ = 5.2

		local var_372_0 = {
			zh = 3.966,
			ja = 5.2
		}
		local var_372_1 = manager.audio:GetLocalizationFlag()

		if var_372_0[var_372_1] ~= nil then
			arg_372_1.duration_ = var_372_0[var_372_1]
		end

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play420132091(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = arg_372_1.actors_["1061ui_story"]
			local var_375_1 = 0

			if var_375_1 < arg_372_1.time_ and arg_372_1.time_ <= var_375_1 + arg_375_0 and not isNil(var_375_0) and arg_372_1.var_.characterEffect1061ui_story == nil then
				arg_372_1.var_.characterEffect1061ui_story = var_375_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_375_2 = 0.200000002980232

			if var_375_1 <= arg_372_1.time_ and arg_372_1.time_ < var_375_1 + var_375_2 and not isNil(var_375_0) then
				local var_375_3 = (arg_372_1.time_ - var_375_1) / var_375_2

				if arg_372_1.var_.characterEffect1061ui_story and not isNil(var_375_0) then
					arg_372_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_372_1.time_ >= var_375_1 + var_375_2 and arg_372_1.time_ < var_375_1 + var_375_2 + arg_375_0 and not isNil(var_375_0) and arg_372_1.var_.characterEffect1061ui_story then
				arg_372_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_375_4 = arg_372_1.actors_["1061ui_story"].transform
			local var_375_5 = 0

			if var_375_5 < arg_372_1.time_ and arg_372_1.time_ <= var_375_5 + arg_375_0 then
				arg_372_1.var_.moveOldPos1061ui_story = var_375_4.localPosition
			end

			local var_375_6 = 0.001

			if var_375_5 <= arg_372_1.time_ and arg_372_1.time_ < var_375_5 + var_375_6 then
				local var_375_7 = (arg_372_1.time_ - var_375_5) / var_375_6
				local var_375_8 = Vector3.New(0, -1.18, -6.15)

				var_375_4.localPosition = Vector3.Lerp(arg_372_1.var_.moveOldPos1061ui_story, var_375_8, var_375_7)

				local var_375_9 = manager.ui.mainCamera.transform.position - var_375_4.position

				var_375_4.forward = Vector3.New(var_375_9.x, var_375_9.y, var_375_9.z)

				local var_375_10 = var_375_4.localEulerAngles

				var_375_10.z = 0
				var_375_10.x = 0
				var_375_4.localEulerAngles = var_375_10
			end

			if arg_372_1.time_ >= var_375_5 + var_375_6 and arg_372_1.time_ < var_375_5 + var_375_6 + arg_375_0 then
				var_375_4.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_375_11 = manager.ui.mainCamera.transform.position - var_375_4.position

				var_375_4.forward = Vector3.New(var_375_11.x, var_375_11.y, var_375_11.z)

				local var_375_12 = var_375_4.localEulerAngles

				var_375_12.z = 0
				var_375_12.x = 0
				var_375_4.localEulerAngles = var_375_12
			end

			local var_375_13 = 0

			if var_375_13 < arg_372_1.time_ and arg_372_1.time_ <= var_375_13 + arg_375_0 then
				arg_372_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			local var_375_14 = 0

			if var_375_14 < arg_372_1.time_ and arg_372_1.time_ <= var_375_14 + arg_375_0 then
				arg_372_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_375_15 = 0
			local var_375_16 = 0.5

			if var_375_15 < arg_372_1.time_ and arg_372_1.time_ <= var_375_15 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				local var_375_17 = arg_372_1:FormatText(StoryNameCfg[612].name)

				arg_372_1.leftNameTxt_.text = var_375_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_18 = arg_372_1:GetWordFromCfg(420132090)
				local var_375_19 = arg_372_1:FormatText(var_375_18.content)

				arg_372_1.text_.text = var_375_19

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_20 = 20
				local var_375_21 = utf8.len(var_375_19)
				local var_375_22 = var_375_20 <= 0 and var_375_16 or var_375_16 * (var_375_21 / var_375_20)

				if var_375_22 > 0 and var_375_16 < var_375_22 then
					arg_372_1.talkMaxDuration = var_375_22

					if var_375_22 + var_375_15 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_22 + var_375_15
					end
				end

				arg_372_1.text_.text = var_375_19
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132090", "story_v_out_420132.awb") ~= 0 then
					local var_375_23 = manager.audio:GetVoiceLength("story_v_out_420132", "420132090", "story_v_out_420132.awb") / 1000

					if var_375_23 + var_375_15 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_23 + var_375_15
					end

					if var_375_18.prefab_name ~= "" and arg_372_1.actors_[var_375_18.prefab_name] ~= nil then
						local var_375_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_18.prefab_name].transform, "story_v_out_420132", "420132090", "story_v_out_420132.awb")

						arg_372_1:RecordAudio("420132090", var_375_24)
						arg_372_1:RecordAudio("420132090", var_375_24)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_420132", "420132090", "story_v_out_420132.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_420132", "420132090", "story_v_out_420132.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_25 = math.max(var_375_16, arg_372_1.talkMaxDuration)

			if var_375_15 <= arg_372_1.time_ and arg_372_1.time_ < var_375_15 + var_375_25 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_15) / var_375_25

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_15 + var_375_25 and arg_372_1.time_ < var_375_15 + var_375_25 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {
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

		arg_372_1:InitPlayNodeList()
	end,
	Play420132091 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 420132091
		arg_376_1.duration_ = 5

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play420132092(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = arg_376_1.actors_["1061ui_story"]
			local var_379_1 = 0

			if var_379_1 < arg_376_1.time_ and arg_376_1.time_ <= var_379_1 + arg_379_0 and not isNil(var_379_0) and arg_376_1.var_.characterEffect1061ui_story == nil then
				arg_376_1.var_.characterEffect1061ui_story = var_379_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_379_2 = 0.200000002980232

			if var_379_1 <= arg_376_1.time_ and arg_376_1.time_ < var_379_1 + var_379_2 and not isNil(var_379_0) then
				local var_379_3 = (arg_376_1.time_ - var_379_1) / var_379_2

				if arg_376_1.var_.characterEffect1061ui_story and not isNil(var_379_0) then
					local var_379_4 = Mathf.Lerp(0, 0.5, var_379_3)

					arg_376_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_376_1.var_.characterEffect1061ui_story.fillRatio = var_379_4
				end
			end

			if arg_376_1.time_ >= var_379_1 + var_379_2 and arg_376_1.time_ < var_379_1 + var_379_2 + arg_379_0 and not isNil(var_379_0) and arg_376_1.var_.characterEffect1061ui_story then
				local var_379_5 = 0.5

				arg_376_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_376_1.var_.characterEffect1061ui_story.fillRatio = var_379_5
			end

			local var_379_6 = 0
			local var_379_7 = 1.3

			if var_379_6 < arg_376_1.time_ and arg_376_1.time_ <= var_379_6 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, false)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_8 = arg_376_1:GetWordFromCfg(420132091)
				local var_379_9 = arg_376_1:FormatText(var_379_8.content)

				arg_376_1.text_.text = var_379_9

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_10 = 52
				local var_379_11 = utf8.len(var_379_9)
				local var_379_12 = var_379_10 <= 0 and var_379_7 or var_379_7 * (var_379_11 / var_379_10)

				if var_379_12 > 0 and var_379_7 < var_379_12 then
					arg_376_1.talkMaxDuration = var_379_12

					if var_379_12 + var_379_6 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_12 + var_379_6
					end
				end

				arg_376_1.text_.text = var_379_9
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)
				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_13 = math.max(var_379_7, arg_376_1.talkMaxDuration)

			if var_379_6 <= arg_376_1.time_ and arg_376_1.time_ < var_379_6 + var_379_13 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_6) / var_379_13

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_6 + var_379_13 and arg_376_1.time_ < var_379_6 + var_379_13 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play420132092 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 420132092
		arg_380_1.duration_ = 9.03

		local var_380_0 = {
			zh = 9.033,
			ja = 8.933
		}
		local var_380_1 = manager.audio:GetLocalizationFlag()

		if var_380_0[var_380_1] ~= nil then
			arg_380_1.duration_ = var_380_0[var_380_1]
		end

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play420132093(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = arg_380_1.actors_["1061ui_story"]
			local var_383_1 = 0

			if var_383_1 < arg_380_1.time_ and arg_380_1.time_ <= var_383_1 + arg_383_0 and not isNil(var_383_0) and arg_380_1.var_.characterEffect1061ui_story == nil then
				arg_380_1.var_.characterEffect1061ui_story = var_383_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_2 = 0.200000002980232

			if var_383_1 <= arg_380_1.time_ and arg_380_1.time_ < var_383_1 + var_383_2 and not isNil(var_383_0) then
				local var_383_3 = (arg_380_1.time_ - var_383_1) / var_383_2

				if arg_380_1.var_.characterEffect1061ui_story and not isNil(var_383_0) then
					arg_380_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_380_1.time_ >= var_383_1 + var_383_2 and arg_380_1.time_ < var_383_1 + var_383_2 + arg_383_0 and not isNil(var_383_0) and arg_380_1.var_.characterEffect1061ui_story then
				arg_380_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_383_4 = 0
			local var_383_5 = 0.925

			if var_383_4 < arg_380_1.time_ and arg_380_1.time_ <= var_383_4 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				local var_383_6 = arg_380_1:FormatText(StoryNameCfg[612].name)

				arg_380_1.leftNameTxt_.text = var_383_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_7 = arg_380_1:GetWordFromCfg(420132092)
				local var_383_8 = arg_380_1:FormatText(var_383_7.content)

				arg_380_1.text_.text = var_383_8

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_9 = 37
				local var_383_10 = utf8.len(var_383_8)
				local var_383_11 = var_383_9 <= 0 and var_383_5 or var_383_5 * (var_383_10 / var_383_9)

				if var_383_11 > 0 and var_383_5 < var_383_11 then
					arg_380_1.talkMaxDuration = var_383_11

					if var_383_11 + var_383_4 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_11 + var_383_4
					end
				end

				arg_380_1.text_.text = var_383_8
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132092", "story_v_out_420132.awb") ~= 0 then
					local var_383_12 = manager.audio:GetVoiceLength("story_v_out_420132", "420132092", "story_v_out_420132.awb") / 1000

					if var_383_12 + var_383_4 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_12 + var_383_4
					end

					if var_383_7.prefab_name ~= "" and arg_380_1.actors_[var_383_7.prefab_name] ~= nil then
						local var_383_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_7.prefab_name].transform, "story_v_out_420132", "420132092", "story_v_out_420132.awb")

						arg_380_1:RecordAudio("420132092", var_383_13)
						arg_380_1:RecordAudio("420132092", var_383_13)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_out_420132", "420132092", "story_v_out_420132.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_out_420132", "420132092", "story_v_out_420132.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_14 = math.max(var_383_5, arg_380_1.talkMaxDuration)

			if var_383_4 <= arg_380_1.time_ and arg_380_1.time_ < var_383_4 + var_383_14 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_4) / var_383_14

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_4 + var_383_14 and arg_380_1.time_ < var_383_4 + var_383_14 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play420132093 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 420132093
		arg_384_1.duration_ = 10.03

		local var_384_0 = {
			zh = 7.033,
			ja = 10.033
		}
		local var_384_1 = manager.audio:GetLocalizationFlag()

		if var_384_0[var_384_1] ~= nil then
			arg_384_1.duration_ = var_384_0[var_384_1]
		end

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play420132094(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = 0
			local var_387_1 = 0.7

			if var_387_0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_0 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				local var_387_2 = arg_384_1:FormatText(StoryNameCfg[612].name)

				arg_384_1.leftNameTxt_.text = var_387_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_3 = arg_384_1:GetWordFromCfg(420132093)
				local var_387_4 = arg_384_1:FormatText(var_387_3.content)

				arg_384_1.text_.text = var_387_4

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_5 = 28
				local var_387_6 = utf8.len(var_387_4)
				local var_387_7 = var_387_5 <= 0 and var_387_1 or var_387_1 * (var_387_6 / var_387_5)

				if var_387_7 > 0 and var_387_1 < var_387_7 then
					arg_384_1.talkMaxDuration = var_387_7

					if var_387_7 + var_387_0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_7 + var_387_0
					end
				end

				arg_384_1.text_.text = var_387_4
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132093", "story_v_out_420132.awb") ~= 0 then
					local var_387_8 = manager.audio:GetVoiceLength("story_v_out_420132", "420132093", "story_v_out_420132.awb") / 1000

					if var_387_8 + var_387_0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_8 + var_387_0
					end

					if var_387_3.prefab_name ~= "" and arg_384_1.actors_[var_387_3.prefab_name] ~= nil then
						local var_387_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_3.prefab_name].transform, "story_v_out_420132", "420132093", "story_v_out_420132.awb")

						arg_384_1:RecordAudio("420132093", var_387_9)
						arg_384_1:RecordAudio("420132093", var_387_9)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_out_420132", "420132093", "story_v_out_420132.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_out_420132", "420132093", "story_v_out_420132.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_10 = math.max(var_387_1, arg_384_1.talkMaxDuration)

			if var_387_0 <= arg_384_1.time_ and arg_384_1.time_ < var_387_0 + var_387_10 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_0) / var_387_10

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_0 + var_387_10 and arg_384_1.time_ < var_387_0 + var_387_10 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play420132094 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 420132094
		arg_388_1.duration_ = 7.43

		local var_388_0 = {
			zh = 7,
			ja = 7.433
		}
		local var_388_1 = manager.audio:GetLocalizationFlag()

		if var_388_0[var_388_1] ~= nil then
			arg_388_1.duration_ = var_388_0[var_388_1]
		end

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play420132095(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = arg_388_1.actors_["1085ui_story"]
			local var_391_1 = 0

			if var_391_1 < arg_388_1.time_ and arg_388_1.time_ <= var_391_1 + arg_391_0 and not isNil(var_391_0) and arg_388_1.var_.characterEffect1085ui_story == nil then
				arg_388_1.var_.characterEffect1085ui_story = var_391_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_2 = 0.200000002980232

			if var_391_1 <= arg_388_1.time_ and arg_388_1.time_ < var_391_1 + var_391_2 and not isNil(var_391_0) then
				local var_391_3 = (arg_388_1.time_ - var_391_1) / var_391_2

				if arg_388_1.var_.characterEffect1085ui_story and not isNil(var_391_0) then
					arg_388_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_388_1.time_ >= var_391_1 + var_391_2 and arg_388_1.time_ < var_391_1 + var_391_2 + arg_391_0 and not isNil(var_391_0) and arg_388_1.var_.characterEffect1085ui_story then
				arg_388_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_391_4 = arg_388_1.actors_["1061ui_story"]
			local var_391_5 = 0

			if var_391_5 < arg_388_1.time_ and arg_388_1.time_ <= var_391_5 + arg_391_0 and not isNil(var_391_4) and arg_388_1.var_.characterEffect1061ui_story == nil then
				arg_388_1.var_.characterEffect1061ui_story = var_391_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_6 = 0.200000002980232

			if var_391_5 <= arg_388_1.time_ and arg_388_1.time_ < var_391_5 + var_391_6 and not isNil(var_391_4) then
				local var_391_7 = (arg_388_1.time_ - var_391_5) / var_391_6

				if arg_388_1.var_.characterEffect1061ui_story and not isNil(var_391_4) then
					local var_391_8 = Mathf.Lerp(0, 0.5, var_391_7)

					arg_388_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_388_1.var_.characterEffect1061ui_story.fillRatio = var_391_8
				end
			end

			if arg_388_1.time_ >= var_391_5 + var_391_6 and arg_388_1.time_ < var_391_5 + var_391_6 + arg_391_0 and not isNil(var_391_4) and arg_388_1.var_.characterEffect1061ui_story then
				local var_391_9 = 0.5

				arg_388_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_388_1.var_.characterEffect1061ui_story.fillRatio = var_391_9
			end

			local var_391_10 = arg_388_1.actors_["1061ui_story"].transform
			local var_391_11 = 0

			if var_391_11 < arg_388_1.time_ and arg_388_1.time_ <= var_391_11 + arg_391_0 then
				arg_388_1.var_.moveOldPos1061ui_story = var_391_10.localPosition
			end

			local var_391_12 = 0.001

			if var_391_11 <= arg_388_1.time_ and arg_388_1.time_ < var_391_11 + var_391_12 then
				local var_391_13 = (arg_388_1.time_ - var_391_11) / var_391_12
				local var_391_14 = Vector3.New(-0.7, -1.18, -6.15)

				var_391_10.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos1061ui_story, var_391_14, var_391_13)

				local var_391_15 = manager.ui.mainCamera.transform.position - var_391_10.position

				var_391_10.forward = Vector3.New(var_391_15.x, var_391_15.y, var_391_15.z)

				local var_391_16 = var_391_10.localEulerAngles

				var_391_16.z = 0
				var_391_16.x = 0
				var_391_10.localEulerAngles = var_391_16
			end

			if arg_388_1.time_ >= var_391_11 + var_391_12 and arg_388_1.time_ < var_391_11 + var_391_12 + arg_391_0 then
				var_391_10.localPosition = Vector3.New(-0.7, -1.18, -6.15)

				local var_391_17 = manager.ui.mainCamera.transform.position - var_391_10.position

				var_391_10.forward = Vector3.New(var_391_17.x, var_391_17.y, var_391_17.z)

				local var_391_18 = var_391_10.localEulerAngles

				var_391_18.z = 0
				var_391_18.x = 0
				var_391_10.localEulerAngles = var_391_18
			end

			local var_391_19 = 0

			if var_391_19 < arg_388_1.time_ and arg_388_1.time_ <= var_391_19 + arg_391_0 then
				arg_388_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_391_20 = arg_388_1.actors_["1085ui_story"].transform
			local var_391_21 = 0

			if var_391_21 < arg_388_1.time_ and arg_388_1.time_ <= var_391_21 + arg_391_0 then
				arg_388_1.var_.moveOldPos1085ui_story = var_391_20.localPosition
			end

			local var_391_22 = 0.001

			if var_391_21 <= arg_388_1.time_ and arg_388_1.time_ < var_391_21 + var_391_22 then
				local var_391_23 = (arg_388_1.time_ - var_391_21) / var_391_22
				local var_391_24 = Vector3.New(0.75, -1.01, -5.83)

				var_391_20.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos1085ui_story, var_391_24, var_391_23)

				local var_391_25 = manager.ui.mainCamera.transform.position - var_391_20.position

				var_391_20.forward = Vector3.New(var_391_25.x, var_391_25.y, var_391_25.z)

				local var_391_26 = var_391_20.localEulerAngles

				var_391_26.z = 0
				var_391_26.x = 0
				var_391_20.localEulerAngles = var_391_26
			end

			if arg_388_1.time_ >= var_391_21 + var_391_22 and arg_388_1.time_ < var_391_21 + var_391_22 + arg_391_0 then
				var_391_20.localPosition = Vector3.New(0.75, -1.01, -5.83)

				local var_391_27 = manager.ui.mainCamera.transform.position - var_391_20.position

				var_391_20.forward = Vector3.New(var_391_27.x, var_391_27.y, var_391_27.z)

				local var_391_28 = var_391_20.localEulerAngles

				var_391_28.z = 0
				var_391_28.x = 0
				var_391_20.localEulerAngles = var_391_28
			end

			local var_391_29 = 0
			local var_391_30 = 0.525

			if var_391_29 < arg_388_1.time_ and arg_388_1.time_ <= var_391_29 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				local var_391_31 = arg_388_1:FormatText(StoryNameCfg[328].name)

				arg_388_1.leftNameTxt_.text = var_391_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_32 = arg_388_1:GetWordFromCfg(420132094)
				local var_391_33 = arg_388_1:FormatText(var_391_32.content)

				arg_388_1.text_.text = var_391_33

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_34 = 21
				local var_391_35 = utf8.len(var_391_33)
				local var_391_36 = var_391_34 <= 0 and var_391_30 or var_391_30 * (var_391_35 / var_391_34)

				if var_391_36 > 0 and var_391_30 < var_391_36 then
					arg_388_1.talkMaxDuration = var_391_36

					if var_391_36 + var_391_29 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_36 + var_391_29
					end
				end

				arg_388_1.text_.text = var_391_33
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132094", "story_v_out_420132.awb") ~= 0 then
					local var_391_37 = manager.audio:GetVoiceLength("story_v_out_420132", "420132094", "story_v_out_420132.awb") / 1000

					if var_391_37 + var_391_29 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_37 + var_391_29
					end

					if var_391_32.prefab_name ~= "" and arg_388_1.actors_[var_391_32.prefab_name] ~= nil then
						local var_391_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_32.prefab_name].transform, "story_v_out_420132", "420132094", "story_v_out_420132.awb")

						arg_388_1:RecordAudio("420132094", var_391_38)
						arg_388_1:RecordAudio("420132094", var_391_38)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_out_420132", "420132094", "story_v_out_420132.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_out_420132", "420132094", "story_v_out_420132.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_39 = math.max(var_391_30, arg_388_1.talkMaxDuration)

			if var_391_29 <= arg_388_1.time_ and arg_388_1.time_ < var_391_29 + var_391_39 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_29) / var_391_39

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_29 + var_391_39 and arg_388_1.time_ < var_391_29 + var_391_39 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {
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
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_388_1:InitPlayNodeList()
	end,
	Play420132095 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 420132095
		arg_392_1.duration_ = 6.87

		local var_392_0 = {
			zh = 4.7,
			ja = 6.866
		}
		local var_392_1 = manager.audio:GetLocalizationFlag()

		if var_392_0[var_392_1] ~= nil then
			arg_392_1.duration_ = var_392_0[var_392_1]
		end

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play420132096(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = arg_392_1.actors_["1061ui_story"]
			local var_395_1 = 0

			if var_395_1 < arg_392_1.time_ and arg_392_1.time_ <= var_395_1 + arg_395_0 and not isNil(var_395_0) and arg_392_1.var_.characterEffect1061ui_story == nil then
				arg_392_1.var_.characterEffect1061ui_story = var_395_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_395_2 = 0.200000002980232

			if var_395_1 <= arg_392_1.time_ and arg_392_1.time_ < var_395_1 + var_395_2 and not isNil(var_395_0) then
				local var_395_3 = (arg_392_1.time_ - var_395_1) / var_395_2

				if arg_392_1.var_.characterEffect1061ui_story and not isNil(var_395_0) then
					arg_392_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_392_1.time_ >= var_395_1 + var_395_2 and arg_392_1.time_ < var_395_1 + var_395_2 + arg_395_0 and not isNil(var_395_0) and arg_392_1.var_.characterEffect1061ui_story then
				arg_392_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_395_4 = arg_392_1.actors_["1085ui_story"]
			local var_395_5 = 0

			if var_395_5 < arg_392_1.time_ and arg_392_1.time_ <= var_395_5 + arg_395_0 and not isNil(var_395_4) and arg_392_1.var_.characterEffect1085ui_story == nil then
				arg_392_1.var_.characterEffect1085ui_story = var_395_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_395_6 = 0.200000002980232

			if var_395_5 <= arg_392_1.time_ and arg_392_1.time_ < var_395_5 + var_395_6 and not isNil(var_395_4) then
				local var_395_7 = (arg_392_1.time_ - var_395_5) / var_395_6

				if arg_392_1.var_.characterEffect1085ui_story and not isNil(var_395_4) then
					local var_395_8 = Mathf.Lerp(0, 0.5, var_395_7)

					arg_392_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_392_1.var_.characterEffect1085ui_story.fillRatio = var_395_8
				end
			end

			if arg_392_1.time_ >= var_395_5 + var_395_6 and arg_392_1.time_ < var_395_5 + var_395_6 + arg_395_0 and not isNil(var_395_4) and arg_392_1.var_.characterEffect1085ui_story then
				local var_395_9 = 0.5

				arg_392_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_392_1.var_.characterEffect1085ui_story.fillRatio = var_395_9
			end

			local var_395_10 = 0
			local var_395_11 = 0.5

			if var_395_10 < arg_392_1.time_ and arg_392_1.time_ <= var_395_10 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				local var_395_12 = arg_392_1:FormatText(StoryNameCfg[612].name)

				arg_392_1.leftNameTxt_.text = var_395_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_13 = arg_392_1:GetWordFromCfg(420132095)
				local var_395_14 = arg_392_1:FormatText(var_395_13.content)

				arg_392_1.text_.text = var_395_14

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_15 = 20
				local var_395_16 = utf8.len(var_395_14)
				local var_395_17 = var_395_15 <= 0 and var_395_11 or var_395_11 * (var_395_16 / var_395_15)

				if var_395_17 > 0 and var_395_11 < var_395_17 then
					arg_392_1.talkMaxDuration = var_395_17

					if var_395_17 + var_395_10 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_17 + var_395_10
					end
				end

				arg_392_1.text_.text = var_395_14
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132095", "story_v_out_420132.awb") ~= 0 then
					local var_395_18 = manager.audio:GetVoiceLength("story_v_out_420132", "420132095", "story_v_out_420132.awb") / 1000

					if var_395_18 + var_395_10 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_18 + var_395_10
					end

					if var_395_13.prefab_name ~= "" and arg_392_1.actors_[var_395_13.prefab_name] ~= nil then
						local var_395_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_13.prefab_name].transform, "story_v_out_420132", "420132095", "story_v_out_420132.awb")

						arg_392_1:RecordAudio("420132095", var_395_19)
						arg_392_1:RecordAudio("420132095", var_395_19)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_out_420132", "420132095", "story_v_out_420132.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_out_420132", "420132095", "story_v_out_420132.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_20 = math.max(var_395_11, arg_392_1.talkMaxDuration)

			if var_395_10 <= arg_392_1.time_ and arg_392_1.time_ < var_395_10 + var_395_20 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_10) / var_395_20

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_10 + var_395_20 and arg_392_1.time_ < var_395_10 + var_395_20 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play420132096 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 420132096
		arg_396_1.duration_ = 3.8

		local var_396_0 = {
			zh = 2.166,
			ja = 3.8
		}
		local var_396_1 = manager.audio:GetLocalizationFlag()

		if var_396_0[var_396_1] ~= nil then
			arg_396_1.duration_ = var_396_0[var_396_1]
		end

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play420132097(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = arg_396_1.actors_["1085ui_story"]
			local var_399_1 = 0

			if var_399_1 < arg_396_1.time_ and arg_396_1.time_ <= var_399_1 + arg_399_0 and not isNil(var_399_0) and arg_396_1.var_.characterEffect1085ui_story == nil then
				arg_396_1.var_.characterEffect1085ui_story = var_399_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_399_2 = 0.200000002980232

			if var_399_1 <= arg_396_1.time_ and arg_396_1.time_ < var_399_1 + var_399_2 and not isNil(var_399_0) then
				local var_399_3 = (arg_396_1.time_ - var_399_1) / var_399_2

				if arg_396_1.var_.characterEffect1085ui_story and not isNil(var_399_0) then
					arg_396_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_396_1.time_ >= var_399_1 + var_399_2 and arg_396_1.time_ < var_399_1 + var_399_2 + arg_399_0 and not isNil(var_399_0) and arg_396_1.var_.characterEffect1085ui_story then
				arg_396_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_399_4 = arg_396_1.actors_["1061ui_story"]
			local var_399_5 = 0

			if var_399_5 < arg_396_1.time_ and arg_396_1.time_ <= var_399_5 + arg_399_0 and not isNil(var_399_4) and arg_396_1.var_.characterEffect1061ui_story == nil then
				arg_396_1.var_.characterEffect1061ui_story = var_399_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_399_6 = 0.200000002980232

			if var_399_5 <= arg_396_1.time_ and arg_396_1.time_ < var_399_5 + var_399_6 and not isNil(var_399_4) then
				local var_399_7 = (arg_396_1.time_ - var_399_5) / var_399_6

				if arg_396_1.var_.characterEffect1061ui_story and not isNil(var_399_4) then
					local var_399_8 = Mathf.Lerp(0, 0.5, var_399_7)

					arg_396_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_396_1.var_.characterEffect1061ui_story.fillRatio = var_399_8
				end
			end

			if arg_396_1.time_ >= var_399_5 + var_399_6 and arg_396_1.time_ < var_399_5 + var_399_6 + arg_399_0 and not isNil(var_399_4) and arg_396_1.var_.characterEffect1061ui_story then
				local var_399_9 = 0.5

				arg_396_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_396_1.var_.characterEffect1061ui_story.fillRatio = var_399_9
			end

			local var_399_10 = 0
			local var_399_11 = 0.2

			if var_399_10 < arg_396_1.time_ and arg_396_1.time_ <= var_399_10 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				local var_399_12 = arg_396_1:FormatText(StoryNameCfg[328].name)

				arg_396_1.leftNameTxt_.text = var_399_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_13 = arg_396_1:GetWordFromCfg(420132096)
				local var_399_14 = arg_396_1:FormatText(var_399_13.content)

				arg_396_1.text_.text = var_399_14

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_15 = 8
				local var_399_16 = utf8.len(var_399_14)
				local var_399_17 = var_399_15 <= 0 and var_399_11 or var_399_11 * (var_399_16 / var_399_15)

				if var_399_17 > 0 and var_399_11 < var_399_17 then
					arg_396_1.talkMaxDuration = var_399_17

					if var_399_17 + var_399_10 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_17 + var_399_10
					end
				end

				arg_396_1.text_.text = var_399_14
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132096", "story_v_out_420132.awb") ~= 0 then
					local var_399_18 = manager.audio:GetVoiceLength("story_v_out_420132", "420132096", "story_v_out_420132.awb") / 1000

					if var_399_18 + var_399_10 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_18 + var_399_10
					end

					if var_399_13.prefab_name ~= "" and arg_396_1.actors_[var_399_13.prefab_name] ~= nil then
						local var_399_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_396_1.actors_[var_399_13.prefab_name].transform, "story_v_out_420132", "420132096", "story_v_out_420132.awb")

						arg_396_1:RecordAudio("420132096", var_399_19)
						arg_396_1:RecordAudio("420132096", var_399_19)
					else
						arg_396_1:AudioAction("play", "voice", "story_v_out_420132", "420132096", "story_v_out_420132.awb")
					end

					arg_396_1:RecordHistoryTalkVoice("story_v_out_420132", "420132096", "story_v_out_420132.awb")
				end

				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_20 = math.max(var_399_11, arg_396_1.talkMaxDuration)

			if var_399_10 <= arg_396_1.time_ and arg_396_1.time_ < var_399_10 + var_399_20 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_10) / var_399_20

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_10 + var_399_20 and arg_396_1.time_ < var_399_10 + var_399_20 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play420132097 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 420132097
		arg_400_1.duration_ = 9.23

		local var_400_0 = {
			zh = 8.4,
			ja = 9.233
		}
		local var_400_1 = manager.audio:GetLocalizationFlag()

		if var_400_0[var_400_1] ~= nil then
			arg_400_1.duration_ = var_400_0[var_400_1]
		end

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play420132098(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = arg_400_1.actors_["1061ui_story"]
			local var_403_1 = 0

			if var_403_1 < arg_400_1.time_ and arg_400_1.time_ <= var_403_1 + arg_403_0 and not isNil(var_403_0) and arg_400_1.var_.characterEffect1061ui_story == nil then
				arg_400_1.var_.characterEffect1061ui_story = var_403_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_403_2 = 0.200000002980232

			if var_403_1 <= arg_400_1.time_ and arg_400_1.time_ < var_403_1 + var_403_2 and not isNil(var_403_0) then
				local var_403_3 = (arg_400_1.time_ - var_403_1) / var_403_2

				if arg_400_1.var_.characterEffect1061ui_story and not isNil(var_403_0) then
					arg_400_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_400_1.time_ >= var_403_1 + var_403_2 and arg_400_1.time_ < var_403_1 + var_403_2 + arg_403_0 and not isNil(var_403_0) and arg_400_1.var_.characterEffect1061ui_story then
				arg_400_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_403_4 = arg_400_1.actors_["1085ui_story"]
			local var_403_5 = 0

			if var_403_5 < arg_400_1.time_ and arg_400_1.time_ <= var_403_5 + arg_403_0 and not isNil(var_403_4) and arg_400_1.var_.characterEffect1085ui_story == nil then
				arg_400_1.var_.characterEffect1085ui_story = var_403_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_403_6 = 0.200000002980232

			if var_403_5 <= arg_400_1.time_ and arg_400_1.time_ < var_403_5 + var_403_6 and not isNil(var_403_4) then
				local var_403_7 = (arg_400_1.time_ - var_403_5) / var_403_6

				if arg_400_1.var_.characterEffect1085ui_story and not isNil(var_403_4) then
					local var_403_8 = Mathf.Lerp(0, 0.5, var_403_7)

					arg_400_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_400_1.var_.characterEffect1085ui_story.fillRatio = var_403_8
				end
			end

			if arg_400_1.time_ >= var_403_5 + var_403_6 and arg_400_1.time_ < var_403_5 + var_403_6 + arg_403_0 and not isNil(var_403_4) and arg_400_1.var_.characterEffect1085ui_story then
				local var_403_9 = 0.5

				arg_400_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_400_1.var_.characterEffect1085ui_story.fillRatio = var_403_9
			end

			local var_403_10 = 0

			if var_403_10 < arg_400_1.time_ and arg_400_1.time_ <= var_403_10 + arg_403_0 then
				arg_400_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action5_1")
			end

			local var_403_11 = 0
			local var_403_12 = 0.75

			if var_403_11 < arg_400_1.time_ and arg_400_1.time_ <= var_403_11 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				local var_403_13 = arg_400_1:FormatText(StoryNameCfg[612].name)

				arg_400_1.leftNameTxt_.text = var_403_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_14 = arg_400_1:GetWordFromCfg(420132097)
				local var_403_15 = arg_400_1:FormatText(var_403_14.content)

				arg_400_1.text_.text = var_403_15

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_16 = 30
				local var_403_17 = utf8.len(var_403_15)
				local var_403_18 = var_403_16 <= 0 and var_403_12 or var_403_12 * (var_403_17 / var_403_16)

				if var_403_18 > 0 and var_403_12 < var_403_18 then
					arg_400_1.talkMaxDuration = var_403_18

					if var_403_18 + var_403_11 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_18 + var_403_11
					end
				end

				arg_400_1.text_.text = var_403_15
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132097", "story_v_out_420132.awb") ~= 0 then
					local var_403_19 = manager.audio:GetVoiceLength("story_v_out_420132", "420132097", "story_v_out_420132.awb") / 1000

					if var_403_19 + var_403_11 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_19 + var_403_11
					end

					if var_403_14.prefab_name ~= "" and arg_400_1.actors_[var_403_14.prefab_name] ~= nil then
						local var_403_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_14.prefab_name].transform, "story_v_out_420132", "420132097", "story_v_out_420132.awb")

						arg_400_1:RecordAudio("420132097", var_403_20)
						arg_400_1:RecordAudio("420132097", var_403_20)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_out_420132", "420132097", "story_v_out_420132.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_out_420132", "420132097", "story_v_out_420132.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_21 = math.max(var_403_12, arg_400_1.talkMaxDuration)

			if var_403_11 <= arg_400_1.time_ and arg_400_1.time_ < var_403_11 + var_403_21 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_11) / var_403_21

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_11 + var_403_21 and arg_400_1.time_ < var_403_11 + var_403_21 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play420132098 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 420132098
		arg_404_1.duration_ = 2

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play420132099(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = arg_404_1.actors_["1085ui_story"]
			local var_407_1 = 0

			if var_407_1 < arg_404_1.time_ and arg_404_1.time_ <= var_407_1 + arg_407_0 and not isNil(var_407_0) and arg_404_1.var_.characterEffect1085ui_story == nil then
				arg_404_1.var_.characterEffect1085ui_story = var_407_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_2 = 0.200000002980232

			if var_407_1 <= arg_404_1.time_ and arg_404_1.time_ < var_407_1 + var_407_2 and not isNil(var_407_0) then
				local var_407_3 = (arg_404_1.time_ - var_407_1) / var_407_2

				if arg_404_1.var_.characterEffect1085ui_story and not isNil(var_407_0) then
					arg_404_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_404_1.time_ >= var_407_1 + var_407_2 and arg_404_1.time_ < var_407_1 + var_407_2 + arg_407_0 and not isNil(var_407_0) and arg_404_1.var_.characterEffect1085ui_story then
				arg_404_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_407_4 = arg_404_1.actors_["1061ui_story"]
			local var_407_5 = 0

			if var_407_5 < arg_404_1.time_ and arg_404_1.time_ <= var_407_5 + arg_407_0 and not isNil(var_407_4) and arg_404_1.var_.characterEffect1061ui_story == nil then
				arg_404_1.var_.characterEffect1061ui_story = var_407_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_6 = 0.200000002980232

			if var_407_5 <= arg_404_1.time_ and arg_404_1.time_ < var_407_5 + var_407_6 and not isNil(var_407_4) then
				local var_407_7 = (arg_404_1.time_ - var_407_5) / var_407_6

				if arg_404_1.var_.characterEffect1061ui_story and not isNil(var_407_4) then
					local var_407_8 = Mathf.Lerp(0, 0.5, var_407_7)

					arg_404_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_404_1.var_.characterEffect1061ui_story.fillRatio = var_407_8
				end
			end

			if arg_404_1.time_ >= var_407_5 + var_407_6 and arg_404_1.time_ < var_407_5 + var_407_6 + arg_407_0 and not isNil(var_407_4) and arg_404_1.var_.characterEffect1061ui_story then
				local var_407_9 = 0.5

				arg_404_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_404_1.var_.characterEffect1061ui_story.fillRatio = var_407_9
			end

			local var_407_10 = 0

			if var_407_10 < arg_404_1.time_ and arg_404_1.time_ <= var_407_10 + arg_407_0 then
				arg_404_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			local var_407_11 = 0
			local var_407_12 = 0.1

			if var_407_11 < arg_404_1.time_ and arg_404_1.time_ <= var_407_11 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				local var_407_13 = arg_404_1:FormatText(StoryNameCfg[328].name)

				arg_404_1.leftNameTxt_.text = var_407_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_14 = arg_404_1:GetWordFromCfg(420132098)
				local var_407_15 = arg_404_1:FormatText(var_407_14.content)

				arg_404_1.text_.text = var_407_15

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_16 = 4
				local var_407_17 = utf8.len(var_407_15)
				local var_407_18 = var_407_16 <= 0 and var_407_12 or var_407_12 * (var_407_17 / var_407_16)

				if var_407_18 > 0 and var_407_12 < var_407_18 then
					arg_404_1.talkMaxDuration = var_407_18

					if var_407_18 + var_407_11 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_18 + var_407_11
					end
				end

				arg_404_1.text_.text = var_407_15
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132098", "story_v_out_420132.awb") ~= 0 then
					local var_407_19 = manager.audio:GetVoiceLength("story_v_out_420132", "420132098", "story_v_out_420132.awb") / 1000

					if var_407_19 + var_407_11 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_19 + var_407_11
					end

					if var_407_14.prefab_name ~= "" and arg_404_1.actors_[var_407_14.prefab_name] ~= nil then
						local var_407_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_14.prefab_name].transform, "story_v_out_420132", "420132098", "story_v_out_420132.awb")

						arg_404_1:RecordAudio("420132098", var_407_20)
						arg_404_1:RecordAudio("420132098", var_407_20)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_out_420132", "420132098", "story_v_out_420132.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_out_420132", "420132098", "story_v_out_420132.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_21 = math.max(var_407_12, arg_404_1.talkMaxDuration)

			if var_407_11 <= arg_404_1.time_ and arg_404_1.time_ < var_407_11 + var_407_21 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_11) / var_407_21

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_11 + var_407_21 and arg_404_1.time_ < var_407_11 + var_407_21 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play420132099 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 420132099
		arg_408_1.duration_ = 3.07

		local var_408_0 = {
			zh = 2.233,
			ja = 3.066
		}
		local var_408_1 = manager.audio:GetLocalizationFlag()

		if var_408_0[var_408_1] ~= nil then
			arg_408_1.duration_ = var_408_0[var_408_1]
		end

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play420132100(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = arg_408_1.actors_["1061ui_story"]
			local var_411_1 = 0

			if var_411_1 < arg_408_1.time_ and arg_408_1.time_ <= var_411_1 + arg_411_0 and not isNil(var_411_0) and arg_408_1.var_.characterEffect1061ui_story == nil then
				arg_408_1.var_.characterEffect1061ui_story = var_411_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_411_2 = 0.200000002980232

			if var_411_1 <= arg_408_1.time_ and arg_408_1.time_ < var_411_1 + var_411_2 and not isNil(var_411_0) then
				local var_411_3 = (arg_408_1.time_ - var_411_1) / var_411_2

				if arg_408_1.var_.characterEffect1061ui_story and not isNil(var_411_0) then
					arg_408_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_408_1.time_ >= var_411_1 + var_411_2 and arg_408_1.time_ < var_411_1 + var_411_2 + arg_411_0 and not isNil(var_411_0) and arg_408_1.var_.characterEffect1061ui_story then
				arg_408_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_411_4 = arg_408_1.actors_["1085ui_story"]
			local var_411_5 = 0

			if var_411_5 < arg_408_1.time_ and arg_408_1.time_ <= var_411_5 + arg_411_0 and not isNil(var_411_4) and arg_408_1.var_.characterEffect1085ui_story == nil then
				arg_408_1.var_.characterEffect1085ui_story = var_411_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_411_6 = 0.200000002980232

			if var_411_5 <= arg_408_1.time_ and arg_408_1.time_ < var_411_5 + var_411_6 and not isNil(var_411_4) then
				local var_411_7 = (arg_408_1.time_ - var_411_5) / var_411_6

				if arg_408_1.var_.characterEffect1085ui_story and not isNil(var_411_4) then
					local var_411_8 = Mathf.Lerp(0, 0.5, var_411_7)

					arg_408_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_408_1.var_.characterEffect1085ui_story.fillRatio = var_411_8
				end
			end

			if arg_408_1.time_ >= var_411_5 + var_411_6 and arg_408_1.time_ < var_411_5 + var_411_6 + arg_411_0 and not isNil(var_411_4) and arg_408_1.var_.characterEffect1085ui_story then
				local var_411_9 = 0.5

				arg_408_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_408_1.var_.characterEffect1085ui_story.fillRatio = var_411_9
			end

			local var_411_10 = 0

			if var_411_10 < arg_408_1.time_ and arg_408_1.time_ <= var_411_10 + arg_411_0 then
				arg_408_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action5_2")
			end

			local var_411_11 = 0
			local var_411_12 = 0.275

			if var_411_11 < arg_408_1.time_ and arg_408_1.time_ <= var_411_11 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				local var_411_13 = arg_408_1:FormatText(StoryNameCfg[612].name)

				arg_408_1.leftNameTxt_.text = var_411_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_14 = arg_408_1:GetWordFromCfg(420132099)
				local var_411_15 = arg_408_1:FormatText(var_411_14.content)

				arg_408_1.text_.text = var_411_15

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_16 = 11
				local var_411_17 = utf8.len(var_411_15)
				local var_411_18 = var_411_16 <= 0 and var_411_12 or var_411_12 * (var_411_17 / var_411_16)

				if var_411_18 > 0 and var_411_12 < var_411_18 then
					arg_408_1.talkMaxDuration = var_411_18

					if var_411_18 + var_411_11 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_18 + var_411_11
					end
				end

				arg_408_1.text_.text = var_411_15
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132099", "story_v_out_420132.awb") ~= 0 then
					local var_411_19 = manager.audio:GetVoiceLength("story_v_out_420132", "420132099", "story_v_out_420132.awb") / 1000

					if var_411_19 + var_411_11 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_19 + var_411_11
					end

					if var_411_14.prefab_name ~= "" and arg_408_1.actors_[var_411_14.prefab_name] ~= nil then
						local var_411_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_14.prefab_name].transform, "story_v_out_420132", "420132099", "story_v_out_420132.awb")

						arg_408_1:RecordAudio("420132099", var_411_20)
						arg_408_1:RecordAudio("420132099", var_411_20)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_out_420132", "420132099", "story_v_out_420132.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_out_420132", "420132099", "story_v_out_420132.awb")
				end

				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_21 = math.max(var_411_12, arg_408_1.talkMaxDuration)

			if var_411_11 <= arg_408_1.time_ and arg_408_1.time_ < var_411_11 + var_411_21 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_11) / var_411_21

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_11 + var_411_21 and arg_408_1.time_ < var_411_11 + var_411_21 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play420132100 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 420132100
		arg_412_1.duration_ = 12.53

		local var_412_0 = {
			zh = 8.6,
			ja = 12.533
		}
		local var_412_1 = manager.audio:GetLocalizationFlag()

		if var_412_0[var_412_1] ~= nil then
			arg_412_1.duration_ = var_412_0[var_412_1]
		end

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play420132101(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = arg_412_1.actors_["1061ui_story"].transform
			local var_415_1 = 0

			if var_415_1 < arg_412_1.time_ and arg_412_1.time_ <= var_415_1 + arg_415_0 then
				arg_412_1.var_.moveOldPos1061ui_story = var_415_0.localPosition
			end

			local var_415_2 = 0.001

			if var_415_1 <= arg_412_1.time_ and arg_412_1.time_ < var_415_1 + var_415_2 then
				local var_415_3 = (arg_412_1.time_ - var_415_1) / var_415_2
				local var_415_4 = Vector3.New(0, -1.18, -6.15)

				var_415_0.localPosition = Vector3.Lerp(arg_412_1.var_.moveOldPos1061ui_story, var_415_4, var_415_3)

				local var_415_5 = manager.ui.mainCamera.transform.position - var_415_0.position

				var_415_0.forward = Vector3.New(var_415_5.x, var_415_5.y, var_415_5.z)

				local var_415_6 = var_415_0.localEulerAngles

				var_415_6.z = 0
				var_415_6.x = 0
				var_415_0.localEulerAngles = var_415_6
			end

			if arg_412_1.time_ >= var_415_1 + var_415_2 and arg_412_1.time_ < var_415_1 + var_415_2 + arg_415_0 then
				var_415_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_415_7 = manager.ui.mainCamera.transform.position - var_415_0.position

				var_415_0.forward = Vector3.New(var_415_7.x, var_415_7.y, var_415_7.z)

				local var_415_8 = var_415_0.localEulerAngles

				var_415_8.z = 0
				var_415_8.x = 0
				var_415_0.localEulerAngles = var_415_8
			end

			local var_415_9 = arg_412_1.actors_["1085ui_story"].transform
			local var_415_10 = 0

			if var_415_10 < arg_412_1.time_ and arg_412_1.time_ <= var_415_10 + arg_415_0 then
				arg_412_1.var_.moveOldPos1085ui_story = var_415_9.localPosition
			end

			local var_415_11 = 0.001

			if var_415_10 <= arg_412_1.time_ and arg_412_1.time_ < var_415_10 + var_415_11 then
				local var_415_12 = (arg_412_1.time_ - var_415_10) / var_415_11
				local var_415_13 = Vector3.New(0, 100, 0)

				var_415_9.localPosition = Vector3.Lerp(arg_412_1.var_.moveOldPos1085ui_story, var_415_13, var_415_12)

				local var_415_14 = manager.ui.mainCamera.transform.position - var_415_9.position

				var_415_9.forward = Vector3.New(var_415_14.x, var_415_14.y, var_415_14.z)

				local var_415_15 = var_415_9.localEulerAngles

				var_415_15.z = 0
				var_415_15.x = 0
				var_415_9.localEulerAngles = var_415_15
			end

			if arg_412_1.time_ >= var_415_10 + var_415_11 and arg_412_1.time_ < var_415_10 + var_415_11 + arg_415_0 then
				var_415_9.localPosition = Vector3.New(0, 100, 0)

				local var_415_16 = manager.ui.mainCamera.transform.position - var_415_9.position

				var_415_9.forward = Vector3.New(var_415_16.x, var_415_16.y, var_415_16.z)

				local var_415_17 = var_415_9.localEulerAngles

				var_415_17.z = 0
				var_415_17.x = 0
				var_415_9.localEulerAngles = var_415_17
			end

			local var_415_18 = 0
			local var_415_19 = 1.325

			if var_415_18 < arg_412_1.time_ and arg_412_1.time_ <= var_415_18 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				local var_415_20 = arg_412_1:FormatText(StoryNameCfg[612].name)

				arg_412_1.leftNameTxt_.text = var_415_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_21 = arg_412_1:GetWordFromCfg(420132100)
				local var_415_22 = arg_412_1:FormatText(var_415_21.content)

				arg_412_1.text_.text = var_415_22

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_23 = 53
				local var_415_24 = utf8.len(var_415_22)
				local var_415_25 = var_415_23 <= 0 and var_415_19 or var_415_19 * (var_415_24 / var_415_23)

				if var_415_25 > 0 and var_415_19 < var_415_25 then
					arg_412_1.talkMaxDuration = var_415_25

					if var_415_25 + var_415_18 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_25 + var_415_18
					end
				end

				arg_412_1.text_.text = var_415_22
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132100", "story_v_out_420132.awb") ~= 0 then
					local var_415_26 = manager.audio:GetVoiceLength("story_v_out_420132", "420132100", "story_v_out_420132.awb") / 1000

					if var_415_26 + var_415_18 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_26 + var_415_18
					end

					if var_415_21.prefab_name ~= "" and arg_412_1.actors_[var_415_21.prefab_name] ~= nil then
						local var_415_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_21.prefab_name].transform, "story_v_out_420132", "420132100", "story_v_out_420132.awb")

						arg_412_1:RecordAudio("420132100", var_415_27)
						arg_412_1:RecordAudio("420132100", var_415_27)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_out_420132", "420132100", "story_v_out_420132.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_out_420132", "420132100", "story_v_out_420132.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_28 = math.max(var_415_19, arg_412_1.talkMaxDuration)

			if var_415_18 <= arg_412_1.time_ and arg_412_1.time_ < var_415_18 + var_415_28 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_18) / var_415_28

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_18 + var_415_28 and arg_412_1.time_ < var_415_18 + var_415_28 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {
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
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_412_1:InitPlayNodeList()
	end,
	Play420132101 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 420132101
		arg_416_1.duration_ = 11

		local var_416_0 = {
			zh = 8.433,
			ja = 11
		}
		local var_416_1 = manager.audio:GetLocalizationFlag()

		if var_416_0[var_416_1] ~= nil then
			arg_416_1.duration_ = var_416_0[var_416_1]
		end

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
			arg_416_1.auto_ = false
		end

		function arg_416_1.playNext_(arg_418_0)
			arg_416_1.onStoryFinished_()
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = 0
			local var_419_1 = 0.975

			if var_419_0 < arg_416_1.time_ and arg_416_1.time_ <= var_419_0 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				local var_419_2 = arg_416_1:FormatText(StoryNameCfg[612].name)

				arg_416_1.leftNameTxt_.text = var_419_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_3 = arg_416_1:GetWordFromCfg(420132101)
				local var_419_4 = arg_416_1:FormatText(var_419_3.content)

				arg_416_1.text_.text = var_419_4

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_5 = 39
				local var_419_6 = utf8.len(var_419_4)
				local var_419_7 = var_419_5 <= 0 and var_419_1 or var_419_1 * (var_419_6 / var_419_5)

				if var_419_7 > 0 and var_419_1 < var_419_7 then
					arg_416_1.talkMaxDuration = var_419_7

					if var_419_7 + var_419_0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_7 + var_419_0
					end
				end

				arg_416_1.text_.text = var_419_4
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132101", "story_v_out_420132.awb") ~= 0 then
					local var_419_8 = manager.audio:GetVoiceLength("story_v_out_420132", "420132101", "story_v_out_420132.awb") / 1000

					if var_419_8 + var_419_0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_8 + var_419_0
					end

					if var_419_3.prefab_name ~= "" and arg_416_1.actors_[var_419_3.prefab_name] ~= nil then
						local var_419_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_3.prefab_name].transform, "story_v_out_420132", "420132101", "story_v_out_420132.awb")

						arg_416_1:RecordAudio("420132101", var_419_9)
						arg_416_1:RecordAudio("420132101", var_419_9)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_out_420132", "420132101", "story_v_out_420132.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_out_420132", "420132101", "story_v_out_420132.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_10 = math.max(var_419_1, arg_416_1.talkMaxDuration)

			if var_419_0 <= arg_416_1.time_ and arg_416_1.time_ < var_419_0 + var_419_10 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_0) / var_419_10

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_0 + var_419_10 and arg_416_1.time_ < var_419_0 + var_419_10 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST61",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST67"
	},
	voices = {
		"story_v_out_420132.awb"
	}
}
