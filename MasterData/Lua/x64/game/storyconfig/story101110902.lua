return {
	Play111092001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 111092001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play111092002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.D06a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "D06a")
				var_4_0.name = "D06a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.D06a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.D06a

				arg_1_1.bgs_.D06a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "D06a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_4 = arg_1_1.bgs_.D06a:GetComponent("SpriteRenderer")

				if var_4_4 then
					arg_1_1.var_.alphaOldValueD06a = var_4_4.color.a
					arg_1_1.var_.alphaMatValueD06a = var_4_4
				end

				arg_1_1.var_.alphaOldValueD06a = 0
			end

			local var_4_5 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_5 then
				if arg_1_1.var_.alphaMatValueD06a then
					arg_1_1.var_.alphaMatValueD06a.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueD06a, 1, (arg_1_1.time_ - 0) / var_4_5)
					arg_1_1.var_.alphaMatValueD06a.color = arg_1_1.var_.alphaMatValueD06a.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_5 and arg_1_1.time_ < 0 + var_4_5 + arg_4_0 and arg_1_1.var_.alphaMatValueD06a then
				arg_1_1.var_.alphaMatValueD06a.color.a = 1
				arg_1_1.var_.alphaMatValueD06a.color = arg_1_1.var_.alphaMatValueD06a.color
			end

			local var_4_6 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_6 + 2 and arg_1_1.time_ < var_4_6 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_1_hel_story", "bgm_activity_1_1_hel_story", "bgm_activity_1_1_hel_story.awb")

				local var_4_9 = manager.audio:GetAudioName("bgm_activity_1_1_hel_story", "bgm_activity_1_1_hel_story")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_9 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_9

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_9
						arg_1_1.bgmTxt2_.text = var_4_9
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

			local var_4_10 = 2
			local var_4_11 = 0.45

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_10 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_12 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_12:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_12:setOnUpdate(nil):setOnComplete(nil)
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

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_13 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(111092001).content)

				arg_1_1.text_.text = var_4_13

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_15 = 18 <= 0 and var_4_11 or var_4_11 * (utf8.len(var_4_13) / 18)

				if (18 <= 0 and var_4_11 or var_4_11 * (utf8.len(var_4_13) / 18)) > 0 and var_4_11 < var_4_15 then
					arg_1_1.talkMaxDuration = var_4_15
					var_4_10 = var_4_10 + 0.3

					if var_4_15 + var_4_10 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_15 + var_4_10
					end
				end

				arg_1_1.text_.text = var_4_13
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_16 = var_4_10 + 0.3
			local var_4_17 = math.max(var_4_11, arg_1_1.talkMaxDuration)

			if var_4_10 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_16) / var_4_17

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play111092002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 111092002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play111092003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 1.075

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(111092002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 43 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 43)

				if (43 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 43)) > 0 and var_11_0 < var_11_3 then
					arg_8_1.talkMaxDuration = var_11_3

					if var_11_3 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_3 + 0
					end
				end

				arg_8_1.text_.text = var_11_1
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_4 = math.max(var_11_0, arg_8_1.talkMaxDuration)

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - 0) / var_11_4

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play111092003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 111092003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play111092004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 1.05

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(111092003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 42 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 42)

				if (42 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 42)) > 0 and var_15_0 < var_15_3 then
					arg_12_1.talkMaxDuration = var_15_3

					if var_15_3 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_3 + 0
					end
				end

				arg_12_1.text_.text = var_15_1
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_4 = math.max(var_15_0, arg_12_1.talkMaxDuration)

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - 0) / var_15_4

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play111092004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 111092004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play111092005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0.425

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_1 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(111092004).content)

				arg_16_1.text_.text = var_19_1

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_3 = 18 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 18)

				if (18 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 18)) > 0 and var_19_0 < var_19_3 then
					arg_16_1.talkMaxDuration = var_19_3

					if var_19_3 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_3 + 0
					end
				end

				arg_16_1.text_.text = var_19_1
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_4 = math.max(var_19_0, arg_16_1.talkMaxDuration)

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - 0) / var_19_4

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play111092005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 111092005
		arg_20_1.duration_ = 2

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play111092006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if arg_20_1.actors_["1094ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1094ui_story"))) then
				local var_23_0 = Object.Instantiate(Asset.Load("Char/" .. "1094ui_story"), arg_20_1.stage_.transform)

				var_23_0.name = "1094ui_story"
				var_23_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.actors_["1094ui_story"] = var_23_0

				local var_23_1 = var_23_0:GetComponentInChildren(typeof(CharacterEffect))

				var_23_1.enabled = true

				local var_23_2 = GameObjectTools.GetOrAddComponent(var_23_0, typeof(DynamicBoneHelper))

				if var_23_2 then
					var_23_2:EnableDynamicBone(false)
				end

				arg_20_1:ShowWeapon(var_23_1.transform, false)

				arg_20_1.var_["1094ui_story" .. "Animator"] = var_23_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_20_1.var_["1094ui_story" .. "Animator"].applyRootMotion = true
				arg_20_1.var_["1094ui_story" .. "LipSync"] = var_23_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_23_3 = arg_20_1.actors_["1094ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1094ui_story = var_23_3.localPosition
			end

			local var_23_4 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_4 then
				var_23_3.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_20_1.time_ - 0) / var_23_4)
				var_23_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_3.position).x, (manager.ui.mainCamera.transform.position - var_23_3.position).y, (manager.ui.mainCamera.transform.position - var_23_3.position).z)
				var_23_3.localEulerAngles.z = 0
				var_23_3.localEulerAngles.x = 0
				var_23_3.localEulerAngles = var_23_3.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_4 and arg_20_1.time_ < 0 + var_23_4 + arg_23_0 then
				var_23_3.localPosition = Vector3.New(0, -0.84, -6.1)
				var_23_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_3.position).x, (manager.ui.mainCamera.transform.position - var_23_3.position).y, (manager.ui.mainCamera.transform.position - var_23_3.position).z)
				var_23_3.localEulerAngles.z = 0
				var_23_3.localEulerAngles.x = 0
				var_23_3.localEulerAngles = var_23_3.localEulerAngles
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_23_5 = arg_20_1.actors_["1094ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_5) and arg_20_1.var_.characterEffect1094ui_story == nil then
				arg_20_1.var_.characterEffect1094ui_story = var_23_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_6 = 0.2

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_6 and not isNil(var_23_5) then
				if arg_20_1.var_.characterEffect1094ui_story and not isNil(var_23_5) then
					arg_20_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_6 and arg_20_1.time_ < 0 + var_23_6 + arg_23_0 and not isNil(var_23_5) and arg_20_1.var_.characterEffect1094ui_story then
				arg_20_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_23_8 = 0
			local var_23_9 = 0.05

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_8 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_10 = arg_20_1:GetWordFromCfg(111092005)
				local var_23_11 = arg_20_1:FormatText(var_23_10.content)

				arg_20_1.text_.text = var_23_11

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_13 = 2 <= 0 and var_23_9 or var_23_9 * (utf8.len(var_23_11) / 2)

				if (2 <= 0 and var_23_9 or var_23_9 * (utf8.len(var_23_11) / 2)) > 0 and var_23_9 < var_23_13 then
					arg_20_1.talkMaxDuration = var_23_13

					if var_23_13 + var_23_8 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_13 + var_23_8
					end
				end

				arg_20_1.text_.text = var_23_11
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111092", "111092005", "story_v_out_111092.awb") ~= 0 then
					local var_23_14 = manager.audio:GetVoiceLength("story_v_out_111092", "111092005", "story_v_out_111092.awb") / 1000

					if var_23_14 + var_23_8 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_14 + var_23_8
					end

					if var_23_10.prefab_name ~= "" and arg_20_1.actors_[var_23_10.prefab_name] ~= nil then
						local var_23_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_10.prefab_name].transform, "story_v_out_111092", "111092005", "story_v_out_111092.awb")

						arg_20_1:RecordAudio("111092005", var_23_15)
						arg_20_1:RecordAudio("111092005", var_23_15)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_111092", "111092005", "story_v_out_111092.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_111092", "111092005", "story_v_out_111092.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_16 = math.max(var_23_9, arg_20_1.talkMaxDuration)

			if var_23_8 <= arg_20_1.time_ and arg_20_1.time_ < var_23_8 + var_23_16 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_8) / var_23_16

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_8 + var_23_16 and arg_20_1.time_ < var_23_8 + var_23_16 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play111092006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 111092006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play111092007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["1094ui_story"]) and arg_24_1.var_.characterEffect1094ui_story == nil then
				arg_24_1.var_.characterEffect1094ui_story = arg_24_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.2

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["1094ui_story"]) then
				if arg_24_1.var_.characterEffect1094ui_story and not isNil(arg_24_1.actors_["1094ui_story"]) then
					arg_24_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_0)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["1094ui_story"]) and arg_24_1.var_.characterEffect1094ui_story then
				arg_24_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_27_1 = 0
			local var_27_2 = 0.6

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_3 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(111092006).content)

				arg_24_1.text_.text = var_27_3

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 24 <= 0 and var_27_2 or var_27_2 * (utf8.len(var_27_3) / 24)

				if (24 <= 0 and var_27_2 or var_27_2 * (utf8.len(var_27_3) / 24)) > 0 and var_27_2 < var_27_5 then
					arg_24_1.talkMaxDuration = var_27_5

					if var_27_5 + var_27_1 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_5 + var_27_1
					end
				end

				arg_24_1.text_.text = var_27_3
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_6 = math.max(var_27_2, arg_24_1.talkMaxDuration)

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_6 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_1) / var_27_6

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_1 + var_27_6 and arg_24_1.time_ < var_27_1 + var_27_6 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play111092007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 111092007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play111092008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0.4

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_1 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(111092007).content)

				arg_28_1.text_.text = var_31_1

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_3 = 16 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_1) / 16)

				if (16 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_1) / 16)) > 0 and var_31_0 < var_31_3 then
					arg_28_1.talkMaxDuration = var_31_3

					if var_31_3 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_3 + 0
					end
				end

				arg_28_1.text_.text = var_31_1
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_4 = math.max(var_31_0, arg_28_1.talkMaxDuration)

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_4 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - 0) / var_31_4

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= 0 + var_31_4 and arg_28_1.time_ < 0 + var_31_4 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play111092008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 111092008
		arg_32_1.duration_ = 2.3

		local var_32_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.3,
			en = 1.999999999999
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play111092009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_35_0 = arg_32_1.actors_["1094ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1094ui_story == nil then
				arg_32_1.var_.characterEffect1094ui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_1 = 0.2

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_1 and not isNil(var_35_0) then
				if arg_32_1.var_.characterEffect1094ui_story and not isNil(var_35_0) then
					arg_32_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_1 and arg_32_1.time_ < 0 + var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1094ui_story then
				arg_32_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_35_3 = 0
			local var_35_4 = 0.075

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_3 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_5 = arg_32_1:GetWordFromCfg(111092008)
				local var_35_6 = arg_32_1:FormatText(var_35_5.content)

				arg_32_1.text_.text = var_35_6

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_8 = 3 <= 0 and var_35_4 or var_35_4 * (utf8.len(var_35_6) / 3)

				if (3 <= 0 and var_35_4 or var_35_4 * (utf8.len(var_35_6) / 3)) > 0 and var_35_4 < var_35_8 then
					arg_32_1.talkMaxDuration = var_35_8

					if var_35_8 + var_35_3 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_3
					end
				end

				arg_32_1.text_.text = var_35_6
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111092", "111092008", "story_v_out_111092.awb") ~= 0 then
					local var_35_9 = manager.audio:GetVoiceLength("story_v_out_111092", "111092008", "story_v_out_111092.awb") / 1000

					if var_35_9 + var_35_3 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_9 + var_35_3
					end

					if var_35_5.prefab_name ~= "" and arg_32_1.actors_[var_35_5.prefab_name] ~= nil then
						local var_35_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_5.prefab_name].transform, "story_v_out_111092", "111092008", "story_v_out_111092.awb")

						arg_32_1:RecordAudio("111092008", var_35_10)
						arg_32_1:RecordAudio("111092008", var_35_10)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_111092", "111092008", "story_v_out_111092.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_111092", "111092008", "story_v_out_111092.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_11 = math.max(var_35_4, arg_32_1.talkMaxDuration)

			if var_35_3 <= arg_32_1.time_ and arg_32_1.time_ < var_35_3 + var_35_11 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_3) / var_35_11

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_3 + var_35_11 and arg_32_1.time_ < var_35_3 + var_35_11 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play111092009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 111092009
		arg_36_1.duration_ = 4.57

		local var_36_0 = {
			ja = 4.566,
			ko = 2.866,
			zh = 3.8,
			en = 3.166
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play111092010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094actionlink/1094action435")
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_39_0 = arg_36_1.actors_["1094ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1094ui_story == nil then
				arg_36_1.var_.characterEffect1094ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_1 = 0.2

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_1 and not isNil(var_39_0) then
				if arg_36_1.var_.characterEffect1094ui_story and not isNil(var_39_0) then
					arg_36_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_1 and arg_36_1.time_ < 0 + var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1094ui_story then
				arg_36_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_39_3 = 0
			local var_39_4 = 0.225

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_3 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_5 = arg_36_1:GetWordFromCfg(111092009)
				local var_39_6 = arg_36_1:FormatText(var_39_5.content)

				arg_36_1.text_.text = var_39_6

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_8 = 9 <= 0 and var_39_4 or var_39_4 * (utf8.len(var_39_6) / 9)

				if (9 <= 0 and var_39_4 or var_39_4 * (utf8.len(var_39_6) / 9)) > 0 and var_39_4 < var_39_8 then
					arg_36_1.talkMaxDuration = var_39_8

					if var_39_8 + var_39_3 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_8 + var_39_3
					end
				end

				arg_36_1.text_.text = var_39_6
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111092", "111092009", "story_v_out_111092.awb") ~= 0 then
					local var_39_9 = manager.audio:GetVoiceLength("story_v_out_111092", "111092009", "story_v_out_111092.awb") / 1000

					if var_39_9 + var_39_3 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_9 + var_39_3
					end

					if var_39_5.prefab_name ~= "" and arg_36_1.actors_[var_39_5.prefab_name] ~= nil then
						local var_39_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_5.prefab_name].transform, "story_v_out_111092", "111092009", "story_v_out_111092.awb")

						arg_36_1:RecordAudio("111092009", var_39_10)
						arg_36_1:RecordAudio("111092009", var_39_10)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_111092", "111092009", "story_v_out_111092.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_111092", "111092009", "story_v_out_111092.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_11 = math.max(var_39_4, arg_36_1.talkMaxDuration)

			if var_39_3 <= arg_36_1.time_ and arg_36_1.time_ < var_39_3 + var_39_11 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_3) / var_39_11

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_3 + var_39_11 and arg_36_1.time_ < var_39_3 + var_39_11 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play111092010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 111092010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play111092011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["1094ui_story"]) and arg_40_1.var_.characterEffect1094ui_story == nil then
				arg_40_1.var_.characterEffect1094ui_story = arg_40_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.2

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["1094ui_story"]) then
				if arg_40_1.var_.characterEffect1094ui_story and not isNil(arg_40_1.actors_["1094ui_story"]) then
					arg_40_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_0)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["1094ui_story"]) and arg_40_1.var_.characterEffect1094ui_story then
				arg_40_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_43_1 = 0
			local var_43_2 = 0.225

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_3 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(111092010).content)

				arg_40_1.text_.text = var_43_3

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 9 <= 0 and var_43_2 or var_43_2 * (utf8.len(var_43_3) / 9)

				if (9 <= 0 and var_43_2 or var_43_2 * (utf8.len(var_43_3) / 9)) > 0 and var_43_2 < var_43_5 then
					arg_40_1.talkMaxDuration = var_43_5

					if var_43_5 + var_43_1 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + var_43_1
					end
				end

				arg_40_1.text_.text = var_43_3
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_6 = math.max(var_43_2, arg_40_1.talkMaxDuration)

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_6 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_1) / var_43_6

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_1 + var_43_6 and arg_40_1.time_ < var_43_1 + var_43_6 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play111092011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 111092011
		arg_44_1.duration_ = 13.33

		local var_44_0 = {
			ja = 10.366,
			ko = 10.066,
			zh = 13.333,
			en = 10.7
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play111092012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_47_0 = arg_44_1.actors_["1094ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1094ui_story == nil then
				arg_44_1.var_.characterEffect1094ui_story = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_1 = 0.2

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_1 and not isNil(var_47_0) then
				if arg_44_1.var_.characterEffect1094ui_story and not isNil(var_47_0) then
					arg_44_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_1 and arg_44_1.time_ < 0 + var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1094ui_story then
				arg_44_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_47_3 = 0
			local var_47_4 = 1.05

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_3 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_5 = arg_44_1:GetWordFromCfg(111092011)
				local var_47_6 = arg_44_1:FormatText(var_47_5.content)

				arg_44_1.text_.text = var_47_6

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_8 = 42 <= 0 and var_47_4 or var_47_4 * (utf8.len(var_47_6) / 42)

				if (42 <= 0 and var_47_4 or var_47_4 * (utf8.len(var_47_6) / 42)) > 0 and var_47_4 < var_47_8 then
					arg_44_1.talkMaxDuration = var_47_8

					if var_47_8 + var_47_3 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_3
					end
				end

				arg_44_1.text_.text = var_47_6
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111092", "111092011", "story_v_out_111092.awb") ~= 0 then
					local var_47_9 = manager.audio:GetVoiceLength("story_v_out_111092", "111092011", "story_v_out_111092.awb") / 1000

					if var_47_9 + var_47_3 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_9 + var_47_3
					end

					if var_47_5.prefab_name ~= "" and arg_44_1.actors_[var_47_5.prefab_name] ~= nil then
						local var_47_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_5.prefab_name].transform, "story_v_out_111092", "111092011", "story_v_out_111092.awb")

						arg_44_1:RecordAudio("111092011", var_47_10)
						arg_44_1:RecordAudio("111092011", var_47_10)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_111092", "111092011", "story_v_out_111092.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_111092", "111092011", "story_v_out_111092.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_11 = math.max(var_47_4, arg_44_1.talkMaxDuration)

			if var_47_3 <= arg_44_1.time_ and arg_44_1.time_ < var_47_3 + var_47_11 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_3) / var_47_11

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_3 + var_47_11 and arg_44_1.time_ < var_47_3 + var_47_11 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play111092012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 111092012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play111092013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["1094ui_story"]) and arg_48_1.var_.characterEffect1094ui_story == nil then
				arg_48_1.var_.characterEffect1094ui_story = arg_48_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.2

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["1094ui_story"]) then
				if arg_48_1.var_.characterEffect1094ui_story and not isNil(arg_48_1.actors_["1094ui_story"]) then
					arg_48_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_0)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["1094ui_story"]) and arg_48_1.var_.characterEffect1094ui_story then
				arg_48_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_51_1 = 0
			local var_51_2 = 0.275

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_3 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(111092012).content)

				arg_48_1.text_.text = var_51_3

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 11 <= 0 and var_51_2 or var_51_2 * (utf8.len(var_51_3) / 11)

				if (11 <= 0 and var_51_2 or var_51_2 * (utf8.len(var_51_3) / 11)) > 0 and var_51_2 < var_51_5 then
					arg_48_1.talkMaxDuration = var_51_5

					if var_51_5 + var_51_1 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_5 + var_51_1
					end
				end

				arg_48_1.text_.text = var_51_3
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_6 = math.max(var_51_2, arg_48_1.talkMaxDuration)

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_6 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_1) / var_51_6

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_1 + var_51_6 and arg_48_1.time_ < var_51_1 + var_51_6 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play111092013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 111092013
		arg_52_1.duration_ = 8.9

		local var_52_0 = {
			ja = 5.5,
			ko = 6.333,
			zh = 8.9,
			en = 8.3
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play111092014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_55_0 = arg_52_1.actors_["1094ui_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1094ui_story == nil then
				arg_52_1.var_.characterEffect1094ui_story = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_1 = 0.2

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_1 and not isNil(var_55_0) then
				if arg_52_1.var_.characterEffect1094ui_story and not isNil(var_55_0) then
					arg_52_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= 0 + var_55_1 and arg_52_1.time_ < 0 + var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1094ui_story then
				arg_52_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_55_3 = 0
			local var_55_4 = 0.725

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_3 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_5 = arg_52_1:GetWordFromCfg(111092013)
				local var_55_6 = arg_52_1:FormatText(var_55_5.content)

				arg_52_1.text_.text = var_55_6

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_8 = 29 <= 0 and var_55_4 or var_55_4 * (utf8.len(var_55_6) / 29)

				if (29 <= 0 and var_55_4 or var_55_4 * (utf8.len(var_55_6) / 29)) > 0 and var_55_4 < var_55_8 then
					arg_52_1.talkMaxDuration = var_55_8

					if var_55_8 + var_55_3 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_8 + var_55_3
					end
				end

				arg_52_1.text_.text = var_55_6
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111092", "111092013", "story_v_out_111092.awb") ~= 0 then
					local var_55_9 = manager.audio:GetVoiceLength("story_v_out_111092", "111092013", "story_v_out_111092.awb") / 1000

					if var_55_9 + var_55_3 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_9 + var_55_3
					end

					if var_55_5.prefab_name ~= "" and arg_52_1.actors_[var_55_5.prefab_name] ~= nil then
						local var_55_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_5.prefab_name].transform, "story_v_out_111092", "111092013", "story_v_out_111092.awb")

						arg_52_1:RecordAudio("111092013", var_55_10)
						arg_52_1:RecordAudio("111092013", var_55_10)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_111092", "111092013", "story_v_out_111092.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_111092", "111092013", "story_v_out_111092.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_11 = math.max(var_55_4, arg_52_1.talkMaxDuration)

			if var_55_3 <= arg_52_1.time_ and arg_52_1.time_ < var_55_3 + var_55_11 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_3) / var_55_11

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_3 + var_55_11 and arg_52_1.time_ < var_55_3 + var_55_11 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play111092014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 111092014
		arg_56_1.duration_ = 9.73

		local var_56_0 = {
			ja = 3.033,
			ko = 7.8,
			zh = 8.1,
			en = 9.733
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play111092015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_59_0 = arg_56_1.actors_["1094ui_story"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1094ui_story == nil then
				arg_56_1.var_.characterEffect1094ui_story = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_1 = 0.2

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_1 and not isNil(var_59_0) then
				if arg_56_1.var_.characterEffect1094ui_story and not isNil(var_59_0) then
					arg_56_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 0 + var_59_1 and arg_56_1.time_ < 0 + var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1094ui_story then
				arg_56_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_59_3 = 0
			local var_59_4 = 0.65

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_3 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_5 = arg_56_1:GetWordFromCfg(111092014)
				local var_59_6 = arg_56_1:FormatText(var_59_5.content)

				arg_56_1.text_.text = var_59_6

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_8 = 26 <= 0 and var_59_4 or var_59_4 * (utf8.len(var_59_6) / 26)

				if (26 <= 0 and var_59_4 or var_59_4 * (utf8.len(var_59_6) / 26)) > 0 and var_59_4 < var_59_8 then
					arg_56_1.talkMaxDuration = var_59_8

					if var_59_8 + var_59_3 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_8 + var_59_3
					end
				end

				arg_56_1.text_.text = var_59_6
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111092", "111092014", "story_v_out_111092.awb") ~= 0 then
					local var_59_9 = manager.audio:GetVoiceLength("story_v_out_111092", "111092014", "story_v_out_111092.awb") / 1000

					if var_59_9 + var_59_3 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_9 + var_59_3
					end

					if var_59_5.prefab_name ~= "" and arg_56_1.actors_[var_59_5.prefab_name] ~= nil then
						local var_59_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_5.prefab_name].transform, "story_v_out_111092", "111092014", "story_v_out_111092.awb")

						arg_56_1:RecordAudio("111092014", var_59_10)
						arg_56_1:RecordAudio("111092014", var_59_10)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_111092", "111092014", "story_v_out_111092.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_111092", "111092014", "story_v_out_111092.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_11 = math.max(var_59_4, arg_56_1.talkMaxDuration)

			if var_59_3 <= arg_56_1.time_ and arg_56_1.time_ < var_59_3 + var_59_11 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_3) / var_59_11

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_3 + var_59_11 and arg_56_1.time_ < var_59_3 + var_59_11 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play111092015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 111092015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play111092016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["1094ui_story"]) and arg_60_1.var_.characterEffect1094ui_story == nil then
				arg_60_1.var_.characterEffect1094ui_story = arg_60_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_0 = 0.2

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["1094ui_story"]) then
				if arg_60_1.var_.characterEffect1094ui_story and not isNil(arg_60_1.actors_["1094ui_story"]) then
					arg_60_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_60_1.time_ - 0) / var_63_0)
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["1094ui_story"]) and arg_60_1.var_.characterEffect1094ui_story then
				arg_60_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_63_1 = 0
			local var_63_2 = 0.2

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_3 = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(111092015).content)

				arg_60_1.text_.text = var_63_3

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_5 = 8 <= 0 and var_63_2 or var_63_2 * (utf8.len(var_63_3) / 8)

				if (8 <= 0 and var_63_2 or var_63_2 * (utf8.len(var_63_3) / 8)) > 0 and var_63_2 < var_63_5 then
					arg_60_1.talkMaxDuration = var_63_5

					if var_63_5 + var_63_1 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_5 + var_63_1
					end
				end

				arg_60_1.text_.text = var_63_3
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_6 = math.max(var_63_2, arg_60_1.talkMaxDuration)

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_6 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_1) / var_63_6

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_1 + var_63_6 and arg_60_1.time_ < var_63_1 + var_63_6 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play111092016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 111092016
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play111092017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0.725

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_1 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(111092016).content)

				arg_64_1.text_.text = var_67_1

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_3 = 29 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_1) / 29)

				if (29 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_1) / 29)) > 0 and var_67_0 < var_67_3 then
					arg_64_1.talkMaxDuration = var_67_3

					if var_67_3 + 0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_3 + 0
					end
				end

				arg_64_1.text_.text = var_67_1
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_4 = math.max(var_67_0, arg_64_1.talkMaxDuration)

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_4 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - 0) / var_67_4

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= 0 + var_67_4 and arg_64_1.time_ < 0 + var_67_4 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play111092017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 111092017
		arg_68_1.duration_ = 3.47

		local var_68_0 = {
			ja = 3.466,
			ko = 2.1,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play111092018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094actionlink/1094action453")
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_71_0 = arg_68_1.actors_["1094ui_story"]

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1094ui_story == nil then
				arg_68_1.var_.characterEffect1094ui_story = var_71_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_1 = 0.2

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_1 and not isNil(var_71_0) then
				if arg_68_1.var_.characterEffect1094ui_story and not isNil(var_71_0) then
					arg_68_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= 0 + var_71_1 and arg_68_1.time_ < 0 + var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1094ui_story then
				arg_68_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_71_3 = 0
			local var_71_4 = 0.15

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_3 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_5 = arg_68_1:GetWordFromCfg(111092017)
				local var_71_6 = arg_68_1:FormatText(var_71_5.content)

				arg_68_1.text_.text = var_71_6

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_8 = 6 <= 0 and var_71_4 or var_71_4 * (utf8.len(var_71_6) / 6)

				if (6 <= 0 and var_71_4 or var_71_4 * (utf8.len(var_71_6) / 6)) > 0 and var_71_4 < var_71_8 then
					arg_68_1.talkMaxDuration = var_71_8

					if var_71_8 + var_71_3 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_8 + var_71_3
					end
				end

				arg_68_1.text_.text = var_71_6
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111092", "111092017", "story_v_out_111092.awb") ~= 0 then
					local var_71_9 = manager.audio:GetVoiceLength("story_v_out_111092", "111092017", "story_v_out_111092.awb") / 1000

					if var_71_9 + var_71_3 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_9 + var_71_3
					end

					if var_71_5.prefab_name ~= "" and arg_68_1.actors_[var_71_5.prefab_name] ~= nil then
						local var_71_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_5.prefab_name].transform, "story_v_out_111092", "111092017", "story_v_out_111092.awb")

						arg_68_1:RecordAudio("111092017", var_71_10)
						arg_68_1:RecordAudio("111092017", var_71_10)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_111092", "111092017", "story_v_out_111092.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_111092", "111092017", "story_v_out_111092.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_11 = math.max(var_71_4, arg_68_1.talkMaxDuration)

			if var_71_3 <= arg_68_1.time_ and arg_68_1.time_ < var_71_3 + var_71_11 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_3) / var_71_11

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_3 + var_71_11 and arg_68_1.time_ < var_71_3 + var_71_11 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play111092018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 111092018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play111092019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if arg_72_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_75_0 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_72_1.stage_.transform)

				var_75_0.name = "1019ui_story"
				var_75_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_72_1.actors_["1019ui_story"] = var_75_0

				local var_75_1 = var_75_0:GetComponentInChildren(typeof(CharacterEffect))

				var_75_1.enabled = true

				local var_75_2 = GameObjectTools.GetOrAddComponent(var_75_0, typeof(DynamicBoneHelper))

				if var_75_2 then
					var_75_2:EnableDynamicBone(false)
				end

				arg_72_1:ShowWeapon(var_75_1.transform, false)

				arg_72_1.var_["1019ui_story" .. "Animator"] = var_75_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_72_1.var_["1019ui_story" .. "Animator"].applyRootMotion = true
				arg_72_1.var_["1019ui_story" .. "LipSync"] = var_75_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_75_3 = arg_72_1.actors_["1019ui_story"].transform

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos1019ui_story = var_75_3.localPosition
			end

			local var_75_4 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_4 then
				var_75_3.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_72_1.time_ - 0) / var_75_4)
				var_75_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_3.position).x, (manager.ui.mainCamera.transform.position - var_75_3.position).y, (manager.ui.mainCamera.transform.position - var_75_3.position).z)
				var_75_3.localEulerAngles.z = 0
				var_75_3.localEulerAngles.x = 0
				var_75_3.localEulerAngles = var_75_3.localEulerAngles
			end

			if arg_72_1.time_ >= 0 + var_75_4 and arg_72_1.time_ < 0 + var_75_4 + arg_75_0 then
				var_75_3.localPosition = Vector3.New(0, 100, 0)
				var_75_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_3.position).x, (manager.ui.mainCamera.transform.position - var_75_3.position).y, (manager.ui.mainCamera.transform.position - var_75_3.position).z)
				var_75_3.localEulerAngles.z = 0
				var_75_3.localEulerAngles.x = 0
				var_75_3.localEulerAngles = var_75_3.localEulerAngles
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_75_5 = arg_72_1.actors_["1094ui_story"]

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(var_75_5) and arg_72_1.var_.characterEffect1094ui_story == nil then
				arg_72_1.var_.characterEffect1094ui_story = var_75_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_6 = 0.2

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_6 and not isNil(var_75_5) then
				if arg_72_1.var_.characterEffect1094ui_story and not isNil(var_75_5) then
					arg_72_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_72_1.time_ - 0) / var_75_6)
				end
			end

			if arg_72_1.time_ >= 0 + var_75_6 and arg_72_1.time_ < 0 + var_75_6 + arg_75_0 and not isNil(var_75_5) and arg_72_1.var_.characterEffect1094ui_story then
				arg_72_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_75_7 = 0
			local var_75_8 = 0.3

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_7 + arg_75_0 then
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

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_9 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(111092018).content)

				arg_72_1.text_.text = var_75_9

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_11 = 12 <= 0 and var_75_8 or var_75_8 * (utf8.len(var_75_9) / 12)

				if (12 <= 0 and var_75_8 or var_75_8 * (utf8.len(var_75_9) / 12)) > 0 and var_75_8 < var_75_11 then
					arg_72_1.talkMaxDuration = var_75_11

					if var_75_11 + var_75_7 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_11 + var_75_7
					end
				end

				arg_72_1.text_.text = var_75_9
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_12 = math.max(var_75_8, arg_72_1.talkMaxDuration)

			if var_75_7 <= arg_72_1.time_ and arg_72_1.time_ < var_75_7 + var_75_12 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_7) / var_75_12

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_7 + var_75_12 and arg_72_1.time_ < var_75_7 + var_75_12 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play111092019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 111092019
		arg_76_1.duration_ = 9

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play111092020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if arg_76_1.bgs_.ST10 == nil then
				local var_79_0 = Object.Instantiate(arg_76_1.paintGo_)

				var_79_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST10")
				var_79_0.name = "ST10"
				var_79_0.transform.parent = arg_76_1.stage_.transform
				var_79_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_76_1.bgs_.ST10 = var_79_0
			end

			if 2 < arg_76_1.time_ and arg_76_1.time_ <= 2 + arg_79_0 then
				local var_79_1 = arg_76_1.bgs_.ST10

				arg_76_1.bgs_.ST10.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_79_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_79_2 = var_79_1:GetComponent("SpriteRenderer")

				if var_79_2 and var_79_2.sprite then
					local var_79_3 = 2 * (var_79_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_79_1.transform.localScale = Vector3.New(var_79_3 / var_79_2.sprite.bounds.size.y < var_79_3 * manager.ui.mainCameraCom_.aspect / var_79_2.sprite.bounds.size.x and var_79_3 * manager.ui.mainCameraCom_.aspect / var_79_2.sprite.bounds.size.x or var_79_3 / var_79_2.sprite.bounds.size.y, var_79_3 / var_79_2.sprite.bounds.size.y < var_79_3 * manager.ui.mainCameraCom_.aspect / var_79_2.sprite.bounds.size.x and var_79_3 * manager.ui.mainCameraCom_.aspect / var_79_2.sprite.bounds.size.x or var_79_3 / var_79_2.sprite.bounds.size.y, 0)
				end

				for iter_79_0, iter_79_1 in pairs(arg_76_1.bgs_) do
					if iter_79_0 ~= "ST10" then
						iter_79_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_79_4 = arg_76_1.actors_["1094ui_story"].transform

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos1094ui_story = var_79_4.localPosition
			end

			local var_79_5 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_5 then
				var_79_4.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1094ui_story, Vector3.New(0, 100, 0), (arg_76_1.time_ - 0) / var_79_5)
				var_79_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_4.position).x, (manager.ui.mainCamera.transform.position - var_79_4.position).y, (manager.ui.mainCamera.transform.position - var_79_4.position).z)
				var_79_4.localEulerAngles.z = 0
				var_79_4.localEulerAngles.x = 0
				var_79_4.localEulerAngles = var_79_4.localEulerAngles
			end

			if arg_76_1.time_ >= 0 + var_79_5 and arg_76_1.time_ < 0 + var_79_5 + arg_79_0 then
				var_79_4.localPosition = Vector3.New(0, 100, 0)
				var_79_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_4.position).x, (manager.ui.mainCamera.transform.position - var_79_4.position).y, (manager.ui.mainCamera.transform.position - var_79_4.position).z)
				var_79_4.localEulerAngles.z = 0
				var_79_4.localEulerAngles.x = 0
				var_79_4.localEulerAngles = var_79_4.localEulerAngles
			end

			local var_79_6 = arg_76_1.actors_["1019ui_story"].transform

			if 3.5 < arg_76_1.time_ and arg_76_1.time_ <= 3.5 + arg_79_0 then
				arg_76_1.var_.moveOldPos1019ui_story = var_79_6.localPosition
			end

			local var_79_7 = 0.001

			if 3.5 <= arg_76_1.time_ and arg_76_1.time_ < 3.5 + var_79_7 then
				var_79_6.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_76_1.time_ - 3.5) / var_79_7)
				var_79_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_6.position).x, (manager.ui.mainCamera.transform.position - var_79_6.position).y, (manager.ui.mainCamera.transform.position - var_79_6.position).z)
				var_79_6.localEulerAngles.z = 0
				var_79_6.localEulerAngles.x = 0
				var_79_6.localEulerAngles = var_79_6.localEulerAngles
			end

			if arg_76_1.time_ >= 3.5 + var_79_7 and arg_76_1.time_ < 3.5 + var_79_7 + arg_79_0 then
				var_79_6.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_79_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_6.position).x, (manager.ui.mainCamera.transform.position - var_79_6.position).y, (manager.ui.mainCamera.transform.position - var_79_6.position).z)
				var_79_6.localEulerAngles.z = 0
				var_79_6.localEulerAngles.x = 0
				var_79_6.localEulerAngles = var_79_6.localEulerAngles
			end

			if 3.5 < arg_76_1.time_ and arg_76_1.time_ <= 3.5 + arg_79_0 then
				arg_76_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_79_8 = 3.5

			arg_76_1.isInRecall_ = false

			if var_79_8 < arg_76_1.time_ and arg_76_1.time_ <= var_79_8 + arg_79_0 then
				arg_76_1.screenFilterGo_:SetActive(true)

				arg_76_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_79_2, iter_79_3 in pairs(arg_76_1.actors_) do
					for iter_79_4, iter_79_5 in ipairs((iter_79_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_79_5.color = iter_79_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_79_9 = 0.2

			if var_79_8 <= arg_76_1.time_ and arg_76_1.time_ < var_79_8 + var_79_9 then
				arg_76_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_76_1.time_ - var_79_8) / var_79_9)
			end

			if arg_76_1.time_ >= var_79_8 + var_79_9 and arg_76_1.time_ < var_79_8 + var_79_9 + arg_79_0 then
				arg_76_1.screenFilterEffect_.weight = 1
			end

			local var_79_10 = 0

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_10 + arg_79_0 then
				arg_76_1.mask_.enabled = true
				arg_76_1.mask_.raycastTarget = true

				arg_76_1:SetGaussion(false)
			end

			local var_79_11 = 2

			if var_79_10 <= arg_76_1.time_ and arg_76_1.time_ < var_79_10 + var_79_11 then
				local var_79_12 = Color.New(0, 0, 0)

				var_79_12.a = Mathf.Lerp(0, 1, (arg_76_1.time_ - var_79_10) / var_79_11)
				arg_76_1.mask_.color = var_79_12
			end

			if arg_76_1.time_ >= var_79_10 + var_79_11 and arg_76_1.time_ < var_79_10 + var_79_11 + arg_79_0 then
				local var_79_13 = Color.New(0, 0, 0)

				var_79_13.a = 1
				arg_76_1.mask_.color = var_79_13
			end

			local var_79_14 = 2

			if 2 < arg_76_1.time_ and arg_76_1.time_ <= var_79_14 + arg_79_0 then
				arg_76_1.mask_.enabled = true
				arg_76_1.mask_.raycastTarget = true

				arg_76_1:SetGaussion(false)
			end

			local var_79_15 = 2

			if var_79_14 <= arg_76_1.time_ and arg_76_1.time_ < var_79_14 + var_79_15 then
				local var_79_16 = Color.New(0, 0, 0)

				var_79_16.a = Mathf.Lerp(1, 0, (arg_76_1.time_ - var_79_14) / var_79_15)
				arg_76_1.mask_.color = var_79_16
			end

			if arg_76_1.time_ >= var_79_14 + var_79_15 and arg_76_1.time_ < var_79_14 + var_79_15 + arg_79_0 then
				local var_79_17 = Color.New(0, 0, 0)

				arg_76_1.mask_.enabled = false
				var_79_17.a = 0
				arg_76_1.mask_.color = var_79_17
			end

			local var_79_18 = 4

			arg_76_1.isInRecall_ = false

			if var_79_18 < arg_76_1.time_ and arg_76_1.time_ <= var_79_18 + arg_79_0 then
				arg_76_1.screenFilterGo_:SetActive(true)

				arg_76_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_79_6, iter_79_7 in pairs(arg_76_1.actors_) do
					for iter_79_8, iter_79_9 in ipairs((iter_79_7:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_79_9.color = iter_79_9.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_79_19 = 0.0166666666666667

			if var_79_18 <= arg_76_1.time_ and arg_76_1.time_ < var_79_18 + var_79_19 then
				arg_76_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_76_1.time_ - var_79_18) / var_79_19)
			end

			if arg_76_1.time_ >= var_79_18 + var_79_19 and arg_76_1.time_ < var_79_18 + var_79_19 + arg_79_0 then
				arg_76_1.screenFilterEffect_.weight = 1
			end

			if arg_76_1.frameCnt_ <= 1 then
				arg_76_1.dialog_:SetActive(false)
			end

			local var_79_20 = 4
			local var_79_21 = 1.175

			if 4 < arg_76_1.time_ and arg_76_1.time_ <= var_79_20 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0

				arg_76_1.dialog_:SetActive(true)

				arg_76_1.dialogCg_.alpha = 0

				local var_79_22 = LeanTween.value(arg_76_1.dialog_, 0, 1, 0.3)

				var_79_22:setOnUpdate(LuaHelper.FloatAction(function(arg_80_0)
					arg_76_1.dialogCg_.alpha = arg_80_0
				end))
				var_79_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_76_1.dialog_)
					var_79_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_76_1.duration_ = arg_76_1.duration_ + 0.3

				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_23 = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(111092019).content)

				arg_76_1.text_.text = var_79_23

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_25 = 47 <= 0 and var_79_21 or var_79_21 * (utf8.len(var_79_23) / 47)

				if (47 <= 0 and var_79_21 or var_79_21 * (utf8.len(var_79_23) / 47)) > 0 and var_79_21 < var_79_25 then
					arg_76_1.talkMaxDuration = var_79_25
					var_79_20 = var_79_20 + 0.3

					if var_79_25 + var_79_20 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_25 + var_79_20
					end
				end

				arg_76_1.text_.text = var_79_23
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_26 = var_79_20 + 0.3
			local var_79_27 = math.max(var_79_21, arg_76_1.talkMaxDuration)

			if var_79_20 + 0.3 <= arg_76_1.time_ and arg_76_1.time_ < var_79_26 + var_79_27 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_26) / var_79_27

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_26 + var_79_27 and arg_76_1.time_ < var_79_26 + var_79_27 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play111092020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 111092020
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play111092021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0.95

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, true)
				arg_82_1.iconController_:SetSelectedState("hero")

				arg_82_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_82_1.callingController_:SetSelectedState("normal")

				arg_82_1.keyicon_.color = Color.New(1, 1, 1)
				arg_82_1.icon_.color = Color.New(1, 1, 1)

				local var_85_1 = arg_82_1:FormatText(arg_82_1:GetWordFromCfg(111092020).content)

				arg_82_1.text_.text = var_85_1

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_3 = 38 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_1) / 38)

				if (38 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_1) / 38)) > 0 and var_85_0 < var_85_3 then
					arg_82_1.talkMaxDuration = var_85_3

					if var_85_3 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_3 + 0
					end
				end

				arg_82_1.text_.text = var_85_1
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_4 = math.max(var_85_0, arg_82_1.talkMaxDuration)

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_4 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - 0) / var_85_4

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= 0 + var_85_4 and arg_82_1.time_ < 0 + var_85_4 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play111092021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 111092021
		arg_86_1.duration_ = 10.6

		local var_86_0 = {
			ja = 10.6,
			ko = 8,
			zh = 8.9,
			en = 7.166
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play111092022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_89_0 = arg_86_1.actors_["1019ui_story"]

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect1019ui_story == nil then
				arg_86_1.var_.characterEffect1019ui_story = var_89_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_1 = 0.2

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_1 and not isNil(var_89_0) then
				if arg_86_1.var_.characterEffect1019ui_story and not isNil(var_89_0) then
					arg_86_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= 0 + var_89_1 and arg_86_1.time_ < 0 + var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect1019ui_story then
				arg_86_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_89_3 = 0
			local var_89_4 = 0.975

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_3 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_5 = arg_86_1:GetWordFromCfg(111092021)
				local var_89_6 = arg_86_1:FormatText(var_89_5.content)

				arg_86_1.text_.text = var_89_6

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_8 = 40 <= 0 and var_89_4 or var_89_4 * (utf8.len(var_89_6) / 40)

				if (40 <= 0 and var_89_4 or var_89_4 * (utf8.len(var_89_6) / 40)) > 0 and var_89_4 < var_89_8 then
					arg_86_1.talkMaxDuration = var_89_8

					if var_89_8 + var_89_3 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_8 + var_89_3
					end
				end

				arg_86_1.text_.text = var_89_6
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111092", "111092021", "story_v_out_111092.awb") ~= 0 then
					local var_89_9 = manager.audio:GetVoiceLength("story_v_out_111092", "111092021", "story_v_out_111092.awb") / 1000

					if var_89_9 + var_89_3 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_9 + var_89_3
					end

					if var_89_5.prefab_name ~= "" and arg_86_1.actors_[var_89_5.prefab_name] ~= nil then
						local var_89_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_5.prefab_name].transform, "story_v_out_111092", "111092021", "story_v_out_111092.awb")

						arg_86_1:RecordAudio("111092021", var_89_10)
						arg_86_1:RecordAudio("111092021", var_89_10)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_111092", "111092021", "story_v_out_111092.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_111092", "111092021", "story_v_out_111092.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_11 = math.max(var_89_4, arg_86_1.talkMaxDuration)

			if var_89_3 <= arg_86_1.time_ and arg_86_1.time_ < var_89_3 + var_89_11 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_3) / var_89_11

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_3 + var_89_11 and arg_86_1.time_ < var_89_3 + var_89_11 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play111092022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 111092022
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play111092023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(arg_90_1.actors_["1019ui_story"]) and arg_90_1.var_.characterEffect1019ui_story == nil then
				arg_90_1.var_.characterEffect1019ui_story = arg_90_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_0 = 0.2

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 and not isNil(arg_90_1.actors_["1019ui_story"]) then
				if arg_90_1.var_.characterEffect1019ui_story and not isNil(arg_90_1.actors_["1019ui_story"]) then
					arg_90_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_90_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_90_1.time_ - 0) / var_93_0)
				end
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 and not isNil(arg_90_1.actors_["1019ui_story"]) and arg_90_1.var_.characterEffect1019ui_story then
				arg_90_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_90_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_93_1 = 0
			local var_93_2 = 1.1

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 then
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

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_3 = arg_90_1:FormatText(arg_90_1:GetWordFromCfg(111092022).content)

				arg_90_1.text_.text = var_93_3

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_5 = 44 <= 0 and var_93_2 or var_93_2 * (utf8.len(var_93_3) / 44)

				if (44 <= 0 and var_93_2 or var_93_2 * (utf8.len(var_93_3) / 44)) > 0 and var_93_2 < var_93_5 then
					arg_90_1.talkMaxDuration = var_93_5

					if var_93_5 + var_93_1 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_5 + var_93_1
					end
				end

				arg_90_1.text_.text = var_93_3
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_6 = math.max(var_93_2, arg_90_1.talkMaxDuration)

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_6 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_1) / var_93_6

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_1 + var_93_6 and arg_90_1.time_ < var_93_1 + var_93_6 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play111092023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 111092023
		arg_94_1.duration_ = 2

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play111092024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_97_0 = arg_94_1.actors_["1019ui_story"]

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1019ui_story == nil then
				arg_94_1.var_.characterEffect1019ui_story = var_97_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_1 = 0.2

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_1 and not isNil(var_97_0) then
				if arg_94_1.var_.characterEffect1019ui_story and not isNil(var_97_0) then
					arg_94_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= 0 + var_97_1 and arg_94_1.time_ < 0 + var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1019ui_story then
				arg_94_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_97_3 = 0
			local var_97_4 = 0.125

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_3 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_5 = arg_94_1:GetWordFromCfg(111092023)
				local var_97_6 = arg_94_1:FormatText(var_97_5.content)

				arg_94_1.text_.text = var_97_6

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_8 = 5 <= 0 and var_97_4 or var_97_4 * (utf8.len(var_97_6) / 5)

				if (5 <= 0 and var_97_4 or var_97_4 * (utf8.len(var_97_6) / 5)) > 0 and var_97_4 < var_97_8 then
					arg_94_1.talkMaxDuration = var_97_8

					if var_97_8 + var_97_3 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_8 + var_97_3
					end
				end

				arg_94_1.text_.text = var_97_6
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111092", "111092023", "story_v_out_111092.awb") ~= 0 then
					local var_97_9 = manager.audio:GetVoiceLength("story_v_out_111092", "111092023", "story_v_out_111092.awb") / 1000

					if var_97_9 + var_97_3 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_9 + var_97_3
					end

					if var_97_5.prefab_name ~= "" and arg_94_1.actors_[var_97_5.prefab_name] ~= nil then
						local var_97_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_5.prefab_name].transform, "story_v_out_111092", "111092023", "story_v_out_111092.awb")

						arg_94_1:RecordAudio("111092023", var_97_10)
						arg_94_1:RecordAudio("111092023", var_97_10)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_111092", "111092023", "story_v_out_111092.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_111092", "111092023", "story_v_out_111092.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_11 = math.max(var_97_4, arg_94_1.talkMaxDuration)

			if var_97_3 <= arg_94_1.time_ and arg_94_1.time_ < var_97_3 + var_97_11 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_3) / var_97_11

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_3 + var_97_11 and arg_94_1.time_ < var_97_3 + var_97_11 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play111092024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 111092024
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play111092025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(arg_98_1.actors_["1019ui_story"]) and arg_98_1.var_.characterEffect1019ui_story == nil then
				arg_98_1.var_.characterEffect1019ui_story = arg_98_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_0 = 0.2

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_0 and not isNil(arg_98_1.actors_["1019ui_story"]) then
				if arg_98_1.var_.characterEffect1019ui_story and not isNil(arg_98_1.actors_["1019ui_story"]) then
					arg_98_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_98_1.time_ - 0) / var_101_0)
				end
			end

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 and not isNil(arg_98_1.actors_["1019ui_story"]) and arg_98_1.var_.characterEffect1019ui_story then
				arg_98_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_101_1 = 0
			local var_101_2 = 0.85

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, true)
				arg_98_1.iconController_:SetSelectedState("hero")

				arg_98_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_98_1.callingController_:SetSelectedState("normal")

				arg_98_1.keyicon_.color = Color.New(1, 1, 1)
				arg_98_1.icon_.color = Color.New(1, 1, 1)

				local var_101_3 = arg_98_1:FormatText(arg_98_1:GetWordFromCfg(111092024).content)

				arg_98_1.text_.text = var_101_3

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_5 = 34 <= 0 and var_101_2 or var_101_2 * (utf8.len(var_101_3) / 34)

				if (34 <= 0 and var_101_2 or var_101_2 * (utf8.len(var_101_3) / 34)) > 0 and var_101_2 < var_101_5 then
					arg_98_1.talkMaxDuration = var_101_5

					if var_101_5 + var_101_1 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_5 + var_101_1
					end
				end

				arg_98_1.text_.text = var_101_3
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_6 = math.max(var_101_2, arg_98_1.talkMaxDuration)

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_6 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_1) / var_101_6

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_1 + var_101_6 and arg_98_1.time_ < var_101_1 + var_101_6 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play111092025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 111092025
		arg_102_1.duration_ = 6.57

		local var_102_0 = {
			ja = 6.566,
			ko = 5.233,
			zh = 6.066,
			en = 4.733
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
				arg_102_0:Play111092026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_105_0 = arg_102_1.actors_["1019ui_story"]

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1019ui_story == nil then
				arg_102_1.var_.characterEffect1019ui_story = var_105_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_1 = 0.2

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_1 and not isNil(var_105_0) then
				if arg_102_1.var_.characterEffect1019ui_story and not isNil(var_105_0) then
					arg_102_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= 0 + var_105_1 and arg_102_1.time_ < 0 + var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1019ui_story then
				arg_102_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_105_3 = 0
			local var_105_4 = 0.55

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_3 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_5 = arg_102_1:GetWordFromCfg(111092025)
				local var_105_6 = arg_102_1:FormatText(var_105_5.content)

				arg_102_1.text_.text = var_105_6

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_8 = 22 <= 0 and var_105_4 or var_105_4 * (utf8.len(var_105_6) / 22)

				if (22 <= 0 and var_105_4 or var_105_4 * (utf8.len(var_105_6) / 22)) > 0 and var_105_4 < var_105_8 then
					arg_102_1.talkMaxDuration = var_105_8

					if var_105_8 + var_105_3 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_8 + var_105_3
					end
				end

				arg_102_1.text_.text = var_105_6
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111092", "111092025", "story_v_out_111092.awb") ~= 0 then
					local var_105_9 = manager.audio:GetVoiceLength("story_v_out_111092", "111092025", "story_v_out_111092.awb") / 1000

					if var_105_9 + var_105_3 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_9 + var_105_3
					end

					if var_105_5.prefab_name ~= "" and arg_102_1.actors_[var_105_5.prefab_name] ~= nil then
						local var_105_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_5.prefab_name].transform, "story_v_out_111092", "111092025", "story_v_out_111092.awb")

						arg_102_1:RecordAudio("111092025", var_105_10)
						arg_102_1:RecordAudio("111092025", var_105_10)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_111092", "111092025", "story_v_out_111092.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_111092", "111092025", "story_v_out_111092.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_11 = math.max(var_105_4, arg_102_1.talkMaxDuration)

			if var_105_3 <= arg_102_1.time_ and arg_102_1.time_ < var_105_3 + var_105_11 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_3) / var_105_11

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_3 + var_105_11 and arg_102_1.time_ < var_105_3 + var_105_11 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play111092026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 111092026
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play111092027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(arg_106_1.actors_["1019ui_story"]) and arg_106_1.var_.characterEffect1019ui_story == nil then
				arg_106_1.var_.characterEffect1019ui_story = arg_106_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_0 = 0.2

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 and not isNil(arg_106_1.actors_["1019ui_story"]) then
				if arg_106_1.var_.characterEffect1019ui_story and not isNil(arg_106_1.actors_["1019ui_story"]) then
					arg_106_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_106_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_106_1.time_ - 0) / var_109_0)
				end
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 and not isNil(arg_106_1.actors_["1019ui_story"]) and arg_106_1.var_.characterEffect1019ui_story then
				arg_106_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_106_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_109_1 = 0
			local var_109_2 = 1.325

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 then
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

				arg_106_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_106_1.callingController_:SetSelectedState("normal")

				arg_106_1.keyicon_.color = Color.New(1, 1, 1)
				arg_106_1.icon_.color = Color.New(1, 1, 1)

				local var_109_3 = arg_106_1:FormatText(arg_106_1:GetWordFromCfg(111092026).content)

				arg_106_1.text_.text = var_109_3

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_5 = 53 <= 0 and var_109_2 or var_109_2 * (utf8.len(var_109_3) / 53)

				if (53 <= 0 and var_109_2 or var_109_2 * (utf8.len(var_109_3) / 53)) > 0 and var_109_2 < var_109_5 then
					arg_106_1.talkMaxDuration = var_109_5

					if var_109_5 + var_109_1 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_5 + var_109_1
					end
				end

				arg_106_1.text_.text = var_109_3
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_6 = math.max(var_109_2, arg_106_1.talkMaxDuration)

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_6 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_1) / var_109_6

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_1 + var_109_6 and arg_106_1.time_ < var_109_1 + var_109_6 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play111092027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 111092027
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play111092028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action3_1")
			end

			local var_113_0 = arg_110_1.actors_["1094ui_story"].transform

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.var_.moveOldPos1094ui_story = var_113_0.localPosition
			end

			local var_113_1 = 0.001

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_1 then
				var_113_0.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1094ui_story, Vector3.New(0, 100, 0), (arg_110_1.time_ - 0) / var_113_1)
				var_113_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_0.position).x, (manager.ui.mainCamera.transform.position - var_113_0.position).y, (manager.ui.mainCamera.transform.position - var_113_0.position).z)
				var_113_0.localEulerAngles.z = 0
				var_113_0.localEulerAngles.x = 0
				var_113_0.localEulerAngles = var_113_0.localEulerAngles
			end

			if arg_110_1.time_ >= 0 + var_113_1 and arg_110_1.time_ < 0 + var_113_1 + arg_113_0 then
				var_113_0.localPosition = Vector3.New(0, 100, 0)
				var_113_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_0.position).x, (manager.ui.mainCamera.transform.position - var_113_0.position).y, (manager.ui.mainCamera.transform.position - var_113_0.position).z)
				var_113_0.localEulerAngles.z = 0
				var_113_0.localEulerAngles.x = 0
				var_113_0.localEulerAngles = var_113_0.localEulerAngles
			end

			local var_113_2 = 0
			local var_113_3 = 0.525

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_2 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_4 = arg_110_1:FormatText(arg_110_1:GetWordFromCfg(111092027).content)

				arg_110_1.text_.text = var_113_4

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_6 = 21 <= 0 and var_113_3 or var_113_3 * (utf8.len(var_113_4) / 21)

				if (21 <= 0 and var_113_3 or var_113_3 * (utf8.len(var_113_4) / 21)) > 0 and var_113_3 < var_113_6 then
					arg_110_1.talkMaxDuration = var_113_6

					if var_113_6 + var_113_2 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_6 + var_113_2
					end
				end

				arg_110_1.text_.text = var_113_4
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_7 = math.max(var_113_3, arg_110_1.talkMaxDuration)

			if var_113_2 <= arg_110_1.time_ and arg_110_1.time_ < var_113_2 + var_113_7 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_2) / var_113_7

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_2 + var_113_7 and arg_110_1.time_ < var_113_2 + var_113_7 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play111092028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 111092028
		arg_114_1.duration_ = 8.5

		local var_114_0 = {
			ja = 8.49933333333333,
			ko = 6.43333333333333,
			zh = 7.53333333333333,
			en = 6.26633333333333
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
				arg_114_0:Play111092029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if arg_114_1.bgs_.D05 == nil then
				local var_117_0 = Object.Instantiate(arg_114_1.paintGo_)

				var_117_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "D05")
				var_117_0.name = "D05"
				var_117_0.transform.parent = arg_114_1.stage_.transform
				var_117_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_114_1.bgs_.D05 = var_117_0
			end

			if 2 < arg_114_1.time_ and arg_114_1.time_ <= 2 + arg_117_0 then
				local var_117_1 = arg_114_1.bgs_.D05

				arg_114_1.bgs_.D05.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_117_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_117_2 = var_117_1:GetComponent("SpriteRenderer")

				if var_117_2 and var_117_2.sprite then
					local var_117_3 = 2 * (var_117_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_117_1.transform.localScale = Vector3.New(var_117_3 / var_117_2.sprite.bounds.size.y < var_117_3 * manager.ui.mainCameraCom_.aspect / var_117_2.sprite.bounds.size.x and var_117_3 * manager.ui.mainCameraCom_.aspect / var_117_2.sprite.bounds.size.x or var_117_3 / var_117_2.sprite.bounds.size.y, var_117_3 / var_117_2.sprite.bounds.size.y < var_117_3 * manager.ui.mainCameraCom_.aspect / var_117_2.sprite.bounds.size.x and var_117_3 * manager.ui.mainCameraCom_.aspect / var_117_2.sprite.bounds.size.x or var_117_3 / var_117_2.sprite.bounds.size.y, 0)
				end

				for iter_117_0, iter_117_1 in pairs(arg_114_1.bgs_) do
					if iter_117_0 ~= "D05" then
						iter_117_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_117_4 = 0

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_4 + arg_117_0 then
				arg_114_1.mask_.enabled = true
				arg_114_1.mask_.raycastTarget = true

				arg_114_1:SetGaussion(false)
			end

			local var_117_5 = 2

			if var_117_4 <= arg_114_1.time_ and arg_114_1.time_ < var_117_4 + var_117_5 then
				local var_117_6 = Color.New(0, 0, 0)

				var_117_6.a = Mathf.Lerp(0, 1, (arg_114_1.time_ - var_117_4) / var_117_5)
				arg_114_1.mask_.color = var_117_6
			end

			if arg_114_1.time_ >= var_117_4 + var_117_5 and arg_114_1.time_ < var_117_4 + var_117_5 + arg_117_0 then
				local var_117_7 = Color.New(0, 0, 0)

				var_117_7.a = 1
				arg_114_1.mask_.color = var_117_7
			end

			local var_117_8 = 2

			if 2 < arg_114_1.time_ and arg_114_1.time_ <= var_117_8 + arg_117_0 then
				arg_114_1.mask_.enabled = true
				arg_114_1.mask_.raycastTarget = true

				arg_114_1:SetGaussion(false)
			end

			local var_117_9 = 2

			if var_117_8 <= arg_114_1.time_ and arg_114_1.time_ < var_117_8 + var_117_9 then
				local var_117_10 = Color.New(0, 0, 0)

				var_117_10.a = Mathf.Lerp(1, 0, (arg_114_1.time_ - var_117_8) / var_117_9)
				arg_114_1.mask_.color = var_117_10
			end

			if arg_114_1.time_ >= var_117_8 + var_117_9 and arg_114_1.time_ < var_117_8 + var_117_9 + arg_117_0 then
				local var_117_11 = Color.New(0, 0, 0)

				arg_114_1.mask_.enabled = false
				var_117_11.a = 0
				arg_114_1.mask_.color = var_117_11
			end

			local var_117_12 = arg_114_1.actors_["1019ui_story"].transform

			if 2 < arg_114_1.time_ and arg_114_1.time_ <= 2 + arg_117_0 then
				arg_114_1.var_.moveOldPos1019ui_story = var_117_12.localPosition
			end

			local var_117_13 = 0.001

			if 2 <= arg_114_1.time_ and arg_114_1.time_ < 2 + var_117_13 then
				var_117_12.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_114_1.time_ - 2) / var_117_13)
				var_117_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_12.position).x, (manager.ui.mainCamera.transform.position - var_117_12.position).y, (manager.ui.mainCamera.transform.position - var_117_12.position).z)
				var_117_12.localEulerAngles.z = 0
				var_117_12.localEulerAngles.x = 0
				var_117_12.localEulerAngles = var_117_12.localEulerAngles
			end

			if arg_114_1.time_ >= 2 + var_117_13 and arg_114_1.time_ < 2 + var_117_13 + arg_117_0 then
				var_117_12.localPosition = Vector3.New(0, 100, 0)
				var_117_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_12.position).x, (manager.ui.mainCamera.transform.position - var_117_12.position).y, (manager.ui.mainCamera.transform.position - var_117_12.position).z)
				var_117_12.localEulerAngles.z = 0
				var_117_12.localEulerAngles.x = 0
				var_117_12.localEulerAngles = var_117_12.localEulerAngles
			end

			local var_117_14 = arg_114_1.actors_["1094ui_story"].transform

			if 3.73333333333333 < arg_114_1.time_ and arg_114_1.time_ <= 3.73333333333333 + arg_117_0 then
				arg_114_1.var_.moveOldPos1094ui_story = var_117_14.localPosition
			end

			local var_117_15 = 0.001

			if 3.73333333333333 <= arg_114_1.time_ and arg_114_1.time_ < 3.73333333333333 + var_117_15 then
				var_117_14.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_114_1.time_ - 3.73333333333333) / var_117_15)
				var_117_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_14.position).x, (manager.ui.mainCamera.transform.position - var_117_14.position).y, (manager.ui.mainCamera.transform.position - var_117_14.position).z)
				var_117_14.localEulerAngles.z = 0
				var_117_14.localEulerAngles.x = 0
				var_117_14.localEulerAngles = var_117_14.localEulerAngles
			end

			if arg_114_1.time_ >= 3.73333333333333 + var_117_15 and arg_114_1.time_ < 3.73333333333333 + var_117_15 + arg_117_0 then
				var_117_14.localPosition = Vector3.New(0, -0.84, -6.1)
				var_117_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_14.position).x, (manager.ui.mainCamera.transform.position - var_117_14.position).y, (manager.ui.mainCamera.transform.position - var_117_14.position).z)
				var_117_14.localEulerAngles.z = 0
				var_117_14.localEulerAngles.x = 0
				var_117_14.localEulerAngles = var_117_14.localEulerAngles
			end

			if 3.73333333333333 < arg_114_1.time_ and arg_114_1.time_ <= 3.73333333333333 + arg_117_0 then
				arg_114_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_117_16 = 2

			arg_114_1.isInRecall_ = false

			if var_117_16 < arg_114_1.time_ and arg_114_1.time_ <= var_117_16 + arg_117_0 then
				arg_114_1.screenFilterGo_:SetActive(false)

				for iter_117_2, iter_117_3 in pairs(arg_114_1.actors_) do
					for iter_117_4, iter_117_5 in ipairs((iter_117_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_117_5.color = iter_117_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_117_17 = 0.0166666666666667

			if var_117_16 <= arg_114_1.time_ and arg_114_1.time_ < var_117_16 + var_117_17 then
				arg_114_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_114_1.time_ - var_117_16) / var_117_17)
			end

			if arg_114_1.time_ >= var_117_16 + var_117_17 and arg_114_1.time_ < var_117_16 + var_117_17 + arg_117_0 then
				arg_114_1.screenFilterEffect_.weight = 0
			end

			if arg_114_1.frameCnt_ <= 1 then
				arg_114_1.dialog_:SetActive(false)
			end

			local var_117_18 = 3.73333333333333
			local var_117_19 = 0.2

			if 3.73333333333333 < arg_114_1.time_ and arg_114_1.time_ <= var_117_18 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0

				arg_114_1.dialog_:SetActive(true)

				arg_114_1.dialogCg_.alpha = 0

				local var_117_20 = LeanTween.value(arg_114_1.dialog_, 0, 1, 0.3)

				var_117_20:setOnUpdate(LuaHelper.FloatAction(function(arg_118_0)
					arg_114_1.dialogCg_.alpha = arg_118_0
				end))
				var_117_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_114_1.dialog_)
					var_117_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_114_1.duration_ = arg_114_1.duration_ + 0.3

				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_21 = arg_114_1:GetWordFromCfg(111092028)
				local var_117_22 = arg_114_1:FormatText(var_117_21.content)

				arg_114_1.text_.text = var_117_22

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_24 = 8 <= 0 and var_117_19 or var_117_19 * (utf8.len(var_117_22) / 8)

				if (8 <= 0 and var_117_19 or var_117_19 * (utf8.len(var_117_22) / 8)) > 0 and var_117_19 < var_117_24 then
					arg_114_1.talkMaxDuration = var_117_24
					var_117_18 = var_117_18 + 0.3

					if var_117_24 + var_117_18 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_24 + var_117_18
					end
				end

				arg_114_1.text_.text = var_117_22
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111092", "111092028", "story_v_out_111092.awb") ~= 0 then
					local var_117_25 = manager.audio:GetVoiceLength("story_v_out_111092", "111092028", "story_v_out_111092.awb") / 1000

					if var_117_25 + var_117_18 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_25 + var_117_18
					end

					if var_117_21.prefab_name ~= "" and arg_114_1.actors_[var_117_21.prefab_name] ~= nil then
						local var_117_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_21.prefab_name].transform, "story_v_out_111092", "111092028", "story_v_out_111092.awb")

						arg_114_1:RecordAudio("111092028", var_117_26)
						arg_114_1:RecordAudio("111092028", var_117_26)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_111092", "111092028", "story_v_out_111092.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_111092", "111092028", "story_v_out_111092.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_27 = var_117_18 + 0.3
			local var_117_28 = math.max(var_117_19, arg_114_1.talkMaxDuration)

			if var_117_18 + 0.3 <= arg_114_1.time_ and arg_114_1.time_ < var_117_27 + var_117_28 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_27) / var_117_28

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_27 + var_117_28 and arg_114_1.time_ < var_117_27 + var_117_28 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.73333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_114_1:InitPlayNodeList()
	end,
	Play111092029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 111092029
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play111092030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0.925

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, false)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_1 = arg_120_1:FormatText(arg_120_1:GetWordFromCfg(111092029).content)

				arg_120_1.text_.text = var_123_1

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_3 = 37 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_1) / 37)

				if (37 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_1) / 37)) > 0 and var_123_0 < var_123_3 then
					arg_120_1.talkMaxDuration = var_123_3

					if var_123_3 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_3 + 0
					end
				end

				arg_120_1.text_.text = var_123_1
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_4 = math.max(var_123_0, arg_120_1.talkMaxDuration)

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_4 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - 0) / var_123_4

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= 0 + var_123_4 and arg_120_1.time_ < 0 + var_123_4 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play111092030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 111092030
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play111092031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_127_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_124_1.bgmTxt_.text ~= var_127_2 and arg_124_1.bgmTxt_.text ~= "" then
						if arg_124_1.bgmTxt2_.text ~= "" then
							arg_124_1.bgmTxt_.text = arg_124_1.bgmTxt2_.text
						end

						arg_124_1.bgmTxt2_.text = var_127_2

						arg_124_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_124_1.bgmTxt_.text = var_127_2
						arg_124_1.bgmTxt2_.text = var_127_2
					end

					if arg_124_1.bgmTimer then
						arg_124_1.bgmTimer:Stop()

						arg_124_1.bgmTimer = nil
					end

					if arg_124_1.settingData.show_music_name == 1 then
						arg_124_1.musicController:SetSelectedState("show")
						arg_124_1.musicAnimator_:Play("open", 0, 0)

						if arg_124_1.settingData.music_time ~= 0 then
							arg_124_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_124_1.settingData.music_time), function()
								if arg_124_1 == nil or isNil(arg_124_1.bgmTxt_) then
									return
								end

								arg_124_1.musicController:SetSelectedState("hide")
								arg_124_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:AudioAction("play", "effect", "se_story", "se_story_communication", "")
			end

			local var_127_4 = 0
			local var_127_5 = 0.925

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_4 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_6 = arg_124_1:FormatText(arg_124_1:GetWordFromCfg(111092030).content)

				arg_124_1.text_.text = var_127_6

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_8 = 37 <= 0 and var_127_5 or var_127_5 * (utf8.len(var_127_6) / 37)

				if (37 <= 0 and var_127_5 or var_127_5 * (utf8.len(var_127_6) / 37)) > 0 and var_127_5 < var_127_8 then
					arg_124_1.talkMaxDuration = var_127_8

					if var_127_8 + var_127_4 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_8 + var_127_4
					end
				end

				arg_124_1.text_.text = var_127_6
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_9 = math.max(var_127_5, arg_124_1.talkMaxDuration)

			if var_127_4 <= arg_124_1.time_ and arg_124_1.time_ < var_127_4 + var_127_9 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_4) / var_127_9

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_4 + var_127_9 and arg_124_1.time_ < var_127_4 + var_127_9 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play111092031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 111092031
		arg_129_1.duration_ = 5.8

		local var_129_0 = {
			ja = 5.8,
			ko = 4.666,
			zh = 3.9,
			en = 4
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play111092032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_132_0 = 0.333333333333333

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 then
				local var_132_1, var_132_2 = math.modf((arg_129_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_132_2 * 0.13, var_132_2 * 0.13, var_132_2 * 0.13) + arg_129_1.var_.shakeOldPos
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 then
				manager.ui.mainCamera.transform.localPosition = arg_129_1.var_.shakeOldPos
			end

			local var_132_3 = 0

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_3 + arg_132_0 then
				arg_129_1.allBtn_.enabled = false
			end

			if arg_129_1.time_ >= var_132_3 + 0.333333333333333 and arg_129_1.time_ < var_132_3 + 0.333333333333333 + arg_132_0 then
				arg_129_1.allBtn_.enabled = true
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:AudioAction("play", "music", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_132_6 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if "" ~= "" then
					if arg_129_1.bgmTxt_.text ~= var_132_6 and arg_129_1.bgmTxt_.text ~= "" then
						if arg_129_1.bgmTxt2_.text ~= "" then
							arg_129_1.bgmTxt_.text = arg_129_1.bgmTxt2_.text
						end

						arg_129_1.bgmTxt2_.text = var_132_6

						arg_129_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_129_1.bgmTxt_.text = var_132_6
						arg_129_1.bgmTxt2_.text = var_132_6
					end

					if arg_129_1.bgmTimer then
						arg_129_1.bgmTimer:Stop()

						arg_129_1.bgmTimer = nil
					end

					if arg_129_1.settingData.show_music_name == 1 then
						arg_129_1.musicController:SetSelectedState("show")
						arg_129_1.musicAnimator_:Play("open", 0, 0)

						if arg_129_1.settingData.music_time ~= 0 then
							arg_129_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_129_1.settingData.music_time), function()
								if arg_129_1 == nil or isNil(arg_129_1.bgmTxt_) then
									return
								end

								arg_129_1.musicController:SetSelectedState("hide")
								arg_129_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_132_7 = 0
			local var_132_8 = 0.525

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_7 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_9 = arg_129_1:GetWordFromCfg(111092031)
				local var_132_10 = arg_129_1:FormatText(var_132_9.content)

				arg_129_1.text_.text = var_132_10

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_12 = 20 <= 0 and var_132_8 or var_132_8 * (utf8.len(var_132_10) / 20)

				if (20 <= 0 and var_132_8 or var_132_8 * (utf8.len(var_132_10) / 20)) > 0 and var_132_8 < var_132_12 then
					arg_129_1.talkMaxDuration = var_132_12

					if var_132_12 + var_132_7 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_12 + var_132_7
					end
				end

				arg_129_1.text_.text = var_132_10
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111092", "111092031", "story_v_out_111092.awb") ~= 0 then
					local var_132_13 = manager.audio:GetVoiceLength("story_v_out_111092", "111092031", "story_v_out_111092.awb") / 1000

					if var_132_13 + var_132_7 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_13 + var_132_7
					end

					if var_132_9.prefab_name ~= "" and arg_129_1.actors_[var_132_9.prefab_name] ~= nil then
						local var_132_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_9.prefab_name].transform, "story_v_out_111092", "111092031", "story_v_out_111092.awb")

						arg_129_1:RecordAudio("111092031", var_132_14)
						arg_129_1:RecordAudio("111092031", var_132_14)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_111092", "111092031", "story_v_out_111092.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_111092", "111092031", "story_v_out_111092.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_15 = math.max(var_132_8, arg_129_1.talkMaxDuration)

			if var_132_7 <= arg_129_1.time_ and arg_129_1.time_ < var_132_7 + var_132_15 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_7) / var_132_15

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_7 + var_132_15 and arg_129_1.time_ < var_132_7 + var_132_15 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play111092032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 111092032
		arg_134_1.duration_ = 3.7

		local var_134_0 = {
			ja = 3.7,
			ko = 3.3,
			zh = 3,
			en = 2.833
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
				arg_134_0:Play111092033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 0.325

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, true)
				arg_134_1.iconController_:SetSelectedState("hero")

				arg_134_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_134_1.callingController_:SetSelectedState("normal")

				arg_134_1.keyicon_.color = Color.New(1, 1, 1)
				arg_134_1.icon_.color = Color.New(1, 1, 1)

				local var_137_1 = arg_134_1:GetWordFromCfg(111092032)
				local var_137_2 = arg_134_1:FormatText(var_137_1.content)

				arg_134_1.text_.text = var_137_2

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_4 = 13 <= 0 and var_137_0 or var_137_0 * (utf8.len(var_137_2) / 13)

				if (13 <= 0 and var_137_0 or var_137_0 * (utf8.len(var_137_2) / 13)) > 0 and var_137_0 < var_137_4 then
					arg_134_1.talkMaxDuration = var_137_4

					if var_137_4 + 0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_4 + 0
					end
				end

				arg_134_1.text_.text = var_137_2
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111092", "111092032", "story_v_out_111092.awb") ~= 0 then
					local var_137_5 = manager.audio:GetVoiceLength("story_v_out_111092", "111092032", "story_v_out_111092.awb") / 1000

					if var_137_5 + 0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_5 + 0
					end

					if var_137_1.prefab_name ~= "" and arg_134_1.actors_[var_137_1.prefab_name] ~= nil then
						local var_137_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_1.prefab_name].transform, "story_v_out_111092", "111092032", "story_v_out_111092.awb")

						arg_134_1:RecordAudio("111092032", var_137_6)
						arg_134_1:RecordAudio("111092032", var_137_6)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_111092", "111092032", "story_v_out_111092.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_111092", "111092032", "story_v_out_111092.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_7 = math.max(var_137_0, arg_134_1.talkMaxDuration)

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_7 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - 0) / var_137_7

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= 0 + var_137_7 and arg_134_1.time_ < 0 + var_137_7 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play111092033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 111092033
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
			arg_138_1.auto_ = false
		end

		function arg_138_1.playNext_(arg_140_0)
			arg_138_1.onStoryFinished_()
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos1094ui_story = arg_138_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_141_0 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 then
				arg_138_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1094ui_story, Vector3.New(0, 100, 0), (arg_138_1.time_ - 0) / var_141_0)
				arg_138_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_138_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["1094ui_story"].transform.position).z)
				arg_138_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_138_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_138_1.actors_["1094ui_story"].transform.localEulerAngles = arg_138_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 then
				arg_138_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_138_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_138_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["1094ui_story"].transform.position).z)
				arg_138_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_138_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_138_1.actors_["1094ui_story"].transform.localEulerAngles = arg_138_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_141_1 = manager.ui.mainCamera.transform

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.shakeOldPos = var_141_1.localPosition
			end

			local var_141_2 = 1

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_2 then
				local var_141_3, var_141_4 = math.modf((arg_138_1.time_ - 0) / 0.066)

				var_141_1.localPosition = Vector3.New(var_141_4 * 0.13, var_141_4 * 0.13, var_141_4 * 0.13) + arg_138_1.var_.shakeOldPos
			end

			if arg_138_1.time_ >= 0 + var_141_2 and arg_138_1.time_ < 0 + var_141_2 + arg_141_0 then
				var_141_1.localPosition = arg_138_1.var_.shakeOldPos
			end

			local var_141_5 = 0

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_5 + arg_141_0 then
				arg_138_1.allBtn_.enabled = false
			end

			if arg_138_1.time_ >= var_141_5 + 1 and arg_138_1.time_ < var_141_5 + 1 + arg_141_0 then
				arg_138_1.allBtn_.enabled = true
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:AudioAction("play", "effect", "se_story", "se_story_explosion", "")
			end

			local var_141_7 = 0
			local var_141_8 = 0.975

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_7 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, false)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_9 = arg_138_1:FormatText(arg_138_1:GetWordFromCfg(111092033).content)

				arg_138_1.text_.text = var_141_9

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_11 = 39 <= 0 and var_141_8 or var_141_8 * (utf8.len(var_141_9) / 39)

				if (39 <= 0 and var_141_8 or var_141_8 * (utf8.len(var_141_9) / 39)) > 0 and var_141_8 < var_141_11 then
					arg_138_1.talkMaxDuration = var_141_11

					if var_141_11 + var_141_7 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_11 + var_141_7
					end
				end

				arg_138_1.text_.text = var_141_9
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_12 = math.max(var_141_8, arg_138_1.talkMaxDuration)

			if var_141_7 <= arg_138_1.time_ and arg_138_1.time_ < var_141_7 + var_141_12 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_7) / var_141_12

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_7 + var_141_12 and arg_138_1.time_ < var_141_7 + var_141_12 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/D06a",
		"TextureConfig/Background/ST10",
		"TextureConfig/Background/D05"
	},
	voices = {
		"story_v_out_111092.awb"
	}
}
