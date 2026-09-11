return {
	Play323082001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 323082001
		arg_1_1.duration_ = 6.8

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play323082002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.J23f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J23f")
				var_4_0.name = "J23f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.J23f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.J23f

				arg_1_1.bgs_.J23f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "J23f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			if 0.433333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.433333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_8_story_mountain", "bgm_activity_4_8_story_mountain", "bgm_activity_4_8_story_mountain.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_4_8_story_mountain", "bgm_activity_4_8_story_mountain")

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
				arg_1_1:AudioAction("play", "effect", "se_story_side_1070", "se_story_1070_wind01_loop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_16 = 1.8
			local var_4_17 = 1.475

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_18 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_18:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_19 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(323082001).content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 59 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 59)

				if (59 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 59)) > 0 and var_4_17 < var_4_21 then
					arg_1_1.talkMaxDuration = var_4_21
					var_4_16 = var_4_16 + 0.3

					if var_4_21 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_16
					end
				end

				arg_1_1.text_.text = var_4_19
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_22 = var_4_16 + 0.3
			local var_4_23 = math.max(var_4_17, arg_1_1.talkMaxDuration)

			if var_4_16 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_23 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_22) / var_4_23

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_22 + var_4_23 and arg_1_1.time_ < var_4_22 + var_4_23 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play323082002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 323082002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play323082003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.925

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(323082002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 37 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 37)

				if (37 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 37)) > 0 and var_12_0 < var_12_3 then
					arg_9_1.talkMaxDuration = var_12_3

					if var_12_3 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_3 + 0
					end
				end

				arg_9_1.text_.text = var_12_1
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_4 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_4

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play323082003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 323082003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play323082004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.325

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(323082003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 13 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 13)

				if (13 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 13)) > 0 and var_16_0 < var_16_3 then
					arg_13_1.talkMaxDuration = var_16_3

					if var_16_3 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_3 + 0
					end
				end

				arg_13_1.text_.text = var_16_1
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_4 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_4

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play323082004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 323082004
		arg_17_1.duration_ = 6.67

		local var_17_0 = {
			zh = 5.466,
			ja = 6.666
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
				arg_17_0:Play323082005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.actors_["10171ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10171ui_story"))) then
				local var_20_0 = Object.Instantiate(Asset.Load("Char/" .. "10171ui_story"), arg_17_1.stage_.transform)

				var_20_0.name = "10171ui_story"
				var_20_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["10171ui_story"] = var_20_0

				local var_20_1 = var_20_0:GetComponentInChildren(typeof(CharacterEffect))

				var_20_1.enabled = true

				local var_20_2 = GameObjectTools.GetOrAddComponent(var_20_0, typeof(DynamicBoneHelper))

				if var_20_2 then
					var_20_2:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_1.transform, false)

				arg_17_1.var_["10171ui_story" .. "Animator"] = var_20_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_["10171ui_story" .. "Animator"].applyRootMotion = true
				arg_17_1.var_["10171ui_story" .. "LipSync"] = var_20_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_3 = arg_17_1.actors_["10171ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos10171ui_story = var_20_3.localPosition

				local var_20_4 = GameObjectTools.GetOrAddComponent(var_20_3.gameObject, typeof(DynamicBoneHelper))

				if var_20_4 then
					var_20_4:EnableDynamicBone(false)
				end
			end

			local var_20_5 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_5 then
				var_20_3.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10171ui_story, Vector3.New(0, -0.95, -6.05), (arg_17_1.time_ - 0) / var_20_5)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_5 and arg_17_1.time_ < 0 + var_20_5 + arg_20_0 then
				var_20_3.localPosition = Vector3.New(0, -0.95, -6.05)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles

				local var_20_6 = GameObjectTools.GetOrAddComponent(var_20_3.gameObject, typeof(DynamicBoneHelper))

				if var_20_6 then
					var_20_6:EnableDynamicBone(true)
				end
			end

			local var_20_7 = arg_17_1.actors_["10171ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_7) and arg_17_1.var_.characterEffect10171ui_story == nil then
				arg_17_1.var_.characterEffect10171ui_story = var_20_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_8 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_8 and not isNil(var_20_7) then
				if arg_17_1.var_.characterEffect10171ui_story and not isNil(var_20_7) then
					arg_17_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_8 and arg_17_1.time_ < 0 + var_20_8 + arg_20_0 and not isNil(var_20_7) and arg_17_1.var_.characterEffect10171ui_story then
				arg_17_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action30_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_20_10 = 0
			local var_20_11 = 0.65

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_12 = arg_17_1:GetWordFromCfg(323082004)
				local var_20_13 = arg_17_1:FormatText(var_20_12.content)

				arg_17_1.text_.text = var_20_13

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_15 = 26 <= 0 and var_20_11 or var_20_11 * (utf8.len(var_20_13) / 26)

				if (26 <= 0 and var_20_11 or var_20_11 * (utf8.len(var_20_13) / 26)) > 0 and var_20_11 < var_20_15 then
					arg_17_1.talkMaxDuration = var_20_15

					if var_20_15 + var_20_10 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_15 + var_20_10
					end
				end

				arg_17_1.text_.text = var_20_13
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082004", "story_v_out_323082.awb") ~= 0 then
					local var_20_16 = manager.audio:GetVoiceLength("story_v_out_323082", "323082004", "story_v_out_323082.awb") / 1000

					if var_20_16 + var_20_10 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_16 + var_20_10
					end

					if var_20_12.prefab_name ~= "" and arg_17_1.actors_[var_20_12.prefab_name] ~= nil then
						local var_20_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_12.prefab_name].transform, "story_v_out_323082", "323082004", "story_v_out_323082.awb")

						arg_17_1:RecordAudio("323082004", var_20_17)
						arg_17_1:RecordAudio("323082004", var_20_17)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_323082", "323082004", "story_v_out_323082.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_323082", "323082004", "story_v_out_323082.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_18 = math.max(var_20_11, arg_17_1.talkMaxDuration)

			if var_20_10 <= arg_17_1.time_ and arg_17_1.time_ < var_20_10 + var_20_18 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_10) / var_20_18

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_10 + var_20_18 and arg_17_1.time_ < var_20_10 + var_20_18 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
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
	Play323082005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 323082005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play323082006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["10171ui_story"]) and arg_21_1.var_.characterEffect10171ui_story == nil then
				arg_21_1.var_.characterEffect10171ui_story = arg_21_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["10171ui_story"]) then
				if arg_21_1.var_.characterEffect10171ui_story and not isNil(arg_21_1.actors_["10171ui_story"]) then
					arg_21_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_21_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_0)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["10171ui_story"]) and arg_21_1.var_.characterEffect10171ui_story then
				arg_21_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_21_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_24_1 = 0
			local var_24_2 = 0.95

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(323082005).content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 38 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 38)

				if (38 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 38)) > 0 and var_24_2 < var_24_5 then
					arg_21_1.talkMaxDuration = var_24_5

					if var_24_5 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + var_24_1
					end
				end

				arg_21_1.text_.text = var_24_3
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_6 = math.max(var_24_2, arg_21_1.talkMaxDuration)

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_6 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_1) / var_24_6

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_1 + var_24_6 and arg_21_1.time_ < var_24_1 + var_24_6 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play323082006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 323082006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play323082007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 1

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_1 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(323082006).content)

				arg_25_1.text_.text = var_28_1

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_3 = 40 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 40)

				if (40 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 40)) > 0 and var_28_0 < var_28_3 then
					arg_25_1.talkMaxDuration = var_28_3

					if var_28_3 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_3 + 0
					end
				end

				arg_25_1.text_.text = var_28_1
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_4 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_4

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play323082007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 323082007
		arg_29_1.duration_ = 2.47

		local var_29_0 = {
			zh = 1.9,
			ja = 2.466
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play323082008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["10171ui_story"]) and arg_29_1.var_.characterEffect10171ui_story == nil then
				arg_29_1.var_.characterEffect10171ui_story = arg_29_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["10171ui_story"]) then
				if arg_29_1.var_.characterEffect10171ui_story and not isNil(arg_29_1.actors_["10171ui_story"]) then
					arg_29_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["10171ui_story"]) and arg_29_1.var_.characterEffect10171ui_story then
				arg_29_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_32_2 = 0
			local var_32_3 = 0.2

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_2 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_4 = arg_29_1:GetWordFromCfg(323082007)
				local var_32_5 = arg_29_1:FormatText(var_32_4.content)

				arg_29_1.text_.text = var_32_5

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_7 = 8 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 8)

				if (8 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 8)) > 0 and var_32_3 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_2
					end
				end

				arg_29_1.text_.text = var_32_5
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082007", "story_v_out_323082.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_323082", "323082007", "story_v_out_323082.awb") / 1000

					if var_32_8 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_2
					end

					if var_32_4.prefab_name ~= "" and arg_29_1.actors_[var_32_4.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_4.prefab_name].transform, "story_v_out_323082", "323082007", "story_v_out_323082.awb")

						arg_29_1:RecordAudio("323082007", var_32_9)
						arg_29_1:RecordAudio("323082007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_323082", "323082007", "story_v_out_323082.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_323082", "323082007", "story_v_out_323082.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_3, arg_29_1.talkMaxDuration)

			if var_32_2 <= arg_29_1.time_ and arg_29_1.time_ < var_32_2 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_2) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_2 + var_32_10 and arg_29_1.time_ < var_32_2 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play323082008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 323082008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play323082009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["10171ui_story"]) and arg_33_1.var_.characterEffect10171ui_story == nil then
				arg_33_1.var_.characterEffect10171ui_story = arg_33_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["10171ui_story"]) then
				if arg_33_1.var_.characterEffect10171ui_story and not isNil(arg_33_1.actors_["10171ui_story"]) then
					arg_33_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_33_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["10171ui_story"]) and arg_33_1.var_.characterEffect10171ui_story then
				arg_33_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_33_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_36_1 = 0
			local var_36_2 = 0.5

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(323082008).content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 20 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 20)

				if (20 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 20)) > 0 and var_36_2 < var_36_5 then
					arg_33_1.talkMaxDuration = var_36_5

					if var_36_5 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + var_36_1
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_6 = math.max(var_36_2, arg_33_1.talkMaxDuration)

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_6 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_1) / var_36_6

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_1 + var_36_6 and arg_33_1.time_ < var_36_1 + var_36_6 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play323082009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 323082009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play323082010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.675

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_1 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(323082009).content)

				arg_37_1.text_.text = var_40_1

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_3 = 27 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 27)

				if (27 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 27)) > 0 and var_40_0 < var_40_3 then
					arg_37_1.talkMaxDuration = var_40_3

					if var_40_3 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_3 + 0
					end
				end

				arg_37_1.text_.text = var_40_1
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_4 = math.max(var_40_0, arg_37_1.talkMaxDuration)

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - 0) / var_40_4

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play323082010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 323082010
		arg_41_1.duration_ = 5.83

		local var_41_0 = {
			zh = 4.633,
			ja = 5.833
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play323082011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["10171ui_story"]) and arg_41_1.var_.characterEffect10171ui_story == nil then
				arg_41_1.var_.characterEffect10171ui_story = arg_41_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["10171ui_story"]) then
				if arg_41_1.var_.characterEffect10171ui_story and not isNil(arg_41_1.actors_["10171ui_story"]) then
					arg_41_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["10171ui_story"]) and arg_41_1.var_.characterEffect10171ui_story then
				arg_41_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action30_2")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_44_2 = 0
			local var_44_3 = 0.65

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_2 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_4 = arg_41_1:GetWordFromCfg(323082010)
				local var_44_5 = arg_41_1:FormatText(var_44_4.content)

				arg_41_1.text_.text = var_44_5

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_7 = 26 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 26)

				if (26 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 26)) > 0 and var_44_3 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_2
					end
				end

				arg_41_1.text_.text = var_44_5
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082010", "story_v_out_323082.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_323082", "323082010", "story_v_out_323082.awb") / 1000

					if var_44_8 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_2
					end

					if var_44_4.prefab_name ~= "" and arg_41_1.actors_[var_44_4.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_4.prefab_name].transform, "story_v_out_323082", "323082010", "story_v_out_323082.awb")

						arg_41_1:RecordAudio("323082010", var_44_9)
						arg_41_1:RecordAudio("323082010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_323082", "323082010", "story_v_out_323082.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_323082", "323082010", "story_v_out_323082.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_10 = math.max(var_44_3, arg_41_1.talkMaxDuration)

			if var_44_2 <= arg_41_1.time_ and arg_41_1.time_ < var_44_2 + var_44_10 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_2) / var_44_10

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_2 + var_44_10 and arg_41_1.time_ < var_44_2 + var_44_10 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play323082011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 323082011
		arg_45_1.duration_ = 2.63

		local var_45_0 = {
			zh = 1.233,
			ja = 2.633
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
				arg_45_0:Play323082012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if arg_45_1.actors_["1070ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1070ui_story"))) then
				local var_48_0 = Object.Instantiate(Asset.Load("Char/" .. "1070ui_story"), arg_45_1.stage_.transform)

				var_48_0.name = "1070ui_story"
				var_48_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_45_1.actors_["1070ui_story"] = var_48_0

				local var_48_1 = var_48_0:GetComponentInChildren(typeof(CharacterEffect))

				var_48_1.enabled = true

				local var_48_2 = GameObjectTools.GetOrAddComponent(var_48_0, typeof(DynamicBoneHelper))

				if var_48_2 then
					var_48_2:EnableDynamicBone(false)
				end

				arg_45_1:ShowWeapon(var_48_1.transform, false)

				arg_45_1.var_["1070ui_story" .. "Animator"] = var_48_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_45_1.var_["1070ui_story" .. "Animator"].applyRootMotion = true
				arg_45_1.var_["1070ui_story" .. "LipSync"] = var_48_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_48_3 = arg_45_1.actors_["1070ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_3) and arg_45_1.var_.characterEffect1070ui_story == nil then
				arg_45_1.var_.characterEffect1070ui_story = var_48_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_4 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_4 and not isNil(var_48_3) then
				if arg_45_1.var_.characterEffect1070ui_story and not isNil(var_48_3) then
					arg_45_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_4 and arg_45_1.time_ < 0 + var_48_4 + arg_48_0 and not isNil(var_48_3) and arg_45_1.var_.characterEffect1070ui_story then
				arg_45_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_48_6 = arg_45_1.actors_["10171ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_6) and arg_45_1.var_.characterEffect10171ui_story == nil then
				arg_45_1.var_.characterEffect10171ui_story = var_48_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_7 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_7 and not isNil(var_48_6) then
				if arg_45_1.var_.characterEffect10171ui_story and not isNil(var_48_6) then
					arg_45_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_45_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_7)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_7 and arg_45_1.time_ < 0 + var_48_7 + arg_48_0 and not isNil(var_48_6) and arg_45_1.var_.characterEffect10171ui_story then
				arg_45_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_45_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_48_8 = 0
			local var_48_9 = 0.1

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_8 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070_split_1")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_10 = arg_45_1:GetWordFromCfg(323082011)
				local var_48_11 = arg_45_1:FormatText(var_48_10.content)

				arg_45_1.text_.text = var_48_11

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_13 = 4 <= 0 and var_48_9 or var_48_9 * (utf8.len(var_48_11) / 4)

				if (4 <= 0 and var_48_9 or var_48_9 * (utf8.len(var_48_11) / 4)) > 0 and var_48_9 < var_48_13 then
					arg_45_1.talkMaxDuration = var_48_13

					if var_48_13 + var_48_8 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_13 + var_48_8
					end
				end

				arg_45_1.text_.text = var_48_11
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082011", "story_v_out_323082.awb") ~= 0 then
					local var_48_14 = manager.audio:GetVoiceLength("story_v_out_323082", "323082011", "story_v_out_323082.awb") / 1000

					if var_48_14 + var_48_8 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_14 + var_48_8
					end

					if var_48_10.prefab_name ~= "" and arg_45_1.actors_[var_48_10.prefab_name] ~= nil then
						local var_48_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_10.prefab_name].transform, "story_v_out_323082", "323082011", "story_v_out_323082.awb")

						arg_45_1:RecordAudio("323082011", var_48_15)
						arg_45_1:RecordAudio("323082011", var_48_15)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_323082", "323082011", "story_v_out_323082.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_323082", "323082011", "story_v_out_323082.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_16 = math.max(var_48_9, arg_45_1.talkMaxDuration)

			if var_48_8 <= arg_45_1.time_ and arg_45_1.time_ < var_48_8 + var_48_16 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_8) / var_48_16

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_8 + var_48_16 and arg_45_1.time_ < var_48_8 + var_48_16 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play323082012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 323082012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play323082013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1070ui_story"]) and arg_49_1.var_.characterEffect1070ui_story == nil then
				arg_49_1.var_.characterEffect1070ui_story = arg_49_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1070ui_story"]) then
				if arg_49_1.var_.characterEffect1070ui_story and not isNil(arg_49_1.actors_["1070ui_story"]) then
					arg_49_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_0)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1070ui_story"]) and arg_49_1.var_.characterEffect1070ui_story then
				arg_49_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_52_1 = 0
			local var_52_2 = 1.35

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_3 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(323082012).content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 54 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 54)

				if (54 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 54)) > 0 and var_52_2 < var_52_5 then
					arg_49_1.talkMaxDuration = var_52_5

					if var_52_5 + var_52_1 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + var_52_1
					end
				end

				arg_49_1.text_.text = var_52_3
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_6 = math.max(var_52_2, arg_49_1.talkMaxDuration)

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_6 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_1) / var_52_6

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_1 + var_52_6 and arg_49_1.time_ < var_52_1 + var_52_6 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play323082013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 323082013
		arg_53_1.duration_ = 4.53

		local var_53_0 = {
			zh = 2.2,
			ja = 4.533
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play323082014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1070ui_story"]) and arg_53_1.var_.characterEffect1070ui_story == nil then
				arg_53_1.var_.characterEffect1070ui_story = arg_53_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["1070ui_story"]) then
				if arg_53_1.var_.characterEffect1070ui_story and not isNil(arg_53_1.actors_["1070ui_story"]) then
					arg_53_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["1070ui_story"]) and arg_53_1.var_.characterEffect1070ui_story then
				arg_53_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_56_2 = 0
			local var_56_3 = 0.3

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_2 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_4 = arg_53_1:GetWordFromCfg(323082013)
				local var_56_5 = arg_53_1:FormatText(var_56_4.content)

				arg_53_1.text_.text = var_56_5

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_7 = 12 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 12)

				if (12 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 12)) > 0 and var_56_3 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_2
					end
				end

				arg_53_1.text_.text = var_56_5
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082013", "story_v_out_323082.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_323082", "323082013", "story_v_out_323082.awb") / 1000

					if var_56_8 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_2
					end

					if var_56_4.prefab_name ~= "" and arg_53_1.actors_[var_56_4.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_4.prefab_name].transform, "story_v_out_323082", "323082013", "story_v_out_323082.awb")

						arg_53_1:RecordAudio("323082013", var_56_9)
						arg_53_1:RecordAudio("323082013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_323082", "323082013", "story_v_out_323082.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_323082", "323082013", "story_v_out_323082.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = math.max(var_56_3, arg_53_1.talkMaxDuration)

			if var_56_2 <= arg_53_1.time_ and arg_53_1.time_ < var_56_2 + var_56_10 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_2) / var_56_10

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_2 + var_56_10 and arg_53_1.time_ < var_56_2 + var_56_10 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play323082014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 323082014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play323082015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos10171ui_story = arg_57_1.actors_["10171ui_story"].transform.localPosition

				local var_60_0 = GameObjectTools.GetOrAddComponent(arg_57_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_60_0 then
					var_60_0:EnableDynamicBone(false)
				end
			end

			local var_60_1 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_1 then
				arg_57_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_57_1.time_ - 0) / var_60_1)
				arg_57_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10171ui_story"].transform.position).z)
				arg_57_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["10171ui_story"].transform.localEulerAngles = arg_57_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_1 and arg_57_1.time_ < 0 + var_60_1 + arg_60_0 then
				arg_57_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_57_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10171ui_story"].transform.position).z)
				arg_57_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["10171ui_story"].transform.localEulerAngles = arg_57_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_60_2 = GameObjectTools.GetOrAddComponent(arg_57_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_60_2 then
					var_60_2:EnableDynamicBone(true)
				end
			end

			local var_60_3 = arg_57_1.actors_["1070ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_3) and arg_57_1.var_.characterEffect1070ui_story == nil then
				arg_57_1.var_.characterEffect1070ui_story = var_60_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_4 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_4 and not isNil(var_60_3) then
				if arg_57_1.var_.characterEffect1070ui_story and not isNil(var_60_3) then
					arg_57_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_4)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_4 and arg_57_1.time_ < 0 + var_60_4 + arg_60_0 and not isNil(var_60_3) and arg_57_1.var_.characterEffect1070ui_story then
				arg_57_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_60_5 = 0
			local var_60_6 = 1.675

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_5 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_7 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(323082014).content)

				arg_57_1.text_.text = var_60_7

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 67 <= 0 and var_60_6 or var_60_6 * (utf8.len(var_60_7) / 67)

				if (67 <= 0 and var_60_6 or var_60_6 * (utf8.len(var_60_7) / 67)) > 0 and var_60_6 < var_60_9 then
					arg_57_1.talkMaxDuration = var_60_9

					if var_60_9 + var_60_5 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_5
					end
				end

				arg_57_1.text_.text = var_60_7
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_10 = math.max(var_60_6, arg_57_1.talkMaxDuration)

			if var_60_5 <= arg_57_1.time_ and arg_57_1.time_ < var_60_5 + var_60_10 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_5) / var_60_10

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_5 + var_60_10 and arg_57_1.time_ < var_60_5 + var_60_10 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play323082015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 323082015
		arg_61_1.duration_ = 2

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play323082016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos10171ui_story = arg_61_1.actors_["10171ui_story"].transform.localPosition

				local var_64_0 = GameObjectTools.GetOrAddComponent(arg_61_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_64_0 then
					var_64_0:EnableDynamicBone(false)
				end
			end

			local var_64_1 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_1 then
				arg_61_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10171ui_story, Vector3.New(0, -0.95, -6.05), (arg_61_1.time_ - 0) / var_64_1)
				arg_61_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10171ui_story"].transform.position).z)
				arg_61_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["10171ui_story"].transform.localEulerAngles = arg_61_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_1 and arg_61_1.time_ < 0 + var_64_1 + arg_64_0 then
				arg_61_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_61_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10171ui_story"].transform.position).z)
				arg_61_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["10171ui_story"].transform.localEulerAngles = arg_61_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_64_2 = GameObjectTools.GetOrAddComponent(arg_61_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_64_2 then
					var_64_2:EnableDynamicBone(true)
				end
			end

			local var_64_3 = arg_61_1.actors_["10171ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_3) and arg_61_1.var_.characterEffect10171ui_story == nil then
				arg_61_1.var_.characterEffect10171ui_story = var_64_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_4 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 and not isNil(var_64_3) then
				if arg_61_1.var_.characterEffect10171ui_story and not isNil(var_64_3) then
					arg_61_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 and not isNil(var_64_3) and arg_61_1.var_.characterEffect10171ui_story then
				arg_61_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_64_6 = 0
			local var_64_7 = 0.075

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_8 = arg_61_1:GetWordFromCfg(323082015)
				local var_64_9 = arg_61_1:FormatText(var_64_8.content)

				arg_61_1.text_.text = var_64_9

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_11 = 3 <= 0 and var_64_7 or var_64_7 * (utf8.len(var_64_9) / 3)

				if (3 <= 0 and var_64_7 or var_64_7 * (utf8.len(var_64_9) / 3)) > 0 and var_64_7 < var_64_11 then
					arg_61_1.talkMaxDuration = var_64_11

					if var_64_11 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_11 + var_64_6
					end
				end

				arg_61_1.text_.text = var_64_9
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082015", "story_v_out_323082.awb") ~= 0 then
					local var_64_12 = manager.audio:GetVoiceLength("story_v_out_323082", "323082015", "story_v_out_323082.awb") / 1000

					if var_64_12 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_12 + var_64_6
					end

					if var_64_8.prefab_name ~= "" and arg_61_1.actors_[var_64_8.prefab_name] ~= nil then
						local var_64_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_8.prefab_name].transform, "story_v_out_323082", "323082015", "story_v_out_323082.awb")

						arg_61_1:RecordAudio("323082015", var_64_13)
						arg_61_1:RecordAudio("323082015", var_64_13)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_323082", "323082015", "story_v_out_323082.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_323082", "323082015", "story_v_out_323082.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_14 = math.max(var_64_7, arg_61_1.talkMaxDuration)

			if var_64_6 <= arg_61_1.time_ and arg_61_1.time_ < var_64_6 + var_64_14 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_6) / var_64_14

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_6 + var_64_14 and arg_61_1.time_ < var_64_6 + var_64_14 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play323082016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 323082016
		arg_65_1.duration_ = 6.03

		local var_65_0 = {
			zh = 4.033,
			ja = 6.033
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play323082017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["10171ui_story"]) and arg_65_1.var_.characterEffect10171ui_story == nil then
				arg_65_1.var_.characterEffect10171ui_story = arg_65_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["10171ui_story"]) then
				if arg_65_1.var_.characterEffect10171ui_story and not isNil(arg_65_1.actors_["10171ui_story"]) then
					arg_65_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_65_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_0)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["10171ui_story"]) and arg_65_1.var_.characterEffect10171ui_story then
				arg_65_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_65_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_68_1 = 0
			local var_68_2 = 0.425

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[1452].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_3 = arg_65_1:GetWordFromCfg(323082016)
				local var_68_4 = arg_65_1:FormatText(var_68_3.content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_6 = 17 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_4) / 17)

				if (17 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_4) / 17)) > 0 and var_68_2 < var_68_6 then
					arg_65_1.talkMaxDuration = var_68_6

					if var_68_6 + var_68_1 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_6 + var_68_1
					end
				end

				arg_65_1.text_.text = var_68_4
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082016", "story_v_out_323082.awb") ~= 0 then
					local var_68_7 = manager.audio:GetVoiceLength("story_v_out_323082", "323082016", "story_v_out_323082.awb") / 1000

					if var_68_7 + var_68_1 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_7 + var_68_1
					end

					if var_68_3.prefab_name ~= "" and arg_65_1.actors_[var_68_3.prefab_name] ~= nil then
						local var_68_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_3.prefab_name].transform, "story_v_out_323082", "323082016", "story_v_out_323082.awb")

						arg_65_1:RecordAudio("323082016", var_68_8)
						arg_65_1:RecordAudio("323082016", var_68_8)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_323082", "323082016", "story_v_out_323082.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_323082", "323082016", "story_v_out_323082.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_9 = math.max(var_68_2, arg_65_1.talkMaxDuration)

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_9 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_1) / var_68_9

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_1 + var_68_9 and arg_65_1.time_ < var_68_1 + var_68_9 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play323082017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 323082017
		arg_69_1.duration_ = 6.93

		local var_69_0 = {
			zh = 6.933,
			ja = 6.133
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play323082018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["10171ui_story"]) and arg_69_1.var_.characterEffect10171ui_story == nil then
				arg_69_1.var_.characterEffect10171ui_story = arg_69_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["10171ui_story"]) then
				if arg_69_1.var_.characterEffect10171ui_story and not isNil(arg_69_1.actors_["10171ui_story"]) then
					arg_69_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["10171ui_story"]) and arg_69_1.var_.characterEffect10171ui_story then
				arg_69_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action34_1")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_72_2 = 0
			local var_72_3 = 0.875

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_2 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_4 = arg_69_1:GetWordFromCfg(323082017)
				local var_72_5 = arg_69_1:FormatText(var_72_4.content)

				arg_69_1.text_.text = var_72_5

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_7 = 35 <= 0 and var_72_3 or var_72_3 * (utf8.len(var_72_5) / 35)

				if (35 <= 0 and var_72_3 or var_72_3 * (utf8.len(var_72_5) / 35)) > 0 and var_72_3 < var_72_7 then
					arg_69_1.talkMaxDuration = var_72_7

					if var_72_7 + var_72_2 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_2
					end
				end

				arg_69_1.text_.text = var_72_5
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082017", "story_v_out_323082.awb") ~= 0 then
					local var_72_8 = manager.audio:GetVoiceLength("story_v_out_323082", "323082017", "story_v_out_323082.awb") / 1000

					if var_72_8 + var_72_2 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_2
					end

					if var_72_4.prefab_name ~= "" and arg_69_1.actors_[var_72_4.prefab_name] ~= nil then
						local var_72_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_4.prefab_name].transform, "story_v_out_323082", "323082017", "story_v_out_323082.awb")

						arg_69_1:RecordAudio("323082017", var_72_9)
						arg_69_1:RecordAudio("323082017", var_72_9)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_323082", "323082017", "story_v_out_323082.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_323082", "323082017", "story_v_out_323082.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_10 = math.max(var_72_3, arg_69_1.talkMaxDuration)

			if var_72_2 <= arg_69_1.time_ and arg_69_1.time_ < var_72_2 + var_72_10 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_2) / var_72_10

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_2 + var_72_10 and arg_69_1.time_ < var_72_2 + var_72_10 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play323082018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 323082018
		arg_73_1.duration_ = 5.23

		local var_73_0 = {
			zh = 3.1,
			ja = 5.233
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play323082019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0.425

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_1 = arg_73_1:GetWordFromCfg(323082018)
				local var_76_2 = arg_73_1:FormatText(var_76_1.content)

				arg_73_1.text_.text = var_76_2

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_4 = 17 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 17)

				if (17 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 17)) > 0 and var_76_0 < var_76_4 then
					arg_73_1.talkMaxDuration = var_76_4

					if var_76_4 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_4 + 0
					end
				end

				arg_73_1.text_.text = var_76_2
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082018", "story_v_out_323082.awb") ~= 0 then
					local var_76_5 = manager.audio:GetVoiceLength("story_v_out_323082", "323082018", "story_v_out_323082.awb") / 1000

					if var_76_5 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + 0
					end

					if var_76_1.prefab_name ~= "" and arg_73_1.actors_[var_76_1.prefab_name] ~= nil then
						local var_76_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_1.prefab_name].transform, "story_v_out_323082", "323082018", "story_v_out_323082.awb")

						arg_73_1:RecordAudio("323082018", var_76_6)
						arg_73_1:RecordAudio("323082018", var_76_6)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_323082", "323082018", "story_v_out_323082.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_323082", "323082018", "story_v_out_323082.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_7 = math.max(var_76_0, arg_73_1.talkMaxDuration)

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_7 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - 0) / var_76_7

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= 0 + var_76_7 and arg_73_1.time_ < 0 + var_76_7 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play323082019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 323082019
		arg_77_1.duration_ = 7.33

		local var_77_0 = {
			zh = 6.366,
			ja = 7.333
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play323082020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1070ui_story = arg_77_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_80_0 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 then
				arg_77_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_77_1.time_ - 0) / var_80_0)
				arg_77_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1070ui_story"].transform.position).z)
				arg_77_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1070ui_story"].transform.localEulerAngles = arg_77_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 then
				arg_77_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_77_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1070ui_story"].transform.position).z)
				arg_77_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1070ui_story"].transform.localEulerAngles = arg_77_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_80_1 = arg_77_1.actors_["10171ui_story"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos10171ui_story = var_80_1.localPosition

				local var_80_2 = GameObjectTools.GetOrAddComponent(var_80_1.gameObject, typeof(DynamicBoneHelper))

				if var_80_2 then
					var_80_2:EnableDynamicBone(false)
				end
			end

			local var_80_3 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_3 then
				var_80_1.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_77_1.time_ - 0) / var_80_3)
				var_80_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_1.position).x, (manager.ui.mainCamera.transform.position - var_80_1.position).y, (manager.ui.mainCamera.transform.position - var_80_1.position).z)
				var_80_1.localEulerAngles.z = 0
				var_80_1.localEulerAngles.x = 0
				var_80_1.localEulerAngles = var_80_1.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_3 and arg_77_1.time_ < 0 + var_80_3 + arg_80_0 then
				var_80_1.localPosition = Vector3.New(0, 100, 0)
				var_80_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_1.position).x, (manager.ui.mainCamera.transform.position - var_80_1.position).y, (manager.ui.mainCamera.transform.position - var_80_1.position).z)
				var_80_1.localEulerAngles.z = 0
				var_80_1.localEulerAngles.x = 0
				var_80_1.localEulerAngles = var_80_1.localEulerAngles

				local var_80_4 = GameObjectTools.GetOrAddComponent(var_80_1.gameObject, typeof(DynamicBoneHelper))

				if var_80_4 then
					var_80_4:EnableDynamicBone(true)
				end
			end

			local var_80_5 = arg_77_1.actors_["1070ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_5) and arg_77_1.var_.characterEffect1070ui_story == nil then
				arg_77_1.var_.characterEffect1070ui_story = var_80_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_6 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_6 and not isNil(var_80_5) then
				if arg_77_1.var_.characterEffect1070ui_story and not isNil(var_80_5) then
					arg_77_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_6 and arg_77_1.time_ < 0 + var_80_6 + arg_80_0 and not isNil(var_80_5) and arg_77_1.var_.characterEffect1070ui_story then
				arg_77_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_80_8 = arg_77_1.actors_["10171ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_8) and arg_77_1.var_.characterEffect10171ui_story == nil then
				arg_77_1.var_.characterEffect10171ui_story = var_80_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_9 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_9 and not isNil(var_80_8) then
				if arg_77_1.var_.characterEffect10171ui_story and not isNil(var_80_8) then
					arg_77_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_77_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_9)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_9 and arg_77_1.time_ < 0 + var_80_9 + arg_80_0 and not isNil(var_80_8) and arg_77_1.var_.characterEffect10171ui_story then
				arg_77_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_77_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action2_1")
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_80_10 = 0
			local var_80_11 = 0.65

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_10 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_12 = arg_77_1:GetWordFromCfg(323082019)
				local var_80_13 = arg_77_1:FormatText(var_80_12.content)

				arg_77_1.text_.text = var_80_13

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_15 = 26 <= 0 and var_80_11 or var_80_11 * (utf8.len(var_80_13) / 26)

				if (26 <= 0 and var_80_11 or var_80_11 * (utf8.len(var_80_13) / 26)) > 0 and var_80_11 < var_80_15 then
					arg_77_1.talkMaxDuration = var_80_15

					if var_80_15 + var_80_10 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_15 + var_80_10
					end
				end

				arg_77_1.text_.text = var_80_13
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082019", "story_v_out_323082.awb") ~= 0 then
					local var_80_16 = manager.audio:GetVoiceLength("story_v_out_323082", "323082019", "story_v_out_323082.awb") / 1000

					if var_80_16 + var_80_10 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_16 + var_80_10
					end

					if var_80_12.prefab_name ~= "" and arg_77_1.actors_[var_80_12.prefab_name] ~= nil then
						local var_80_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_12.prefab_name].transform, "story_v_out_323082", "323082019", "story_v_out_323082.awb")

						arg_77_1:RecordAudio("323082019", var_80_17)
						arg_77_1:RecordAudio("323082019", var_80_17)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_323082", "323082019", "story_v_out_323082.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_323082", "323082019", "story_v_out_323082.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_18 = math.max(var_80_11, arg_77_1.talkMaxDuration)

			if var_80_10 <= arg_77_1.time_ and arg_77_1.time_ < var_80_10 + var_80_18 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_10) / var_80_18

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_10 + var_80_18 and arg_77_1.time_ < var_80_10 + var_80_18 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play323082020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 323082020
		arg_81_1.duration_ = 2.77

		local var_81_0 = {
			zh = 2.066,
			ja = 2.766
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play323082021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1070ui_story"]) and arg_81_1.var_.characterEffect1070ui_story == nil then
				arg_81_1.var_.characterEffect1070ui_story = arg_81_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1070ui_story"]) then
				if arg_81_1.var_.characterEffect1070ui_story and not isNil(arg_81_1.actors_["1070ui_story"]) then
					arg_81_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_0)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1070ui_story"]) and arg_81_1.var_.characterEffect1070ui_story then
				arg_81_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_84_1 = 0
			local var_84_2 = 0.2

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[1452].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_3 = arg_81_1:GetWordFromCfg(323082020)
				local var_84_4 = arg_81_1:FormatText(var_84_3.content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_6 = 8 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_4) / 8)

				if (8 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_4) / 8)) > 0 and var_84_2 < var_84_6 then
					arg_81_1.talkMaxDuration = var_84_6

					if var_84_6 + var_84_1 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_6 + var_84_1
					end
				end

				arg_81_1.text_.text = var_84_4
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082020", "story_v_out_323082.awb") ~= 0 then
					local var_84_7 = manager.audio:GetVoiceLength("story_v_out_323082", "323082020", "story_v_out_323082.awb") / 1000

					if var_84_7 + var_84_1 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_1
					end

					if var_84_3.prefab_name ~= "" and arg_81_1.actors_[var_84_3.prefab_name] ~= nil then
						local var_84_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_3.prefab_name].transform, "story_v_out_323082", "323082020", "story_v_out_323082.awb")

						arg_81_1:RecordAudio("323082020", var_84_8)
						arg_81_1:RecordAudio("323082020", var_84_8)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_323082", "323082020", "story_v_out_323082.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_323082", "323082020", "story_v_out_323082.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_9 = math.max(var_84_2, arg_81_1.talkMaxDuration)

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_9 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_1) / var_84_9

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_1 + var_84_9 and arg_81_1.time_ < var_84_1 + var_84_9 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play323082021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 323082021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play323082022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.7

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_1 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(323082021).content)

				arg_85_1.text_.text = var_88_1

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_3 = 28 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 28)

				if (28 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 28)) > 0 and var_88_0 < var_88_3 then
					arg_85_1.talkMaxDuration = var_88_3

					if var_88_3 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_3 + 0
					end
				end

				arg_85_1.text_.text = var_88_1
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_4 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_4 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_4

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_4 and arg_85_1.time_ < 0 + var_88_4 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play323082022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 323082022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play323082023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1070ui_story = arg_89_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1070ui_story"].transform.position).z)
				arg_89_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1070ui_story"].transform.localEulerAngles = arg_89_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_89_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1070ui_story"].transform.position).z)
				arg_89_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1070ui_story"].transform.localEulerAngles = arg_89_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if 0.733333333333333 < arg_89_1.time_ and arg_89_1.time_ <= 0.733333333333333 + arg_92_0 then
				arg_89_1:AudioAction("play", "effect", "se_story_148", "se_story_148_foley_gun_drop", "")
			end

			local var_92_2 = 0
			local var_92_3 = 1.15

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_2 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_4 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(323082022).content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_6 = 46 <= 0 and var_92_3 or var_92_3 * (utf8.len(var_92_4) / 46)

				if (46 <= 0 and var_92_3 or var_92_3 * (utf8.len(var_92_4) / 46)) > 0 and var_92_3 < var_92_6 then
					arg_89_1.talkMaxDuration = var_92_6

					if var_92_6 + var_92_2 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_6 + var_92_2
					end
				end

				arg_89_1.text_.text = var_92_4
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_7 = math.max(var_92_3, arg_89_1.talkMaxDuration)

			if var_92_2 <= arg_89_1.time_ and arg_89_1.time_ < var_92_2 + var_92_7 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_2) / var_92_7

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_2 + var_92_7 and arg_89_1.time_ < var_92_2 + var_92_7 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play323082023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 323082023
		arg_93_1.duration_ = 8.47

		local var_93_0 = {
			zh = 7.4,
			ja = 8.466
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play323082024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.775

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[1452].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_1 = arg_93_1:GetWordFromCfg(323082023)
				local var_96_2 = arg_93_1:FormatText(var_96_1.content)

				arg_93_1.text_.text = var_96_2

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 31 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 31)

				if (31 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 31)) > 0 and var_96_0 < var_96_4 then
					arg_93_1.talkMaxDuration = var_96_4

					if var_96_4 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_4 + 0
					end
				end

				arg_93_1.text_.text = var_96_2
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082023", "story_v_out_323082.awb") ~= 0 then
					local var_96_5 = manager.audio:GetVoiceLength("story_v_out_323082", "323082023", "story_v_out_323082.awb") / 1000

					if var_96_5 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + 0
					end

					if var_96_1.prefab_name ~= "" and arg_93_1.actors_[var_96_1.prefab_name] ~= nil then
						local var_96_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_1.prefab_name].transform, "story_v_out_323082", "323082023", "story_v_out_323082.awb")

						arg_93_1:RecordAudio("323082023", var_96_6)
						arg_93_1:RecordAudio("323082023", var_96_6)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_323082", "323082023", "story_v_out_323082.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_323082", "323082023", "story_v_out_323082.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_7 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_7 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_7

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_7 and arg_93_1.time_ < 0 + var_96_7 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play323082024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 323082024
		arg_97_1.duration_ = 5.97

		local var_97_0 = {
			zh = 4.666,
			ja = 5.966
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play323082025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10171ui_story = arg_97_1.actors_["10171ui_story"].transform.localPosition

				local var_100_0 = GameObjectTools.GetOrAddComponent(arg_97_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_100_0 then
					var_100_0:EnableDynamicBone(false)
				end
			end

			local var_100_1 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_1 then
				arg_97_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10171ui_story, Vector3.New(0, -0.95, -6.05), (arg_97_1.time_ - 0) / var_100_1)
				arg_97_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10171ui_story"].transform.position).z)
				arg_97_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["10171ui_story"].transform.localEulerAngles = arg_97_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_1 and arg_97_1.time_ < 0 + var_100_1 + arg_100_0 then
				arg_97_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_97_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10171ui_story"].transform.position).z)
				arg_97_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["10171ui_story"].transform.localEulerAngles = arg_97_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_100_2 = GameObjectTools.GetOrAddComponent(arg_97_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_100_2 then
					var_100_2:EnableDynamicBone(true)
				end
			end

			local var_100_3 = arg_97_1.actors_["10171ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_3) and arg_97_1.var_.characterEffect10171ui_story == nil then
				arg_97_1.var_.characterEffect10171ui_story = var_100_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_4 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 and not isNil(var_100_3) then
				if arg_97_1.var_.characterEffect10171ui_story and not isNil(var_100_3) then
					arg_97_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 and not isNil(var_100_3) and arg_97_1.var_.characterEffect10171ui_story then
				arg_97_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action34_2")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_100_6 = 0
			local var_100_7 = 0.65

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_6 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_8 = arg_97_1:GetWordFromCfg(323082024)
				local var_100_9 = arg_97_1:FormatText(var_100_8.content)

				arg_97_1.text_.text = var_100_9

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_11 = 26 <= 0 and var_100_7 or var_100_7 * (utf8.len(var_100_9) / 26)

				if (26 <= 0 and var_100_7 or var_100_7 * (utf8.len(var_100_9) / 26)) > 0 and var_100_7 < var_100_11 then
					arg_97_1.talkMaxDuration = var_100_11

					if var_100_11 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_11 + var_100_6
					end
				end

				arg_97_1.text_.text = var_100_9
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082024", "story_v_out_323082.awb") ~= 0 then
					local var_100_12 = manager.audio:GetVoiceLength("story_v_out_323082", "323082024", "story_v_out_323082.awb") / 1000

					if var_100_12 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_12 + var_100_6
					end

					if var_100_8.prefab_name ~= "" and arg_97_1.actors_[var_100_8.prefab_name] ~= nil then
						local var_100_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_8.prefab_name].transform, "story_v_out_323082", "323082024", "story_v_out_323082.awb")

						arg_97_1:RecordAudio("323082024", var_100_13)
						arg_97_1:RecordAudio("323082024", var_100_13)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_323082", "323082024", "story_v_out_323082.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_323082", "323082024", "story_v_out_323082.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_14 = math.max(var_100_7, arg_97_1.talkMaxDuration)

			if var_100_6 <= arg_97_1.time_ and arg_97_1.time_ < var_100_6 + var_100_14 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_6) / var_100_14

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_6 + var_100_14 and arg_97_1.time_ < var_100_6 + var_100_14 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play323082025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 323082025
		arg_101_1.duration_ = 2.13

		local var_101_0 = {
			zh = 1.5,
			ja = 2.133
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play323082026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.175

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_1 = arg_101_1:GetWordFromCfg(323082025)
				local var_104_2 = arg_101_1:FormatText(var_104_1.content)

				arg_101_1.text_.text = var_104_2

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 7 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 7)

				if (7 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 7)) > 0 and var_104_0 < var_104_4 then
					arg_101_1.talkMaxDuration = var_104_4

					if var_104_4 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_4 + 0
					end
				end

				arg_101_1.text_.text = var_104_2
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082025", "story_v_out_323082.awb") ~= 0 then
					local var_104_5 = manager.audio:GetVoiceLength("story_v_out_323082", "323082025", "story_v_out_323082.awb") / 1000

					if var_104_5 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + 0
					end

					if var_104_1.prefab_name ~= "" and arg_101_1.actors_[var_104_1.prefab_name] ~= nil then
						local var_104_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_1.prefab_name].transform, "story_v_out_323082", "323082025", "story_v_out_323082.awb")

						arg_101_1:RecordAudio("323082025", var_104_6)
						arg_101_1:RecordAudio("323082025", var_104_6)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_323082", "323082025", "story_v_out_323082.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_323082", "323082025", "story_v_out_323082.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_7 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_7

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play323082026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 323082026
		arg_105_1.duration_ = 9.9

		local var_105_0 = {
			zh = 8.466,
			ja = 9.9
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play323082027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["10171ui_story"]) and arg_105_1.var_.characterEffect10171ui_story == nil then
				arg_105_1.var_.characterEffect10171ui_story = arg_105_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["10171ui_story"]) then
				if arg_105_1.var_.characterEffect10171ui_story and not isNil(arg_105_1.actors_["10171ui_story"]) then
					arg_105_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_105_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_0)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["10171ui_story"]) and arg_105_1.var_.characterEffect10171ui_story then
				arg_105_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_105_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_108_1 = 0
			local var_108_2 = 1.075

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[1452].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_3 = arg_105_1:GetWordFromCfg(323082026)
				local var_108_4 = arg_105_1:FormatText(var_108_3.content)

				arg_105_1.text_.text = var_108_4

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_6 = 43 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_4) / 43)

				if (43 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_4) / 43)) > 0 and var_108_2 < var_108_6 then
					arg_105_1.talkMaxDuration = var_108_6

					if var_108_6 + var_108_1 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_6 + var_108_1
					end
				end

				arg_105_1.text_.text = var_108_4
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082026", "story_v_out_323082.awb") ~= 0 then
					local var_108_7 = manager.audio:GetVoiceLength("story_v_out_323082", "323082026", "story_v_out_323082.awb") / 1000

					if var_108_7 + var_108_1 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_7 + var_108_1
					end

					if var_108_3.prefab_name ~= "" and arg_105_1.actors_[var_108_3.prefab_name] ~= nil then
						local var_108_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_3.prefab_name].transform, "story_v_out_323082", "323082026", "story_v_out_323082.awb")

						arg_105_1:RecordAudio("323082026", var_108_8)
						arg_105_1:RecordAudio("323082026", var_108_8)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_323082", "323082026", "story_v_out_323082.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_323082", "323082026", "story_v_out_323082.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_9 = math.max(var_108_2, arg_105_1.talkMaxDuration)

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_9 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_1) / var_108_9

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_1 + var_108_9 and arg_105_1.time_ < var_108_1 + var_108_9 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play323082027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 323082027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play323082028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos10171ui_story = arg_109_1.actors_["10171ui_story"].transform.localPosition

				local var_112_0 = GameObjectTools.GetOrAddComponent(arg_109_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_112_0 then
					var_112_0:EnableDynamicBone(false)
				end
			end

			local var_112_1 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_1 then
				arg_109_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_109_1.time_ - 0) / var_112_1)
				arg_109_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["10171ui_story"].transform.position).z)
				arg_109_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["10171ui_story"].transform.localEulerAngles = arg_109_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_1 and arg_109_1.time_ < 0 + var_112_1 + arg_112_0 then
				arg_109_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_109_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["10171ui_story"].transform.position).z)
				arg_109_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["10171ui_story"].transform.localEulerAngles = arg_109_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_112_2 = GameObjectTools.GetOrAddComponent(arg_109_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_112_2 then
					var_112_2:EnableDynamicBone(true)
				end
			end

			local var_112_3 = 0
			local var_112_4 = 1.4

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_3 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_5 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(323082027).content)

				arg_109_1.text_.text = var_112_5

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_7 = 56 <= 0 and var_112_4 or var_112_4 * (utf8.len(var_112_5) / 56)

				if (56 <= 0 and var_112_4 or var_112_4 * (utf8.len(var_112_5) / 56)) > 0 and var_112_4 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_3 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_3
					end
				end

				arg_109_1.text_.text = var_112_5
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_8 = math.max(var_112_4, arg_109_1.talkMaxDuration)

			if var_112_3 <= arg_109_1.time_ and arg_109_1.time_ < var_112_3 + var_112_8 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_3) / var_112_8

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_3 + var_112_8 and arg_109_1.time_ < var_112_3 + var_112_8 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play323082028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 323082028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play323082029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 1.1

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

				local var_116_1 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(323082028).content)

				arg_113_1.text_.text = var_116_1

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_3 = 44 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 44)

				if (44 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 44)) > 0 and var_116_0 < var_116_3 then
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
	Play323082029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 323082029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play323082030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0.6

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_1 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(323082029).content)

				arg_117_1.text_.text = var_120_1

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_3 = 24 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 24)

				if (24 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 24)) > 0 and var_120_0 < var_120_3 then
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
	Play323082030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 323082030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play323082031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 1.175

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_1 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(323082030).content)

				arg_121_1.text_.text = var_124_1

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_3 = 47 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_1) / 47)

				if (47 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_1) / 47)) > 0 and var_124_0 < var_124_3 then
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
	Play323082031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 323082031
		arg_125_1.duration_ = 21.17

		local var_125_0 = {
			zh = 9.933,
			ja = 21.166
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
				arg_125_0:Play323082032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 1.35

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[1452].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_1 = arg_125_1:GetWordFromCfg(323082031)
				local var_128_2 = arg_125_1:FormatText(var_128_1.content)

				arg_125_1.text_.text = var_128_2

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_4 = 54 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 54)

				if (54 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 54)) > 0 and var_128_0 < var_128_4 then
					arg_125_1.talkMaxDuration = var_128_4

					if var_128_4 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_4 + 0
					end
				end

				arg_125_1.text_.text = var_128_2
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082031", "story_v_out_323082.awb") ~= 0 then
					local var_128_5 = manager.audio:GetVoiceLength("story_v_out_323082", "323082031", "story_v_out_323082.awb") / 1000

					if var_128_5 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + 0
					end

					if var_128_1.prefab_name ~= "" and arg_125_1.actors_[var_128_1.prefab_name] ~= nil then
						local var_128_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_1.prefab_name].transform, "story_v_out_323082", "323082031", "story_v_out_323082.awb")

						arg_125_1:RecordAudio("323082031", var_128_6)
						arg_125_1:RecordAudio("323082031", var_128_6)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_323082", "323082031", "story_v_out_323082.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_323082", "323082031", "story_v_out_323082.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_7 = math.max(var_128_0, arg_125_1.talkMaxDuration)

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_7 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - 0) / var_128_7

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= 0 + var_128_7 and arg_125_1.time_ < 0 + var_128_7 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play323082032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 323082032
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play323082033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0.275

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
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

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_1 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(323082032).content)

				arg_129_1.text_.text = var_132_1

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_3 = 11 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_1) / 11)

				if (11 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_1) / 11)) > 0 and var_132_0 < var_132_3 then
					arg_129_1.talkMaxDuration = var_132_3

					if var_132_3 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_3 + 0
					end
				end

				arg_129_1.text_.text = var_132_1
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_4 = math.max(var_132_0, arg_129_1.talkMaxDuration)

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_4 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - 0) / var_132_4

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= 0 + var_132_4 and arg_129_1.time_ < 0 + var_132_4 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play323082033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 323082033
		arg_133_1.duration_ = 13.37

		local var_133_0 = {
			zh = 7.7,
			ja = 13.366
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
				arg_133_0:Play323082034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0.925

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[1452].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_1 = arg_133_1:GetWordFromCfg(323082033)
				local var_136_2 = arg_133_1:FormatText(var_136_1.content)

				arg_133_1.text_.text = var_136_2

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 37 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 37)

				if (37 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 37)) > 0 and var_136_0 < var_136_4 then
					arg_133_1.talkMaxDuration = var_136_4

					if var_136_4 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_4 + 0
					end
				end

				arg_133_1.text_.text = var_136_2
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082033", "story_v_out_323082.awb") ~= 0 then
					local var_136_5 = manager.audio:GetVoiceLength("story_v_out_323082", "323082033", "story_v_out_323082.awb") / 1000

					if var_136_5 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + 0
					end

					if var_136_1.prefab_name ~= "" and arg_133_1.actors_[var_136_1.prefab_name] ~= nil then
						local var_136_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_1.prefab_name].transform, "story_v_out_323082", "323082033", "story_v_out_323082.awb")

						arg_133_1:RecordAudio("323082033", var_136_6)
						arg_133_1:RecordAudio("323082033", var_136_6)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_323082", "323082033", "story_v_out_323082.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_323082", "323082033", "story_v_out_323082.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_7 = math.max(var_136_0, arg_133_1.talkMaxDuration)

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_7 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - 0) / var_136_7

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= 0 + var_136_7 and arg_133_1.time_ < 0 + var_136_7 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play323082034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 323082034
		arg_137_1.duration_ = 4.47

		local var_137_0 = {
			zh = 3.033,
			ja = 4.466
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play323082035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0.3

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[1452].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_1 = arg_137_1:GetWordFromCfg(323082034)
				local var_140_2 = arg_137_1:FormatText(var_140_1.content)

				arg_137_1.text_.text = var_140_2

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_4 = 12 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 12)

				if (12 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 12)) > 0 and var_140_0 < var_140_4 then
					arg_137_1.talkMaxDuration = var_140_4

					if var_140_4 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_4 + 0
					end
				end

				arg_137_1.text_.text = var_140_2
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082034", "story_v_out_323082.awb") ~= 0 then
					local var_140_5 = manager.audio:GetVoiceLength("story_v_out_323082", "323082034", "story_v_out_323082.awb") / 1000

					if var_140_5 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + 0
					end

					if var_140_1.prefab_name ~= "" and arg_137_1.actors_[var_140_1.prefab_name] ~= nil then
						local var_140_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_1.prefab_name].transform, "story_v_out_323082", "323082034", "story_v_out_323082.awb")

						arg_137_1:RecordAudio("323082034", var_140_6)
						arg_137_1:RecordAudio("323082034", var_140_6)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_323082", "323082034", "story_v_out_323082.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_323082", "323082034", "story_v_out_323082.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_7 = math.max(var_140_0, arg_137_1.talkMaxDuration)

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_7 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - 0) / var_140_7

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= 0 + var_140_7 and arg_137_1.time_ < 0 + var_140_7 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play323082035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 323082035
		arg_141_1.duration_ = 4.7

		local var_141_0 = {
			zh = 4.7,
			ja = 4.4
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play323082036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1070ui_story = arg_141_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_144_0 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 then
				arg_141_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_141_1.time_ - 0) / var_144_0)
				arg_141_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1070ui_story"].transform.position).z)
				arg_141_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1070ui_story"].transform.localEulerAngles = arg_141_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 then
				arg_141_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_141_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1070ui_story"].transform.position).z)
				arg_141_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1070ui_story"].transform.localEulerAngles = arg_141_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_144_1 = arg_141_1.actors_["1070ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect1070ui_story == nil then
				arg_141_1.var_.characterEffect1070ui_story = var_144_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_2 and not isNil(var_144_1) then
				if arg_141_1.var_.characterEffect1070ui_story and not isNil(var_144_1) then
					arg_141_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_2 and arg_141_1.time_ < 0 + var_144_2 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect1070ui_story then
				arg_141_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action426")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_144_4 = 0
			local var_144_5 = 0.45

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_6 = arg_141_1:GetWordFromCfg(323082035)
				local var_144_7 = arg_141_1:FormatText(var_144_6.content)

				arg_141_1.text_.text = var_144_7

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_9 = 18 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 18)

				if (18 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 18)) > 0 and var_144_5 < var_144_9 then
					arg_141_1.talkMaxDuration = var_144_9

					if var_144_9 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_9 + var_144_4
					end
				end

				arg_141_1.text_.text = var_144_7
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082035", "story_v_out_323082.awb") ~= 0 then
					local var_144_10 = manager.audio:GetVoiceLength("story_v_out_323082", "323082035", "story_v_out_323082.awb") / 1000

					if var_144_10 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_4
					end

					if var_144_6.prefab_name ~= "" and arg_141_1.actors_[var_144_6.prefab_name] ~= nil then
						local var_144_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_6.prefab_name].transform, "story_v_out_323082", "323082035", "story_v_out_323082.awb")

						arg_141_1:RecordAudio("323082035", var_144_11)
						arg_141_1:RecordAudio("323082035", var_144_11)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_323082", "323082035", "story_v_out_323082.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_323082", "323082035", "story_v_out_323082.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_12 = math.max(var_144_5, arg_141_1.talkMaxDuration)

			if var_144_4 <= arg_141_1.time_ and arg_141_1.time_ < var_144_4 + var_144_12 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_4) / var_144_12

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_4 + var_144_12 and arg_141_1.time_ < var_144_4 + var_144_12 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play323082036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 323082036
		arg_145_1.duration_ = 6.7

		local var_145_0 = {
			zh = 6.7,
			ja = 6.533
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play323082037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0.7

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_1 = arg_145_1:GetWordFromCfg(323082036)
				local var_148_2 = arg_145_1:FormatText(var_148_1.content)

				arg_145_1.text_.text = var_148_2

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_4 = 28 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 28)

				if (28 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 28)) > 0 and var_148_0 < var_148_4 then
					arg_145_1.talkMaxDuration = var_148_4

					if var_148_4 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_4 + 0
					end
				end

				arg_145_1.text_.text = var_148_2
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082036", "story_v_out_323082.awb") ~= 0 then
					local var_148_5 = manager.audio:GetVoiceLength("story_v_out_323082", "323082036", "story_v_out_323082.awb") / 1000

					if var_148_5 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + 0
					end

					if var_148_1.prefab_name ~= "" and arg_145_1.actors_[var_148_1.prefab_name] ~= nil then
						local var_148_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_1.prefab_name].transform, "story_v_out_323082", "323082036", "story_v_out_323082.awb")

						arg_145_1:RecordAudio("323082036", var_148_6)
						arg_145_1:RecordAudio("323082036", var_148_6)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_323082", "323082036", "story_v_out_323082.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_323082", "323082036", "story_v_out_323082.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_7 = math.max(var_148_0, arg_145_1.talkMaxDuration)

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_7 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - 0) / var_148_7

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= 0 + var_148_7 and arg_145_1.time_ < 0 + var_148_7 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play323082037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 323082037
		arg_149_1.duration_ = 8.9

		local var_149_0 = {
			zh = 6.3,
			ja = 8.9
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play323082038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["1070ui_story"]) and arg_149_1.var_.characterEffect1070ui_story == nil then
				arg_149_1.var_.characterEffect1070ui_story = arg_149_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_0 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["1070ui_story"]) then
				if arg_149_1.var_.characterEffect1070ui_story and not isNil(arg_149_1.actors_["1070ui_story"]) then
					arg_149_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_0)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["1070ui_story"]) and arg_149_1.var_.characterEffect1070ui_story then
				arg_149_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_152_1 = 0
			local var_152_2 = 0.6

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[1452].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_3 = arg_149_1:GetWordFromCfg(323082037)
				local var_152_4 = arg_149_1:FormatText(var_152_3.content)

				arg_149_1.text_.text = var_152_4

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_6 = 24 <= 0 and var_152_2 or var_152_2 * (utf8.len(var_152_4) / 24)

				if (24 <= 0 and var_152_2 or var_152_2 * (utf8.len(var_152_4) / 24)) > 0 and var_152_2 < var_152_6 then
					arg_149_1.talkMaxDuration = var_152_6

					if var_152_6 + var_152_1 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_6 + var_152_1
					end
				end

				arg_149_1.text_.text = var_152_4
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082037", "story_v_out_323082.awb") ~= 0 then
					local var_152_7 = manager.audio:GetVoiceLength("story_v_out_323082", "323082037", "story_v_out_323082.awb") / 1000

					if var_152_7 + var_152_1 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_7 + var_152_1
					end

					if var_152_3.prefab_name ~= "" and arg_149_1.actors_[var_152_3.prefab_name] ~= nil then
						local var_152_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_3.prefab_name].transform, "story_v_out_323082", "323082037", "story_v_out_323082.awb")

						arg_149_1:RecordAudio("323082037", var_152_8)
						arg_149_1:RecordAudio("323082037", var_152_8)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_323082", "323082037", "story_v_out_323082.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_323082", "323082037", "story_v_out_323082.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_9 = math.max(var_152_2, arg_149_1.talkMaxDuration)

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_9 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_1) / var_152_9

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_1 + var_152_9 and arg_149_1.time_ < var_152_1 + var_152_9 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play323082038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 323082038
		arg_153_1.duration_ = 9.1

		local var_153_0 = {
			zh = 6.133,
			ja = 9.1
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play323082039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["1070ui_story"]) and arg_153_1.var_.characterEffect1070ui_story == nil then
				arg_153_1.var_.characterEffect1070ui_story = arg_153_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_0 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["1070ui_story"]) then
				if arg_153_1.var_.characterEffect1070ui_story and not isNil(arg_153_1.actors_["1070ui_story"]) then
					arg_153_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["1070ui_story"]) and arg_153_1.var_.characterEffect1070ui_story then
				arg_153_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action464")
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva", "EmotionTimelineAnimator")
			end

			local var_156_2 = 0
			local var_156_3 = 0.6

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_2 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_4 = arg_153_1:GetWordFromCfg(323082038)
				local var_156_5 = arg_153_1:FormatText(var_156_4.content)

				arg_153_1.text_.text = var_156_5

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_7 = 24 <= 0 and var_156_3 or var_156_3 * (utf8.len(var_156_5) / 24)

				if (24 <= 0 and var_156_3 or var_156_3 * (utf8.len(var_156_5) / 24)) > 0 and var_156_3 < var_156_7 then
					arg_153_1.talkMaxDuration = var_156_7

					if var_156_7 + var_156_2 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_7 + var_156_2
					end
				end

				arg_153_1.text_.text = var_156_5
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082038", "story_v_out_323082.awb") ~= 0 then
					local var_156_8 = manager.audio:GetVoiceLength("story_v_out_323082", "323082038", "story_v_out_323082.awb") / 1000

					if var_156_8 + var_156_2 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_8 + var_156_2
					end

					if var_156_4.prefab_name ~= "" and arg_153_1.actors_[var_156_4.prefab_name] ~= nil then
						local var_156_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_4.prefab_name].transform, "story_v_out_323082", "323082038", "story_v_out_323082.awb")

						arg_153_1:RecordAudio("323082038", var_156_9)
						arg_153_1:RecordAudio("323082038", var_156_9)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_323082", "323082038", "story_v_out_323082.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_323082", "323082038", "story_v_out_323082.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_10 = math.max(var_156_3, arg_153_1.talkMaxDuration)

			if var_156_2 <= arg_153_1.time_ and arg_153_1.time_ < var_156_2 + var_156_10 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_2) / var_156_10

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_2 + var_156_10 and arg_153_1.time_ < var_156_2 + var_156_10 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play323082039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 323082039
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play323082040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(arg_157_1.actors_["1070ui_story"]) and arg_157_1.var_.characterEffect1070ui_story == nil then
				arg_157_1.var_.characterEffect1070ui_story = arg_157_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_0 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 and not isNil(arg_157_1.actors_["1070ui_story"]) then
				if arg_157_1.var_.characterEffect1070ui_story and not isNil(arg_157_1.actors_["1070ui_story"]) then
					arg_157_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_157_1.time_ - 0) / var_160_0)
				end
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 and not isNil(arg_157_1.actors_["1070ui_story"]) and arg_157_1.var_.characterEffect1070ui_story then
				arg_157_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_160_1 = 0
			local var_160_2 = 0.0329999998211861

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_3 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(323082039).content)

				arg_157_1.text_.text = var_160_3

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_5 = 1 <= 0 and var_160_2 or var_160_2 * (utf8.len(var_160_3) / 1)

				if (1 <= 0 and var_160_2 or var_160_2 * (utf8.len(var_160_3) / 1)) > 0 and var_160_2 < var_160_5 then
					arg_157_1.talkMaxDuration = var_160_5

					if var_160_5 + var_160_1 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_5 + var_160_1
					end
				end

				arg_157_1.text_.text = var_160_3
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_6 = math.max(var_160_2, arg_157_1.talkMaxDuration)

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_6 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_1) / var_160_6

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_1 + var_160_6 and arg_157_1.time_ < var_160_1 + var_160_6 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play323082040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 323082040
		arg_161_1.duration_ = 2.47

		local var_161_0 = {
			zh = 2.466,
			ja = 2.4
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play323082041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0.225

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[1452].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_1 = arg_161_1:GetWordFromCfg(323082040)
				local var_164_2 = arg_161_1:FormatText(var_164_1.content)

				arg_161_1.text_.text = var_164_2

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_4 = 9 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 9)

				if (9 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 9)) > 0 and var_164_0 < var_164_4 then
					arg_161_1.talkMaxDuration = var_164_4

					if var_164_4 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_4 + 0
					end
				end

				arg_161_1.text_.text = var_164_2
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082040", "story_v_out_323082.awb") ~= 0 then
					local var_164_5 = manager.audio:GetVoiceLength("story_v_out_323082", "323082040", "story_v_out_323082.awb") / 1000

					if var_164_5 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_5 + 0
					end

					if var_164_1.prefab_name ~= "" and arg_161_1.actors_[var_164_1.prefab_name] ~= nil then
						local var_164_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_1.prefab_name].transform, "story_v_out_323082", "323082040", "story_v_out_323082.awb")

						arg_161_1:RecordAudio("323082040", var_164_6)
						arg_161_1:RecordAudio("323082040", var_164_6)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_323082", "323082040", "story_v_out_323082.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_323082", "323082040", "story_v_out_323082.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_7 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_7 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_7

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_7 and arg_161_1.time_ < 0 + var_164_7 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play323082041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 323082041
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play323082042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_168_0 = 0
			local var_168_1 = 0.4

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_2 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(323082041).content)

				arg_165_1.text_.text = var_168_2

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_4 = 16 <= 0 and var_168_1 or var_168_1 * (utf8.len(var_168_2) / 16)

				if (16 <= 0 and var_168_1 or var_168_1 * (utf8.len(var_168_2) / 16)) > 0 and var_168_1 < var_168_4 then
					arg_165_1.talkMaxDuration = var_168_4

					if var_168_4 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_4 + var_168_0
					end
				end

				arg_165_1.text_.text = var_168_2
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_5 = math.max(var_168_1, arg_165_1.talkMaxDuration)

			if var_168_0 <= arg_165_1.time_ and arg_165_1.time_ < var_168_0 + var_168_5 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_0) / var_168_5

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_0 + var_168_5 and arg_165_1.time_ < var_168_0 + var_168_5 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play323082042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 323082042
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play323082043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos1070ui_story = arg_169_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_172_0 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 then
				arg_169_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_169_1.time_ - 0) / var_172_0)
				arg_169_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1070ui_story"].transform.position).z)
				arg_169_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1070ui_story"].transform.localEulerAngles = arg_169_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 then
				arg_169_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_169_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1070ui_story"].transform.position).z)
				arg_169_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1070ui_story"].transform.localEulerAngles = arg_169_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_172_1 = 0
			local var_172_2 = 0.925

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_3 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(323082042).content)

				arg_169_1.text_.text = var_172_3

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_5 = 37 <= 0 and var_172_2 or var_172_2 * (utf8.len(var_172_3) / 37)

				if (37 <= 0 and var_172_2 or var_172_2 * (utf8.len(var_172_3) / 37)) > 0 and var_172_2 < var_172_5 then
					arg_169_1.talkMaxDuration = var_172_5

					if var_172_5 + var_172_1 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_5 + var_172_1
					end
				end

				arg_169_1.text_.text = var_172_3
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_6 = math.max(var_172_2, arg_169_1.talkMaxDuration)

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_6 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_1) / var_172_6

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_1 + var_172_6 and arg_169_1.time_ < var_172_1 + var_172_6 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play323082043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 323082043
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play323082044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0.925

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_1 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(323082043).content)

				arg_173_1.text_.text = var_176_1

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_3 = 37 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_1) / 37)

				if (37 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_1) / 37)) > 0 and var_176_0 < var_176_3 then
					arg_173_1.talkMaxDuration = var_176_3

					if var_176_3 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_3 + 0
					end
				end

				arg_173_1.text_.text = var_176_1
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_4 = math.max(var_176_0, arg_173_1.talkMaxDuration)

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_4 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - 0) / var_176_4

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= 0 + var_176_4 and arg_173_1.time_ < 0 + var_176_4 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play323082044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 323082044
		arg_177_1.duration_ = 4.67

		local var_177_0 = {
			zh = 2.433,
			ja = 4.666
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play323082045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0.3

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[1452].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, true)
				arg_177_1.iconController_:SetSelectedState("hero")

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_177_1.callingController_:SetSelectedState("normal")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_1 = arg_177_1:GetWordFromCfg(323082044)
				local var_180_2 = arg_177_1:FormatText(var_180_1.content)

				arg_177_1.text_.text = var_180_2

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_4 = 12 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 12)

				if (12 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 12)) > 0 and var_180_0 < var_180_4 then
					arg_177_1.talkMaxDuration = var_180_4

					if var_180_4 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_4 + 0
					end
				end

				arg_177_1.text_.text = var_180_2
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082044", "story_v_out_323082.awb") ~= 0 then
					local var_180_5 = manager.audio:GetVoiceLength("story_v_out_323082", "323082044", "story_v_out_323082.awb") / 1000

					if var_180_5 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + 0
					end

					if var_180_1.prefab_name ~= "" and arg_177_1.actors_[var_180_1.prefab_name] ~= nil then
						local var_180_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_1.prefab_name].transform, "story_v_out_323082", "323082044", "story_v_out_323082.awb")

						arg_177_1:RecordAudio("323082044", var_180_6)
						arg_177_1:RecordAudio("323082044", var_180_6)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_323082", "323082044", "story_v_out_323082.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_323082", "323082044", "story_v_out_323082.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_7 = math.max(var_180_0, arg_177_1.talkMaxDuration)

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_7 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - 0) / var_180_7

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= 0 + var_180_7 and arg_177_1.time_ < 0 + var_180_7 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play323082045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 323082045
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play323082046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0.975

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_1 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(323082045).content)

				arg_181_1.text_.text = var_184_1

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_3 = 39 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 39)

				if (39 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 39)) > 0 and var_184_0 < var_184_3 then
					arg_181_1.talkMaxDuration = var_184_3

					if var_184_3 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_3 + 0
					end
				end

				arg_181_1.text_.text = var_184_1
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_4 = math.max(var_184_0, arg_181_1.talkMaxDuration)

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_4 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - 0) / var_184_4

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= 0 + var_184_4 and arg_181_1.time_ < 0 + var_184_4 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play323082046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 323082046
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play323082047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 1.025

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_1 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(323082046).content)

				arg_185_1.text_.text = var_188_1

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_3 = 41 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 41)

				if (41 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 41)) > 0 and var_188_0 < var_188_3 then
					arg_185_1.talkMaxDuration = var_188_3

					if var_188_3 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_3 + 0
					end
				end

				arg_185_1.text_.text = var_188_1
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_4 = math.max(var_188_0, arg_185_1.talkMaxDuration)

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_4 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - 0) / var_188_4

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= 0 + var_188_4 and arg_185_1.time_ < 0 + var_188_4 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play323082047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 323082047
		arg_189_1.duration_ = 10.53

		local var_189_0 = {
			zh = 7.966,
			ja = 10.533
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play323082048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 1.025

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[1452].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_1 = arg_189_1:GetWordFromCfg(323082047)
				local var_192_2 = arg_189_1:FormatText(var_192_1.content)

				arg_189_1.text_.text = var_192_2

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_4 = 41 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 41)

				if (41 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 41)) > 0 and var_192_0 < var_192_4 then
					arg_189_1.talkMaxDuration = var_192_4

					if var_192_4 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_4 + 0
					end
				end

				arg_189_1.text_.text = var_192_2
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082047", "story_v_out_323082.awb") ~= 0 then
					local var_192_5 = manager.audio:GetVoiceLength("story_v_out_323082", "323082047", "story_v_out_323082.awb") / 1000

					if var_192_5 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + 0
					end

					if var_192_1.prefab_name ~= "" and arg_189_1.actors_[var_192_1.prefab_name] ~= nil then
						local var_192_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_1.prefab_name].transform, "story_v_out_323082", "323082047", "story_v_out_323082.awb")

						arg_189_1:RecordAudio("323082047", var_192_6)
						arg_189_1:RecordAudio("323082047", var_192_6)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_323082", "323082047", "story_v_out_323082.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_323082", "323082047", "story_v_out_323082.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_7 = math.max(var_192_0, arg_189_1.talkMaxDuration)

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_7 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - 0) / var_192_7

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= 0 + var_192_7 and arg_189_1.time_ < 0 + var_192_7 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play323082048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 323082048
		arg_193_1.duration_ = 12.57

		local var_193_0 = {
			zh = 9.466,
			ja = 12.566
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play323082049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 1.275

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[1452].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_1 = arg_193_1:GetWordFromCfg(323082048)
				local var_196_2 = arg_193_1:FormatText(var_196_1.content)

				arg_193_1.text_.text = var_196_2

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_4 = 51 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 51)

				if (51 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 51)) > 0 and var_196_0 < var_196_4 then
					arg_193_1.talkMaxDuration = var_196_4

					if var_196_4 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_4 + 0
					end
				end

				arg_193_1.text_.text = var_196_2
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082048", "story_v_out_323082.awb") ~= 0 then
					local var_196_5 = manager.audio:GetVoiceLength("story_v_out_323082", "323082048", "story_v_out_323082.awb") / 1000

					if var_196_5 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_5 + 0
					end

					if var_196_1.prefab_name ~= "" and arg_193_1.actors_[var_196_1.prefab_name] ~= nil then
						local var_196_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_1.prefab_name].transform, "story_v_out_323082", "323082048", "story_v_out_323082.awb")

						arg_193_1:RecordAudio("323082048", var_196_6)
						arg_193_1:RecordAudio("323082048", var_196_6)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_323082", "323082048", "story_v_out_323082.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_323082", "323082048", "story_v_out_323082.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_7 = math.max(var_196_0, arg_193_1.talkMaxDuration)

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_7 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - 0) / var_196_7

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= 0 + var_196_7 and arg_193_1.time_ < 0 + var_196_7 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play323082049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 323082049
		arg_197_1.duration_ = 13.6

		local var_197_0 = {
			zh = 8.2,
			ja = 13.6
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play323082050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0.975

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[1452].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_1 = arg_197_1:GetWordFromCfg(323082049)
				local var_200_2 = arg_197_1:FormatText(var_200_1.content)

				arg_197_1.text_.text = var_200_2

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_4 = 39 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 39)

				if (39 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 39)) > 0 and var_200_0 < var_200_4 then
					arg_197_1.talkMaxDuration = var_200_4

					if var_200_4 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_4 + 0
					end
				end

				arg_197_1.text_.text = var_200_2
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082049", "story_v_out_323082.awb") ~= 0 then
					local var_200_5 = manager.audio:GetVoiceLength("story_v_out_323082", "323082049", "story_v_out_323082.awb") / 1000

					if var_200_5 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_5 + 0
					end

					if var_200_1.prefab_name ~= "" and arg_197_1.actors_[var_200_1.prefab_name] ~= nil then
						local var_200_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_1.prefab_name].transform, "story_v_out_323082", "323082049", "story_v_out_323082.awb")

						arg_197_1:RecordAudio("323082049", var_200_6)
						arg_197_1:RecordAudio("323082049", var_200_6)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_323082", "323082049", "story_v_out_323082.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_323082", "323082049", "story_v_out_323082.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_7 = math.max(var_200_0, arg_197_1.talkMaxDuration)

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_7 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - 0) / var_200_7

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= 0 + var_200_7 and arg_197_1.time_ < 0 + var_200_7 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play323082050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 323082050
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play323082051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0.825

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_1 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(323082050).content)

				arg_201_1.text_.text = var_204_1

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_3 = 33 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_1) / 33)

				if (33 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_1) / 33)) > 0 and var_204_0 < var_204_3 then
					arg_201_1.talkMaxDuration = var_204_3

					if var_204_3 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_3 + 0
					end
				end

				arg_201_1.text_.text = var_204_1
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_4 = math.max(var_204_0, arg_201_1.talkMaxDuration)

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_4 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - 0) / var_204_4

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= 0 + var_204_4 and arg_201_1.time_ < 0 + var_204_4 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play323082051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 323082051
		arg_205_1.duration_ = 2.3

		local var_205_0 = {
			zh = 0.999999999999,
			ja = 2.3
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play323082052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0.1

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[1452].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, true)
				arg_205_1.iconController_:SetSelectedState("hero")

				arg_205_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_205_1.callingController_:SetSelectedState("normal")

				arg_205_1.keyicon_.color = Color.New(1, 1, 1)
				arg_205_1.icon_.color = Color.New(1, 1, 1)

				local var_208_1 = arg_205_1:GetWordFromCfg(323082051)
				local var_208_2 = arg_205_1:FormatText(var_208_1.content)

				arg_205_1.text_.text = var_208_2

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_4 = 4 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 4)

				if (4 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 4)) > 0 and var_208_0 < var_208_4 then
					arg_205_1.talkMaxDuration = var_208_4

					if var_208_4 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_4 + 0
					end
				end

				arg_205_1.text_.text = var_208_2
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082051", "story_v_out_323082.awb") ~= 0 then
					local var_208_5 = manager.audio:GetVoiceLength("story_v_out_323082", "323082051", "story_v_out_323082.awb") / 1000

					if var_208_5 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_5 + 0
					end

					if var_208_1.prefab_name ~= "" and arg_205_1.actors_[var_208_1.prefab_name] ~= nil then
						local var_208_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_1.prefab_name].transform, "story_v_out_323082", "323082051", "story_v_out_323082.awb")

						arg_205_1:RecordAudio("323082051", var_208_6)
						arg_205_1:RecordAudio("323082051", var_208_6)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_323082", "323082051", "story_v_out_323082.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_323082", "323082051", "story_v_out_323082.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_7 = math.max(var_208_0, arg_205_1.talkMaxDuration)

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_7 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - 0) / var_208_7

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= 0 + var_208_7 and arg_205_1.time_ < 0 + var_208_7 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play323082052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 323082052
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play323082053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0.575

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_1 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(323082052).content)

				arg_209_1.text_.text = var_212_1

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_3 = 23 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_1) / 23)

				if (23 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_1) / 23)) > 0 and var_212_0 < var_212_3 then
					arg_209_1.talkMaxDuration = var_212_3

					if var_212_3 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_3 + 0
					end
				end

				arg_209_1.text_.text = var_212_1
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_4 = math.max(var_212_0, arg_209_1.talkMaxDuration)

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_4 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - 0) / var_212_4

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= 0 + var_212_4 and arg_209_1.time_ < 0 + var_212_4 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play323082053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 323082053
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play323082054(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0.575

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_1 = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(323082053).content)

				arg_213_1.text_.text = var_216_1

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_3 = 23 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_1) / 23)

				if (23 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_1) / 23)) > 0 and var_216_0 < var_216_3 then
					arg_213_1.talkMaxDuration = var_216_3

					if var_216_3 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_3 + 0
					end
				end

				arg_213_1.text_.text = var_216_1
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_4 = math.max(var_216_0, arg_213_1.talkMaxDuration)

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_4 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - 0) / var_216_4

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= 0 + var_216_4 and arg_213_1.time_ < 0 + var_216_4 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play323082054 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 323082054
		arg_217_1.duration_ = 1

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play323082055(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0.125

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10171")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_1 = arg_217_1:GetWordFromCfg(323082054)
				local var_220_2 = arg_217_1:FormatText(var_220_1.content)

				arg_217_1.text_.text = var_220_2

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_4 = 5 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 5)

				if (5 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 5)) > 0 and var_220_0 < var_220_4 then
					arg_217_1.talkMaxDuration = var_220_4

					if var_220_4 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_4 + 0
					end
				end

				arg_217_1.text_.text = var_220_2
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082054", "story_v_out_323082.awb") ~= 0 then
					local var_220_5 = manager.audio:GetVoiceLength("story_v_out_323082", "323082054", "story_v_out_323082.awb") / 1000

					if var_220_5 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + 0
					end

					if var_220_1.prefab_name ~= "" and arg_217_1.actors_[var_220_1.prefab_name] ~= nil then
						local var_220_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_1.prefab_name].transform, "story_v_out_323082", "323082054", "story_v_out_323082.awb")

						arg_217_1:RecordAudio("323082054", var_220_6)
						arg_217_1:RecordAudio("323082054", var_220_6)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_323082", "323082054", "story_v_out_323082.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_323082", "323082054", "story_v_out_323082.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_7 = math.max(var_220_0, arg_217_1.talkMaxDuration)

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_7 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - 0) / var_220_7

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= 0 + var_220_7 and arg_217_1.time_ < 0 + var_220_7 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play323082055 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 323082055
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play323082056(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 1.15

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_1 = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(323082055).content)

				arg_221_1.text_.text = var_224_1

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_3 = 46 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_1) / 46)

				if (46 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_1) / 46)) > 0 and var_224_0 < var_224_3 then
					arg_221_1.talkMaxDuration = var_224_3

					if var_224_3 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_3 + 0
					end
				end

				arg_221_1.text_.text = var_224_1
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_4 = math.max(var_224_0, arg_221_1.talkMaxDuration)

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_4 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - 0) / var_224_4

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= 0 + var_224_4 and arg_221_1.time_ < 0 + var_224_4 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play323082056 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 323082056
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play323082057(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 1.35

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_1 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(323082056).content)

				arg_225_1.text_.text = var_228_1

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_3 = 54 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_1) / 54)

				if (54 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_1) / 54)) > 0 and var_228_0 < var_228_3 then
					arg_225_1.talkMaxDuration = var_228_3

					if var_228_3 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_3 + 0
					end
				end

				arg_225_1.text_.text = var_228_1
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_4 = math.max(var_228_0, arg_225_1.talkMaxDuration)

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_4 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - 0) / var_228_4

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= 0 + var_228_4 and arg_225_1.time_ < 0 + var_228_4 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play323082057 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 323082057
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play323082058(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0.825

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_1 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(323082057).content)

				arg_229_1.text_.text = var_232_1

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_3 = 33 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_1) / 33)

				if (33 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_1) / 33)) > 0 and var_232_0 < var_232_3 then
					arg_229_1.talkMaxDuration = var_232_3

					if var_232_3 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_3 + 0
					end
				end

				arg_229_1.text_.text = var_232_1
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_4 = math.max(var_232_0, arg_229_1.talkMaxDuration)

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_4 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - 0) / var_232_4

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= 0 + var_232_4 and arg_229_1.time_ < 0 + var_232_4 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play323082058 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 323082058
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play323082059(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 1.4

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_1 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(323082058).content)

				arg_233_1.text_.text = var_236_1

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_3 = 56 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_1) / 56)

				if (56 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_1) / 56)) > 0 and var_236_0 < var_236_3 then
					arg_233_1.talkMaxDuration = var_236_3

					if var_236_3 + 0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_3 + 0
					end
				end

				arg_233_1.text_.text = var_236_1
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_4 = math.max(var_236_0, arg_233_1.talkMaxDuration)

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_4 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - 0) / var_236_4

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= 0 + var_236_4 and arg_233_1.time_ < 0 + var_236_4 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play323082059 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 323082059
		arg_237_1.duration_ = 8.33

		local var_237_0 = {
			zh = 5.566,
			ja = 8.333
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
				arg_237_0:Play323082060(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos10171ui_story = arg_237_1.actors_["10171ui_story"].transform.localPosition

				local var_240_0 = GameObjectTools.GetOrAddComponent(arg_237_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_240_0 then
					var_240_0:EnableDynamicBone(false)
				end
			end

			local var_240_1 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_1 then
				arg_237_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos10171ui_story, Vector3.New(0, -0.95, -6.05), (arg_237_1.time_ - 0) / var_240_1)
				arg_237_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["10171ui_story"].transform.position).z)
				arg_237_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["10171ui_story"].transform.localEulerAngles = arg_237_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_237_1.time_ >= 0 + var_240_1 and arg_237_1.time_ < 0 + var_240_1 + arg_240_0 then
				arg_237_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_237_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["10171ui_story"].transform.position).z)
				arg_237_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["10171ui_story"].transform.localEulerAngles = arg_237_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_240_2 = GameObjectTools.GetOrAddComponent(arg_237_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_240_2 then
					var_240_2:EnableDynamicBone(true)
				end
			end

			local var_240_3 = arg_237_1.actors_["10171ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_3) and arg_237_1.var_.characterEffect10171ui_story == nil then
				arg_237_1.var_.characterEffect10171ui_story = var_240_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_4 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_4 and not isNil(var_240_3) then
				if arg_237_1.var_.characterEffect10171ui_story and not isNil(var_240_3) then
					arg_237_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= 0 + var_240_4 and arg_237_1.time_ < 0 + var_240_4 + arg_240_0 and not isNil(var_240_3) and arg_237_1.var_.characterEffect10171ui_story then
				arg_237_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action30_1")
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_240_6 = 0
			local var_240_7 = 0.55

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_6 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_8 = arg_237_1:GetWordFromCfg(323082059)
				local var_240_9 = arg_237_1:FormatText(var_240_8.content)

				arg_237_1.text_.text = var_240_9

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_11 = 22 <= 0 and var_240_7 or var_240_7 * (utf8.len(var_240_9) / 22)

				if (22 <= 0 and var_240_7 or var_240_7 * (utf8.len(var_240_9) / 22)) > 0 and var_240_7 < var_240_11 then
					arg_237_1.talkMaxDuration = var_240_11

					if var_240_11 + var_240_6 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_11 + var_240_6
					end
				end

				arg_237_1.text_.text = var_240_9
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082059", "story_v_out_323082.awb") ~= 0 then
					local var_240_12 = manager.audio:GetVoiceLength("story_v_out_323082", "323082059", "story_v_out_323082.awb") / 1000

					if var_240_12 + var_240_6 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_12 + var_240_6
					end

					if var_240_8.prefab_name ~= "" and arg_237_1.actors_[var_240_8.prefab_name] ~= nil then
						local var_240_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_8.prefab_name].transform, "story_v_out_323082", "323082059", "story_v_out_323082.awb")

						arg_237_1:RecordAudio("323082059", var_240_13)
						arg_237_1:RecordAudio("323082059", var_240_13)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_323082", "323082059", "story_v_out_323082.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_323082", "323082059", "story_v_out_323082.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_14 = math.max(var_240_7, arg_237_1.talkMaxDuration)

			if var_240_6 <= arg_237_1.time_ and arg_237_1.time_ < var_240_6 + var_240_14 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_6) / var_240_14

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_6 + var_240_14 and arg_237_1.time_ < var_240_6 + var_240_14 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_237_1:InitPlayNodeList()
	end,
	Play323082060 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 323082060
		arg_241_1.duration_ = 8.13

		local var_241_0 = {
			zh = 4.2,
			ja = 8.133
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
				arg_241_0:Play323082061(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(arg_241_1.actors_["10171ui_story"]) and arg_241_1.var_.characterEffect10171ui_story == nil then
				arg_241_1.var_.characterEffect10171ui_story = arg_241_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_0 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 and not isNil(arg_241_1.actors_["10171ui_story"]) then
				if arg_241_1.var_.characterEffect10171ui_story and not isNil(arg_241_1.actors_["10171ui_story"]) then
					arg_241_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_241_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_241_1.time_ - 0) / var_244_0)
				end
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 and not isNil(arg_241_1.actors_["10171ui_story"]) and arg_241_1.var_.characterEffect10171ui_story then
				arg_241_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_241_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_244_1 = 0
			local var_244_2 = 0.4

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[1452].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, true)
				arg_241_1.iconController_:SetSelectedState("hero")

				arg_241_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_241_1.callingController_:SetSelectedState("normal")

				arg_241_1.keyicon_.color = Color.New(1, 1, 1)
				arg_241_1.icon_.color = Color.New(1, 1, 1)

				local var_244_3 = arg_241_1:GetWordFromCfg(323082060)
				local var_244_4 = arg_241_1:FormatText(var_244_3.content)

				arg_241_1.text_.text = var_244_4

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_6 = 16 <= 0 and var_244_2 or var_244_2 * (utf8.len(var_244_4) / 16)

				if (16 <= 0 and var_244_2 or var_244_2 * (utf8.len(var_244_4) / 16)) > 0 and var_244_2 < var_244_6 then
					arg_241_1.talkMaxDuration = var_244_6

					if var_244_6 + var_244_1 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_6 + var_244_1
					end
				end

				arg_241_1.text_.text = var_244_4
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082060", "story_v_out_323082.awb") ~= 0 then
					local var_244_7 = manager.audio:GetVoiceLength("story_v_out_323082", "323082060", "story_v_out_323082.awb") / 1000

					if var_244_7 + var_244_1 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_7 + var_244_1
					end

					if var_244_3.prefab_name ~= "" and arg_241_1.actors_[var_244_3.prefab_name] ~= nil then
						local var_244_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_3.prefab_name].transform, "story_v_out_323082", "323082060", "story_v_out_323082.awb")

						arg_241_1:RecordAudio("323082060", var_244_8)
						arg_241_1:RecordAudio("323082060", var_244_8)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_323082", "323082060", "story_v_out_323082.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_323082", "323082060", "story_v_out_323082.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_9 = math.max(var_244_2, arg_241_1.talkMaxDuration)

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_9 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_1) / var_244_9

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_1 + var_244_9 and arg_241_1.time_ < var_244_1 + var_244_9 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play323082061 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 323082061
		arg_245_1.duration_ = 10.9

		local var_245_0 = {
			zh = 6.7,
			ja = 10.9
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
				arg_245_0:Play323082062(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(arg_245_1.actors_["10171ui_story"]) and arg_245_1.var_.characterEffect10171ui_story == nil then
				arg_245_1.var_.characterEffect10171ui_story = arg_245_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_0 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 and not isNil(arg_245_1.actors_["10171ui_story"]) then
				if arg_245_1.var_.characterEffect10171ui_story and not isNil(arg_245_1.actors_["10171ui_story"]) then
					arg_245_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 and not isNil(arg_245_1.actors_["10171ui_story"]) and arg_245_1.var_.characterEffect10171ui_story then
				arg_245_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171actionlink/10171action43031")
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_248_2 = 0
			local var_248_3 = 0.85

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_2 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_4 = arg_245_1:GetWordFromCfg(323082061)
				local var_248_5 = arg_245_1:FormatText(var_248_4.content)

				arg_245_1.text_.text = var_248_5

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_7 = 34 <= 0 and var_248_3 or var_248_3 * (utf8.len(var_248_5) / 34)

				if (34 <= 0 and var_248_3 or var_248_3 * (utf8.len(var_248_5) / 34)) > 0 and var_248_3 < var_248_7 then
					arg_245_1.talkMaxDuration = var_248_7

					if var_248_7 + var_248_2 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_7 + var_248_2
					end
				end

				arg_245_1.text_.text = var_248_5
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082061", "story_v_out_323082.awb") ~= 0 then
					local var_248_8 = manager.audio:GetVoiceLength("story_v_out_323082", "323082061", "story_v_out_323082.awb") / 1000

					if var_248_8 + var_248_2 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_8 + var_248_2
					end

					if var_248_4.prefab_name ~= "" and arg_245_1.actors_[var_248_4.prefab_name] ~= nil then
						local var_248_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_4.prefab_name].transform, "story_v_out_323082", "323082061", "story_v_out_323082.awb")

						arg_245_1:RecordAudio("323082061", var_248_9)
						arg_245_1:RecordAudio("323082061", var_248_9)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_323082", "323082061", "story_v_out_323082.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_323082", "323082061", "story_v_out_323082.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_10 = math.max(var_248_3, arg_245_1.talkMaxDuration)

			if var_248_2 <= arg_245_1.time_ and arg_245_1.time_ < var_248_2 + var_248_10 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_2) / var_248_10

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_2 + var_248_10 and arg_245_1.time_ < var_248_2 + var_248_10 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play323082062 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 323082062
		arg_249_1.duration_ = 2.67

		local var_249_0 = {
			zh = 1.4,
			ja = 2.666
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
				arg_249_0:Play323082063(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(arg_249_1.actors_["10171ui_story"]) and arg_249_1.var_.characterEffect10171ui_story == nil then
				arg_249_1.var_.characterEffect10171ui_story = arg_249_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_0 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 and not isNil(arg_249_1.actors_["10171ui_story"]) then
				if arg_249_1.var_.characterEffect10171ui_story and not isNil(arg_249_1.actors_["10171ui_story"]) then
					arg_249_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_249_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_249_1.time_ - 0) / var_252_0)
				end
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 and not isNil(arg_249_1.actors_["10171ui_story"]) and arg_249_1.var_.characterEffect10171ui_story then
				arg_249_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_249_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_252_1 = 0
			local var_252_2 = 0.15

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[1452].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, true)
				arg_249_1.iconController_:SetSelectedState("hero")

				arg_249_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_249_1.callingController_:SetSelectedState("normal")

				arg_249_1.keyicon_.color = Color.New(1, 1, 1)
				arg_249_1.icon_.color = Color.New(1, 1, 1)

				local var_252_3 = arg_249_1:GetWordFromCfg(323082062)
				local var_252_4 = arg_249_1:FormatText(var_252_3.content)

				arg_249_1.text_.text = var_252_4

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_6 = 6 <= 0 and var_252_2 or var_252_2 * (utf8.len(var_252_4) / 6)

				if (6 <= 0 and var_252_2 or var_252_2 * (utf8.len(var_252_4) / 6)) > 0 and var_252_2 < var_252_6 then
					arg_249_1.talkMaxDuration = var_252_6

					if var_252_6 + var_252_1 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_6 + var_252_1
					end
				end

				arg_249_1.text_.text = var_252_4
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082062", "story_v_out_323082.awb") ~= 0 then
					local var_252_7 = manager.audio:GetVoiceLength("story_v_out_323082", "323082062", "story_v_out_323082.awb") / 1000

					if var_252_7 + var_252_1 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_7 + var_252_1
					end

					if var_252_3.prefab_name ~= "" and arg_249_1.actors_[var_252_3.prefab_name] ~= nil then
						local var_252_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_3.prefab_name].transform, "story_v_out_323082", "323082062", "story_v_out_323082.awb")

						arg_249_1:RecordAudio("323082062", var_252_8)
						arg_249_1:RecordAudio("323082062", var_252_8)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_323082", "323082062", "story_v_out_323082.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_323082", "323082062", "story_v_out_323082.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_9 = math.max(var_252_2, arg_249_1.talkMaxDuration)

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_9 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_1) / var_252_9

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_1 + var_252_9 and arg_249_1.time_ < var_252_1 + var_252_9 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play323082063 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 323082063
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play323082064(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos10171ui_story = arg_253_1.actors_["10171ui_story"].transform.localPosition

				local var_256_0 = GameObjectTools.GetOrAddComponent(arg_253_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_256_0 then
					var_256_0:EnableDynamicBone(false)
				end
			end

			local var_256_1 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_1 then
				arg_253_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_253_1.time_ - 0) / var_256_1)
				arg_253_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["10171ui_story"].transform.position).z)
				arg_253_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["10171ui_story"].transform.localEulerAngles = arg_253_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_1 and arg_253_1.time_ < 0 + var_256_1 + arg_256_0 then
				arg_253_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_253_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["10171ui_story"].transform.position).z)
				arg_253_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["10171ui_story"].transform.localEulerAngles = arg_253_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_256_2 = GameObjectTools.GetOrAddComponent(arg_253_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_256_2 then
					var_256_2:EnableDynamicBone(true)
				end
			end

			local var_256_3 = 0
			local var_256_4 = 0.975

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_3 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_5 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(323082063).content)

				arg_253_1.text_.text = var_256_5

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_7 = 39 <= 0 and var_256_4 or var_256_4 * (utf8.len(var_256_5) / 39)

				if (39 <= 0 and var_256_4 or var_256_4 * (utf8.len(var_256_5) / 39)) > 0 and var_256_4 < var_256_7 then
					arg_253_1.talkMaxDuration = var_256_7

					if var_256_7 + var_256_3 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_7 + var_256_3
					end
				end

				arg_253_1.text_.text = var_256_5
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_8 = math.max(var_256_4, arg_253_1.talkMaxDuration)

			if var_256_3 <= arg_253_1.time_ and arg_253_1.time_ < var_256_3 + var_256_8 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_3) / var_256_8

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_3 + var_256_8 and arg_253_1.time_ < var_256_3 + var_256_8 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_253_1:InitPlayNodeList()
	end,
	Play323082064 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 323082064
		arg_257_1.duration_ = 15.3

		local var_257_0 = {
			zh = 7.8,
			ja = 15.3
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
				arg_257_0:Play323082065(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0.9

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[1452].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_1 = arg_257_1:GetWordFromCfg(323082064)
				local var_260_2 = arg_257_1:FormatText(var_260_1.content)

				arg_257_1.text_.text = var_260_2

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_4 = 36 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_2) / 36)

				if (36 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_2) / 36)) > 0 and var_260_0 < var_260_4 then
					arg_257_1.talkMaxDuration = var_260_4

					if var_260_4 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_4 + 0
					end
				end

				arg_257_1.text_.text = var_260_2
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082064", "story_v_out_323082.awb") ~= 0 then
					local var_260_5 = manager.audio:GetVoiceLength("story_v_out_323082", "323082064", "story_v_out_323082.awb") / 1000

					if var_260_5 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_5 + 0
					end

					if var_260_1.prefab_name ~= "" and arg_257_1.actors_[var_260_1.prefab_name] ~= nil then
						local var_260_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_1.prefab_name].transform, "story_v_out_323082", "323082064", "story_v_out_323082.awb")

						arg_257_1:RecordAudio("323082064", var_260_6)
						arg_257_1:RecordAudio("323082064", var_260_6)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_323082", "323082064", "story_v_out_323082.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_323082", "323082064", "story_v_out_323082.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_7 = math.max(var_260_0, arg_257_1.talkMaxDuration)

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_7 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - 0) / var_260_7

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= 0 + var_260_7 and arg_257_1.time_ < 0 + var_260_7 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play323082065 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 323082065
		arg_261_1.duration_ = 13.3

		local var_261_0 = {
			zh = 6.933,
			ja = 13.3
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
				arg_261_0:Play323082066(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos10171ui_story = arg_261_1.actors_["10171ui_story"].transform.localPosition

				local var_264_0 = GameObjectTools.GetOrAddComponent(arg_261_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_264_0 then
					var_264_0:EnableDynamicBone(false)
				end
			end

			local var_264_1 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_1 then
				arg_261_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos10171ui_story, Vector3.New(0, -0.95, -6.05), (arg_261_1.time_ - 0) / var_264_1)
				arg_261_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["10171ui_story"].transform.position).z)
				arg_261_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["10171ui_story"].transform.localEulerAngles = arg_261_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_261_1.time_ >= 0 + var_264_1 and arg_261_1.time_ < 0 + var_264_1 + arg_264_0 then
				arg_261_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_261_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["10171ui_story"].transform.position).z)
				arg_261_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["10171ui_story"].transform.localEulerAngles = arg_261_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_264_2 = GameObjectTools.GetOrAddComponent(arg_261_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_264_2 then
					var_264_2:EnableDynamicBone(true)
				end
			end

			local var_264_3 = arg_261_1.actors_["10171ui_story"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_3) and arg_261_1.var_.characterEffect10171ui_story == nil then
				arg_261_1.var_.characterEffect10171ui_story = var_264_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_4 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_4 and not isNil(var_264_3) then
				if arg_261_1.var_.characterEffect10171ui_story and not isNil(var_264_3) then
					arg_261_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= 0 + var_264_4 and arg_261_1.time_ < 0 + var_264_4 + arg_264_0 and not isNil(var_264_3) and arg_261_1.var_.characterEffect10171ui_story then
				arg_261_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action31_2")
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_264_6 = 0
			local var_264_7 = 1.175

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_6 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_8 = arg_261_1:GetWordFromCfg(323082065)
				local var_264_9 = arg_261_1:FormatText(var_264_8.content)

				arg_261_1.text_.text = var_264_9

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_11 = 47 <= 0 and var_264_7 or var_264_7 * (utf8.len(var_264_9) / 47)

				if (47 <= 0 and var_264_7 or var_264_7 * (utf8.len(var_264_9) / 47)) > 0 and var_264_7 < var_264_11 then
					arg_261_1.talkMaxDuration = var_264_11

					if var_264_11 + var_264_6 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_11 + var_264_6
					end
				end

				arg_261_1.text_.text = var_264_9
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082065", "story_v_out_323082.awb") ~= 0 then
					local var_264_12 = manager.audio:GetVoiceLength("story_v_out_323082", "323082065", "story_v_out_323082.awb") / 1000

					if var_264_12 + var_264_6 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_12 + var_264_6
					end

					if var_264_8.prefab_name ~= "" and arg_261_1.actors_[var_264_8.prefab_name] ~= nil then
						local var_264_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_8.prefab_name].transform, "story_v_out_323082", "323082065", "story_v_out_323082.awb")

						arg_261_1:RecordAudio("323082065", var_264_13)
						arg_261_1:RecordAudio("323082065", var_264_13)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_323082", "323082065", "story_v_out_323082.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_323082", "323082065", "story_v_out_323082.awb")
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
				actorName = "10171ui_story",
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
	Play323082066 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 323082066
		arg_265_1.duration_ = 7.17

		local var_265_0 = {
			zh = 4.533,
			ja = 7.166
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
				arg_265_0:Play323082067(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0.625

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_1 = arg_265_1:GetWordFromCfg(323082066)
				local var_268_2 = arg_265_1:FormatText(var_268_1.content)

				arg_265_1.text_.text = var_268_2

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_4 = 25 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_2) / 25)

				if (25 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_2) / 25)) > 0 and var_268_0 < var_268_4 then
					arg_265_1.talkMaxDuration = var_268_4

					if var_268_4 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_4 + 0
					end
				end

				arg_265_1.text_.text = var_268_2
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082066", "story_v_out_323082.awb") ~= 0 then
					local var_268_5 = manager.audio:GetVoiceLength("story_v_out_323082", "323082066", "story_v_out_323082.awb") / 1000

					if var_268_5 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_5 + 0
					end

					if var_268_1.prefab_name ~= "" and arg_265_1.actors_[var_268_1.prefab_name] ~= nil then
						local var_268_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_1.prefab_name].transform, "story_v_out_323082", "323082066", "story_v_out_323082.awb")

						arg_265_1:RecordAudio("323082066", var_268_6)
						arg_265_1:RecordAudio("323082066", var_268_6)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_323082", "323082066", "story_v_out_323082.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_323082", "323082066", "story_v_out_323082.awb")
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
	Play323082067 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 323082067
		arg_269_1.duration_ = 8.17

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play323082068(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 1.63333333333333 < arg_269_1.time_ and arg_269_1.time_ <= 1.63333333333333 + arg_272_0 then
				local var_272_0 = arg_269_1.bgs_.J23f

				arg_269_1.bgs_.J23f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_272_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_272_1 = var_272_0:GetComponent("SpriteRenderer")

				if var_272_1 and var_272_1.sprite then
					local var_272_2 = 2 * (var_272_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_272_0.transform.localScale = Vector3.New(var_272_2 / var_272_1.sprite.bounds.size.y < var_272_2 * manager.ui.mainCameraCom_.aspect / var_272_1.sprite.bounds.size.x and var_272_2 * manager.ui.mainCameraCom_.aspect / var_272_1.sprite.bounds.size.x or var_272_2 / var_272_1.sprite.bounds.size.y, var_272_2 / var_272_1.sprite.bounds.size.y < var_272_2 * manager.ui.mainCameraCom_.aspect / var_272_1.sprite.bounds.size.x and var_272_2 * manager.ui.mainCameraCom_.aspect / var_272_1.sprite.bounds.size.x or var_272_2 / var_272_1.sprite.bounds.size.y, 0)
				end

				for iter_272_0, iter_272_1 in pairs(arg_269_1.bgs_) do
					if iter_272_0 ~= "J23f" then
						iter_272_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_272_3 = 0

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_3 + arg_272_0 then
				arg_269_1.allBtn_.enabled = false
			end

			if arg_269_1.time_ >= var_272_3 + 0.3 and arg_269_1.time_ < var_272_3 + 0.3 + arg_272_0 then
				arg_269_1.allBtn_.enabled = true
			end

			local var_272_4 = 0

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_4 + arg_272_0 then
				arg_269_1.mask_.enabled = true
				arg_269_1.mask_.raycastTarget = true

				arg_269_1:SetGaussion(false)
			end

			local var_272_5 = 1.63333333333333

			if var_272_4 <= arg_269_1.time_ and arg_269_1.time_ < var_272_4 + var_272_5 then
				local var_272_6 = Color.New(0, 0, 0)

				var_272_6.a = Mathf.Lerp(0, 1, (arg_269_1.time_ - var_272_4) / var_272_5)
				arg_269_1.mask_.color = var_272_6
			end

			if arg_269_1.time_ >= var_272_4 + var_272_5 and arg_269_1.time_ < var_272_4 + var_272_5 + arg_272_0 then
				local var_272_7 = Color.New(0, 0, 0)

				var_272_7.a = 1
				arg_269_1.mask_.color = var_272_7
			end

			local var_272_8 = 1.63333333333333

			if 1.63333333333333 < arg_269_1.time_ and arg_269_1.time_ <= var_272_8 + arg_272_0 then
				arg_269_1.mask_.enabled = true
				arg_269_1.mask_.raycastTarget = true

				arg_269_1:SetGaussion(false)
			end

			local var_272_9 = 1.86666666666667

			if var_272_8 <= arg_269_1.time_ and arg_269_1.time_ < var_272_8 + var_272_9 then
				local var_272_10 = Color.New(0, 0, 0)

				var_272_10.a = Mathf.Lerp(1, 0, (arg_269_1.time_ - var_272_8) / var_272_9)
				arg_269_1.mask_.color = var_272_10
			end

			if arg_269_1.time_ >= var_272_8 + var_272_9 and arg_269_1.time_ < var_272_8 + var_272_9 + arg_272_0 then
				local var_272_11 = Color.New(0, 0, 0)

				arg_269_1.mask_.enabled = false
				var_272_11.a = 0
				arg_269_1.mask_.color = var_272_11
			end

			local var_272_12 = arg_269_1.actors_["10171ui_story"].transform

			if 1.63333333333333 < arg_269_1.time_ and arg_269_1.time_ <= 1.63333333333333 + arg_272_0 then
				arg_269_1.var_.moveOldPos10171ui_story = var_272_12.localPosition

				local var_272_13 = GameObjectTools.GetOrAddComponent(var_272_12.gameObject, typeof(DynamicBoneHelper))

				if var_272_13 then
					var_272_13:EnableDynamicBone(false)
				end
			end

			local var_272_14 = 0.001

			if 1.63333333333333 <= arg_269_1.time_ and arg_269_1.time_ < 1.63333333333333 + var_272_14 then
				var_272_12.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_269_1.time_ - 1.63333333333333) / var_272_14)
				var_272_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_272_12.position).x, (manager.ui.mainCamera.transform.position - var_272_12.position).y, (manager.ui.mainCamera.transform.position - var_272_12.position).z)
				var_272_12.localEulerAngles.z = 0
				var_272_12.localEulerAngles.x = 0
				var_272_12.localEulerAngles = var_272_12.localEulerAngles
			end

			if arg_269_1.time_ >= 1.63333333333333 + var_272_14 and arg_269_1.time_ < 1.63333333333333 + var_272_14 + arg_272_0 then
				var_272_12.localPosition = Vector3.New(0, 100, 0)
				var_272_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_272_12.position).x, (manager.ui.mainCamera.transform.position - var_272_12.position).y, (manager.ui.mainCamera.transform.position - var_272_12.position).z)
				var_272_12.localEulerAngles.z = 0
				var_272_12.localEulerAngles.x = 0
				var_272_12.localEulerAngles = var_272_12.localEulerAngles

				local var_272_15 = GameObjectTools.GetOrAddComponent(var_272_12.gameObject, typeof(DynamicBoneHelper))

				if var_272_15 then
					var_272_15:EnableDynamicBone(true)
				end
			end

			local var_272_16 = arg_269_1.actors_["10171ui_story"]

			if 1.63333333333333 < arg_269_1.time_ and arg_269_1.time_ <= 1.63333333333333 + arg_272_0 and not isNil(var_272_16) and arg_269_1.var_.characterEffect10171ui_story == nil then
				arg_269_1.var_.characterEffect10171ui_story = var_272_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_17 = 0.200000002980232

			if 1.63333333333333 <= arg_269_1.time_ and arg_269_1.time_ < 1.63333333333333 + var_272_17 and not isNil(var_272_16) then
				if arg_269_1.var_.characterEffect10171ui_story and not isNil(var_272_16) then
					arg_269_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_269_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_269_1.time_ - 1.63333333333333) / var_272_17)
				end
			end

			if arg_269_1.time_ >= 1.63333333333333 + var_272_17 and arg_269_1.time_ < 1.63333333333333 + var_272_17 + arg_272_0 and not isNil(var_272_16) and arg_269_1.var_.characterEffect10171ui_story then
				arg_269_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_269_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			if arg_269_1.frameCnt_ <= 1 then
				arg_269_1.dialog_:SetActive(false)
			end

			local var_272_18 = 3.16666666666667
			local var_272_19 = 0.8

			if 3.16666666666667 < arg_269_1.time_ and arg_269_1.time_ <= var_272_18 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0

				arg_269_1.dialog_:SetActive(true)

				arg_269_1.dialogCg_.alpha = 0

				local var_272_20 = LeanTween.value(arg_269_1.dialog_, 0, 1, 0.3)

				var_272_20:setOnUpdate(LuaHelper.FloatAction(function(arg_273_0)
					arg_269_1.dialogCg_.alpha = arg_273_0
				end))
				var_272_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_269_1.dialog_)
					var_272_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_269_1.duration_ = arg_269_1.duration_ + 0.3

				SetActive(arg_269_1.leftNameGo_, false)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_21 = arg_269_1:FormatText(arg_269_1:GetWordFromCfg(323082067).content)

				arg_269_1.text_.text = var_272_21

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_23 = 32 <= 0 and var_272_19 or var_272_19 * (utf8.len(var_272_21) / 32)

				if (32 <= 0 and var_272_19 or var_272_19 * (utf8.len(var_272_21) / 32)) > 0 and var_272_19 < var_272_23 then
					arg_269_1.talkMaxDuration = var_272_23
					var_272_18 = var_272_18 + 0.3

					if var_272_23 + var_272_18 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_23 + var_272_18
					end
				end

				arg_269_1.text_.text = var_272_21
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_24 = var_272_18 + 0.3
			local var_272_25 = math.max(var_272_19, arg_269_1.talkMaxDuration)

			if var_272_18 + 0.3 <= arg_269_1.time_ and arg_269_1.time_ < var_272_24 + var_272_25 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_24) / var_272_25

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_24 + var_272_25 and arg_269_1.time_ < var_272_24 + var_272_25 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.63333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play323082068 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 323082068
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play323082069(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0.925

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, false)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_1 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(323082068).content)

				arg_275_1.text_.text = var_278_1

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_3 = 37 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_1) / 37)

				if (37 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_1) / 37)) > 0 and var_278_0 < var_278_3 then
					arg_275_1.talkMaxDuration = var_278_3

					if var_278_3 + 0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_3 + 0
					end
				end

				arg_275_1.text_.text = var_278_1
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_4 = math.max(var_278_0, arg_275_1.talkMaxDuration)

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_4 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - 0) / var_278_4

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= 0 + var_278_4 and arg_275_1.time_ < 0 + var_278_4 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play323082069 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 323082069
		arg_279_1.duration_ = 2.57

		local var_279_0 = {
			zh = 1.9,
			ja = 2.566
		}
		local var_279_1 = manager.audio:GetLocalizationFlag()

		if var_279_0[var_279_1] ~= nil then
			arg_279_1.duration_ = var_279_0[var_279_1]
		end

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play323082070(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos10171ui_story = arg_279_1.actors_["10171ui_story"].transform.localPosition

				local var_282_0 = GameObjectTools.GetOrAddComponent(arg_279_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_282_0 then
					var_282_0:EnableDynamicBone(false)
				end
			end

			local var_282_1 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_1 then
				arg_279_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos10171ui_story, Vector3.New(0, -0.95, -6.05), (arg_279_1.time_ - 0) / var_282_1)
				arg_279_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["10171ui_story"].transform.position).z)
				arg_279_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["10171ui_story"].transform.localEulerAngles = arg_279_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_279_1.time_ >= 0 + var_282_1 and arg_279_1.time_ < 0 + var_282_1 + arg_282_0 then
				arg_279_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_279_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["10171ui_story"].transform.position).z)
				arg_279_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["10171ui_story"].transform.localEulerAngles = arg_279_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_282_2 = GameObjectTools.GetOrAddComponent(arg_279_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_282_2 then
					var_282_2:EnableDynamicBone(true)
				end
			end

			local var_282_3 = arg_279_1.actors_["10171ui_story"]

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(var_282_3) and arg_279_1.var_.characterEffect10171ui_story == nil then
				arg_279_1.var_.characterEffect10171ui_story = var_282_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_4 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_4 and not isNil(var_282_3) then
				if arg_279_1.var_.characterEffect10171ui_story and not isNil(var_282_3) then
					arg_279_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= 0 + var_282_4 and arg_279_1.time_ < 0 + var_282_4 + arg_282_0 and not isNil(var_282_3) and arg_279_1.var_.characterEffect10171ui_story then
				arg_279_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action1_1")
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_282_6 = 0
			local var_282_7 = 0.225

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_6 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_8 = arg_279_1:GetWordFromCfg(323082069)
				local var_282_9 = arg_279_1:FormatText(var_282_8.content)

				arg_279_1.text_.text = var_282_9

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_11 = 9 <= 0 and var_282_7 or var_282_7 * (utf8.len(var_282_9) / 9)

				if (9 <= 0 and var_282_7 or var_282_7 * (utf8.len(var_282_9) / 9)) > 0 and var_282_7 < var_282_11 then
					arg_279_1.talkMaxDuration = var_282_11

					if var_282_11 + var_282_6 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_11 + var_282_6
					end
				end

				arg_279_1.text_.text = var_282_9
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082069", "story_v_out_323082.awb") ~= 0 then
					local var_282_12 = manager.audio:GetVoiceLength("story_v_out_323082", "323082069", "story_v_out_323082.awb") / 1000

					if var_282_12 + var_282_6 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_12 + var_282_6
					end

					if var_282_8.prefab_name ~= "" and arg_279_1.actors_[var_282_8.prefab_name] ~= nil then
						local var_282_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_8.prefab_name].transform, "story_v_out_323082", "323082069", "story_v_out_323082.awb")

						arg_279_1:RecordAudio("323082069", var_282_13)
						arg_279_1:RecordAudio("323082069", var_282_13)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_323082", "323082069", "story_v_out_323082.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_323082", "323082069", "story_v_out_323082.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_14 = math.max(var_282_7, arg_279_1.talkMaxDuration)

			if var_282_6 <= arg_279_1.time_ and arg_279_1.time_ < var_282_6 + var_282_14 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_6) / var_282_14

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_6 + var_282_14 and arg_279_1.time_ < var_282_6 + var_282_14 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_279_1:InitPlayNodeList()
	end,
	Play323082070 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 323082070
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play323082071(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(arg_283_1.actors_["10171ui_story"]) and arg_283_1.var_.characterEffect10171ui_story == nil then
				arg_283_1.var_.characterEffect10171ui_story = arg_283_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_0 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 and not isNil(arg_283_1.actors_["10171ui_story"]) then
				if arg_283_1.var_.characterEffect10171ui_story and not isNil(arg_283_1.actors_["10171ui_story"]) then
					arg_283_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_283_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_283_1.time_ - 0) / var_286_0)
				end
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 and not isNil(arg_283_1.actors_["10171ui_story"]) and arg_283_1.var_.characterEffect10171ui_story then
				arg_283_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_283_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_286_1 = 0
			local var_286_2 = 0.525

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, true)
				arg_283_1.iconController_:SetSelectedState("hero")

				arg_283_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_283_1.callingController_:SetSelectedState("normal")

				arg_283_1.keyicon_.color = Color.New(1, 1, 1)
				arg_283_1.icon_.color = Color.New(1, 1, 1)

				local var_286_3 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(323082070).content)

				arg_283_1.text_.text = var_286_3

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_5 = 21 <= 0 and var_286_2 or var_286_2 * (utf8.len(var_286_3) / 21)

				if (21 <= 0 and var_286_2 or var_286_2 * (utf8.len(var_286_3) / 21)) > 0 and var_286_2 < var_286_5 then
					arg_283_1.talkMaxDuration = var_286_5

					if var_286_5 + var_286_1 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_5 + var_286_1
					end
				end

				arg_283_1.text_.text = var_286_3
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_6 = math.max(var_286_2, arg_283_1.talkMaxDuration)

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_6 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_1) / var_286_6

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_1 + var_286_6 and arg_283_1.time_ < var_286_1 + var_286_6 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play323082071 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 323082071
		arg_287_1.duration_ = 4.6

		local var_287_0 = {
			zh = 4.6,
			ja = 3.9
		}
		local var_287_1 = manager.audio:GetLocalizationFlag()

		if var_287_0[var_287_1] ~= nil then
			arg_287_1.duration_ = var_287_0[var_287_1]
		end

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play323082072(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(arg_287_1.actors_["10171ui_story"]) and arg_287_1.var_.characterEffect10171ui_story == nil then
				arg_287_1.var_.characterEffect10171ui_story = arg_287_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_0 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 and not isNil(arg_287_1.actors_["10171ui_story"]) then
				if arg_287_1.var_.characterEffect10171ui_story and not isNil(arg_287_1.actors_["10171ui_story"]) then
					arg_287_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 and not isNil(arg_287_1.actors_["10171ui_story"]) and arg_287_1.var_.characterEffect10171ui_story then
				arg_287_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action1_1")
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_290_2 = 0
			local var_290_3 = 0.575

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_2 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_4 = arg_287_1:GetWordFromCfg(323082071)
				local var_290_5 = arg_287_1:FormatText(var_290_4.content)

				arg_287_1.text_.text = var_290_5

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_7 = 23 <= 0 and var_290_3 or var_290_3 * (utf8.len(var_290_5) / 23)

				if (23 <= 0 and var_290_3 or var_290_3 * (utf8.len(var_290_5) / 23)) > 0 and var_290_3 < var_290_7 then
					arg_287_1.talkMaxDuration = var_290_7

					if var_290_7 + var_290_2 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_7 + var_290_2
					end
				end

				arg_287_1.text_.text = var_290_5
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082071", "story_v_out_323082.awb") ~= 0 then
					local var_290_8 = manager.audio:GetVoiceLength("story_v_out_323082", "323082071", "story_v_out_323082.awb") / 1000

					if var_290_8 + var_290_2 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_8 + var_290_2
					end

					if var_290_4.prefab_name ~= "" and arg_287_1.actors_[var_290_4.prefab_name] ~= nil then
						local var_290_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_4.prefab_name].transform, "story_v_out_323082", "323082071", "story_v_out_323082.awb")

						arg_287_1:RecordAudio("323082071", var_290_9)
						arg_287_1:RecordAudio("323082071", var_290_9)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_323082", "323082071", "story_v_out_323082.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_323082", "323082071", "story_v_out_323082.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_10 = math.max(var_290_3, arg_287_1.talkMaxDuration)

			if var_290_2 <= arg_287_1.time_ and arg_287_1.time_ < var_290_2 + var_290_10 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_2) / var_290_10

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_2 + var_290_10 and arg_287_1.time_ < var_290_2 + var_290_10 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play323082072 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 323082072
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play323082073(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(arg_291_1.actors_["10171ui_story"]) and arg_291_1.var_.characterEffect10171ui_story == nil then
				arg_291_1.var_.characterEffect10171ui_story = arg_291_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_0 = 0.200000002980232

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 and not isNil(arg_291_1.actors_["10171ui_story"]) then
				if arg_291_1.var_.characterEffect10171ui_story and not isNil(arg_291_1.actors_["10171ui_story"]) then
					arg_291_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_291_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_291_1.time_ - 0) / var_294_0)
				end
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 and not isNil(arg_291_1.actors_["10171ui_story"]) and arg_291_1.var_.characterEffect10171ui_story then
				arg_291_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_291_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_294_1 = 0
			local var_294_2 = 1.05

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, true)
				arg_291_1.iconController_:SetSelectedState("hero")

				arg_291_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_291_1.callingController_:SetSelectedState("normal")

				arg_291_1.keyicon_.color = Color.New(1, 1, 1)
				arg_291_1.icon_.color = Color.New(1, 1, 1)

				local var_294_3 = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(323082072).content)

				arg_291_1.text_.text = var_294_3

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_5 = 42 <= 0 and var_294_2 or var_294_2 * (utf8.len(var_294_3) / 42)

				if (42 <= 0 and var_294_2 or var_294_2 * (utf8.len(var_294_3) / 42)) > 0 and var_294_2 < var_294_5 then
					arg_291_1.talkMaxDuration = var_294_5

					if var_294_5 + var_294_1 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_5 + var_294_1
					end
				end

				arg_291_1.text_.text = var_294_3
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_6 = math.max(var_294_2, arg_291_1.talkMaxDuration)

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_6 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_1) / var_294_6

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_1 + var_294_6 and arg_291_1.time_ < var_294_1 + var_294_6 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play323082073 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 323082073
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play323082074(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0.8

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, true)
				arg_295_1.iconController_:SetSelectedState("hero")

				arg_295_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_295_1.callingController_:SetSelectedState("normal")

				arg_295_1.keyicon_.color = Color.New(1, 1, 1)
				arg_295_1.icon_.color = Color.New(1, 1, 1)

				local var_298_1 = arg_295_1:FormatText(arg_295_1:GetWordFromCfg(323082073).content)

				arg_295_1.text_.text = var_298_1

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_3 = 32 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_1) / 32)

				if (32 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_1) / 32)) > 0 and var_298_0 < var_298_3 then
					arg_295_1.talkMaxDuration = var_298_3

					if var_298_3 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_3 + 0
					end
				end

				arg_295_1.text_.text = var_298_1
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_4 = math.max(var_298_0, arg_295_1.talkMaxDuration)

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_4 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - 0) / var_298_4

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= 0 + var_298_4 and arg_295_1.time_ < 0 + var_298_4 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play323082074 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 323082074
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play323082075(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.var_.moveOldPos10171ui_story = arg_299_1.actors_["10171ui_story"].transform.localPosition

				local var_302_0 = GameObjectTools.GetOrAddComponent(arg_299_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_302_0 then
					var_302_0:EnableDynamicBone(false)
				end
			end

			local var_302_1 = 0.001

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_1 then
				arg_299_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_299_1.time_ - 0) / var_302_1)
				arg_299_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_299_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["10171ui_story"].transform.position).z)
				arg_299_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_299_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_299_1.actors_["10171ui_story"].transform.localEulerAngles = arg_299_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_299_1.time_ >= 0 + var_302_1 and arg_299_1.time_ < 0 + var_302_1 + arg_302_0 then
				arg_299_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_299_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_299_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["10171ui_story"].transform.position).z)
				arg_299_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_299_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_299_1.actors_["10171ui_story"].transform.localEulerAngles = arg_299_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_302_2 = GameObjectTools.GetOrAddComponent(arg_299_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_302_2 then
					var_302_2:EnableDynamicBone(true)
				end
			end

			if 0.034000001847744 < arg_299_1.time_ and arg_299_1.time_ <= 0.034000001847744 + arg_302_0 then
				arg_299_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_clap", "")
			end

			local var_302_4 = 0
			local var_302_5 = 0.775

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_4 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, false)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_6 = arg_299_1:FormatText(arg_299_1:GetWordFromCfg(323082074).content)

				arg_299_1.text_.text = var_302_6

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_8 = 31 <= 0 and var_302_5 or var_302_5 * (utf8.len(var_302_6) / 31)

				if (31 <= 0 and var_302_5 or var_302_5 * (utf8.len(var_302_6) / 31)) > 0 and var_302_5 < var_302_8 then
					arg_299_1.talkMaxDuration = var_302_8

					if var_302_8 + var_302_4 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_8 + var_302_4
					end
				end

				arg_299_1.text_.text = var_302_6
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_9 = math.max(var_302_5, arg_299_1.talkMaxDuration)

			if var_302_4 <= arg_299_1.time_ and arg_299_1.time_ < var_302_4 + var_302_9 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_4) / var_302_9

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_4 + var_302_9 and arg_299_1.time_ < var_302_4 + var_302_9 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_299_1:InitPlayNodeList()
	end,
	Play323082075 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 323082075
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play323082076(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 0.675

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, true)
				arg_303_1.iconController_:SetSelectedState("hero")

				arg_303_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_303_1.callingController_:SetSelectedState("normal")

				arg_303_1.keyicon_.color = Color.New(1, 1, 1)
				arg_303_1.icon_.color = Color.New(1, 1, 1)

				local var_306_1 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(323082075).content)

				arg_303_1.text_.text = var_306_1

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_3 = 27 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_1) / 27)

				if (27 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_1) / 27)) > 0 and var_306_0 < var_306_3 then
					arg_303_1.talkMaxDuration = var_306_3

					if var_306_3 + 0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_3 + 0
					end
				end

				arg_303_1.text_.text = var_306_1
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_4 = math.max(var_306_0, arg_303_1.talkMaxDuration)

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_4 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - 0) / var_306_4

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= 0 + var_306_4 and arg_303_1.time_ < 0 + var_306_4 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play323082076 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 323082076
		arg_307_1.duration_ = 6.37

		local var_307_0 = {
			zh = 4.89966666666667,
			ja = 6.36666666666667
		}
		local var_307_1 = manager.audio:GetLocalizationFlag()

		if var_307_0[var_307_1] ~= nil then
			arg_307_1.duration_ = var_307_0[var_307_1]
		end

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play323082077(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.var_.moveOldPos1070ui_story = arg_307_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_310_0 = 0.001

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 then
				arg_307_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_307_1.time_ - 0) / var_310_0)
				arg_307_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_307_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["1070ui_story"].transform.position).z)
				arg_307_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_307_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_307_1.actors_["1070ui_story"].transform.localEulerAngles = arg_307_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 then
				arg_307_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_307_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_307_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["1070ui_story"].transform.position).z)
				arg_307_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_307_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_307_1.actors_["1070ui_story"].transform.localEulerAngles = arg_307_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_310_1 = arg_307_1.actors_["1070ui_story"]

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(var_310_1) and arg_307_1.var_.characterEffect1070ui_story == nil then
				arg_307_1.var_.characterEffect1070ui_story = var_310_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_2 = 0.200000002980232

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_2 and not isNil(var_310_1) then
				if arg_307_1.var_.characterEffect1070ui_story and not isNil(var_310_1) then
					arg_307_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_307_1.time_ >= 0 + var_310_2 and arg_307_1.time_ < 0 + var_310_2 + arg_310_0 and not isNil(var_310_1) and arg_307_1.var_.characterEffect1070ui_story then
				arg_307_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action2_1")
			end

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_310_4 = 0

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_4 + arg_310_0 then
				arg_307_1.allBtn_.enabled = false
			end

			if arg_307_1.time_ >= var_310_4 + 1 and arg_307_1.time_ < var_310_4 + 1 + arg_310_0 then
				arg_307_1.allBtn_.enabled = true
			end

			if arg_307_1.frameCnt_ <= 1 then
				arg_307_1.dialog_:SetActive(false)
			end

			local var_310_5 = 0.666666666666667
			local var_310_6 = 0.6

			if 0.666666666666667 < arg_307_1.time_ and arg_307_1.time_ <= var_310_5 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0

				arg_307_1.dialog_:SetActive(true)

				arg_307_1.dialogCg_.alpha = 0

				local var_310_7 = LeanTween.value(arg_307_1.dialog_, 0, 1, 0.3)

				var_310_7:setOnUpdate(LuaHelper.FloatAction(function(arg_311_0)
					arg_307_1.dialogCg_.alpha = arg_311_0
				end))
				var_310_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_307_1.dialog_)
					var_310_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_307_1.duration_ = arg_307_1.duration_ + 0.3

				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_8 = arg_307_1:GetWordFromCfg(323082076)
				local var_310_9 = arg_307_1:FormatText(var_310_8.content)

				arg_307_1.text_.text = var_310_9

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_11 = 24 <= 0 and var_310_6 or var_310_6 * (utf8.len(var_310_9) / 24)

				if (24 <= 0 and var_310_6 or var_310_6 * (utf8.len(var_310_9) / 24)) > 0 and var_310_6 < var_310_11 then
					arg_307_1.talkMaxDuration = var_310_11
					var_310_5 = var_310_5 + 0.3

					if var_310_11 + var_310_5 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_11 + var_310_5
					end
				end

				arg_307_1.text_.text = var_310_9
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082076", "story_v_out_323082.awb") ~= 0 then
					local var_310_12 = manager.audio:GetVoiceLength("story_v_out_323082", "323082076", "story_v_out_323082.awb") / 1000

					if var_310_12 + var_310_5 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_12 + var_310_5
					end

					if var_310_8.prefab_name ~= "" and arg_307_1.actors_[var_310_8.prefab_name] ~= nil then
						local var_310_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_8.prefab_name].transform, "story_v_out_323082", "323082076", "story_v_out_323082.awb")

						arg_307_1:RecordAudio("323082076", var_310_13)
						arg_307_1:RecordAudio("323082076", var_310_13)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_323082", "323082076", "story_v_out_323082.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_323082", "323082076", "story_v_out_323082.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_14 = var_310_5 + 0.3
			local var_310_15 = math.max(var_310_6, arg_307_1.talkMaxDuration)

			if var_310_5 + 0.3 <= arg_307_1.time_ and arg_307_1.time_ < var_310_14 + var_310_15 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_14) / var_310_15

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_14 + var_310_15 and arg_307_1.time_ < var_310_14 + var_310_15 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_307_1:InitPlayNodeList()
	end,
	Play323082077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 323082077
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play323082078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(arg_313_1.actors_["1070ui_story"]) and arg_313_1.var_.characterEffect1070ui_story == nil then
				arg_313_1.var_.characterEffect1070ui_story = arg_313_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_0 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 and not isNil(arg_313_1.actors_["1070ui_story"]) then
				if arg_313_1.var_.characterEffect1070ui_story and not isNil(arg_313_1.actors_["1070ui_story"]) then
					arg_313_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_313_1.time_ - 0) / var_316_0)
				end
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 and not isNil(arg_313_1.actors_["1070ui_story"]) and arg_313_1.var_.characterEffect1070ui_story then
				arg_313_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_316_1 = 0
			local var_316_2 = 1

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_3 = arg_313_1:FormatText(arg_313_1:GetWordFromCfg(323082077).content)

				arg_313_1.text_.text = var_316_3

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_5 = 40 <= 0 and var_316_2 or var_316_2 * (utf8.len(var_316_3) / 40)

				if (40 <= 0 and var_316_2 or var_316_2 * (utf8.len(var_316_3) / 40)) > 0 and var_316_2 < var_316_5 then
					arg_313_1.talkMaxDuration = var_316_5

					if var_316_5 + var_316_1 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_5 + var_316_1
					end
				end

				arg_313_1.text_.text = var_316_3
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_6 = math.max(var_316_2, arg_313_1.talkMaxDuration)

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_6 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_1) / var_316_6

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_1 + var_316_6 and arg_313_1.time_ < var_316_1 + var_316_6 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play323082078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 323082078
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play323082079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 1.35

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, true)
				arg_317_1.iconController_:SetSelectedState("hero")

				arg_317_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_317_1.callingController_:SetSelectedState("normal")

				arg_317_1.keyicon_.color = Color.New(1, 1, 1)
				arg_317_1.icon_.color = Color.New(1, 1, 1)

				local var_320_1 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(323082078).content)

				arg_317_1.text_.text = var_320_1

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_3 = 54 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_1) / 54)

				if (54 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_1) / 54)) > 0 and var_320_0 < var_320_3 then
					arg_317_1.talkMaxDuration = var_320_3

					if var_320_3 + 0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_3 + 0
					end
				end

				arg_317_1.text_.text = var_320_1
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_4 = math.max(var_320_0, arg_317_1.talkMaxDuration)

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_4 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - 0) / var_320_4

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= 0 + var_320_4 and arg_317_1.time_ < 0 + var_320_4 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play323082079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 323082079
		arg_321_1.duration_ = 4.8

		local var_321_0 = {
			zh = 4.8,
			ja = 4.233
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
				arg_321_0:Play323082080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(arg_321_1.actors_["1070ui_story"]) and arg_321_1.var_.characterEffect1070ui_story == nil then
				arg_321_1.var_.characterEffect1070ui_story = arg_321_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_0 = 0.200000002980232

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 and not isNil(arg_321_1.actors_["1070ui_story"]) then
				if arg_321_1.var_.characterEffect1070ui_story and not isNil(arg_321_1.actors_["1070ui_story"]) then
					arg_321_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 and not isNil(arg_321_1.actors_["1070ui_story"]) and arg_321_1.var_.characterEffect1070ui_story then
				arg_321_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action2_2")
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_324_2 = 0
			local var_324_3 = 0.325

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_2 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_4 = arg_321_1:GetWordFromCfg(323082079)
				local var_324_5 = arg_321_1:FormatText(var_324_4.content)

				arg_321_1.text_.text = var_324_5

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_7 = 13 <= 0 and var_324_3 or var_324_3 * (utf8.len(var_324_5) / 13)

				if (13 <= 0 and var_324_3 or var_324_3 * (utf8.len(var_324_5) / 13)) > 0 and var_324_3 < var_324_7 then
					arg_321_1.talkMaxDuration = var_324_7

					if var_324_7 + var_324_2 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_7 + var_324_2
					end
				end

				arg_321_1.text_.text = var_324_5
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082079", "story_v_out_323082.awb") ~= 0 then
					local var_324_8 = manager.audio:GetVoiceLength("story_v_out_323082", "323082079", "story_v_out_323082.awb") / 1000

					if var_324_8 + var_324_2 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_8 + var_324_2
					end

					if var_324_4.prefab_name ~= "" and arg_321_1.actors_[var_324_4.prefab_name] ~= nil then
						local var_324_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_4.prefab_name].transform, "story_v_out_323082", "323082079", "story_v_out_323082.awb")

						arg_321_1:RecordAudio("323082079", var_324_9)
						arg_321_1:RecordAudio("323082079", var_324_9)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_323082", "323082079", "story_v_out_323082.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_323082", "323082079", "story_v_out_323082.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_10 = math.max(var_324_3, arg_321_1.talkMaxDuration)

			if var_324_2 <= arg_321_1.time_ and arg_321_1.time_ < var_324_2 + var_324_10 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_2) / var_324_10

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_2 + var_324_10 and arg_321_1.time_ < var_324_2 + var_324_10 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play323082080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 323082080
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play323082081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(arg_325_1.actors_["1070ui_story"]) and arg_325_1.var_.characterEffect1070ui_story == nil then
				arg_325_1.var_.characterEffect1070ui_story = arg_325_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_0 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 and not isNil(arg_325_1.actors_["1070ui_story"]) then
				if arg_325_1.var_.characterEffect1070ui_story and not isNil(arg_325_1.actors_["1070ui_story"]) then
					arg_325_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_325_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_325_1.time_ - 0) / var_328_0)
				end
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 and not isNil(arg_325_1.actors_["1070ui_story"]) and arg_325_1.var_.characterEffect1070ui_story then
				arg_325_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_325_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_328_1 = 0
			local var_328_2 = 1.3

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

				local var_328_3 = arg_325_1:FormatText(arg_325_1:GetWordFromCfg(323082080).content)

				arg_325_1.text_.text = var_328_3

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_5 = 52 <= 0 and var_328_2 or var_328_2 * (utf8.len(var_328_3) / 52)

				if (52 <= 0 and var_328_2 or var_328_2 * (utf8.len(var_328_3) / 52)) > 0 and var_328_2 < var_328_5 then
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
	Play323082081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 323082081
		arg_329_1.duration_ = 3.37

		local var_329_0 = {
			zh = 2.63333333333333,
			ja = 3.36633333333333
		}
		local var_329_1 = manager.audio:GetLocalizationFlag()

		if var_329_0[var_329_1] ~= nil then
			arg_329_1.duration_ = var_329_0[var_329_1]
		end

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play323082082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos1070ui_story = arg_329_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_332_0 = 0.001

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 then
				arg_329_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_329_1.time_ - 0) / var_332_0)
				arg_329_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_329_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1070ui_story"].transform.position).z)
				arg_329_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_329_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_329_1.actors_["1070ui_story"].transform.localEulerAngles = arg_329_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 then
				arg_329_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_329_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_329_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1070ui_story"].transform.position).z)
				arg_329_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_329_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_329_1.actors_["1070ui_story"].transform.localEulerAngles = arg_329_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_332_1 = "1071ui_story"

			if arg_329_1.actors_["1071ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1071ui_story"))) then
				local var_332_2 = Object.Instantiate(Asset.Load("Char/" .. "1071ui_story"), arg_329_1.stage_.transform)

				var_332_2.name = var_332_1
				var_332_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_329_1.actors_[var_332_1] = var_332_2

				local var_332_3 = var_332_2:GetComponentInChildren(typeof(CharacterEffect))

				var_332_3.enabled = true

				local var_332_4 = GameObjectTools.GetOrAddComponent(var_332_2, typeof(DynamicBoneHelper))

				if var_332_4 then
					var_332_4:EnableDynamicBone(false)
				end

				arg_329_1:ShowWeapon(var_332_3.transform, false)

				arg_329_1.var_[var_332_1 .. "Animator"] = var_332_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_329_1.var_[var_332_1 .. "Animator"].applyRootMotion = true
				arg_329_1.var_[var_332_1 .. "LipSync"] = var_332_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_332_5 = arg_329_1.actors_["1071ui_story"]

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(var_332_5) and arg_329_1.var_.characterEffect1071ui_story == nil then
				arg_329_1.var_.characterEffect1071ui_story = var_332_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_6 = 0.200000002980232

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_6 and not isNil(var_332_5) then
				if arg_329_1.var_.characterEffect1071ui_story and not isNil(var_332_5) then
					arg_329_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_329_1.time_ >= 0 + var_332_6 and arg_329_1.time_ < 0 + var_332_6 + arg_332_0 and not isNil(var_332_5) and arg_329_1.var_.characterEffect1071ui_story then
				arg_329_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_332_8 = 0

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_8 + arg_332_0 then
				arg_329_1.allBtn_.enabled = false
			end

			if arg_329_1.time_ >= var_332_8 + 0.533333333333333 and arg_329_1.time_ < var_332_8 + 0.533333333333333 + arg_332_0 then
				arg_329_1.allBtn_.enabled = true
			end

			if arg_329_1.frameCnt_ <= 1 then
				arg_329_1.dialog_:SetActive(false)
			end

			local var_332_9 = 0.433333333333333
			local var_332_10 = 0.2

			if 0.433333333333333 < arg_329_1.time_ and arg_329_1.time_ <= var_332_9 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0

				arg_329_1.dialog_:SetActive(true)

				arg_329_1.dialogCg_.alpha = 0

				local var_332_11 = LeanTween.value(arg_329_1.dialog_, 0, 1, 0.3)

				var_332_11:setOnUpdate(LuaHelper.FloatAction(function(arg_333_0)
					arg_329_1.dialogCg_.alpha = arg_333_0
				end))
				var_332_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_329_1.dialog_)
					var_332_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_329_1.duration_ = arg_329_1.duration_ + 0.3

				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, true)
				arg_329_1.iconController_:SetSelectedState("hero")

				arg_329_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1071")

				arg_329_1.callingController_:SetSelectedState("calling")

				arg_329_1.keyicon_.color = Color.New(1, 1, 1)
				arg_329_1.icon_.color = Color.New(1, 1, 1)

				local var_332_12 = arg_329_1:GetWordFromCfg(323082081)
				local var_332_13 = arg_329_1:FormatText(var_332_12.content)

				arg_329_1.text_.text = var_332_13

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_15 = 8 <= 0 and var_332_10 or var_332_10 * (utf8.len(var_332_13) / 8)

				if (8 <= 0 and var_332_10 or var_332_10 * (utf8.len(var_332_13) / 8)) > 0 and var_332_10 < var_332_15 then
					arg_329_1.talkMaxDuration = var_332_15
					var_332_9 = var_332_9 + 0.3

					if var_332_15 + var_332_9 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_15 + var_332_9
					end
				end

				arg_329_1.text_.text = var_332_13
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082081", "story_v_out_323082.awb") ~= 0 then
					local var_332_16 = manager.audio:GetVoiceLength("story_v_out_323082", "323082081", "story_v_out_323082.awb") / 1000

					if var_332_16 + var_332_9 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_16 + var_332_9
					end

					if var_332_12.prefab_name ~= "" and arg_329_1.actors_[var_332_12.prefab_name] ~= nil then
						local var_332_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_12.prefab_name].transform, "story_v_out_323082", "323082081", "story_v_out_323082.awb")

						arg_329_1:RecordAudio("323082081", var_332_17)
						arg_329_1:RecordAudio("323082081", var_332_17)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_323082", "323082081", "story_v_out_323082.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_323082", "323082081", "story_v_out_323082.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_18 = var_332_9 + 0.3
			local var_332_19 = math.max(var_332_10, arg_329_1.talkMaxDuration)

			if var_332_9 + 0.3 <= arg_329_1.time_ and arg_329_1.time_ < var_332_18 + var_332_19 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_18) / var_332_19

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_18 + var_332_19 and arg_329_1.time_ < var_332_18 + var_332_19 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_329_1:InitPlayNodeList()
	end,
	Play323082082 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 323082082
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play323082083(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(arg_335_1.actors_["1071ui_story"]) and arg_335_1.var_.characterEffect1071ui_story == nil then
				arg_335_1.var_.characterEffect1071ui_story = arg_335_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_0 = 0.200000002980232

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_0 and not isNil(arg_335_1.actors_["1071ui_story"]) then
				if arg_335_1.var_.characterEffect1071ui_story and not isNil(arg_335_1.actors_["1071ui_story"]) then
					arg_335_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_335_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_335_1.time_ - 0) / var_338_0)
				end
			end

			if arg_335_1.time_ >= 0 + var_338_0 and arg_335_1.time_ < 0 + var_338_0 + arg_338_0 and not isNil(arg_335_1.actors_["1071ui_story"]) and arg_335_1.var_.characterEffect1071ui_story then
				arg_335_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_335_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_338_1 = 0
			local var_338_2 = 0.625

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_1 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, true)
				arg_335_1.iconController_:SetSelectedState("hero")

				arg_335_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_335_1.callingController_:SetSelectedState("normal")

				arg_335_1.keyicon_.color = Color.New(1, 1, 1)
				arg_335_1.icon_.color = Color.New(1, 1, 1)

				local var_338_3 = arg_335_1:FormatText(arg_335_1:GetWordFromCfg(323082082).content)

				arg_335_1.text_.text = var_338_3

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_5 = 25 <= 0 and var_338_2 or var_338_2 * (utf8.len(var_338_3) / 25)

				if (25 <= 0 and var_338_2 or var_338_2 * (utf8.len(var_338_3) / 25)) > 0 and var_338_2 < var_338_5 then
					arg_335_1.talkMaxDuration = var_338_5

					if var_338_5 + var_338_1 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_5 + var_338_1
					end
				end

				arg_335_1.text_.text = var_338_3
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_6 = math.max(var_338_2, arg_335_1.talkMaxDuration)

			if var_338_1 <= arg_335_1.time_ and arg_335_1.time_ < var_338_1 + var_338_6 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_1) / var_338_6

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_1 + var_338_6 and arg_335_1.time_ < var_338_1 + var_338_6 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play323082083 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 323082083
		arg_339_1.duration_ = 6.1

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play323082084(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if arg_339_1.bgs_.STblack == nil then
				local var_342_0 = Object.Instantiate(arg_339_1.paintGo_)

				var_342_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_342_0.name = "STblack"
				var_342_0.transform.parent = arg_339_1.stage_.transform
				var_342_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_339_1.bgs_.STblack = var_342_0
			end

			if 1.1 < arg_339_1.time_ and arg_339_1.time_ <= 1.1 + arg_342_0 then
				local var_342_1 = arg_339_1.bgs_.STblack

				arg_339_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_342_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_342_2 = var_342_1:GetComponent("SpriteRenderer")

				if var_342_2 and var_342_2.sprite then
					local var_342_3 = 2 * (var_342_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_342_1.transform.localScale = Vector3.New(var_342_3 / var_342_2.sprite.bounds.size.y < var_342_3 * manager.ui.mainCameraCom_.aspect / var_342_2.sprite.bounds.size.x and var_342_3 * manager.ui.mainCameraCom_.aspect / var_342_2.sprite.bounds.size.x or var_342_3 / var_342_2.sprite.bounds.size.y, var_342_3 / var_342_2.sprite.bounds.size.y < var_342_3 * manager.ui.mainCameraCom_.aspect / var_342_2.sprite.bounds.size.x and var_342_3 * manager.ui.mainCameraCom_.aspect / var_342_2.sprite.bounds.size.x or var_342_3 / var_342_2.sprite.bounds.size.y, 0)
				end

				for iter_342_0, iter_342_1 in pairs(arg_339_1.bgs_) do
					if iter_342_0 ~= "STblack" then
						iter_342_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_342_4 = 0

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_4 + arg_342_0 then
				arg_339_1.allBtn_.enabled = false
			end

			if arg_339_1.time_ >= var_342_4 + 0.3 and arg_339_1.time_ < var_342_4 + 0.3 + arg_342_0 then
				arg_339_1.allBtn_.enabled = true
			end

			local var_342_5 = 0

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_5 + arg_342_0 then
				arg_339_1.mask_.enabled = true
				arg_339_1.mask_.raycastTarget = true

				arg_339_1:SetGaussion(false)
			end

			local var_342_6 = 1.1

			if var_342_5 <= arg_339_1.time_ and arg_339_1.time_ < var_342_5 + var_342_6 then
				local var_342_7 = Color.New(0, 0, 0)

				var_342_7.a = Mathf.Lerp(0, 1, (arg_339_1.time_ - var_342_5) / var_342_6)
				arg_339_1.mask_.color = var_342_7
			end

			if arg_339_1.time_ >= var_342_5 + var_342_6 and arg_339_1.time_ < var_342_5 + var_342_6 + arg_342_0 then
				local var_342_8 = Color.New(0, 0, 0)

				var_342_8.a = 1
				arg_339_1.mask_.color = var_342_8
			end

			local var_342_9 = 1.1

			if 1.1 < arg_339_1.time_ and arg_339_1.time_ <= var_342_9 + arg_342_0 then
				arg_339_1.mask_.enabled = true
				arg_339_1.mask_.raycastTarget = true

				arg_339_1:SetGaussion(false)
			end

			local var_342_10 = 1.76666666666667

			if var_342_9 <= arg_339_1.time_ and arg_339_1.time_ < var_342_9 + var_342_10 then
				local var_342_11 = Color.New(0, 0, 0)

				var_342_11.a = Mathf.Lerp(1, 0, (arg_339_1.time_ - var_342_9) / var_342_10)
				arg_339_1.mask_.color = var_342_11
			end

			if arg_339_1.time_ >= var_342_9 + var_342_10 and arg_339_1.time_ < var_342_9 + var_342_10 + arg_342_0 then
				local var_342_12 = Color.New(0, 0, 0)

				arg_339_1.mask_.enabled = false
				var_342_12.a = 0
				arg_339_1.mask_.color = var_342_12
			end

			if 1.1 < arg_339_1.time_ and arg_339_1.time_ <= 1.1 + arg_342_0 then
				local var_342_13 = arg_339_1.fswbg_.transform:Find("textbox/adapt/content") or arg_339_1.fswbg_.transform:Find("textbox/content")
				local var_342_14 = arg_339_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_342_15 = var_342_13:GetComponent("RectTransform")

				var_342_13:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_342_15.offsetMin = Vector2.New(0, 0)
				var_342_15.offsetMax = Vector2.New(0, 0)
			end

			if 1.1 < arg_339_1.time_ and arg_339_1.time_ <= 1.1 + arg_342_0 then
				arg_339_1.fswbg_:SetActive(true)
				arg_339_1.dialog_:SetActive(false)

				arg_339_1.fswtw_.percent = 0
				arg_339_1.fswt_.text = arg_339_1:FormatText(arg_339_1:GetWordFromCfg(323082083).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.fswt_)

				arg_339_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_339_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_339_1.fswtw_:SetDirty()

				arg_339_1.typewritterCharCountI18N = 0

				SetActive(arg_339_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_339_1:ShowNextGo(false)
			end

			local var_342_16 = 1.86666666666667

			if 1.86666666666667 < arg_339_1.time_ and arg_339_1.time_ <= var_342_16 + arg_342_0 then
				arg_339_1.var_.oldValueTypewriter = arg_339_1.fswtw_.percent

				SetActive(arg_339_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_339_1:ShowNextGo(false)
			end

			local var_342_17 = 15
			local var_342_18 = 1
			local var_342_19, var_342_20 = arg_339_1:GetPercentByPara(arg_339_1:FormatText(arg_339_1:GetWordFromCfg(323082083).content), 1)

			if var_342_16 < arg_339_1.time_ and arg_339_1.time_ <= var_342_16 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0

				local var_342_21 = var_342_17 <= 0 and var_342_18 or var_342_18 * ((var_342_20 - arg_339_1.typewritterCharCountI18N) / var_342_17)

				if (var_342_17 <= 0 and var_342_18 or var_342_18 * ((var_342_20 - arg_339_1.typewritterCharCountI18N) / var_342_17)) > 0 and var_342_18 < var_342_21 then
					arg_339_1.talkMaxDuration = var_342_21

					if var_342_21 + var_342_16 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_21 + var_342_16
					end
				end
			end

			local var_342_22 = math.max(1, arg_339_1.talkMaxDuration)

			if var_342_16 <= arg_339_1.time_ and arg_339_1.time_ < var_342_16 + var_342_22 then
				arg_339_1.fswtw_.percent = Mathf.Lerp(arg_339_1.var_.oldValueTypewriter, var_342_19, (arg_339_1.time_ - var_342_16) / var_342_22)
				arg_339_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_339_1.fswtw_:SetDirty()
			end

			if arg_339_1.time_ >= var_342_16 + var_342_22 and arg_339_1.time_ < var_342_16 + var_342_22 + arg_342_0 then
				arg_339_1.fswtw_.percent = var_342_19

				arg_339_1.fswtw_:SetDirty()
				arg_339_1:ShowNextGo(true)

				arg_339_1.typewritterCharCountI18N = var_342_20
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play323082084 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 323082084
		arg_343_1.duration_ = 7.47

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play323082085(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 1 < arg_343_1.time_ and arg_343_1.time_ <= 1 + arg_346_0 then
				local var_346_0 = arg_343_1.bgs_.J23f

				arg_343_1.bgs_.J23f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_346_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_346_1 = var_346_0:GetComponent("SpriteRenderer")

				if var_346_1 and var_346_1.sprite then
					local var_346_2 = 2 * (var_346_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_346_0.transform.localScale = Vector3.New(var_346_2 / var_346_1.sprite.bounds.size.y < var_346_2 * manager.ui.mainCameraCom_.aspect / var_346_1.sprite.bounds.size.x and var_346_2 * manager.ui.mainCameraCom_.aspect / var_346_1.sprite.bounds.size.x or var_346_2 / var_346_1.sprite.bounds.size.y, var_346_2 / var_346_1.sprite.bounds.size.y < var_346_2 * manager.ui.mainCameraCom_.aspect / var_346_1.sprite.bounds.size.x and var_346_2 * manager.ui.mainCameraCom_.aspect / var_346_1.sprite.bounds.size.x or var_346_2 / var_346_1.sprite.bounds.size.y, 0)
				end

				for iter_346_0, iter_346_1 in pairs(arg_343_1.bgs_) do
					if iter_346_0 ~= "J23f" then
						iter_346_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_346_3 = 0

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_3 + arg_346_0 then
				arg_343_1.allBtn_.enabled = false
			end

			if arg_343_1.time_ >= var_346_3 + 0.3 and arg_343_1.time_ < var_346_3 + 0.3 + arg_346_0 then
				arg_343_1.allBtn_.enabled = true
			end

			local var_346_4 = 0

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_4 + arg_346_0 then
				arg_343_1.mask_.enabled = true
				arg_343_1.mask_.raycastTarget = true

				arg_343_1:SetGaussion(false)
			end

			local var_346_5 = 1

			if var_346_4 <= arg_343_1.time_ and arg_343_1.time_ < var_346_4 + var_346_5 then
				local var_346_6 = Color.New(0, 0, 0)

				var_346_6.a = Mathf.Lerp(0, 1, (arg_343_1.time_ - var_346_4) / var_346_5)
				arg_343_1.mask_.color = var_346_6
			end

			if arg_343_1.time_ >= var_346_4 + var_346_5 and arg_343_1.time_ < var_346_4 + var_346_5 + arg_346_0 then
				local var_346_7 = Color.New(0, 0, 0)

				var_346_7.a = 1
				arg_343_1.mask_.color = var_346_7
			end

			local var_346_8 = 1

			if 1 < arg_343_1.time_ and arg_343_1.time_ <= var_346_8 + arg_346_0 then
				arg_343_1.mask_.enabled = true
				arg_343_1.mask_.raycastTarget = true

				arg_343_1:SetGaussion(false)
			end

			local var_346_9 = 2.23333333333333

			if var_346_8 <= arg_343_1.time_ and arg_343_1.time_ < var_346_8 + var_346_9 then
				local var_346_10 = Color.New(0, 0, 0)

				var_346_10.a = Mathf.Lerp(1, 0, (arg_343_1.time_ - var_346_8) / var_346_9)
				arg_343_1.mask_.color = var_346_10
			end

			if arg_343_1.time_ >= var_346_8 + var_346_9 and arg_343_1.time_ < var_346_8 + var_346_9 + arg_346_0 then
				local var_346_11 = Color.New(0, 0, 0)

				arg_343_1.mask_.enabled = false
				var_346_11.a = 0
				arg_343_1.mask_.color = var_346_11
			end

			local var_346_12 = arg_343_1.actors_["1071ui_story"].transform

			if 2.63333333333333 < arg_343_1.time_ and arg_343_1.time_ <= 2.63333333333333 + arg_346_0 then
				arg_343_1.var_.moveOldPos1071ui_story = var_346_12.localPosition
			end

			local var_346_13 = 0.001

			if 2.63333333333333 <= arg_343_1.time_ and arg_343_1.time_ < 2.63333333333333 + var_346_13 then
				var_346_12.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos1071ui_story, Vector3.New(0, -1.05, -6.2), (arg_343_1.time_ - 2.63333333333333) / var_346_13)
				var_346_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_346_12.position).x, (manager.ui.mainCamera.transform.position - var_346_12.position).y, (manager.ui.mainCamera.transform.position - var_346_12.position).z)
				var_346_12.localEulerAngles.z = 0
				var_346_12.localEulerAngles.x = 0
				var_346_12.localEulerAngles = var_346_12.localEulerAngles
			end

			if arg_343_1.time_ >= 2.63333333333333 + var_346_13 and arg_343_1.time_ < 2.63333333333333 + var_346_13 + arg_346_0 then
				var_346_12.localPosition = Vector3.New(0, -1.05, -6.2)
				var_346_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_346_12.position).x, (manager.ui.mainCamera.transform.position - var_346_12.position).y, (manager.ui.mainCamera.transform.position - var_346_12.position).z)
				var_346_12.localEulerAngles.z = 0
				var_346_12.localEulerAngles.x = 0
				var_346_12.localEulerAngles = var_346_12.localEulerAngles
			end

			local var_346_14 = arg_343_1.actors_["1071ui_story"]

			if 2.63333333333333 < arg_343_1.time_ and arg_343_1.time_ <= 2.63333333333333 + arg_346_0 and not isNil(var_346_14) and arg_343_1.var_.characterEffect1071ui_story == nil then
				arg_343_1.var_.characterEffect1071ui_story = var_346_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_15 = 0.200000002980232

			if 2.63333333333333 <= arg_343_1.time_ and arg_343_1.time_ < 2.63333333333333 + var_346_15 and not isNil(var_346_14) then
				if arg_343_1.var_.characterEffect1071ui_story and not isNil(var_346_14) then
					arg_343_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_343_1.time_ >= 2.63333333333333 + var_346_15 and arg_343_1.time_ < 2.63333333333333 + var_346_15 + arg_346_0 and not isNil(var_346_14) and arg_343_1.var_.characterEffect1071ui_story then
				arg_343_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 2.63333333333333 < arg_343_1.time_ and arg_343_1.time_ <= 2.63333333333333 + arg_346_0 then
				arg_343_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			if 2.63333333333333 < arg_343_1.time_ and arg_343_1.time_ <= 2.63333333333333 + arg_346_0 then
				arg_343_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			if 2.46666666666667 < arg_343_1.time_ and arg_343_1.time_ <= 2.46666666666667 + arg_346_0 then
				if arg_343_1.var_.characterEffect1071ui_story == nil then
					arg_343_1.var_.characterEffect1071ui_story = arg_343_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_346_17 = arg_343_1.var_.characterEffect1071ui_story

				arg_343_1.var_.characterEffect1071ui_story.imageEffect:turnOff()

				var_346_17.interferenceEffect.enabled = true
				var_346_17.interferenceEffect.noise = 0.001
				var_346_17.interferenceEffect.simTimeScale = 1
				var_346_17.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 2.46666666666667 < arg_343_1.time_ and arg_343_1.time_ <= 2.46666666666667 + arg_346_0 then
				if arg_343_1.var_.characterEffect1071ui_story == nil then
					arg_343_1.var_.characterEffect1071ui_story = arg_343_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_343_1.var_.characterEffect1071ui_story.imageEffect:turnOn(false)
			end

			if 1 < arg_343_1.time_ and arg_343_1.time_ <= 1 + arg_346_0 then
				arg_343_1.fswbg_:SetActive(false)
				arg_343_1.dialog_:SetActive(false)
				SetActive(arg_343_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_343_1:ShowNextGo(false)
			end

			if 1.01666666666667 < arg_343_1.time_ and arg_343_1.time_ <= 1.01666666666667 + arg_346_0 then
				arg_343_1.fswbg_:SetActive(false)
				arg_343_1.dialog_:SetActive(false)
				SetActive(arg_343_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_343_1:ShowNextGo(false)
			end

			if arg_343_1.frameCnt_ <= 1 then
				arg_343_1.dialog_:SetActive(false)
			end

			local var_346_19 = 3
			local var_346_20 = 0.1

			if 3 < arg_343_1.time_ and arg_343_1.time_ <= var_346_19 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0

				arg_343_1.dialog_:SetActive(true)

				arg_343_1.dialogCg_.alpha = 0

				local var_346_21 = LeanTween.value(arg_343_1.dialog_, 0, 1, 0.3)

				var_346_21:setOnUpdate(LuaHelper.FloatAction(function(arg_347_0)
					arg_343_1.dialogCg_.alpha = arg_347_0
				end))
				var_346_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_343_1.dialog_)
					var_346_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_343_1.duration_ = arg_343_1.duration_ + 0.3

				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_22 = arg_343_1:GetWordFromCfg(323082084)
				local var_346_23 = arg_343_1:FormatText(var_346_22.content)

				arg_343_1.text_.text = var_346_23

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_25 = 4 <= 0 and var_346_20 or var_346_20 * (utf8.len(var_346_23) / 4)

				if (4 <= 0 and var_346_20 or var_346_20 * (utf8.len(var_346_23) / 4)) > 0 and var_346_20 < var_346_25 then
					arg_343_1.talkMaxDuration = var_346_25
					var_346_19 = var_346_19 + 0.3

					if var_346_25 + var_346_19 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_25 + var_346_19
					end
				end

				arg_343_1.text_.text = var_346_23
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082084", "story_v_out_323082.awb") ~= 0 then
					local var_346_26 = manager.audio:GetVoiceLength("story_v_out_323082", "323082084", "story_v_out_323082.awb") / 1000

					if var_346_26 + var_346_19 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_26 + var_346_19
					end

					if var_346_22.prefab_name ~= "" and arg_343_1.actors_[var_346_22.prefab_name] ~= nil then
						local var_346_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_22.prefab_name].transform, "story_v_out_323082", "323082084", "story_v_out_323082.awb")

						arg_343_1:RecordAudio("323082084", var_346_27)
						arg_343_1:RecordAudio("323082084", var_346_27)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_323082", "323082084", "story_v_out_323082.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_323082", "323082084", "story_v_out_323082.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_28 = var_346_19 + 0.3
			local var_346_29 = math.max(var_346_20, arg_343_1.talkMaxDuration)

			if var_346_19 + 0.3 <= arg_343_1.time_ and arg_343_1.time_ < var_346_28 + var_346_29 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_28) / var_346_29

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_28 + var_346_29 and arg_343_1.time_ < var_346_28 + var_346_29 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.63333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_343_1:InitPlayNodeList()
	end,
	Play323082085 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 323082085
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play323082086(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(arg_349_1.actors_["1071ui_story"]) and arg_349_1.var_.characterEffect1071ui_story == nil then
				arg_349_1.var_.characterEffect1071ui_story = arg_349_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_0 = 0.200000002980232

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_0 and not isNil(arg_349_1.actors_["1071ui_story"]) then
				if arg_349_1.var_.characterEffect1071ui_story and not isNil(arg_349_1.actors_["1071ui_story"]) then
					arg_349_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_349_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_349_1.time_ - 0) / var_352_0)
				end
			end

			if arg_349_1.time_ >= 0 + var_352_0 and arg_349_1.time_ < 0 + var_352_0 + arg_352_0 and not isNil(arg_349_1.actors_["1071ui_story"]) and arg_349_1.var_.characterEffect1071ui_story then
				arg_349_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_349_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_352_1 = 0
			local var_352_2 = 0.375

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, true)
				arg_349_1.iconController_:SetSelectedState("hero")

				arg_349_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_349_1.callingController_:SetSelectedState("normal")

				arg_349_1.keyicon_.color = Color.New(1, 1, 1)
				arg_349_1.icon_.color = Color.New(1, 1, 1)

				local var_352_3 = arg_349_1:FormatText(arg_349_1:GetWordFromCfg(323082085).content)

				arg_349_1.text_.text = var_352_3

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_5 = 15 <= 0 and var_352_2 or var_352_2 * (utf8.len(var_352_3) / 15)

				if (15 <= 0 and var_352_2 or var_352_2 * (utf8.len(var_352_3) / 15)) > 0 and var_352_2 < var_352_5 then
					arg_349_1.talkMaxDuration = var_352_5

					if var_352_5 + var_352_1 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_5 + var_352_1
					end
				end

				arg_349_1.text_.text = var_352_3
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_6 = math.max(var_352_2, arg_349_1.talkMaxDuration)

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_6 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_1) / var_352_6

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_1 + var_352_6 and arg_349_1.time_ < var_352_1 + var_352_6 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play323082086 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 323082086
		arg_353_1.duration_ = 12.97

		local var_353_0 = {
			zh = 4.2,
			ja = 12.966
		}
		local var_353_1 = manager.audio:GetLocalizationFlag()

		if var_353_0[var_353_1] ~= nil then
			arg_353_1.duration_ = var_353_0[var_353_1]
		end

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play323082087(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(arg_353_1.actors_["1071ui_story"]) and arg_353_1.var_.characterEffect1071ui_story == nil then
				arg_353_1.var_.characterEffect1071ui_story = arg_353_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_0 = 0.200000002980232

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_0 and not isNil(arg_353_1.actors_["1071ui_story"]) then
				if arg_353_1.var_.characterEffect1071ui_story and not isNil(arg_353_1.actors_["1071ui_story"]) then
					arg_353_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_353_1.time_ >= 0 + var_356_0 and arg_353_1.time_ < 0 + var_356_0 + arg_356_0 and not isNil(arg_353_1.actors_["1071ui_story"]) and arg_353_1.var_.characterEffect1071ui_story then
				arg_353_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action3_1")
			end

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_356_2 = 0
			local var_356_3 = 0.6

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_2 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_4 = arg_353_1:GetWordFromCfg(323082086)
				local var_356_5 = arg_353_1:FormatText(var_356_4.content)

				arg_353_1.text_.text = var_356_5

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_7 = 24 <= 0 and var_356_3 or var_356_3 * (utf8.len(var_356_5) / 24)

				if (24 <= 0 and var_356_3 or var_356_3 * (utf8.len(var_356_5) / 24)) > 0 and var_356_3 < var_356_7 then
					arg_353_1.talkMaxDuration = var_356_7

					if var_356_7 + var_356_2 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_7 + var_356_2
					end
				end

				arg_353_1.text_.text = var_356_5
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082086", "story_v_out_323082.awb") ~= 0 then
					local var_356_8 = manager.audio:GetVoiceLength("story_v_out_323082", "323082086", "story_v_out_323082.awb") / 1000

					if var_356_8 + var_356_2 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_8 + var_356_2
					end

					if var_356_4.prefab_name ~= "" and arg_353_1.actors_[var_356_4.prefab_name] ~= nil then
						local var_356_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_4.prefab_name].transform, "story_v_out_323082", "323082086", "story_v_out_323082.awb")

						arg_353_1:RecordAudio("323082086", var_356_9)
						arg_353_1:RecordAudio("323082086", var_356_9)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_323082", "323082086", "story_v_out_323082.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_323082", "323082086", "story_v_out_323082.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_10 = math.max(var_356_3, arg_353_1.talkMaxDuration)

			if var_356_2 <= arg_353_1.time_ and arg_353_1.time_ < var_356_2 + var_356_10 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_2) / var_356_10

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_2 + var_356_10 and arg_353_1.time_ < var_356_2 + var_356_10 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play323082087 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 323082087
		arg_357_1.duration_ = 8.8

		local var_357_0 = {
			zh = 3.9,
			ja = 8.8
		}
		local var_357_1 = manager.audio:GetLocalizationFlag()

		if var_357_0[var_357_1] ~= nil then
			arg_357_1.duration_ = var_357_0[var_357_1]
		end

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play323082088(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.var_.moveOldPos1070ui_story = arg_357_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_360_0 = 0.001

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 then
				arg_357_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_357_1.time_ - 0) / var_360_0)
				arg_357_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_357_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1070ui_story"].transform.position).z)
				arg_357_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_357_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_357_1.actors_["1070ui_story"].transform.localEulerAngles = arg_357_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 then
				arg_357_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_357_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_357_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1070ui_story"].transform.position).z)
				arg_357_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_357_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_357_1.actors_["1070ui_story"].transform.localEulerAngles = arg_357_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_360_1 = arg_357_1.actors_["1071ui_story"].transform

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.var_.moveOldPos1071ui_story = var_360_1.localPosition
			end

			local var_360_2 = 0.001

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_2 then
				var_360_1.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_357_1.time_ - 0) / var_360_2)
				var_360_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_360_1.position).x, (manager.ui.mainCamera.transform.position - var_360_1.position).y, (manager.ui.mainCamera.transform.position - var_360_1.position).z)
				var_360_1.localEulerAngles.z = 0
				var_360_1.localEulerAngles.x = 0
				var_360_1.localEulerAngles = var_360_1.localEulerAngles
			end

			if arg_357_1.time_ >= 0 + var_360_2 and arg_357_1.time_ < 0 + var_360_2 + arg_360_0 then
				var_360_1.localPosition = Vector3.New(0, 100, 0)
				var_360_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_360_1.position).x, (manager.ui.mainCamera.transform.position - var_360_1.position).y, (manager.ui.mainCamera.transform.position - var_360_1.position).z)
				var_360_1.localEulerAngles.z = 0
				var_360_1.localEulerAngles.x = 0
				var_360_1.localEulerAngles = var_360_1.localEulerAngles
			end

			local var_360_3 = arg_357_1.actors_["1070ui_story"]

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(var_360_3) and arg_357_1.var_.characterEffect1070ui_story == nil then
				arg_357_1.var_.characterEffect1070ui_story = var_360_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_4 = 0.200000002980232

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_4 and not isNil(var_360_3) then
				if arg_357_1.var_.characterEffect1070ui_story and not isNil(var_360_3) then
					arg_357_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_357_1.time_ >= 0 + var_360_4 and arg_357_1.time_ < 0 + var_360_4 + arg_360_0 and not isNil(var_360_3) and arg_357_1.var_.characterEffect1070ui_story then
				arg_357_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_360_6 = arg_357_1.actors_["1071ui_story"]

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(var_360_6) and arg_357_1.var_.characterEffect1071ui_story == nil then
				arg_357_1.var_.characterEffect1071ui_story = var_360_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_7 = 0.200000002980232

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_7 and not isNil(var_360_6) then
				if arg_357_1.var_.characterEffect1071ui_story and not isNil(var_360_6) then
					arg_357_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_357_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_357_1.time_ - 0) / var_360_7)
				end
			end

			if arg_357_1.time_ >= 0 + var_360_7 and arg_357_1.time_ < 0 + var_360_7 + arg_360_0 and not isNil(var_360_6) and arg_357_1.var_.characterEffect1071ui_story then
				arg_357_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_357_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_1")
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_360_8 = 0
			local var_360_9 = 0.45

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_8 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_10 = arg_357_1:GetWordFromCfg(323082087)
				local var_360_11 = arg_357_1:FormatText(var_360_10.content)

				arg_357_1.text_.text = var_360_11

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_13 = 18 <= 0 and var_360_9 or var_360_9 * (utf8.len(var_360_11) / 18)

				if (18 <= 0 and var_360_9 or var_360_9 * (utf8.len(var_360_11) / 18)) > 0 and var_360_9 < var_360_13 then
					arg_357_1.talkMaxDuration = var_360_13

					if var_360_13 + var_360_8 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_13 + var_360_8
					end
				end

				arg_357_1.text_.text = var_360_11
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082087", "story_v_out_323082.awb") ~= 0 then
					local var_360_14 = manager.audio:GetVoiceLength("story_v_out_323082", "323082087", "story_v_out_323082.awb") / 1000

					if var_360_14 + var_360_8 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_14 + var_360_8
					end

					if var_360_10.prefab_name ~= "" and arg_357_1.actors_[var_360_10.prefab_name] ~= nil then
						local var_360_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_10.prefab_name].transform, "story_v_out_323082", "323082087", "story_v_out_323082.awb")

						arg_357_1:RecordAudio("323082087", var_360_15)
						arg_357_1:RecordAudio("323082087", var_360_15)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_323082", "323082087", "story_v_out_323082.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_323082", "323082087", "story_v_out_323082.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_16 = math.max(var_360_9, arg_357_1.talkMaxDuration)

			if var_360_8 <= arg_357_1.time_ and arg_357_1.time_ < var_360_8 + var_360_16 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_8) / var_360_16

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_8 + var_360_16 and arg_357_1.time_ < var_360_8 + var_360_16 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_357_1:InitPlayNodeList()
	end,
	Play323082088 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 323082088
		arg_361_1.duration_ = 4.2

		local var_361_0 = {
			zh = 3.6,
			ja = 4.2
		}
		local var_361_1 = manager.audio:GetLocalizationFlag()

		if var_361_0[var_361_1] ~= nil then
			arg_361_1.duration_ = var_361_0[var_361_1]
		end

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play323082089(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(arg_361_1.actors_["1071ui_story"]) and arg_361_1.var_.characterEffect1071ui_story == nil then
				arg_361_1.var_.characterEffect1071ui_story = arg_361_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_0 = 0.200000002980232

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_0 and not isNil(arg_361_1.actors_["1071ui_story"]) then
				if arg_361_1.var_.characterEffect1071ui_story and not isNil(arg_361_1.actors_["1071ui_story"]) then
					arg_361_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_361_1.time_ >= 0 + var_364_0 and arg_361_1.time_ < 0 + var_364_0 + arg_364_0 and not isNil(arg_361_1.actors_["1071ui_story"]) and arg_361_1.var_.characterEffect1071ui_story then
				arg_361_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_364_2 = arg_361_1.actors_["1070ui_story"]

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(var_364_2) and arg_361_1.var_.characterEffect1070ui_story == nil then
				arg_361_1.var_.characterEffect1070ui_story = var_364_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_3 = 0.200000002980232

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_3 and not isNil(var_364_2) then
				if arg_361_1.var_.characterEffect1070ui_story and not isNil(var_364_2) then
					arg_361_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_361_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_361_1.time_ - 0) / var_364_3)
				end
			end

			if arg_361_1.time_ >= 0 + var_364_3 and arg_361_1.time_ < 0 + var_364_3 + arg_364_0 and not isNil(var_364_2) and arg_361_1.var_.characterEffect1070ui_story then
				arg_361_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_361_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071actionlink/1071action435")
			end

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_364_4 = arg_361_1.actors_["1071ui_story"].transform

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.var_.moveOldPos1071ui_story = var_364_4.localPosition
			end

			local var_364_5 = 0.001

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_5 then
				var_364_4.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos1071ui_story, Vector3.New(0, -1.05, -6.2), (arg_361_1.time_ - 0) / var_364_5)
				var_364_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_364_4.position).x, (manager.ui.mainCamera.transform.position - var_364_4.position).y, (manager.ui.mainCamera.transform.position - var_364_4.position).z)
				var_364_4.localEulerAngles.z = 0
				var_364_4.localEulerAngles.x = 0
				var_364_4.localEulerAngles = var_364_4.localEulerAngles
			end

			if arg_361_1.time_ >= 0 + var_364_5 and arg_361_1.time_ < 0 + var_364_5 + arg_364_0 then
				var_364_4.localPosition = Vector3.New(0, -1.05, -6.2)
				var_364_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_364_4.position).x, (manager.ui.mainCamera.transform.position - var_364_4.position).y, (manager.ui.mainCamera.transform.position - var_364_4.position).z)
				var_364_4.localEulerAngles.z = 0
				var_364_4.localEulerAngles.x = 0
				var_364_4.localEulerAngles = var_364_4.localEulerAngles
			end

			local var_364_6 = arg_361_1.actors_["1070ui_story"].transform

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.var_.moveOldPos1070ui_story = var_364_6.localPosition
			end

			local var_364_7 = 0.001

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_7 then
				var_364_6.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_361_1.time_ - 0) / var_364_7)
				var_364_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_364_6.position).x, (manager.ui.mainCamera.transform.position - var_364_6.position).y, (manager.ui.mainCamera.transform.position - var_364_6.position).z)
				var_364_6.localEulerAngles.z = 0
				var_364_6.localEulerAngles.x = 0
				var_364_6.localEulerAngles = var_364_6.localEulerAngles
			end

			if arg_361_1.time_ >= 0 + var_364_7 and arg_361_1.time_ < 0 + var_364_7 + arg_364_0 then
				var_364_6.localPosition = Vector3.New(0, 100, 0)
				var_364_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_364_6.position).x, (manager.ui.mainCamera.transform.position - var_364_6.position).y, (manager.ui.mainCamera.transform.position - var_364_6.position).z)
				var_364_6.localEulerAngles.z = 0
				var_364_6.localEulerAngles.x = 0
				var_364_6.localEulerAngles = var_364_6.localEulerAngles
			end

			local var_364_8 = 0
			local var_364_9 = 0.45

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_8 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_10 = arg_361_1:GetWordFromCfg(323082088)
				local var_364_11 = arg_361_1:FormatText(var_364_10.content)

				arg_361_1.text_.text = var_364_11

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_13 = 18 <= 0 and var_364_9 or var_364_9 * (utf8.len(var_364_11) / 18)

				if (18 <= 0 and var_364_9 or var_364_9 * (utf8.len(var_364_11) / 18)) > 0 and var_364_9 < var_364_13 then
					arg_361_1.talkMaxDuration = var_364_13

					if var_364_13 + var_364_8 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_13 + var_364_8
					end
				end

				arg_361_1.text_.text = var_364_11
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082088", "story_v_out_323082.awb") ~= 0 then
					local var_364_14 = manager.audio:GetVoiceLength("story_v_out_323082", "323082088", "story_v_out_323082.awb") / 1000

					if var_364_14 + var_364_8 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_14 + var_364_8
					end

					if var_364_10.prefab_name ~= "" and arg_361_1.actors_[var_364_10.prefab_name] ~= nil then
						local var_364_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_10.prefab_name].transform, "story_v_out_323082", "323082088", "story_v_out_323082.awb")

						arg_361_1:RecordAudio("323082088", var_364_15)
						arg_361_1:RecordAudio("323082088", var_364_15)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_323082", "323082088", "story_v_out_323082.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_323082", "323082088", "story_v_out_323082.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_16 = math.max(var_364_9, arg_361_1.talkMaxDuration)

			if var_364_8 <= arg_361_1.time_ and arg_361_1.time_ < var_364_8 + var_364_16 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_8) / var_364_16

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_8 + var_364_16 and arg_361_1.time_ < var_364_8 + var_364_16 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_361_1:InitPlayNodeList()
	end,
	Play323082089 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 323082089
		arg_365_1.duration_ = 10.67

		local var_365_0 = {
			zh = 8.133,
			ja = 10.666
		}
		local var_365_1 = manager.audio:GetLocalizationFlag()

		if var_365_0[var_365_1] ~= nil then
			arg_365_1.duration_ = var_365_0[var_365_1]
		end

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play323082090(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 1.225

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_1 = arg_365_1:GetWordFromCfg(323082089)
				local var_368_2 = arg_365_1:FormatText(var_368_1.content)

				arg_365_1.text_.text = var_368_2

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_4 = 49 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_2) / 49)

				if (49 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_2) / 49)) > 0 and var_368_0 < var_368_4 then
					arg_365_1.talkMaxDuration = var_368_4

					if var_368_4 + 0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_4 + 0
					end
				end

				arg_365_1.text_.text = var_368_2
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082089", "story_v_out_323082.awb") ~= 0 then
					local var_368_5 = manager.audio:GetVoiceLength("story_v_out_323082", "323082089", "story_v_out_323082.awb") / 1000

					if var_368_5 + 0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_5 + 0
					end

					if var_368_1.prefab_name ~= "" and arg_365_1.actors_[var_368_1.prefab_name] ~= nil then
						local var_368_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_1.prefab_name].transform, "story_v_out_323082", "323082089", "story_v_out_323082.awb")

						arg_365_1:RecordAudio("323082089", var_368_6)
						arg_365_1:RecordAudio("323082089", var_368_6)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_323082", "323082089", "story_v_out_323082.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_323082", "323082089", "story_v_out_323082.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_7 = math.max(var_368_0, arg_365_1.talkMaxDuration)

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_7 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - 0) / var_368_7

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= 0 + var_368_7 and arg_365_1.time_ < 0 + var_368_7 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play323082090 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 323082090
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play323082091(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(arg_369_1.actors_["1071ui_story"]) and arg_369_1.var_.characterEffect1071ui_story == nil then
				arg_369_1.var_.characterEffect1071ui_story = arg_369_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_0 = 0.200000002980232

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_0 and not isNil(arg_369_1.actors_["1071ui_story"]) then
				if arg_369_1.var_.characterEffect1071ui_story and not isNil(arg_369_1.actors_["1071ui_story"]) then
					arg_369_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_369_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_369_1.time_ - 0) / var_372_0)
				end
			end

			if arg_369_1.time_ >= 0 + var_372_0 and arg_369_1.time_ < 0 + var_372_0 + arg_372_0 and not isNil(arg_369_1.actors_["1071ui_story"]) and arg_369_1.var_.characterEffect1071ui_story then
				arg_369_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_369_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_372_1 = 0
			local var_372_2 = 0.65

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, true)
				arg_369_1.iconController_:SetSelectedState("hero")

				arg_369_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_369_1.callingController_:SetSelectedState("normal")

				arg_369_1.keyicon_.color = Color.New(1, 1, 1)
				arg_369_1.icon_.color = Color.New(1, 1, 1)

				local var_372_3 = arg_369_1:FormatText(arg_369_1:GetWordFromCfg(323082090).content)

				arg_369_1.text_.text = var_372_3

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_5 = 26 <= 0 and var_372_2 or var_372_2 * (utf8.len(var_372_3) / 26)

				if (26 <= 0 and var_372_2 or var_372_2 * (utf8.len(var_372_3) / 26)) > 0 and var_372_2 < var_372_5 then
					arg_369_1.talkMaxDuration = var_372_5

					if var_372_5 + var_372_1 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_5 + var_372_1
					end
				end

				arg_369_1.text_.text = var_372_3
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_6 = math.max(var_372_2, arg_369_1.talkMaxDuration)

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_6 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_1) / var_372_6

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_1 + var_372_6 and arg_369_1.time_ < var_372_1 + var_372_6 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play323082091 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 323082091
		arg_373_1.duration_ = 9.83

		local var_373_0 = {
			zh = 6.566,
			ja = 9.833
		}
		local var_373_1 = manager.audio:GetLocalizationFlag()

		if var_373_0[var_373_1] ~= nil then
			arg_373_1.duration_ = var_373_0[var_373_1]
		end

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play323082092(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(arg_373_1.actors_["1071ui_story"]) and arg_373_1.var_.characterEffect1071ui_story == nil then
				arg_373_1.var_.characterEffect1071ui_story = arg_373_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_0 = 0.200000002980232

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_0 and not isNil(arg_373_1.actors_["1071ui_story"]) then
				if arg_373_1.var_.characterEffect1071ui_story and not isNil(arg_373_1.actors_["1071ui_story"]) then
					arg_373_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_373_1.time_ >= 0 + var_376_0 and arg_373_1.time_ < 0 + var_376_0 + arg_376_0 and not isNil(arg_373_1.actors_["1071ui_story"]) and arg_373_1.var_.characterEffect1071ui_story then
				arg_373_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_2")
			end

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_376_2 = 0
			local var_376_3 = 0.8

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_2 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_4 = arg_373_1:GetWordFromCfg(323082091)
				local var_376_5 = arg_373_1:FormatText(var_376_4.content)

				arg_373_1.text_.text = var_376_5

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_7 = 32 <= 0 and var_376_3 or var_376_3 * (utf8.len(var_376_5) / 32)

				if (32 <= 0 and var_376_3 or var_376_3 * (utf8.len(var_376_5) / 32)) > 0 and var_376_3 < var_376_7 then
					arg_373_1.talkMaxDuration = var_376_7

					if var_376_7 + var_376_2 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_7 + var_376_2
					end
				end

				arg_373_1.text_.text = var_376_5
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082091", "story_v_out_323082.awb") ~= 0 then
					local var_376_8 = manager.audio:GetVoiceLength("story_v_out_323082", "323082091", "story_v_out_323082.awb") / 1000

					if var_376_8 + var_376_2 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_8 + var_376_2
					end

					if var_376_4.prefab_name ~= "" and arg_373_1.actors_[var_376_4.prefab_name] ~= nil then
						local var_376_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_4.prefab_name].transform, "story_v_out_323082", "323082091", "story_v_out_323082.awb")

						arg_373_1:RecordAudio("323082091", var_376_9)
						arg_373_1:RecordAudio("323082091", var_376_9)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_323082", "323082091", "story_v_out_323082.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_323082", "323082091", "story_v_out_323082.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_10 = math.max(var_376_3, arg_373_1.talkMaxDuration)

			if var_376_2 <= arg_373_1.time_ and arg_373_1.time_ < var_376_2 + var_376_10 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_2) / var_376_10

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_2 + var_376_10 and arg_373_1.time_ < var_376_2 + var_376_10 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play323082092 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 323082092
		arg_377_1.duration_ = 4.1

		local var_377_0 = {
			zh = 2.966,
			ja = 4.1
		}
		local var_377_1 = manager.audio:GetLocalizationFlag()

		if var_377_0[var_377_1] ~= nil then
			arg_377_1.duration_ = var_377_0[var_377_1]
		end

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play323082093(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.var_.moveOldPos1070ui_story = arg_377_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_380_0 = 0.001

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_0 then
				arg_377_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_377_1.time_ - 0) / var_380_0)
				arg_377_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_377_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1070ui_story"].transform.position).z)
				arg_377_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_377_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_377_1.actors_["1070ui_story"].transform.localEulerAngles = arg_377_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_377_1.time_ >= 0 + var_380_0 and arg_377_1.time_ < 0 + var_380_0 + arg_380_0 then
				arg_377_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_377_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_377_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1070ui_story"].transform.position).z)
				arg_377_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_377_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_377_1.actors_["1070ui_story"].transform.localEulerAngles = arg_377_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_380_1 = arg_377_1.actors_["10171ui_story"].transform

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.var_.moveOldPos10171ui_story = var_380_1.localPosition

				local var_380_2 = GameObjectTools.GetOrAddComponent(var_380_1.gameObject, typeof(DynamicBoneHelper))

				if var_380_2 then
					var_380_2:EnableDynamicBone(false)
				end
			end

			local var_380_3 = 0.001

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_3 then
				var_380_1.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos10171ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_377_1.time_ - 0) / var_380_3)
				var_380_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_380_1.position).x, (manager.ui.mainCamera.transform.position - var_380_1.position).y, (manager.ui.mainCamera.transform.position - var_380_1.position).z)
				var_380_1.localEulerAngles.z = 0
				var_380_1.localEulerAngles.x = 0
				var_380_1.localEulerAngles = var_380_1.localEulerAngles
			end

			if arg_377_1.time_ >= 0 + var_380_3 and arg_377_1.time_ < 0 + var_380_3 + arg_380_0 then
				var_380_1.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				var_380_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_380_1.position).x, (manager.ui.mainCamera.transform.position - var_380_1.position).y, (manager.ui.mainCamera.transform.position - var_380_1.position).z)
				var_380_1.localEulerAngles.z = 0
				var_380_1.localEulerAngles.x = 0
				var_380_1.localEulerAngles = var_380_1.localEulerAngles

				local var_380_4 = GameObjectTools.GetOrAddComponent(var_380_1.gameObject, typeof(DynamicBoneHelper))

				if var_380_4 then
					var_380_4:EnableDynamicBone(true)
				end
			end

			local var_380_5 = arg_377_1.actors_["10171ui_story"]

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(var_380_5) and arg_377_1.var_.characterEffect10171ui_story == nil then
				arg_377_1.var_.characterEffect10171ui_story = var_380_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_6 = 0.200000002980232

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_6 and not isNil(var_380_5) then
				if arg_377_1.var_.characterEffect10171ui_story and not isNil(var_380_5) then
					arg_377_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_377_1.time_ >= 0 + var_380_6 and arg_377_1.time_ < 0 + var_380_6 + arg_380_0 and not isNil(var_380_5) and arg_377_1.var_.characterEffect10171ui_story then
				arg_377_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_380_8 = arg_377_1.actors_["1071ui_story"]

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(var_380_8) and arg_377_1.var_.characterEffect1071ui_story == nil then
				arg_377_1.var_.characterEffect1071ui_story = var_380_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_9 = 0.200000002980232

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_9 and not isNil(var_380_8) then
				if arg_377_1.var_.characterEffect1071ui_story and not isNil(var_380_8) then
					arg_377_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_377_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_377_1.time_ - 0) / var_380_9)
				end
			end

			if arg_377_1.time_ >= 0 + var_380_9 and arg_377_1.time_ < 0 + var_380_9 + arg_380_0 and not isNil(var_380_8) and arg_377_1.var_.characterEffect1071ui_story then
				arg_377_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_377_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action1_1")
			end

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_380_10 = arg_377_1.actors_["1071ui_story"].transform

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.var_.moveOldPos1071ui_story = var_380_10.localPosition
			end

			local var_380_11 = 0.001

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_11 then
				var_380_10.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos1071ui_story, Vector3.New(0.7, -1.05, -6.2), (arg_377_1.time_ - 0) / var_380_11)
				var_380_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_380_10.position).x, (manager.ui.mainCamera.transform.position - var_380_10.position).y, (manager.ui.mainCamera.transform.position - var_380_10.position).z)
				var_380_10.localEulerAngles.z = 0
				var_380_10.localEulerAngles.x = 0
				var_380_10.localEulerAngles = var_380_10.localEulerAngles
			end

			if arg_377_1.time_ >= 0 + var_380_11 and arg_377_1.time_ < 0 + var_380_11 + arg_380_0 then
				var_380_10.localPosition = Vector3.New(0.7, -1.05, -6.2)
				var_380_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_380_10.position).x, (manager.ui.mainCamera.transform.position - var_380_10.position).y, (manager.ui.mainCamera.transform.position - var_380_10.position).z)
				var_380_10.localEulerAngles.z = 0
				var_380_10.localEulerAngles.x = 0
				var_380_10.localEulerAngles = var_380_10.localEulerAngles
			end

			local var_380_12 = 0
			local var_380_13 = 0.375

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_12 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_14 = arg_377_1:GetWordFromCfg(323082092)
				local var_380_15 = arg_377_1:FormatText(var_380_14.content)

				arg_377_1.text_.text = var_380_15

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_17 = 15 <= 0 and var_380_13 or var_380_13 * (utf8.len(var_380_15) / 15)

				if (15 <= 0 and var_380_13 or var_380_13 * (utf8.len(var_380_15) / 15)) > 0 and var_380_13 < var_380_17 then
					arg_377_1.talkMaxDuration = var_380_17

					if var_380_17 + var_380_12 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_17 + var_380_12
					end
				end

				arg_377_1.text_.text = var_380_15
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082092", "story_v_out_323082.awb") ~= 0 then
					local var_380_18 = manager.audio:GetVoiceLength("story_v_out_323082", "323082092", "story_v_out_323082.awb") / 1000

					if var_380_18 + var_380_12 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_18 + var_380_12
					end

					if var_380_14.prefab_name ~= "" and arg_377_1.actors_[var_380_14.prefab_name] ~= nil then
						local var_380_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_14.prefab_name].transform, "story_v_out_323082", "323082092", "story_v_out_323082.awb")

						arg_377_1:RecordAudio("323082092", var_380_19)
						arg_377_1:RecordAudio("323082092", var_380_19)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_323082", "323082092", "story_v_out_323082.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_323082", "323082092", "story_v_out_323082.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_20 = math.max(var_380_13, arg_377_1.talkMaxDuration)

			if var_380_12 <= arg_377_1.time_ and arg_377_1.time_ < var_380_12 + var_380_20 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_12) / var_380_20

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_12 + var_380_20 and arg_377_1.time_ < var_380_12 + var_380_20 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_377_1:InitPlayNodeList()
	end,
	Play323082093 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 323082093
		arg_381_1.duration_ = 7.93

		local var_381_0 = {
			zh = 4.5,
			ja = 7.933
		}
		local var_381_1 = manager.audio:GetLocalizationFlag()

		if var_381_0[var_381_1] ~= nil then
			arg_381_1.duration_ = var_381_0[var_381_1]
		end

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play323082094(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(arg_381_1.actors_["1071ui_story"]) and arg_381_1.var_.characterEffect1071ui_story == nil then
				arg_381_1.var_.characterEffect1071ui_story = arg_381_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_0 = 0.200000002980232

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_0 and not isNil(arg_381_1.actors_["1071ui_story"]) then
				if arg_381_1.var_.characterEffect1071ui_story and not isNil(arg_381_1.actors_["1071ui_story"]) then
					arg_381_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_381_1.time_ >= 0 + var_384_0 and arg_381_1.time_ < 0 + var_384_0 + arg_384_0 and not isNil(arg_381_1.actors_["1071ui_story"]) and arg_381_1.var_.characterEffect1071ui_story then
				arg_381_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_384_2 = arg_381_1.actors_["10171ui_story"]

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(var_384_2) and arg_381_1.var_.characterEffect10171ui_story == nil then
				arg_381_1.var_.characterEffect10171ui_story = var_384_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_3 = 0.200000002980232

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_3 and not isNil(var_384_2) then
				if arg_381_1.var_.characterEffect10171ui_story and not isNil(var_384_2) then
					arg_381_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_381_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_381_1.time_ - 0) / var_384_3)
				end
			end

			if arg_381_1.time_ >= 0 + var_384_3 and arg_381_1.time_ < 0 + var_384_3 + arg_384_0 and not isNil(var_384_2) and arg_381_1.var_.characterEffect10171ui_story then
				arg_381_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_381_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action6_1")
			end

			local var_384_4 = 0
			local var_384_5 = 0.575

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_4 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_6 = arg_381_1:GetWordFromCfg(323082093)
				local var_384_7 = arg_381_1:FormatText(var_384_6.content)

				arg_381_1.text_.text = var_384_7

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_9 = 23 <= 0 and var_384_5 or var_384_5 * (utf8.len(var_384_7) / 23)

				if (23 <= 0 and var_384_5 or var_384_5 * (utf8.len(var_384_7) / 23)) > 0 and var_384_5 < var_384_9 then
					arg_381_1.talkMaxDuration = var_384_9

					if var_384_9 + var_384_4 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_9 + var_384_4
					end
				end

				arg_381_1.text_.text = var_384_7
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082093", "story_v_out_323082.awb") ~= 0 then
					local var_384_10 = manager.audio:GetVoiceLength("story_v_out_323082", "323082093", "story_v_out_323082.awb") / 1000

					if var_384_10 + var_384_4 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_10 + var_384_4
					end

					if var_384_6.prefab_name ~= "" and arg_381_1.actors_[var_384_6.prefab_name] ~= nil then
						local var_384_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_6.prefab_name].transform, "story_v_out_323082", "323082093", "story_v_out_323082.awb")

						arg_381_1:RecordAudio("323082093", var_384_11)
						arg_381_1:RecordAudio("323082093", var_384_11)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_out_323082", "323082093", "story_v_out_323082.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_out_323082", "323082093", "story_v_out_323082.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_12 = math.max(var_384_5, arg_381_1.talkMaxDuration)

			if var_384_4 <= arg_381_1.time_ and arg_381_1.time_ < var_384_4 + var_384_12 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_4) / var_384_12

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_4 + var_384_12 and arg_381_1.time_ < var_384_4 + var_384_12 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play323082094 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 323082094
		arg_385_1.duration_ = 7.83

		local var_385_0 = {
			zh = 5.1,
			ja = 7.833
		}
		local var_385_1 = manager.audio:GetLocalizationFlag()

		if var_385_0[var_385_1] ~= nil then
			arg_385_1.duration_ = var_385_0[var_385_1]
		end

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
			arg_385_1.auto_ = false
		end

		function arg_385_1.playNext_(arg_387_0)
			arg_385_1.onStoryFinished_()
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = 0.65

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_1 = arg_385_1:GetWordFromCfg(323082094)
				local var_388_2 = arg_385_1:FormatText(var_388_1.content)

				arg_385_1.text_.text = var_388_2

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_4 = 26 <= 0 and var_388_0 or var_388_0 * (utf8.len(var_388_2) / 26)

				if (26 <= 0 and var_388_0 or var_388_0 * (utf8.len(var_388_2) / 26)) > 0 and var_388_0 < var_388_4 then
					arg_385_1.talkMaxDuration = var_388_4

					if var_388_4 + 0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_4 + 0
					end
				end

				arg_385_1.text_.text = var_388_2
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323082", "323082094", "story_v_out_323082.awb") ~= 0 then
					local var_388_5 = manager.audio:GetVoiceLength("story_v_out_323082", "323082094", "story_v_out_323082.awb") / 1000

					if var_388_5 + 0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_5 + 0
					end

					if var_388_1.prefab_name ~= "" and arg_385_1.actors_[var_388_1.prefab_name] ~= nil then
						local var_388_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_1.prefab_name].transform, "story_v_out_323082", "323082094", "story_v_out_323082.awb")

						arg_385_1:RecordAudio("323082094", var_388_6)
						arg_385_1:RecordAudio("323082094", var_388_6)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_323082", "323082094", "story_v_out_323082.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_323082", "323082094", "story_v_out_323082.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_7 = math.max(var_388_0, arg_385_1.talkMaxDuration)

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_7 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - 0) / var_388_7

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= 0 + var_388_7 and arg_385_1.time_ < 0 + var_388_7 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J23f",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_323082.awb"
	}
}
