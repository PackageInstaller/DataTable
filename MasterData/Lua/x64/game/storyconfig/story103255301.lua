return {
	Play325531001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 325531001
		arg_1_1.duration_ = 6.57

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play325531002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.J25f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J25f")
				var_4_0.name = "J25f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.J25f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.J25f

				arg_1_1.bgs_.J25f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "J25f" then
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

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_121_00", "se_story_121_00_dooropen_loop", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_5_1_story_boss", "bgm_activity_5_1_story_boss", "bgm_activity_5_1_story_boss.awb")

				local var_4_12 = manager.audio:GetAudioName("bgm_activity_5_1_story_boss", "bgm_activity_5_1_story_boss")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_12 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_12

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_12
						arg_1_1.bgmTxt2_.text = var_4_12
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

			local var_4_13 = 1.56666666666667
			local var_4_14 = 1.15

			if 1.56666666666667 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_15 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_15:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_16 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(325531001).content)

				arg_1_1.text_.text = var_4_16

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_18 = 46 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_16) / 46)

				if (46 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_16) / 46)) > 0 and var_4_14 < var_4_18 then
					arg_1_1.talkMaxDuration = var_4_18
					var_4_13 = var_4_13 + 0.3

					if var_4_18 + var_4_13 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_18 + var_4_13
					end
				end

				arg_1_1.text_.text = var_4_16
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_19 = var_4_13 + 0.3
			local var_4_20 = math.max(var_4_14, arg_1_1.talkMaxDuration)

			if var_4_13 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_19 + var_4_20 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_19) / var_4_20

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_19 + var_4_20 and arg_1_1.time_ < var_4_19 + var_4_20 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play325531002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 325531002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play325531003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 1.175

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

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(325531002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 47 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 47)

				if (47 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 47)) > 0 and var_11_0 < var_11_3 then
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
	Play325531003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 325531003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play325531004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.225

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(325531003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 9 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 9)

				if (9 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 9)) > 0 and var_15_0 < var_15_3 then
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
	Play325531004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 325531004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play325531005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 1.025

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_1 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(325531004).content)

				arg_16_1.text_.text = var_19_1

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_3 = 41 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 41)

				if (41 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 41)) > 0 and var_19_0 < var_19_3 then
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
	Play325531005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 325531005
		arg_20_1.duration_ = 3.6

		local var_20_0 = {
			zh = 3.1,
			ja = 3.6
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play325531006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if arg_20_1.actors_["10180ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10180ui_story"))) then
				local var_23_0 = Object.Instantiate(Asset.Load("Char/" .. "10180ui_story"), arg_20_1.stage_.transform)

				var_23_0.name = "10180ui_story"
				var_23_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.actors_["10180ui_story"] = var_23_0

				local var_23_1 = var_23_0:GetComponentInChildren(typeof(CharacterEffect))

				var_23_1.enabled = true

				local var_23_2 = GameObjectTools.GetOrAddComponent(var_23_0, typeof(DynamicBoneHelper))

				if var_23_2 then
					var_23_2:EnableDynamicBone(false)
				end

				arg_20_1:ShowWeapon(var_23_1.transform, false)

				arg_20_1.var_["10180ui_story" .. "Animator"] = var_23_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_20_1.var_["10180ui_story" .. "Animator"].applyRootMotion = true
				arg_20_1.var_["10180ui_story" .. "LipSync"] = var_23_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_23_3 = arg_20_1.actors_["10180ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos10180ui_story = var_23_3.localPosition

				local var_23_4 = GameObjectTools.GetOrAddComponent(var_23_3.gameObject, typeof(DynamicBoneHelper))

				if var_23_4 then
					var_23_4:EnableDynamicBone(false)
				end
			end

			local var_23_5 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_5 then
				var_23_3.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos10180ui_story, Vector3.New(-0.03, -1.09, -6.14), (arg_20_1.time_ - 0) / var_23_5)
				var_23_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_3.position).x, (manager.ui.mainCamera.transform.position - var_23_3.position).y, (manager.ui.mainCamera.transform.position - var_23_3.position).z)
				var_23_3.localEulerAngles.z = 0
				var_23_3.localEulerAngles.x = 0
				var_23_3.localEulerAngles = var_23_3.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_5 and arg_20_1.time_ < 0 + var_23_5 + arg_23_0 then
				var_23_3.localPosition = Vector3.New(-0.03, -1.09, -6.14)
				var_23_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_3.position).x, (manager.ui.mainCamera.transform.position - var_23_3.position).y, (manager.ui.mainCamera.transform.position - var_23_3.position).z)
				var_23_3.localEulerAngles.z = 0
				var_23_3.localEulerAngles.x = 0
				var_23_3.localEulerAngles = var_23_3.localEulerAngles

				local var_23_6 = GameObjectTools.GetOrAddComponent(var_23_3.gameObject, typeof(DynamicBoneHelper))

				if var_23_6 then
					var_23_6:EnableDynamicBone(true)
				end
			end

			local var_23_7 = arg_20_1.actors_["10180ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_7) and arg_20_1.var_.characterEffect10180ui_story == nil then
				arg_20_1.var_.characterEffect10180ui_story = var_23_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_8 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_8 and not isNil(var_23_7) then
				if arg_20_1.var_.characterEffect10180ui_story and not isNil(var_23_7) then
					arg_20_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_8 and arg_20_1.time_ < 0 + var_23_8 + arg_23_0 and not isNil(var_23_7) and arg_20_1.var_.characterEffect10180ui_story then
				arg_20_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action1_1")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_23_10 = 0
			local var_23_11 = 0.2

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_10 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_12 = arg_20_1:GetWordFromCfg(325531005)
				local var_23_13 = arg_20_1:FormatText(var_23_12.content)

				arg_20_1.text_.text = var_23_13

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_15 = 8 <= 0 and var_23_11 or var_23_11 * (utf8.len(var_23_13) / 8)

				if (8 <= 0 and var_23_11 or var_23_11 * (utf8.len(var_23_13) / 8)) > 0 and var_23_11 < var_23_15 then
					arg_20_1.talkMaxDuration = var_23_15

					if var_23_15 + var_23_10 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_15 + var_23_10
					end
				end

				arg_20_1.text_.text = var_23_13
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325531", "325531005", "story_v_out_325531.awb") ~= 0 then
					local var_23_16 = manager.audio:GetVoiceLength("story_v_out_325531", "325531005", "story_v_out_325531.awb") / 1000

					if var_23_16 + var_23_10 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_16 + var_23_10
					end

					if var_23_12.prefab_name ~= "" and arg_20_1.actors_[var_23_12.prefab_name] ~= nil then
						local var_23_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_12.prefab_name].transform, "story_v_out_325531", "325531005", "story_v_out_325531.awb")

						arg_20_1:RecordAudio("325531005", var_23_17)
						arg_20_1:RecordAudio("325531005", var_23_17)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_325531", "325531005", "story_v_out_325531.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_325531", "325531005", "story_v_out_325531.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_18 = math.max(var_23_11, arg_20_1.talkMaxDuration)

			if var_23_10 <= arg_20_1.time_ and arg_20_1.time_ < var_23_10 + var_23_18 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_10) / var_23_18

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_10 + var_23_18 and arg_20_1.time_ < var_23_10 + var_23_18 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play325531006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 325531006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play325531007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["10180ui_story"]) and arg_24_1.var_.characterEffect10180ui_story == nil then
				arg_24_1.var_.characterEffect10180ui_story = arg_24_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["10180ui_story"]) then
				if arg_24_1.var_.characterEffect10180ui_story and not isNil(arg_24_1.actors_["10180ui_story"]) then
					arg_24_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_24_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_0)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["10180ui_story"]) and arg_24_1.var_.characterEffect10180ui_story then
				arg_24_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_24_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_27_1 = 0
			local var_27_2 = 0.275

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_3 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(325531006).content)

				arg_24_1.text_.text = var_27_3

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 11 <= 0 and var_27_2 or var_27_2 * (utf8.len(var_27_3) / 11)

				if (11 <= 0 and var_27_2 or var_27_2 * (utf8.len(var_27_3) / 11)) > 0 and var_27_2 < var_27_5 then
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
	Play325531007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 325531007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play325531008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0.875

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_1 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(325531007).content)

				arg_28_1.text_.text = var_31_1

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_3 = 35 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_1) / 35)

				if (35 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_1) / 35)) > 0 and var_31_0 < var_31_3 then
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
	Play325531008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 325531008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play325531009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0.475

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_1 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(325531008).content)

				arg_32_1.text_.text = var_35_1

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_3 = 19 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_1) / 19)

				if (19 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_1) / 19)) > 0 and var_35_0 < var_35_3 then
					arg_32_1.talkMaxDuration = var_35_3

					if var_35_3 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_3 + 0
					end
				end

				arg_32_1.text_.text = var_35_1
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_4 = math.max(var_35_0, arg_32_1.talkMaxDuration)

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_4 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - 0) / var_35_4

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= 0 + var_35_4 and arg_32_1.time_ < 0 + var_35_4 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play325531009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 325531009
		arg_36_1.duration_ = 6.9

		local var_36_0 = {
			zh = 3.833,
			ja = 6.9
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
				arg_36_0:Play325531010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["10180ui_story"]) and arg_36_1.var_.characterEffect10180ui_story == nil then
				arg_36_1.var_.characterEffect10180ui_story = arg_36_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["10180ui_story"]) then
				if arg_36_1.var_.characterEffect10180ui_story and not isNil(arg_36_1.actors_["10180ui_story"]) then
					arg_36_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["10180ui_story"]) and arg_36_1.var_.characterEffect10180ui_story then
				arg_36_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action4_1")
			end

			local var_39_2 = 0
			local var_39_3 = 0.375

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_2 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_4 = arg_36_1:GetWordFromCfg(325531009)
				local var_39_5 = arg_36_1:FormatText(var_39_4.content)

				arg_36_1.text_.text = var_39_5

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_7 = 15 <= 0 and var_39_3 or var_39_3 * (utf8.len(var_39_5) / 15)

				if (15 <= 0 and var_39_3 or var_39_3 * (utf8.len(var_39_5) / 15)) > 0 and var_39_3 < var_39_7 then
					arg_36_1.talkMaxDuration = var_39_7

					if var_39_7 + var_39_2 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_7 + var_39_2
					end
				end

				arg_36_1.text_.text = var_39_5
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325531", "325531009", "story_v_out_325531.awb") ~= 0 then
					local var_39_8 = manager.audio:GetVoiceLength("story_v_out_325531", "325531009", "story_v_out_325531.awb") / 1000

					if var_39_8 + var_39_2 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_8 + var_39_2
					end

					if var_39_4.prefab_name ~= "" and arg_36_1.actors_[var_39_4.prefab_name] ~= nil then
						local var_39_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_4.prefab_name].transform, "story_v_out_325531", "325531009", "story_v_out_325531.awb")

						arg_36_1:RecordAudio("325531009", var_39_9)
						arg_36_1:RecordAudio("325531009", var_39_9)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_325531", "325531009", "story_v_out_325531.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_325531", "325531009", "story_v_out_325531.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_10 = math.max(var_39_3, arg_36_1.talkMaxDuration)

			if var_39_2 <= arg_36_1.time_ and arg_36_1.time_ < var_39_2 + var_39_10 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_2) / var_39_10

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_2 + var_39_10 and arg_36_1.time_ < var_39_2 + var_39_10 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play325531010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 325531010
		arg_40_1.duration_ = 8.23

		local var_40_0 = {
			zh = 8.233,
			ja = 8.1
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play325531011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0.575

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_1 = arg_40_1:GetWordFromCfg(325531010)
				local var_43_2 = arg_40_1:FormatText(var_43_1.content)

				arg_40_1.text_.text = var_43_2

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_4 = 23 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 23)

				if (23 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 23)) > 0 and var_43_0 < var_43_4 then
					arg_40_1.talkMaxDuration = var_43_4

					if var_43_4 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_4 + 0
					end
				end

				arg_40_1.text_.text = var_43_2
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325531", "325531010", "story_v_out_325531.awb") ~= 0 then
					local var_43_5 = manager.audio:GetVoiceLength("story_v_out_325531", "325531010", "story_v_out_325531.awb") / 1000

					if var_43_5 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + 0
					end

					if var_43_1.prefab_name ~= "" and arg_40_1.actors_[var_43_1.prefab_name] ~= nil then
						local var_43_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_1.prefab_name].transform, "story_v_out_325531", "325531010", "story_v_out_325531.awb")

						arg_40_1:RecordAudio("325531010", var_43_6)
						arg_40_1:RecordAudio("325531010", var_43_6)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_325531", "325531010", "story_v_out_325531.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_325531", "325531010", "story_v_out_325531.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_7 = math.max(var_43_0, arg_40_1.talkMaxDuration)

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_7 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - 0) / var_43_7

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= 0 + var_43_7 and arg_40_1.time_ < 0 + var_43_7 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play325531011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 325531011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play325531012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["10180ui_story"]) and arg_44_1.var_.characterEffect10180ui_story == nil then
				arg_44_1.var_.characterEffect10180ui_story = arg_44_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["10180ui_story"]) then
				if arg_44_1.var_.characterEffect10180ui_story and not isNil(arg_44_1.actors_["10180ui_story"]) then
					arg_44_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_44_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_0)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["10180ui_story"]) and arg_44_1.var_.characterEffect10180ui_story then
				arg_44_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_44_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_47_1 = 0
			local var_47_2 = 0.55

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_3 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(325531011).content)

				arg_44_1.text_.text = var_47_3

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 22 <= 0 and var_47_2 or var_47_2 * (utf8.len(var_47_3) / 22)

				if (22 <= 0 and var_47_2 or var_47_2 * (utf8.len(var_47_3) / 22)) > 0 and var_47_2 < var_47_5 then
					arg_44_1.talkMaxDuration = var_47_5

					if var_47_5 + var_47_1 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_5 + var_47_1
					end
				end

				arg_44_1.text_.text = var_47_3
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_6 = math.max(var_47_2, arg_44_1.talkMaxDuration)

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_6 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_1) / var_47_6

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_1 + var_47_6 and arg_44_1.time_ < var_47_1 + var_47_6 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play325531012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 325531012
		arg_48_1.duration_ = 6.93

		local var_48_0 = {
			zh = 5.4,
			ja = 6.933
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play325531013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["10180ui_story"]) and arg_48_1.var_.characterEffect10180ui_story == nil then
				arg_48_1.var_.characterEffect10180ui_story = arg_48_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["10180ui_story"]) then
				if arg_48_1.var_.characterEffect10180ui_story and not isNil(arg_48_1.actors_["10180ui_story"]) then
					arg_48_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["10180ui_story"]) and arg_48_1.var_.characterEffect10180ui_story then
				arg_48_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_51_2 = 0
			local var_51_3 = 0.475

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_2 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_4 = arg_48_1:GetWordFromCfg(325531012)
				local var_51_5 = arg_48_1:FormatText(var_51_4.content)

				arg_48_1.text_.text = var_51_5

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_7 = 19 <= 0 and var_51_3 or var_51_3 * (utf8.len(var_51_5) / 19)

				if (19 <= 0 and var_51_3 or var_51_3 * (utf8.len(var_51_5) / 19)) > 0 and var_51_3 < var_51_7 then
					arg_48_1.talkMaxDuration = var_51_7

					if var_51_7 + var_51_2 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_7 + var_51_2
					end
				end

				arg_48_1.text_.text = var_51_5
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325531", "325531012", "story_v_out_325531.awb") ~= 0 then
					local var_51_8 = manager.audio:GetVoiceLength("story_v_out_325531", "325531012", "story_v_out_325531.awb") / 1000

					if var_51_8 + var_51_2 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_8 + var_51_2
					end

					if var_51_4.prefab_name ~= "" and arg_48_1.actors_[var_51_4.prefab_name] ~= nil then
						local var_51_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_4.prefab_name].transform, "story_v_out_325531", "325531012", "story_v_out_325531.awb")

						arg_48_1:RecordAudio("325531012", var_51_9)
						arg_48_1:RecordAudio("325531012", var_51_9)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_325531", "325531012", "story_v_out_325531.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_325531", "325531012", "story_v_out_325531.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_10 = math.max(var_51_3, arg_48_1.talkMaxDuration)

			if var_51_2 <= arg_48_1.time_ and arg_48_1.time_ < var_51_2 + var_51_10 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_2) / var_51_10

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_2 + var_51_10 and arg_48_1.time_ < var_51_2 + var_51_10 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play325531013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 325531013
		arg_52_1.duration_ = 18.63

		local var_52_0 = {
			zh = 9.3,
			ja = 18.633
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
				arg_52_0:Play325531014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action4_2")
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_55_0 = 0
			local var_55_1 = 0.675

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_2 = arg_52_1:GetWordFromCfg(325531013)
				local var_55_3 = arg_52_1:FormatText(var_55_2.content)

				arg_52_1.text_.text = var_55_3

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 27 <= 0 and var_55_1 or var_55_1 * (utf8.len(var_55_3) / 27)

				if (27 <= 0 and var_55_1 or var_55_1 * (utf8.len(var_55_3) / 27)) > 0 and var_55_1 < var_55_5 then
					arg_52_1.talkMaxDuration = var_55_5

					if var_55_5 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_5 + var_55_0
					end
				end

				arg_52_1.text_.text = var_55_3
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325531", "325531013", "story_v_out_325531.awb") ~= 0 then
					local var_55_6 = manager.audio:GetVoiceLength("story_v_out_325531", "325531013", "story_v_out_325531.awb") / 1000

					if var_55_6 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_6 + var_55_0
					end

					if var_55_2.prefab_name ~= "" and arg_52_1.actors_[var_55_2.prefab_name] ~= nil then
						local var_55_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_2.prefab_name].transform, "story_v_out_325531", "325531013", "story_v_out_325531.awb")

						arg_52_1:RecordAudio("325531013", var_55_7)
						arg_52_1:RecordAudio("325531013", var_55_7)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_325531", "325531013", "story_v_out_325531.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_325531", "325531013", "story_v_out_325531.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_8 = math.max(var_55_1, arg_52_1.talkMaxDuration)

			if var_55_0 <= arg_52_1.time_ and arg_52_1.time_ < var_55_0 + var_55_8 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_0) / var_55_8

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_0 + var_55_8 and arg_52_1.time_ < var_55_0 + var_55_8 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play325531014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 325531014
		arg_56_1.duration_ = 1

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"

			SetActive(arg_56_1.choicesGo_, true)

			for iter_57_0, iter_57_1 in ipairs(arg_56_1.choices_) do
				SetActive(iter_57_1.go, iter_57_0 <= 3)
			end

			arg_56_1.choices_[1].txt.text = arg_56_1:FormatText(StoryChoiceCfg[1668].name)
			arg_56_1.choices_[2].txt.text = arg_56_1:FormatText(StoryChoiceCfg[1669].name)
			arg_56_1.choices_[3].txt.text = arg_56_1:FormatText(StoryChoiceCfg[1670].name)
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play325531015(arg_56_1)
			end

			if arg_58_0 == 2 then
				arg_56_0:Play325531015(arg_56_1)
			end

			if arg_58_0 == 3 then
				arg_56_0:Play325531015(arg_56_1)
			end

			arg_56_1:RecordChoiceLog(325531014, 1668, 1669, 1670)
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["10180ui_story"]) and arg_56_1.var_.characterEffect10180ui_story == nil then
				arg_56_1.var_.characterEffect10180ui_story = arg_56_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_0 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["10180ui_story"]) then
				if arg_56_1.var_.characterEffect10180ui_story and not isNil(arg_56_1.actors_["10180ui_story"]) then
					arg_56_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_56_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 0) / var_59_0)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["10180ui_story"]) and arg_56_1.var_.characterEffect10180ui_story then
				arg_56_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_56_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play325531015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 325531015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play325531016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0.325

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
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

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_1 = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(325531015).content)

				arg_60_1.text_.text = var_63_1

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_3 = 13 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_1) / 13)

				if (13 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_1) / 13)) > 0 and var_63_0 < var_63_3 then
					arg_60_1.talkMaxDuration = var_63_3

					if var_63_3 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_3 + 0
					end
				end

				arg_60_1.text_.text = var_63_1
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_4 = math.max(var_63_0, arg_60_1.talkMaxDuration)

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_4 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - 0) / var_63_4

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= 0 + var_63_4 and arg_60_1.time_ < 0 + var_63_4 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play325531016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 325531016
		arg_64_1.duration_ = 3.7

		local var_64_0 = {
			zh = 1,
			ja = 3.7
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play325531017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["10180ui_story"]) and arg_64_1.var_.characterEffect10180ui_story == nil then
				arg_64_1.var_.characterEffect10180ui_story = arg_64_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_0 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["10180ui_story"]) then
				if arg_64_1.var_.characterEffect10180ui_story and not isNil(arg_64_1.actors_["10180ui_story"]) then
					arg_64_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["10180ui_story"]) and arg_64_1.var_.characterEffect10180ui_story then
				arg_64_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_67_2 = 0
			local var_67_3 = 0.125

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_2 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_4 = arg_64_1:GetWordFromCfg(325531016)
				local var_67_5 = arg_64_1:FormatText(var_67_4.content)

				arg_64_1.text_.text = var_67_5

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_7 = 5 <= 0 and var_67_3 or var_67_3 * (utf8.len(var_67_5) / 5)

				if (5 <= 0 and var_67_3 or var_67_3 * (utf8.len(var_67_5) / 5)) > 0 and var_67_3 < var_67_7 then
					arg_64_1.talkMaxDuration = var_67_7

					if var_67_7 + var_67_2 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_7 + var_67_2
					end
				end

				arg_64_1.text_.text = var_67_5
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325531", "325531016", "story_v_out_325531.awb") ~= 0 then
					local var_67_8 = manager.audio:GetVoiceLength("story_v_out_325531", "325531016", "story_v_out_325531.awb") / 1000

					if var_67_8 + var_67_2 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_8 + var_67_2
					end

					if var_67_4.prefab_name ~= "" and arg_64_1.actors_[var_67_4.prefab_name] ~= nil then
						local var_67_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_4.prefab_name].transform, "story_v_out_325531", "325531016", "story_v_out_325531.awb")

						arg_64_1:RecordAudio("325531016", var_67_9)
						arg_64_1:RecordAudio("325531016", var_67_9)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_325531", "325531016", "story_v_out_325531.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_325531", "325531016", "story_v_out_325531.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_10 = math.max(var_67_3, arg_64_1.talkMaxDuration)

			if var_67_2 <= arg_64_1.time_ and arg_64_1.time_ < var_67_2 + var_67_10 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_2) / var_67_10

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_2 + var_67_10 and arg_64_1.time_ < var_67_2 + var_67_10 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play325531017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 325531017
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play325531018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["10180ui_story"]) and arg_68_1.var_.characterEffect10180ui_story == nil then
				arg_68_1.var_.characterEffect10180ui_story = arg_68_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_0 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["10180ui_story"]) then
				if arg_68_1.var_.characterEffect10180ui_story and not isNil(arg_68_1.actors_["10180ui_story"]) then
					arg_68_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_68_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_68_1.time_ - 0) / var_71_0)
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["10180ui_story"]) and arg_68_1.var_.characterEffect10180ui_story then
				arg_68_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_68_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_71_1 = 0
			local var_71_2 = 0.75

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_3 = arg_68_1:FormatText(arg_68_1:GetWordFromCfg(325531017).content)

				arg_68_1.text_.text = var_71_3

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_5 = 30 <= 0 and var_71_2 or var_71_2 * (utf8.len(var_71_3) / 30)

				if (30 <= 0 and var_71_2 or var_71_2 * (utf8.len(var_71_3) / 30)) > 0 and var_71_2 < var_71_5 then
					arg_68_1.talkMaxDuration = var_71_5

					if var_71_5 + var_71_1 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_5 + var_71_1
					end
				end

				arg_68_1.text_.text = var_71_3
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_6 = math.max(var_71_2, arg_68_1.talkMaxDuration)

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_6 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_1) / var_71_6

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_1 + var_71_6 and arg_68_1.time_ < var_71_1 + var_71_6 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play325531018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 325531018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play325531019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0.475

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
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

				local var_75_1 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(325531018).content)

				arg_72_1.text_.text = var_75_1

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_3 = 19 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_1) / 19)

				if (19 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_1) / 19)) > 0 and var_75_0 < var_75_3 then
					arg_72_1.talkMaxDuration = var_75_3

					if var_75_3 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_3 + 0
					end
				end

				arg_72_1.text_.text = var_75_1
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_4 = math.max(var_75_0, arg_72_1.talkMaxDuration)

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_4 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - 0) / var_75_4

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= 0 + var_75_4 and arg_72_1.time_ < 0 + var_75_4 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play325531019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 325531019
		arg_76_1.duration_ = 6.4

		local var_76_0 = {
			zh = 3.066,
			ja = 6.4
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
				arg_76_0:Play325531020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(arg_76_1.actors_["10180ui_story"]) and arg_76_1.var_.characterEffect10180ui_story == nil then
				arg_76_1.var_.characterEffect10180ui_story = arg_76_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_0 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 and not isNil(arg_76_1.actors_["10180ui_story"]) then
				if arg_76_1.var_.characterEffect10180ui_story and not isNil(arg_76_1.actors_["10180ui_story"]) then
					arg_76_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["10180ui_story"]) and arg_76_1.var_.characterEffect10180ui_story then
				arg_76_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action22_1")
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_79_2 = 0
			local var_79_3 = 0.175

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_2 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_4 = arg_76_1:GetWordFromCfg(325531019)
				local var_79_5 = arg_76_1:FormatText(var_79_4.content)

				arg_76_1.text_.text = var_79_5

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_7 = 7 <= 0 and var_79_3 or var_79_3 * (utf8.len(var_79_5) / 7)

				if (7 <= 0 and var_79_3 or var_79_3 * (utf8.len(var_79_5) / 7)) > 0 and var_79_3 < var_79_7 then
					arg_76_1.talkMaxDuration = var_79_7

					if var_79_7 + var_79_2 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_7 + var_79_2
					end
				end

				arg_76_1.text_.text = var_79_5
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325531", "325531019", "story_v_out_325531.awb") ~= 0 then
					local var_79_8 = manager.audio:GetVoiceLength("story_v_out_325531", "325531019", "story_v_out_325531.awb") / 1000

					if var_79_8 + var_79_2 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_8 + var_79_2
					end

					if var_79_4.prefab_name ~= "" and arg_76_1.actors_[var_79_4.prefab_name] ~= nil then
						local var_79_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_4.prefab_name].transform, "story_v_out_325531", "325531019", "story_v_out_325531.awb")

						arg_76_1:RecordAudio("325531019", var_79_9)
						arg_76_1:RecordAudio("325531019", var_79_9)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_325531", "325531019", "story_v_out_325531.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_325531", "325531019", "story_v_out_325531.awb")
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
	Play325531020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 325531020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play325531021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["10180ui_story"]) and arg_80_1.var_.characterEffect10180ui_story == nil then
				arg_80_1.var_.characterEffect10180ui_story = arg_80_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_0 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["10180ui_story"]) then
				if arg_80_1.var_.characterEffect10180ui_story and not isNil(arg_80_1.actors_["10180ui_story"]) then
					arg_80_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_80_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_0)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["10180ui_story"]) and arg_80_1.var_.characterEffect10180ui_story then
				arg_80_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_80_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_83_1 = 0
			local var_83_2 = 0.1

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
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

				local var_83_3 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(325531020).content)

				arg_80_1.text_.text = var_83_3

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 4 <= 0 and var_83_2 or var_83_2 * (utf8.len(var_83_3) / 4)

				if (4 <= 0 and var_83_2 or var_83_2 * (utf8.len(var_83_3) / 4)) > 0 and var_83_2 < var_83_5 then
					arg_80_1.talkMaxDuration = var_83_5

					if var_83_5 + var_83_1 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_5 + var_83_1
					end
				end

				arg_80_1.text_.text = var_83_3
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_6 = math.max(var_83_2, arg_80_1.talkMaxDuration)

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_6 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_1) / var_83_6

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_1 + var_83_6 and arg_80_1.time_ < var_83_1 + var_83_6 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play325531021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 325531021
		arg_84_1.duration_ = 13.93

		local var_84_0 = {
			zh = 9.666,
			ja = 13.933
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play325531022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["10180ui_story"]) and arg_84_1.var_.characterEffect10180ui_story == nil then
				arg_84_1.var_.characterEffect10180ui_story = arg_84_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_0 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["10180ui_story"]) then
				if arg_84_1.var_.characterEffect10180ui_story and not isNil(arg_84_1.actors_["10180ui_story"]) then
					arg_84_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["10180ui_story"]) and arg_84_1.var_.characterEffect10180ui_story then
				arg_84_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_87_2 = 0
			local var_87_3 = 0.85

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_2 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_4 = arg_84_1:GetWordFromCfg(325531021)
				local var_87_5 = arg_84_1:FormatText(var_87_4.content)

				arg_84_1.text_.text = var_87_5

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_7 = 34 <= 0 and var_87_3 or var_87_3 * (utf8.len(var_87_5) / 34)

				if (34 <= 0 and var_87_3 or var_87_3 * (utf8.len(var_87_5) / 34)) > 0 and var_87_3 < var_87_7 then
					arg_84_1.talkMaxDuration = var_87_7

					if var_87_7 + var_87_2 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_7 + var_87_2
					end
				end

				arg_84_1.text_.text = var_87_5
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325531", "325531021", "story_v_out_325531.awb") ~= 0 then
					local var_87_8 = manager.audio:GetVoiceLength("story_v_out_325531", "325531021", "story_v_out_325531.awb") / 1000

					if var_87_8 + var_87_2 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_8 + var_87_2
					end

					if var_87_4.prefab_name ~= "" and arg_84_1.actors_[var_87_4.prefab_name] ~= nil then
						local var_87_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_4.prefab_name].transform, "story_v_out_325531", "325531021", "story_v_out_325531.awb")

						arg_84_1:RecordAudio("325531021", var_87_9)
						arg_84_1:RecordAudio("325531021", var_87_9)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_325531", "325531021", "story_v_out_325531.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_325531", "325531021", "story_v_out_325531.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_10 = math.max(var_87_3, arg_84_1.talkMaxDuration)

			if var_87_2 <= arg_84_1.time_ and arg_84_1.time_ < var_87_2 + var_87_10 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_2) / var_87_10

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_2 + var_87_10 and arg_84_1.time_ < var_87_2 + var_87_10 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play325531022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 325531022
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play325531023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(arg_88_1.actors_["10180ui_story"]) and arg_88_1.var_.characterEffect10180ui_story == nil then
				arg_88_1.var_.characterEffect10180ui_story = arg_88_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_0 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 and not isNil(arg_88_1.actors_["10180ui_story"]) then
				if arg_88_1.var_.characterEffect10180ui_story and not isNil(arg_88_1.actors_["10180ui_story"]) then
					arg_88_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_88_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_88_1.time_ - 0) / var_91_0)
				end
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 and not isNil(arg_88_1.actors_["10180ui_story"]) and arg_88_1.var_.characterEffect10180ui_story then
				arg_88_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_88_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_91_1 = 0
			local var_91_2 = 0.275

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_3 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(325531022).content)

				arg_88_1.text_.text = var_91_3

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_5 = 11 <= 0 and var_91_2 or var_91_2 * (utf8.len(var_91_3) / 11)

				if (11 <= 0 and var_91_2 or var_91_2 * (utf8.len(var_91_3) / 11)) > 0 and var_91_2 < var_91_5 then
					arg_88_1.talkMaxDuration = var_91_5

					if var_91_5 + var_91_1 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_5 + var_91_1
					end
				end

				arg_88_1.text_.text = var_91_3
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_6 = math.max(var_91_2, arg_88_1.talkMaxDuration)

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_6 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_1) / var_91_6

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_1 + var_91_6 and arg_88_1.time_ < var_91_1 + var_91_6 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play325531023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 325531023
		arg_92_1.duration_ = 7.43

		local var_92_0 = {
			zh = 3.6,
			ja = 7.433
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play325531024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(arg_92_1.actors_["10180ui_story"]) and arg_92_1.var_.characterEffect10180ui_story == nil then
				arg_92_1.var_.characterEffect10180ui_story = arg_92_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_0 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 and not isNil(arg_92_1.actors_["10180ui_story"]) then
				if arg_92_1.var_.characterEffect10180ui_story and not isNil(arg_92_1.actors_["10180ui_story"]) then
					arg_92_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 and not isNil(arg_92_1.actors_["10180ui_story"]) and arg_92_1.var_.characterEffect10180ui_story then
				arg_92_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action22_2")
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_95_2 = 0
			local var_95_3 = 0.3

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_2 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_4 = arg_92_1:GetWordFromCfg(325531023)
				local var_95_5 = arg_92_1:FormatText(var_95_4.content)

				arg_92_1.text_.text = var_95_5

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_7 = 12 <= 0 and var_95_3 or var_95_3 * (utf8.len(var_95_5) / 12)

				if (12 <= 0 and var_95_3 or var_95_3 * (utf8.len(var_95_5) / 12)) > 0 and var_95_3 < var_95_7 then
					arg_92_1.talkMaxDuration = var_95_7

					if var_95_7 + var_95_2 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_7 + var_95_2
					end
				end

				arg_92_1.text_.text = var_95_5
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325531", "325531023", "story_v_out_325531.awb") ~= 0 then
					local var_95_8 = manager.audio:GetVoiceLength("story_v_out_325531", "325531023", "story_v_out_325531.awb") / 1000

					if var_95_8 + var_95_2 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_8 + var_95_2
					end

					if var_95_4.prefab_name ~= "" and arg_92_1.actors_[var_95_4.prefab_name] ~= nil then
						local var_95_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_4.prefab_name].transform, "story_v_out_325531", "325531023", "story_v_out_325531.awb")

						arg_92_1:RecordAudio("325531023", var_95_9)
						arg_92_1:RecordAudio("325531023", var_95_9)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_325531", "325531023", "story_v_out_325531.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_325531", "325531023", "story_v_out_325531.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_10 = math.max(var_95_3, arg_92_1.talkMaxDuration)

			if var_95_2 <= arg_92_1.time_ and arg_92_1.time_ < var_95_2 + var_95_10 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_2) / var_95_10

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_2 + var_95_10 and arg_92_1.time_ < var_95_2 + var_95_10 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play325531024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 325531024
		arg_96_1.duration_ = 16.73

		local var_96_0 = {
			zh = 10.033,
			ja = 16.733
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play325531025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0.825

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_1 = arg_96_1:GetWordFromCfg(325531024)
				local var_99_2 = arg_96_1:FormatText(var_99_1.content)

				arg_96_1.text_.text = var_99_2

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_4 = 33 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_2) / 33)

				if (33 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_2) / 33)) > 0 and var_99_0 < var_99_4 then
					arg_96_1.talkMaxDuration = var_99_4

					if var_99_4 + 0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_4 + 0
					end
				end

				arg_96_1.text_.text = var_99_2
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325531", "325531024", "story_v_out_325531.awb") ~= 0 then
					local var_99_5 = manager.audio:GetVoiceLength("story_v_out_325531", "325531024", "story_v_out_325531.awb") / 1000

					if var_99_5 + 0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_5 + 0
					end

					if var_99_1.prefab_name ~= "" and arg_96_1.actors_[var_99_1.prefab_name] ~= nil then
						local var_99_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_1.prefab_name].transform, "story_v_out_325531", "325531024", "story_v_out_325531.awb")

						arg_96_1:RecordAudio("325531024", var_99_6)
						arg_96_1:RecordAudio("325531024", var_99_6)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_325531", "325531024", "story_v_out_325531.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_325531", "325531024", "story_v_out_325531.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_7 = math.max(var_99_0, arg_96_1.talkMaxDuration)

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_7 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - 0) / var_99_7

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= 0 + var_99_7 and arg_96_1.time_ < 0 + var_99_7 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play325531025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 325531025
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play325531026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["10180ui_story"]) and arg_100_1.var_.characterEffect10180ui_story == nil then
				arg_100_1.var_.characterEffect10180ui_story = arg_100_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_0 = 0.200000002980232

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["10180ui_story"]) then
				if arg_100_1.var_.characterEffect10180ui_story and not isNil(arg_100_1.actors_["10180ui_story"]) then
					arg_100_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_100_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_100_1.time_ - 0) / var_103_0)
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["10180ui_story"]) and arg_100_1.var_.characterEffect10180ui_story then
				arg_100_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_100_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_103_1 = 0
			local var_103_2 = 0.55

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_3 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(325531025).content)

				arg_100_1.text_.text = var_103_3

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_5 = 22 <= 0 and var_103_2 or var_103_2 * (utf8.len(var_103_3) / 22)

				if (22 <= 0 and var_103_2 or var_103_2 * (utf8.len(var_103_3) / 22)) > 0 and var_103_2 < var_103_5 then
					arg_100_1.talkMaxDuration = var_103_5

					if var_103_5 + var_103_1 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_5 + var_103_1
					end
				end

				arg_100_1.text_.text = var_103_3
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_6 = math.max(var_103_2, arg_100_1.talkMaxDuration)

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_6 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_1) / var_103_6

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_1 + var_103_6 and arg_100_1.time_ < var_103_1 + var_103_6 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play325531026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 325531026
		arg_104_1.duration_ = 1.57

		local var_104_0 = {
			zh = 1.3,
			ja = 1.566
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play325531027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(arg_104_1.actors_["10180ui_story"]) and arg_104_1.var_.characterEffect10180ui_story == nil then
				arg_104_1.var_.characterEffect10180ui_story = arg_104_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_0 = 0.200000002980232

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 and not isNil(arg_104_1.actors_["10180ui_story"]) then
				if arg_104_1.var_.characterEffect10180ui_story and not isNil(arg_104_1.actors_["10180ui_story"]) then
					arg_104_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 and not isNil(arg_104_1.actors_["10180ui_story"]) and arg_104_1.var_.characterEffect10180ui_story then
				arg_104_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_107_2 = 0
			local var_107_3 = 0.05

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_2 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_4 = arg_104_1:GetWordFromCfg(325531026)
				local var_107_5 = arg_104_1:FormatText(var_107_4.content)

				arg_104_1.text_.text = var_107_5

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_7 = 2 <= 0 and var_107_3 or var_107_3 * (utf8.len(var_107_5) / 2)

				if (2 <= 0 and var_107_3 or var_107_3 * (utf8.len(var_107_5) / 2)) > 0 and var_107_3 < var_107_7 then
					arg_104_1.talkMaxDuration = var_107_7

					if var_107_7 + var_107_2 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_7 + var_107_2
					end
				end

				arg_104_1.text_.text = var_107_5
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325531", "325531026", "story_v_out_325531.awb") ~= 0 then
					local var_107_8 = manager.audio:GetVoiceLength("story_v_out_325531", "325531026", "story_v_out_325531.awb") / 1000

					if var_107_8 + var_107_2 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_8 + var_107_2
					end

					if var_107_4.prefab_name ~= "" and arg_104_1.actors_[var_107_4.prefab_name] ~= nil then
						local var_107_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_4.prefab_name].transform, "story_v_out_325531", "325531026", "story_v_out_325531.awb")

						arg_104_1:RecordAudio("325531026", var_107_9)
						arg_104_1:RecordAudio("325531026", var_107_9)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_325531", "325531026", "story_v_out_325531.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_325531", "325531026", "story_v_out_325531.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_10 = math.max(var_107_3, arg_104_1.talkMaxDuration)

			if var_107_2 <= arg_104_1.time_ and arg_104_1.time_ < var_107_2 + var_107_10 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_2) / var_107_10

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_2 + var_107_10 and arg_104_1.time_ < var_107_2 + var_107_10 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play325531027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 325531027
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play325531028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(arg_108_1.actors_["10180ui_story"]) and arg_108_1.var_.characterEffect10180ui_story == nil then
				arg_108_1.var_.characterEffect10180ui_story = arg_108_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_0 = 0.200000002980232

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 and not isNil(arg_108_1.actors_["10180ui_story"]) then
				if arg_108_1.var_.characterEffect10180ui_story and not isNil(arg_108_1.actors_["10180ui_story"]) then
					arg_108_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_108_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_108_1.time_ - 0) / var_111_0)
				end
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 and not isNil(arg_108_1.actors_["10180ui_story"]) and arg_108_1.var_.characterEffect10180ui_story then
				arg_108_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_108_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_111_1 = 0
			local var_111_2 = 0.75

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, false)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_3 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(325531027).content)

				arg_108_1.text_.text = var_111_3

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 30 <= 0 and var_111_2 or var_111_2 * (utf8.len(var_111_3) / 30)

				if (30 <= 0 and var_111_2 or var_111_2 * (utf8.len(var_111_3) / 30)) > 0 and var_111_2 < var_111_5 then
					arg_108_1.talkMaxDuration = var_111_5

					if var_111_5 + var_111_1 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_5 + var_111_1
					end
				end

				arg_108_1.text_.text = var_111_3
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_6 = math.max(var_111_2, arg_108_1.talkMaxDuration)

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_6 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_1) / var_111_6

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_1 + var_111_6 and arg_108_1.time_ < var_111_1 + var_111_6 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play325531028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 325531028
		arg_112_1.duration_ = 9.93

		local var_112_0 = {
			zh = 6.8,
			ja = 9.933
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play325531029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["10180ui_story"]) and arg_112_1.var_.characterEffect10180ui_story == nil then
				arg_112_1.var_.characterEffect10180ui_story = arg_112_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_0 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["10180ui_story"]) then
				if arg_112_1.var_.characterEffect10180ui_story and not isNil(arg_112_1.actors_["10180ui_story"]) then
					arg_112_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["10180ui_story"]) and arg_112_1.var_.characterEffect10180ui_story then
				arg_112_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action3_1")
			end

			local var_115_2 = 0
			local var_115_3 = 0.425

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_2 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_4 = arg_112_1:GetWordFromCfg(325531028)
				local var_115_5 = arg_112_1:FormatText(var_115_4.content)

				arg_112_1.text_.text = var_115_5

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_7 = 17 <= 0 and var_115_3 or var_115_3 * (utf8.len(var_115_5) / 17)

				if (17 <= 0 and var_115_3 or var_115_3 * (utf8.len(var_115_5) / 17)) > 0 and var_115_3 < var_115_7 then
					arg_112_1.talkMaxDuration = var_115_7

					if var_115_7 + var_115_2 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_7 + var_115_2
					end
				end

				arg_112_1.text_.text = var_115_5
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325531", "325531028", "story_v_out_325531.awb") ~= 0 then
					local var_115_8 = manager.audio:GetVoiceLength("story_v_out_325531", "325531028", "story_v_out_325531.awb") / 1000

					if var_115_8 + var_115_2 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_8 + var_115_2
					end

					if var_115_4.prefab_name ~= "" and arg_112_1.actors_[var_115_4.prefab_name] ~= nil then
						local var_115_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_4.prefab_name].transform, "story_v_out_325531", "325531028", "story_v_out_325531.awb")

						arg_112_1:RecordAudio("325531028", var_115_9)
						arg_112_1:RecordAudio("325531028", var_115_9)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_325531", "325531028", "story_v_out_325531.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_325531", "325531028", "story_v_out_325531.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_10 = math.max(var_115_3, arg_112_1.talkMaxDuration)

			if var_115_2 <= arg_112_1.time_ and arg_112_1.time_ < var_115_2 + var_115_10 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_2) / var_115_10

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_2 + var_115_10 and arg_112_1.time_ < var_115_2 + var_115_10 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play325531029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 325531029
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play325531030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(arg_116_1.actors_["10180ui_story"]) and arg_116_1.var_.characterEffect10180ui_story == nil then
				arg_116_1.var_.characterEffect10180ui_story = arg_116_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_0 = 0.200000002980232

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 and not isNil(arg_116_1.actors_["10180ui_story"]) then
				if arg_116_1.var_.characterEffect10180ui_story and not isNil(arg_116_1.actors_["10180ui_story"]) then
					arg_116_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_116_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_116_1.time_ - 0) / var_119_0)
				end
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 and not isNil(arg_116_1.actors_["10180ui_story"]) and arg_116_1.var_.characterEffect10180ui_story then
				arg_116_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_116_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_119_1 = 0
			local var_119_2 = 0.975

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_3 = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(325531029).content)

				arg_116_1.text_.text = var_119_3

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_5 = 39 <= 0 and var_119_2 or var_119_2 * (utf8.len(var_119_3) / 39)

				if (39 <= 0 and var_119_2 or var_119_2 * (utf8.len(var_119_3) / 39)) > 0 and var_119_2 < var_119_5 then
					arg_116_1.talkMaxDuration = var_119_5

					if var_119_5 + var_119_1 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_5 + var_119_1
					end
				end

				arg_116_1.text_.text = var_119_3
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_6 = math.max(var_119_2, arg_116_1.talkMaxDuration)

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_6 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_1) / var_119_6

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_1 + var_119_6 and arg_116_1.time_ < var_119_1 + var_119_6 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play325531030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 325531030
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play325531031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0.875

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_1 = arg_120_1:FormatText(arg_120_1:GetWordFromCfg(325531030).content)

				arg_120_1.text_.text = var_123_1

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_3 = 35 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_1) / 35)

				if (35 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_1) / 35)) > 0 and var_123_0 < var_123_3 then
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
	Play325531031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 325531031
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play325531032(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0.575

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, true)
				arg_124_1.iconController_:SetSelectedState("hero")

				arg_124_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_124_1.callingController_:SetSelectedState("normal")

				arg_124_1.keyicon_.color = Color.New(1, 1, 1)
				arg_124_1.icon_.color = Color.New(1, 1, 1)

				local var_127_1 = arg_124_1:FormatText(arg_124_1:GetWordFromCfg(325531031).content)

				arg_124_1.text_.text = var_127_1

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_3 = 23 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_1) / 23)

				if (23 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_1) / 23)) > 0 and var_127_0 < var_127_3 then
					arg_124_1.talkMaxDuration = var_127_3

					if var_127_3 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_3 + 0
					end
				end

				arg_124_1.text_.text = var_127_1
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_4 = math.max(var_127_0, arg_124_1.talkMaxDuration)

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_4 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - 0) / var_127_4

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= 0 + var_127_4 and arg_124_1.time_ < 0 + var_127_4 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play325531032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 325531032
		arg_128_1.duration_ = 4.8

		local var_128_0 = {
			zh = 4.8,
			ja = 4.2
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play325531033(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(arg_128_1.actors_["10180ui_story"]) and arg_128_1.var_.characterEffect10180ui_story == nil then
				arg_128_1.var_.characterEffect10180ui_story = arg_128_1.actors_["10180ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_0 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 and not isNil(arg_128_1.actors_["10180ui_story"]) then
				if arg_128_1.var_.characterEffect10180ui_story and not isNil(arg_128_1.actors_["10180ui_story"]) then
					arg_128_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 and not isNil(arg_128_1.actors_["10180ui_story"]) and arg_128_1.var_.characterEffect10180ui_story then
				arg_128_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action3_2")
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_131_2 = 0
			local var_131_3 = 0.375

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_2 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_4 = arg_128_1:GetWordFromCfg(325531032)
				local var_131_5 = arg_128_1:FormatText(var_131_4.content)

				arg_128_1.text_.text = var_131_5

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_7 = 15 <= 0 and var_131_3 or var_131_3 * (utf8.len(var_131_5) / 15)

				if (15 <= 0 and var_131_3 or var_131_3 * (utf8.len(var_131_5) / 15)) > 0 and var_131_3 < var_131_7 then
					arg_128_1.talkMaxDuration = var_131_7

					if var_131_7 + var_131_2 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_7 + var_131_2
					end
				end

				arg_128_1.text_.text = var_131_5
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325531", "325531032", "story_v_out_325531.awb") ~= 0 then
					local var_131_8 = manager.audio:GetVoiceLength("story_v_out_325531", "325531032", "story_v_out_325531.awb") / 1000

					if var_131_8 + var_131_2 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_8 + var_131_2
					end

					if var_131_4.prefab_name ~= "" and arg_128_1.actors_[var_131_4.prefab_name] ~= nil then
						local var_131_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_4.prefab_name].transform, "story_v_out_325531", "325531032", "story_v_out_325531.awb")

						arg_128_1:RecordAudio("325531032", var_131_9)
						arg_128_1:RecordAudio("325531032", var_131_9)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_325531", "325531032", "story_v_out_325531.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_325531", "325531032", "story_v_out_325531.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_10 = math.max(var_131_3, arg_128_1.talkMaxDuration)

			if var_131_2 <= arg_128_1.time_ and arg_128_1.time_ < var_131_2 + var_131_10 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_2) / var_131_10

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_2 + var_131_10 and arg_128_1.time_ < var_131_2 + var_131_10 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play325531033 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 325531033
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play325531034(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos10180ui_story = arg_132_1.actors_["10180ui_story"].transform.localPosition

				local var_135_0 = GameObjectTools.GetOrAddComponent(arg_132_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_135_0 then
					var_135_0:EnableDynamicBone(false)
				end
			end

			local var_135_1 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_1 then
				arg_132_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos10180ui_story, Vector3.New(0, 100, 0), (arg_132_1.time_ - 0) / var_135_1)
				arg_132_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["10180ui_story"].transform.position).z)
				arg_132_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["10180ui_story"].transform.localEulerAngles = arg_132_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_132_1.time_ >= 0 + var_135_1 and arg_132_1.time_ < 0 + var_135_1 + arg_135_0 then
				arg_132_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_132_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["10180ui_story"].transform.position).z)
				arg_132_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["10180ui_story"].transform.localEulerAngles = arg_132_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_135_2 = GameObjectTools.GetOrAddComponent(arg_132_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_135_2 then
					var_135_2:EnableDynamicBone(true)
				end
			end

			local var_135_3 = arg_132_1.actors_["10180ui_story"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_3) and arg_132_1.var_.characterEffect10180ui_story == nil then
				arg_132_1.var_.characterEffect10180ui_story = var_135_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_4 = 0.200000002980232

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_4 and not isNil(var_135_3) then
				if arg_132_1.var_.characterEffect10180ui_story and not isNil(var_135_3) then
					arg_132_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_132_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_132_1.time_ - 0) / var_135_4)
				end
			end

			if arg_132_1.time_ >= 0 + var_135_4 and arg_132_1.time_ < 0 + var_135_4 + arg_135_0 and not isNil(var_135_3) and arg_132_1.var_.characterEffect10180ui_story then
				arg_132_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_132_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_135_5 = 0
			local var_135_6 = 0.5

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_5 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, false)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_7 = arg_132_1:FormatText(arg_132_1:GetWordFromCfg(325531033).content)

				arg_132_1.text_.text = var_135_7

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_9 = 20 <= 0 and var_135_6 or var_135_6 * (utf8.len(var_135_7) / 20)

				if (20 <= 0 and var_135_6 or var_135_6 * (utf8.len(var_135_7) / 20)) > 0 and var_135_6 < var_135_9 then
					arg_132_1.talkMaxDuration = var_135_9

					if var_135_9 + var_135_5 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_9 + var_135_5
					end
				end

				arg_132_1.text_.text = var_135_7
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_10 = math.max(var_135_6, arg_132_1.talkMaxDuration)

			if var_135_5 <= arg_132_1.time_ and arg_132_1.time_ < var_135_5 + var_135_10 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_5) / var_135_10

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_5 + var_135_10 and arg_132_1.time_ < var_135_5 + var_135_10 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play325531034 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 325531034
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play325531035(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 1.05

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, false)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_1 = arg_136_1:FormatText(arg_136_1:GetWordFromCfg(325531034).content)

				arg_136_1.text_.text = var_139_1

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_3 = 42 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_1) / 42)

				if (42 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_1) / 42)) > 0 and var_139_0 < var_139_3 then
					arg_136_1.talkMaxDuration = var_139_3

					if var_139_3 + 0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_3 + 0
					end
				end

				arg_136_1.text_.text = var_139_1
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_4 = math.max(var_139_0, arg_136_1.talkMaxDuration)

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_4 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - 0) / var_139_4

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= 0 + var_139_4 and arg_136_1.time_ < 0 + var_139_4 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play325531035 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 325531035
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play325531036(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 0.875

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, false)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_1 = arg_140_1:FormatText(arg_140_1:GetWordFromCfg(325531035).content)

				arg_140_1.text_.text = var_143_1

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_3 = 35 <= 0 and var_143_0 or var_143_0 * (utf8.len(var_143_1) / 35)

				if (35 <= 0 and var_143_0 or var_143_0 * (utf8.len(var_143_1) / 35)) > 0 and var_143_0 < var_143_3 then
					arg_140_1.talkMaxDuration = var_143_3

					if var_143_3 + 0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_3 + 0
					end
				end

				arg_140_1.text_.text = var_143_1
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_4 = math.max(var_143_0, arg_140_1.talkMaxDuration)

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_4 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - 0) / var_143_4

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= 0 + var_143_4 and arg_140_1.time_ < 0 + var_143_4 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play325531036 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 325531036
		arg_144_1.duration_ = 6

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play325531037(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_9000

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.mask_.enabled = true
				arg_144_1.mask_.raycastTarget = true

				arg_144_1:SetGaussion(false)
			end

			local var_147_0 = 0.533333333333333

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 then
				local var_147_1 = Color.New(1, 1, 1)

				var_147_1.a = Mathf.Lerp(1, 0, (arg_144_1.time_ - 0) / var_147_0)
				arg_144_1.mask_.color = var_147_1
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 then
				local var_147_2 = Color.New(1, 1, 1)

				arg_144_1.mask_.enabled = false
				var_147_2.a = 0
				arg_144_1.mask_.color = var_147_2
			end

			if 0.2 < arg_144_1.time_ and arg_144_1.time_ <= 0.2 + arg_147_0 then
				local var_147_3 = arg_144_1.var_.effect34324

				if not arg_144_1.var_.effect34324 then
					var_147_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang01"), manager.ui.mainCamera.transform)
					var_147_3.name = "34324"
					arg_144_1.var_.effect34324 = var_147_3
				else
					var_147_3.transform:SetParent(var_147_9000)
				end

				var_147_3.transform.localPosition = Vector3.New(0, 0, 0)
				var_147_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_147_3.transform.localScale = Vector3.New(var_147_3.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_147_3.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_147_3.transform.localScale.z)
			end

			if 1.73333333333333 < arg_144_1.time_ and arg_144_1.time_ <= 1.73333333333333 + arg_147_0 then
				if arg_144_1.var_.effect34324 then
					Object.Destroy(arg_144_1.var_.effect34324)

					arg_144_1.var_.effect34324 = nil
				end
			end

			local var_147_6 = 0

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_6 + arg_147_0 then
				arg_144_1.allBtn_.enabled = false
			end

			if arg_144_1.time_ >= var_147_6 + 1.3 and arg_144_1.time_ < var_147_6 + 1.3 + arg_147_0 then
				arg_144_1.allBtn_.enabled = true
			end

			if 0.1 < arg_144_1.time_ and arg_144_1.time_ <= 0.1 + arg_147_0 then
				arg_144_1:AudioAction("play", "effect", "se_story_148", "se_story_148_sword03", "")
			end

			if arg_144_1.frameCnt_ <= 1 then
				arg_144_1.dialog_:SetActive(false)
			end

			local var_147_8 = 1
			local var_147_9 = 0.875

			if 1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_8 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0

				arg_144_1.dialog_:SetActive(true)

				arg_144_1.dialogCg_.alpha = 0

				local var_147_10 = LeanTween.value(arg_144_1.dialog_, 0, 1, 0.3)

				var_147_10:setOnUpdate(LuaHelper.FloatAction(function(arg_148_0)
					arg_144_1.dialogCg_.alpha = arg_148_0
				end))
				var_147_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_144_1.dialog_)
					var_147_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_144_1.duration_ = arg_144_1.duration_ + 0.3

				SetActive(arg_144_1.leftNameGo_, false)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_11 = arg_144_1:FormatText(arg_144_1:GetWordFromCfg(325531036).content)

				arg_144_1.text_.text = var_147_11

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_13 = 35 <= 0 and var_147_9 or var_147_9 * (utf8.len(var_147_11) / 35)

				if (35 <= 0 and var_147_9 or var_147_9 * (utf8.len(var_147_11) / 35)) > 0 and var_147_9 < var_147_13 then
					arg_144_1.talkMaxDuration = var_147_13
					var_147_8 = var_147_8 + 0.3

					if var_147_13 + var_147_8 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_13 + var_147_8
					end
				end

				arg_144_1.text_.text = var_147_11
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_14 = var_147_8 + 0.3
			local var_147_15 = math.max(var_147_9, arg_144_1.talkMaxDuration)

			if var_147_8 + 0.3 <= arg_144_1.time_ and arg_144_1.time_ < var_147_14 + var_147_15 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_14) / var_147_15

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_14 + var_147_15 and arg_144_1.time_ < var_147_14 + var_147_15 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play325531037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 325531037
		arg_150_1.duration_ = 2

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play325531038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if arg_150_1.actors_["10170ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10170ui_story"))) then
				local var_153_0 = Object.Instantiate(Asset.Load("Char/" .. "10170ui_story"), arg_150_1.stage_.transform)

				var_153_0.name = "10170ui_story"
				var_153_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_150_1.actors_["10170ui_story"] = var_153_0

				local var_153_1 = var_153_0:GetComponentInChildren(typeof(CharacterEffect))

				var_153_1.enabled = true

				local var_153_2 = GameObjectTools.GetOrAddComponent(var_153_0, typeof(DynamicBoneHelper))

				if var_153_2 then
					var_153_2:EnableDynamicBone(false)
				end

				arg_150_1:ShowWeapon(var_153_1.transform, false)

				arg_150_1.var_["10170ui_story" .. "Animator"] = var_153_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_150_1.var_["10170ui_story" .. "Animator"].applyRootMotion = true
				arg_150_1.var_["10170ui_story" .. "LipSync"] = var_153_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_153_3 = arg_150_1.actors_["10170ui_story"].transform

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.var_.moveOldPos10170ui_story = var_153_3.localPosition

				local var_153_4 = GameObjectTools.GetOrAddComponent(var_153_3.gameObject, typeof(DynamicBoneHelper))

				if var_153_4 then
					var_153_4:EnableDynamicBone(false)
				end
			end

			local var_153_5 = 0.001

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_5 then
				var_153_3.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos10170ui_story, Vector3.New(0, 100, 0), (arg_150_1.time_ - 0) / var_153_5)
				var_153_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_153_3.position).x, (manager.ui.mainCamera.transform.position - var_153_3.position).y, (manager.ui.mainCamera.transform.position - var_153_3.position).z)
				var_153_3.localEulerAngles.z = 0
				var_153_3.localEulerAngles.x = 0
				var_153_3.localEulerAngles = var_153_3.localEulerAngles
			end

			if arg_150_1.time_ >= 0 + var_153_5 and arg_150_1.time_ < 0 + var_153_5 + arg_153_0 then
				var_153_3.localPosition = Vector3.New(0, 100, 0)
				var_153_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_153_3.position).x, (manager.ui.mainCamera.transform.position - var_153_3.position).y, (manager.ui.mainCamera.transform.position - var_153_3.position).z)
				var_153_3.localEulerAngles.z = 0
				var_153_3.localEulerAngles.x = 0
				var_153_3.localEulerAngles = var_153_3.localEulerAngles

				local var_153_6 = GameObjectTools.GetOrAddComponent(var_153_3.gameObject, typeof(DynamicBoneHelper))

				if var_153_6 then
					var_153_6:EnableDynamicBone(true)
				end
			end

			local var_153_7 = arg_150_1.actors_["10170ui_story"]

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(var_153_7) and arg_150_1.var_.characterEffect10170ui_story == nil then
				arg_150_1.var_.characterEffect10170ui_story = var_153_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_8 = 0.200000002980232

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_8 and not isNil(var_153_7) then
				if arg_150_1.var_.characterEffect10170ui_story and not isNil(var_153_7) then
					arg_150_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_150_1.time_ >= 0 + var_153_8 and arg_150_1.time_ < 0 + var_153_8 + arg_153_0 and not isNil(var_153_7) and arg_150_1.var_.characterEffect10170ui_story then
				arg_150_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action1_1")
			end

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_153_10 = 0
			local var_153_11 = 0.2

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_10 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, true)
				arg_150_1.iconController_:SetSelectedState("hero")

				arg_150_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10170")

				arg_150_1.callingController_:SetSelectedState("normal")

				arg_150_1.keyicon_.color = Color.New(1, 1, 1)
				arg_150_1.icon_.color = Color.New(1, 1, 1)

				local var_153_12 = arg_150_1:GetWordFromCfg(325531037)
				local var_153_13 = arg_150_1:FormatText(var_153_12.content)

				arg_150_1.text_.text = var_153_13

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_15 = 8 <= 0 and var_153_11 or var_153_11 * (utf8.len(var_153_13) / 8)

				if (8 <= 0 and var_153_11 or var_153_11 * (utf8.len(var_153_13) / 8)) > 0 and var_153_11 < var_153_15 then
					arg_150_1.talkMaxDuration = var_153_15

					if var_153_15 + var_153_10 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_15 + var_153_10
					end
				end

				arg_150_1.text_.text = var_153_13
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325531", "325531037", "story_v_out_325531.awb") ~= 0 then
					local var_153_16 = manager.audio:GetVoiceLength("story_v_out_325531", "325531037", "story_v_out_325531.awb") / 1000

					if var_153_16 + var_153_10 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_16 + var_153_10
					end

					if var_153_12.prefab_name ~= "" and arg_150_1.actors_[var_153_12.prefab_name] ~= nil then
						local var_153_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_12.prefab_name].transform, "story_v_out_325531", "325531037", "story_v_out_325531.awb")

						arg_150_1:RecordAudio("325531037", var_153_17)
						arg_150_1:RecordAudio("325531037", var_153_17)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_325531", "325531037", "story_v_out_325531.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_325531", "325531037", "story_v_out_325531.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_18 = math.max(var_153_11, arg_150_1.talkMaxDuration)

			if var_153_10 <= arg_150_1.time_ and arg_150_1.time_ < var_153_10 + var_153_18 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_10) / var_153_18

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_10 + var_153_18 and arg_150_1.time_ < var_153_10 + var_153_18 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
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
	Play325531038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 325531038
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play325531039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.var_.moveOldPos10170ui_story = arg_154_1.actors_["10170ui_story"].transform.localPosition

				local var_157_0 = GameObjectTools.GetOrAddComponent(arg_154_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_157_0 then
					var_157_0:EnableDynamicBone(false)
				end
			end

			local var_157_1 = 0.001

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_1 then
				arg_154_1.actors_["10170ui_story"].transform.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos10170ui_story, Vector3.New(0, 100, 0), (arg_154_1.time_ - 0) / var_157_1)
				arg_154_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_154_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["10170ui_story"].transform.position).z)
				arg_154_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_154_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_154_1.actors_["10170ui_story"].transform.localEulerAngles = arg_154_1.actors_["10170ui_story"].transform.localEulerAngles
			end

			if arg_154_1.time_ >= 0 + var_157_1 and arg_154_1.time_ < 0 + var_157_1 + arg_157_0 then
				arg_154_1.actors_["10170ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_154_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_154_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["10170ui_story"].transform.position).z)
				arg_154_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_154_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_154_1.actors_["10170ui_story"].transform.localEulerAngles = arg_154_1.actors_["10170ui_story"].transform.localEulerAngles

				local var_157_2 = GameObjectTools.GetOrAddComponent(arg_154_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_157_2 then
					var_157_2:EnableDynamicBone(true)
				end
			end

			local var_157_3 = arg_154_1.actors_["10170ui_story"]

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(var_157_3) and arg_154_1.var_.characterEffect10170ui_story == nil then
				arg_154_1.var_.characterEffect10170ui_story = var_157_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_4 = 0.200000002980232

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_4 and not isNil(var_157_3) then
				if arg_154_1.var_.characterEffect10170ui_story and not isNil(var_157_3) then
					arg_154_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_154_1.var_.characterEffect10170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_154_1.time_ - 0) / var_157_4)
				end
			end

			if arg_154_1.time_ >= 0 + var_157_4 and arg_154_1.time_ < 0 + var_157_4 + arg_157_0 and not isNil(var_157_3) and arg_154_1.var_.characterEffect10170ui_story then
				arg_154_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_154_1.var_.characterEffect10170ui_story.fillRatio = 0.5
			end

			local var_157_5 = 0
			local var_157_6 = 1.225

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_5 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, false)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_7 = arg_154_1:FormatText(arg_154_1:GetWordFromCfg(325531038).content)

				arg_154_1.text_.text = var_157_7

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_9 = 49 <= 0 and var_157_6 or var_157_6 * (utf8.len(var_157_7) / 49)

				if (49 <= 0 and var_157_6 or var_157_6 * (utf8.len(var_157_7) / 49)) > 0 and var_157_6 < var_157_9 then
					arg_154_1.talkMaxDuration = var_157_9

					if var_157_9 + var_157_5 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_9 + var_157_5
					end
				end

				arg_154_1.text_.text = var_157_7
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_10 = math.max(var_157_6, arg_154_1.talkMaxDuration)

			if var_157_5 <= arg_154_1.time_ and arg_154_1.time_ < var_157_5 + var_157_10 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_5) / var_157_10

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_5 + var_157_10 and arg_154_1.time_ < var_157_5 + var_157_10 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_154_1:InitPlayNodeList()
	end,
	Play325531039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 325531039
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play325531040(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 0.725

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, false)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_1 = arg_158_1:FormatText(arg_158_1:GetWordFromCfg(325531039).content)

				arg_158_1.text_.text = var_161_1

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_3 = 29 <= 0 and var_161_0 or var_161_0 * (utf8.len(var_161_1) / 29)

				if (29 <= 0 and var_161_0 or var_161_0 * (utf8.len(var_161_1) / 29)) > 0 and var_161_0 < var_161_3 then
					arg_158_1.talkMaxDuration = var_161_3

					if var_161_3 + 0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_3 + 0
					end
				end

				arg_158_1.text_.text = var_161_1
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_4 = math.max(var_161_0, arg_158_1.talkMaxDuration)

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_4 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - 0) / var_161_4

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= 0 + var_161_4 and arg_158_1.time_ < 0 + var_161_4 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play325531040 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 325531040
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play325531041(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 0.2

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
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

				local var_165_1 = arg_162_1:FormatText(arg_162_1:GetWordFromCfg(325531040).content)

				arg_162_1.text_.text = var_165_1

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_3 = 8 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_1) / 8)

				if (8 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_1) / 8)) > 0 and var_165_0 < var_165_3 then
					arg_162_1.talkMaxDuration = var_165_3

					if var_165_3 + 0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_3 + 0
					end
				end

				arg_162_1.text_.text = var_165_1
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_4 = math.max(var_165_0, arg_162_1.talkMaxDuration)

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_4 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - 0) / var_165_4

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= 0 + var_165_4 and arg_162_1.time_ < 0 + var_165_4 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play325531041 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 325531041
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play325531042(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = 1.025

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, false)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_1 = arg_166_1:FormatText(arg_166_1:GetWordFromCfg(325531041).content)

				arg_166_1.text_.text = var_169_1

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_3 = 41 <= 0 and var_169_0 or var_169_0 * (utf8.len(var_169_1) / 41)

				if (41 <= 0 and var_169_0 or var_169_0 * (utf8.len(var_169_1) / 41)) > 0 and var_169_0 < var_169_3 then
					arg_166_1.talkMaxDuration = var_169_3

					if var_169_3 + 0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_3 + 0
					end
				end

				arg_166_1.text_.text = var_169_1
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_4 = math.max(var_169_0, arg_166_1.talkMaxDuration)

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_4 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - 0) / var_169_4

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= 0 + var_169_4 and arg_166_1.time_ < 0 + var_169_4 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play325531042 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 325531042
		arg_170_1.duration_ = 2.03

		local var_170_0 = {
			zh = 1.999999999999,
			ja = 2.033
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
				arg_170_0:Play325531043(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.var_.moveOldPos10170ui_story = arg_170_1.actors_["10170ui_story"].transform.localPosition

				local var_173_0 = GameObjectTools.GetOrAddComponent(arg_170_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_173_0 then
					var_173_0:EnableDynamicBone(false)
				end
			end

			local var_173_1 = 0.001

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_1 then
				arg_170_1.actors_["10170ui_story"].transform.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos10170ui_story, Vector3.New(0, -1.03, -6.05), (arg_170_1.time_ - 0) / var_173_1)
				arg_170_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_170_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["10170ui_story"].transform.position).z)
				arg_170_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_170_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_170_1.actors_["10170ui_story"].transform.localEulerAngles = arg_170_1.actors_["10170ui_story"].transform.localEulerAngles
			end

			if arg_170_1.time_ >= 0 + var_173_1 and arg_170_1.time_ < 0 + var_173_1 + arg_173_0 then
				arg_170_1.actors_["10170ui_story"].transform.localPosition = Vector3.New(0, -1.03, -6.05)
				arg_170_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_170_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["10170ui_story"].transform.position).z)
				arg_170_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_170_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_170_1.actors_["10170ui_story"].transform.localEulerAngles = arg_170_1.actors_["10170ui_story"].transform.localEulerAngles

				local var_173_2 = GameObjectTools.GetOrAddComponent(arg_170_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_173_2 then
					var_173_2:EnableDynamicBone(true)
				end
			end

			local var_173_3 = arg_170_1.actors_["10170ui_story"]

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(var_173_3) and arg_170_1.var_.characterEffect10170ui_story == nil then
				arg_170_1.var_.characterEffect10170ui_story = var_173_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_4 = 0.200000002980232

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_4 and not isNil(var_173_3) then
				if arg_170_1.var_.characterEffect10170ui_story and not isNil(var_173_3) then
					arg_170_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_170_1.time_ >= 0 + var_173_4 and arg_170_1.time_ < 0 + var_173_4 + arg_173_0 and not isNil(var_173_3) and arg_170_1.var_.characterEffect10170ui_story then
				arg_170_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action27_1")
			end

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_173_6 = 0
			local var_173_7 = 0.2

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_6 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_8 = arg_170_1:GetWordFromCfg(325531042)
				local var_173_9 = arg_170_1:FormatText(var_173_8.content)

				arg_170_1.text_.text = var_173_9

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_11 = 8 <= 0 and var_173_7 or var_173_7 * (utf8.len(var_173_9) / 8)

				if (8 <= 0 and var_173_7 or var_173_7 * (utf8.len(var_173_9) / 8)) > 0 and var_173_7 < var_173_11 then
					arg_170_1.talkMaxDuration = var_173_11

					if var_173_11 + var_173_6 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_11 + var_173_6
					end
				end

				arg_170_1.text_.text = var_173_9
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325531", "325531042", "story_v_out_325531.awb") ~= 0 then
					local var_173_12 = manager.audio:GetVoiceLength("story_v_out_325531", "325531042", "story_v_out_325531.awb") / 1000

					if var_173_12 + var_173_6 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_12 + var_173_6
					end

					if var_173_8.prefab_name ~= "" and arg_170_1.actors_[var_173_8.prefab_name] ~= nil then
						local var_173_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_8.prefab_name].transform, "story_v_out_325531", "325531042", "story_v_out_325531.awb")

						arg_170_1:RecordAudio("325531042", var_173_13)
						arg_170_1:RecordAudio("325531042", var_173_13)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_325531", "325531042", "story_v_out_325531.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_325531", "325531042", "story_v_out_325531.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_14 = math.max(var_173_7, arg_170_1.talkMaxDuration)

			if var_173_6 <= arg_170_1.time_ and arg_170_1.time_ < var_173_6 + var_173_14 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_6) / var_173_14

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_6 + var_173_14 and arg_170_1.time_ < var_173_6 + var_173_14 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
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
	Play325531043 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 325531043
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play325531044(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(arg_174_1.actors_["10170ui_story"]) and arg_174_1.var_.characterEffect10170ui_story == nil then
				arg_174_1.var_.characterEffect10170ui_story = arg_174_1.actors_["10170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_0 = 0.200000002980232

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_0 and not isNil(arg_174_1.actors_["10170ui_story"]) then
				if arg_174_1.var_.characterEffect10170ui_story and not isNil(arg_174_1.actors_["10170ui_story"]) then
					arg_174_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_174_1.var_.characterEffect10170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_174_1.time_ - 0) / var_177_0)
				end
			end

			if arg_174_1.time_ >= 0 + var_177_0 and arg_174_1.time_ < 0 + var_177_0 + arg_177_0 and not isNil(arg_174_1.actors_["10170ui_story"]) and arg_174_1.var_.characterEffect10170ui_story then
				arg_174_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_174_1.var_.characterEffect10170ui_story.fillRatio = 0.5
			end

			local var_177_1 = 0
			local var_177_2 = 0.575

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 then
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

				local var_177_3 = arg_174_1:FormatText(arg_174_1:GetWordFromCfg(325531043).content)

				arg_174_1.text_.text = var_177_3

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_5 = 23 <= 0 and var_177_2 or var_177_2 * (utf8.len(var_177_3) / 23)

				if (23 <= 0 and var_177_2 or var_177_2 * (utf8.len(var_177_3) / 23)) > 0 and var_177_2 < var_177_5 then
					arg_174_1.talkMaxDuration = var_177_5

					if var_177_5 + var_177_1 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_5 + var_177_1
					end
				end

				arg_174_1.text_.text = var_177_3
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_6 = math.max(var_177_2, arg_174_1.talkMaxDuration)

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_6 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_1) / var_177_6

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_1 + var_177_6 and arg_174_1.time_ < var_177_1 + var_177_6 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play325531044 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 325531044
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play325531045(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 0.45

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, true)
				arg_178_1.iconController_:SetSelectedState("hero")

				arg_178_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_178_1.callingController_:SetSelectedState("normal")

				arg_178_1.keyicon_.color = Color.New(1, 1, 1)
				arg_178_1.icon_.color = Color.New(1, 1, 1)

				local var_181_1 = arg_178_1:FormatText(arg_178_1:GetWordFromCfg(325531044).content)

				arg_178_1.text_.text = var_181_1

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_3 = 18 <= 0 and var_181_0 or var_181_0 * (utf8.len(var_181_1) / 18)

				if (18 <= 0 and var_181_0 or var_181_0 * (utf8.len(var_181_1) / 18)) > 0 and var_181_0 < var_181_3 then
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
	Play325531045 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 325531045
		arg_182_1.duration_ = 2.83

		local var_182_0 = {
			zh = 2.433,
			ja = 2.833
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
				arg_182_0:Play325531046(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(arg_182_1.actors_["10170ui_story"]) and arg_182_1.var_.characterEffect10170ui_story == nil then
				arg_182_1.var_.characterEffect10170ui_story = arg_182_1.actors_["10170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_0 = 0.200000002980232

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 and not isNil(arg_182_1.actors_["10170ui_story"]) then
				if arg_182_1.var_.characterEffect10170ui_story and not isNil(arg_182_1.actors_["10170ui_story"]) then
					arg_182_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 and not isNil(arg_182_1.actors_["10170ui_story"]) and arg_182_1.var_.characterEffect10170ui_story then
				arg_182_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action27_2")
			end

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_185_2 = 0
			local var_185_3 = 0.275

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_2 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_4 = arg_182_1:GetWordFromCfg(325531045)
				local var_185_5 = arg_182_1:FormatText(var_185_4.content)

				arg_182_1.text_.text = var_185_5

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_7 = 11 <= 0 and var_185_3 or var_185_3 * (utf8.len(var_185_5) / 11)

				if (11 <= 0 and var_185_3 or var_185_3 * (utf8.len(var_185_5) / 11)) > 0 and var_185_3 < var_185_7 then
					arg_182_1.talkMaxDuration = var_185_7

					if var_185_7 + var_185_2 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_7 + var_185_2
					end
				end

				arg_182_1.text_.text = var_185_5
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325531", "325531045", "story_v_out_325531.awb") ~= 0 then
					local var_185_8 = manager.audio:GetVoiceLength("story_v_out_325531", "325531045", "story_v_out_325531.awb") / 1000

					if var_185_8 + var_185_2 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_8 + var_185_2
					end

					if var_185_4.prefab_name ~= "" and arg_182_1.actors_[var_185_4.prefab_name] ~= nil then
						local var_185_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_4.prefab_name].transform, "story_v_out_325531", "325531045", "story_v_out_325531.awb")

						arg_182_1:RecordAudio("325531045", var_185_9)
						arg_182_1:RecordAudio("325531045", var_185_9)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_325531", "325531045", "story_v_out_325531.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_325531", "325531045", "story_v_out_325531.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_10 = math.max(var_185_3, arg_182_1.talkMaxDuration)

			if var_185_2 <= arg_182_1.time_ and arg_182_1.time_ < var_185_2 + var_185_10 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_2) / var_185_10

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_2 + var_185_10 and arg_182_1.time_ < var_185_2 + var_185_10 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play325531046 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 325531046
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play325531047(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(arg_186_1.actors_["10170ui_story"]) and arg_186_1.var_.characterEffect10170ui_story == nil then
				arg_186_1.var_.characterEffect10170ui_story = arg_186_1.actors_["10170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_0 = 0.200000002980232

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 and not isNil(arg_186_1.actors_["10170ui_story"]) then
				if arg_186_1.var_.characterEffect10170ui_story and not isNil(arg_186_1.actors_["10170ui_story"]) then
					arg_186_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_186_1.var_.characterEffect10170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_186_1.time_ - 0) / var_189_0)
				end
			end

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 and not isNil(arg_186_1.actors_["10170ui_story"]) and arg_186_1.var_.characterEffect10170ui_story then
				arg_186_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_186_1.var_.characterEffect10170ui_story.fillRatio = 0.5
			end

			local var_189_1 = 0
			local var_189_2 = 0.4

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

				local var_189_3 = arg_186_1:FormatText(arg_186_1:GetWordFromCfg(325531046).content)

				arg_186_1.text_.text = var_189_3

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_5 = 16 <= 0 and var_189_2 or var_189_2 * (utf8.len(var_189_3) / 16)

				if (16 <= 0 and var_189_2 or var_189_2 * (utf8.len(var_189_3) / 16)) > 0 and var_189_2 < var_189_5 then
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
	Play325531047 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 325531047
		arg_190_1.duration_ = 1.23

		local var_190_0 = {
			zh = 0.999999999999,
			ja = 1.233
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
				arg_190_0:Play325531048(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(arg_190_1.actors_["10170ui_story"]) and arg_190_1.var_.characterEffect10170ui_story == nil then
				arg_190_1.var_.characterEffect10170ui_story = arg_190_1.actors_["10170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_0 = 0.200000002980232

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 and not isNil(arg_190_1.actors_["10170ui_story"]) then
				if arg_190_1.var_.characterEffect10170ui_story and not isNil(arg_190_1.actors_["10170ui_story"]) then
					arg_190_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 and not isNil(arg_190_1.actors_["10170ui_story"]) and arg_190_1.var_.characterEffect10170ui_story then
				arg_190_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_193_2 = 0
			local var_193_3 = 0.075

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_2 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_4 = arg_190_1:GetWordFromCfg(325531047)
				local var_193_5 = arg_190_1:FormatText(var_193_4.content)

				arg_190_1.text_.text = var_193_5

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_7 = 3 <= 0 and var_193_3 or var_193_3 * (utf8.len(var_193_5) / 3)

				if (3 <= 0 and var_193_3 or var_193_3 * (utf8.len(var_193_5) / 3)) > 0 and var_193_3 < var_193_7 then
					arg_190_1.talkMaxDuration = var_193_7

					if var_193_7 + var_193_2 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_7 + var_193_2
					end
				end

				arg_190_1.text_.text = var_193_5
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325531", "325531047", "story_v_out_325531.awb") ~= 0 then
					local var_193_8 = manager.audio:GetVoiceLength("story_v_out_325531", "325531047", "story_v_out_325531.awb") / 1000

					if var_193_8 + var_193_2 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_8 + var_193_2
					end

					if var_193_4.prefab_name ~= "" and arg_190_1.actors_[var_193_4.prefab_name] ~= nil then
						local var_193_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_4.prefab_name].transform, "story_v_out_325531", "325531047", "story_v_out_325531.awb")

						arg_190_1:RecordAudio("325531047", var_193_9)
						arg_190_1:RecordAudio("325531047", var_193_9)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_325531", "325531047", "story_v_out_325531.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_325531", "325531047", "story_v_out_325531.awb")
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
	Play325531048 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 325531048
		arg_194_1.duration_ = 5

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play325531049(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(arg_194_1.actors_["10170ui_story"]) and arg_194_1.var_.characterEffect10170ui_story == nil then
				arg_194_1.var_.characterEffect10170ui_story = arg_194_1.actors_["10170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_0 = 0.200000002980232

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_0 and not isNil(arg_194_1.actors_["10170ui_story"]) then
				if arg_194_1.var_.characterEffect10170ui_story and not isNil(arg_194_1.actors_["10170ui_story"]) then
					arg_194_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_194_1.var_.characterEffect10170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_194_1.time_ - 0) / var_197_0)
				end
			end

			if arg_194_1.time_ >= 0 + var_197_0 and arg_194_1.time_ < 0 + var_197_0 + arg_197_0 and not isNil(arg_194_1.actors_["10170ui_story"]) and arg_194_1.var_.characterEffect10170ui_story then
				arg_194_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_194_1.var_.characterEffect10170ui_story.fillRatio = 0.5
			end

			local var_197_1 = 0
			local var_197_2 = 0.275

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, true)
				arg_194_1.iconController_:SetSelectedState("hero")

				arg_194_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_194_1.callingController_:SetSelectedState("normal")

				arg_194_1.keyicon_.color = Color.New(1, 1, 1)
				arg_194_1.icon_.color = Color.New(1, 1, 1)

				local var_197_3 = arg_194_1:FormatText(arg_194_1:GetWordFromCfg(325531048).content)

				arg_194_1.text_.text = var_197_3

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_5 = 11 <= 0 and var_197_2 or var_197_2 * (utf8.len(var_197_3) / 11)

				if (11 <= 0 and var_197_2 or var_197_2 * (utf8.len(var_197_3) / 11)) > 0 and var_197_2 < var_197_5 then
					arg_194_1.talkMaxDuration = var_197_5

					if var_197_5 + var_197_1 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_5 + var_197_1
					end
				end

				arg_194_1.text_.text = var_197_3
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)
				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_6 = math.max(var_197_2, arg_194_1.talkMaxDuration)

			if var_197_1 <= arg_194_1.time_ and arg_194_1.time_ < var_197_1 + var_197_6 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_1) / var_197_6

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_1 + var_197_6 and arg_194_1.time_ < var_197_1 + var_197_6 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play325531049 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 325531049
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play325531050(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.var_.moveOldPos10170ui_story = arg_198_1.actors_["10170ui_story"].transform.localPosition

				local var_201_0 = GameObjectTools.GetOrAddComponent(arg_198_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_201_0 then
					var_201_0:EnableDynamicBone(false)
				end
			end

			local var_201_1 = 0.001

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_1 then
				arg_198_1.actors_["10170ui_story"].transform.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos10170ui_story, Vector3.New(0, 100, 0), (arg_198_1.time_ - 0) / var_201_1)
				arg_198_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_198_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["10170ui_story"].transform.position).z)
				arg_198_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_198_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_198_1.actors_["10170ui_story"].transform.localEulerAngles = arg_198_1.actors_["10170ui_story"].transform.localEulerAngles
			end

			if arg_198_1.time_ >= 0 + var_201_1 and arg_198_1.time_ < 0 + var_201_1 + arg_201_0 then
				arg_198_1.actors_["10170ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_198_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_198_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["10170ui_story"].transform.position).z)
				arg_198_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_198_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_198_1.actors_["10170ui_story"].transform.localEulerAngles = arg_198_1.actors_["10170ui_story"].transform.localEulerAngles

				local var_201_2 = GameObjectTools.GetOrAddComponent(arg_198_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_201_2 then
					var_201_2:EnableDynamicBone(true)
				end
			end

			if 0.1 < arg_198_1.time_ and arg_198_1.time_ <= 0.1 + arg_201_0 then
				arg_198_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_knockcar", "")
			end

			local var_201_4 = 0
			local var_201_5 = 0.575

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_4 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, false)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_6 = arg_198_1:FormatText(arg_198_1:GetWordFromCfg(325531049).content)

				arg_198_1.text_.text = var_201_6

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_8 = 23 <= 0 and var_201_5 or var_201_5 * (utf8.len(var_201_6) / 23)

				if (23 <= 0 and var_201_5 or var_201_5 * (utf8.len(var_201_6) / 23)) > 0 and var_201_5 < var_201_8 then
					arg_198_1.talkMaxDuration = var_201_8

					if var_201_8 + var_201_4 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_8 + var_201_4
					end
				end

				arg_198_1.text_.text = var_201_6
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_9 = math.max(var_201_5, arg_198_1.talkMaxDuration)

			if var_201_4 <= arg_198_1.time_ and arg_198_1.time_ < var_201_4 + var_201_9 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_4) / var_201_9

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_4 + var_201_9 and arg_198_1.time_ < var_201_4 + var_201_9 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
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
	Play325531050 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 325531050
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play325531051(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = 0.875

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

				local var_205_1 = arg_202_1:FormatText(arg_202_1:GetWordFromCfg(325531050).content)

				arg_202_1.text_.text = var_205_1

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_3 = 35 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_1) / 35)

				if (35 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_1) / 35)) > 0 and var_205_0 < var_205_3 then
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
	Play325531051 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 325531051
		arg_206_1.duration_ = 4.53

		local var_206_0 = {
			zh = 2.9,
			ja = 4.533
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
				arg_206_0:Play325531052(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.var_.moveOldPos10170ui_story = arg_206_1.actors_["10170ui_story"].transform.localPosition

				local var_209_0 = GameObjectTools.GetOrAddComponent(arg_206_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_209_0 then
					var_209_0:EnableDynamicBone(false)
				end
			end

			local var_209_1 = 0.001

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_1 then
				arg_206_1.actors_["10170ui_story"].transform.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos10170ui_story, Vector3.New(0, -1.03, -6.05), (arg_206_1.time_ - 0) / var_209_1)
				arg_206_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_206_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["10170ui_story"].transform.position).z)
				arg_206_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_206_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_206_1.actors_["10170ui_story"].transform.localEulerAngles = arg_206_1.actors_["10170ui_story"].transform.localEulerAngles
			end

			if arg_206_1.time_ >= 0 + var_209_1 and arg_206_1.time_ < 0 + var_209_1 + arg_209_0 then
				arg_206_1.actors_["10170ui_story"].transform.localPosition = Vector3.New(0, -1.03, -6.05)
				arg_206_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_206_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["10170ui_story"].transform.position).z)
				arg_206_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_206_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_206_1.actors_["10170ui_story"].transform.localEulerAngles = arg_206_1.actors_["10170ui_story"].transform.localEulerAngles

				local var_209_2 = GameObjectTools.GetOrAddComponent(arg_206_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_209_2 then
					var_209_2:EnableDynamicBone(true)
				end
			end

			local var_209_3 = arg_206_1.actors_["10170ui_story"]

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(var_209_3) and arg_206_1.var_.characterEffect10170ui_story == nil then
				arg_206_1.var_.characterEffect10170ui_story = var_209_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_4 = 0.200000002980232

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_4 and not isNil(var_209_3) then
				if arg_206_1.var_.characterEffect10170ui_story and not isNil(var_209_3) then
					arg_206_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_206_1.time_ >= 0 + var_209_4 and arg_206_1.time_ < 0 + var_209_4 + arg_209_0 and not isNil(var_209_3) and arg_206_1.var_.characterEffect10170ui_story then
				arg_206_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action1_1")
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_209_6 = 0
			local var_209_7 = 0.3

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_6 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_8 = arg_206_1:GetWordFromCfg(325531051)
				local var_209_9 = arg_206_1:FormatText(var_209_8.content)

				arg_206_1.text_.text = var_209_9

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_11 = 12 <= 0 and var_209_7 or var_209_7 * (utf8.len(var_209_9) / 12)

				if (12 <= 0 and var_209_7 or var_209_7 * (utf8.len(var_209_9) / 12)) > 0 and var_209_7 < var_209_11 then
					arg_206_1.talkMaxDuration = var_209_11

					if var_209_11 + var_209_6 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_11 + var_209_6
					end
				end

				arg_206_1.text_.text = var_209_9
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325531", "325531051", "story_v_out_325531.awb") ~= 0 then
					local var_209_12 = manager.audio:GetVoiceLength("story_v_out_325531", "325531051", "story_v_out_325531.awb") / 1000

					if var_209_12 + var_209_6 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_12 + var_209_6
					end

					if var_209_8.prefab_name ~= "" and arg_206_1.actors_[var_209_8.prefab_name] ~= nil then
						local var_209_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_8.prefab_name].transform, "story_v_out_325531", "325531051", "story_v_out_325531.awb")

						arg_206_1:RecordAudio("325531051", var_209_13)
						arg_206_1:RecordAudio("325531051", var_209_13)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_325531", "325531051", "story_v_out_325531.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_325531", "325531051", "story_v_out_325531.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_14 = math.max(var_209_7, arg_206_1.talkMaxDuration)

			if var_209_6 <= arg_206_1.time_ and arg_206_1.time_ < var_209_6 + var_209_14 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_6) / var_209_14

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_6 + var_209_14 and arg_206_1.time_ < var_209_6 + var_209_14 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
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
	Play325531052 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 325531052
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play325531053(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(arg_210_1.actors_["10170ui_story"]) and arg_210_1.var_.characterEffect10170ui_story == nil then
				arg_210_1.var_.characterEffect10170ui_story = arg_210_1.actors_["10170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_0 = 0.200000002980232

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 and not isNil(arg_210_1.actors_["10170ui_story"]) then
				if arg_210_1.var_.characterEffect10170ui_story and not isNil(arg_210_1.actors_["10170ui_story"]) then
					arg_210_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_210_1.var_.characterEffect10170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_210_1.time_ - 0) / var_213_0)
				end
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 and not isNil(arg_210_1.actors_["10170ui_story"]) and arg_210_1.var_.characterEffect10170ui_story then
				arg_210_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_210_1.var_.characterEffect10170ui_story.fillRatio = 0.5
			end

			local var_213_1 = 0
			local var_213_2 = 0.775

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

				local var_213_3 = arg_210_1:FormatText(arg_210_1:GetWordFromCfg(325531052).content)

				arg_210_1.text_.text = var_213_3

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_5 = 31 <= 0 and var_213_2 or var_213_2 * (utf8.len(var_213_3) / 31)

				if (31 <= 0 and var_213_2 or var_213_2 * (utf8.len(var_213_3) / 31)) > 0 and var_213_2 < var_213_5 then
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

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play325531053 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 325531053
		arg_214_1.duration_ = 5

		local var_214_0 = {
			zh = 5,
			ja = 4.9
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
				arg_214_0:Play325531054(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(arg_214_1.actors_["10170ui_story"]) and arg_214_1.var_.characterEffect10170ui_story == nil then
				arg_214_1.var_.characterEffect10170ui_story = arg_214_1.actors_["10170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_0 = 0.200000002980232

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 and not isNil(arg_214_1.actors_["10170ui_story"]) then
				if arg_214_1.var_.characterEffect10170ui_story and not isNil(arg_214_1.actors_["10170ui_story"]) then
					arg_214_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 and not isNil(arg_214_1.actors_["10170ui_story"]) and arg_214_1.var_.characterEffect10170ui_story then
				arg_214_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_217_2 = 0
			local var_217_3 = 0.475

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_2 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_4 = arg_214_1:GetWordFromCfg(325531053)
				local var_217_5 = arg_214_1:FormatText(var_217_4.content)

				arg_214_1.text_.text = var_217_5

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_7 = 19 <= 0 and var_217_3 or var_217_3 * (utf8.len(var_217_5) / 19)

				if (19 <= 0 and var_217_3 or var_217_3 * (utf8.len(var_217_5) / 19)) > 0 and var_217_3 < var_217_7 then
					arg_214_1.talkMaxDuration = var_217_7

					if var_217_7 + var_217_2 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_7 + var_217_2
					end
				end

				arg_214_1.text_.text = var_217_5
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325531", "325531053", "story_v_out_325531.awb") ~= 0 then
					local var_217_8 = manager.audio:GetVoiceLength("story_v_out_325531", "325531053", "story_v_out_325531.awb") / 1000

					if var_217_8 + var_217_2 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_8 + var_217_2
					end

					if var_217_4.prefab_name ~= "" and arg_214_1.actors_[var_217_4.prefab_name] ~= nil then
						local var_217_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_4.prefab_name].transform, "story_v_out_325531", "325531053", "story_v_out_325531.awb")

						arg_214_1:RecordAudio("325531053", var_217_9)
						arg_214_1:RecordAudio("325531053", var_217_9)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_325531", "325531053", "story_v_out_325531.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_325531", "325531053", "story_v_out_325531.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_10 = math.max(var_217_3, arg_214_1.talkMaxDuration)

			if var_217_2 <= arg_214_1.time_ and arg_214_1.time_ < var_217_2 + var_217_10 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_2) / var_217_10

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_2 + var_217_10 and arg_214_1.time_ < var_217_2 + var_217_10 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play325531054 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 325531054
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play325531055(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(arg_218_1.actors_["10170ui_story"]) and arg_218_1.var_.characterEffect10170ui_story == nil then
				arg_218_1.var_.characterEffect10170ui_story = arg_218_1.actors_["10170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_0 = 0.200000002980232

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_0 and not isNil(arg_218_1.actors_["10170ui_story"]) then
				if arg_218_1.var_.characterEffect10170ui_story and not isNil(arg_218_1.actors_["10170ui_story"]) then
					arg_218_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_218_1.var_.characterEffect10170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_218_1.time_ - 0) / var_221_0)
				end
			end

			if arg_218_1.time_ >= 0 + var_221_0 and arg_218_1.time_ < 0 + var_221_0 + arg_221_0 and not isNil(arg_218_1.actors_["10170ui_story"]) and arg_218_1.var_.characterEffect10170ui_story then
				arg_218_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_218_1.var_.characterEffect10170ui_story.fillRatio = 0.5
			end

			local var_221_1 = 0
			local var_221_2 = 1.525

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 then
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

				local var_221_3 = arg_218_1:FormatText(arg_218_1:GetWordFromCfg(325531054).content)

				arg_218_1.text_.text = var_221_3

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_5 = 61 <= 0 and var_221_2 or var_221_2 * (utf8.len(var_221_3) / 61)

				if (61 <= 0 and var_221_2 or var_221_2 * (utf8.len(var_221_3) / 61)) > 0 and var_221_2 < var_221_5 then
					arg_218_1.talkMaxDuration = var_221_5

					if var_221_5 + var_221_1 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_5 + var_221_1
					end
				end

				arg_218_1.text_.text = var_221_3
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_6 = math.max(var_221_2, arg_218_1.talkMaxDuration)

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_6 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_1) / var_221_6

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_1 + var_221_6 and arg_218_1.time_ < var_221_1 + var_221_6 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play325531055 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 325531055
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play325531056(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 0.5

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, true)
				arg_222_1.iconController_:SetSelectedState("hero")

				arg_222_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_222_1.callingController_:SetSelectedState("normal")

				arg_222_1.keyicon_.color = Color.New(1, 1, 1)
				arg_222_1.icon_.color = Color.New(1, 1, 1)

				local var_225_1 = arg_222_1:FormatText(arg_222_1:GetWordFromCfg(325531055).content)

				arg_222_1.text_.text = var_225_1

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_3 = 20 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_1) / 20)

				if (20 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_1) / 20)) > 0 and var_225_0 < var_225_3 then
					arg_222_1.talkMaxDuration = var_225_3

					if var_225_3 + 0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_3 + 0
					end
				end

				arg_222_1.text_.text = var_225_1
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_4 = math.max(var_225_0, arg_222_1.talkMaxDuration)

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_4 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - 0) / var_225_4

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= 0 + var_225_4 and arg_222_1.time_ < 0 + var_225_4 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play325531056 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 325531056
		arg_226_1.duration_ = 9.4

		local var_226_0 = {
			zh = 4.233,
			ja = 9.4
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play325531057(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(arg_226_1.actors_["10170ui_story"]) and arg_226_1.var_.characterEffect10170ui_story == nil then
				arg_226_1.var_.characterEffect10170ui_story = arg_226_1.actors_["10170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_0 = 0.200000002980232

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_0 and not isNil(arg_226_1.actors_["10170ui_story"]) then
				if arg_226_1.var_.characterEffect10170ui_story and not isNil(arg_226_1.actors_["10170ui_story"]) then
					arg_226_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_226_1.time_ >= 0 + var_229_0 and arg_226_1.time_ < 0 + var_229_0 + arg_229_0 and not isNil(arg_226_1.actors_["10170ui_story"]) and arg_226_1.var_.characterEffect10170ui_story then
				arg_226_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action2_1")
			end

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_229_2 = 0
			local var_229_3 = 0.475

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_2 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_4 = arg_226_1:GetWordFromCfg(325531056)
				local var_229_5 = arg_226_1:FormatText(var_229_4.content)

				arg_226_1.text_.text = var_229_5

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_7 = 19 <= 0 and var_229_3 or var_229_3 * (utf8.len(var_229_5) / 19)

				if (19 <= 0 and var_229_3 or var_229_3 * (utf8.len(var_229_5) / 19)) > 0 and var_229_3 < var_229_7 then
					arg_226_1.talkMaxDuration = var_229_7

					if var_229_7 + var_229_2 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_7 + var_229_2
					end
				end

				arg_226_1.text_.text = var_229_5
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325531", "325531056", "story_v_out_325531.awb") ~= 0 then
					local var_229_8 = manager.audio:GetVoiceLength("story_v_out_325531", "325531056", "story_v_out_325531.awb") / 1000

					if var_229_8 + var_229_2 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_8 + var_229_2
					end

					if var_229_4.prefab_name ~= "" and arg_226_1.actors_[var_229_4.prefab_name] ~= nil then
						local var_229_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_4.prefab_name].transform, "story_v_out_325531", "325531056", "story_v_out_325531.awb")

						arg_226_1:RecordAudio("325531056", var_229_9)
						arg_226_1:RecordAudio("325531056", var_229_9)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_325531", "325531056", "story_v_out_325531.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_325531", "325531056", "story_v_out_325531.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_10 = math.max(var_229_3, arg_226_1.talkMaxDuration)

			if var_229_2 <= arg_226_1.time_ and arg_226_1.time_ < var_229_2 + var_229_10 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_2) / var_229_10

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_2 + var_229_10 and arg_226_1.time_ < var_229_2 + var_229_10 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play325531057 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 325531057
		arg_230_1.duration_ = 5

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play325531058(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(arg_230_1.actors_["10170ui_story"]) and arg_230_1.var_.characterEffect10170ui_story == nil then
				arg_230_1.var_.characterEffect10170ui_story = arg_230_1.actors_["10170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_0 = 0.200000002980232

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 and not isNil(arg_230_1.actors_["10170ui_story"]) then
				if arg_230_1.var_.characterEffect10170ui_story and not isNil(arg_230_1.actors_["10170ui_story"]) then
					arg_230_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_230_1.var_.characterEffect10170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_230_1.time_ - 0) / var_233_0)
				end
			end

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 and not isNil(arg_230_1.actors_["10170ui_story"]) and arg_230_1.var_.characterEffect10170ui_story then
				arg_230_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_230_1.var_.characterEffect10170ui_story.fillRatio = 0.5
			end

			local var_233_1 = 0
			local var_233_2 = 0.05

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, true)
				arg_230_1.iconController_:SetSelectedState("hero")

				arg_230_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_230_1.callingController_:SetSelectedState("normal")

				arg_230_1.keyicon_.color = Color.New(1, 1, 1)
				arg_230_1.icon_.color = Color.New(1, 1, 1)

				local var_233_3 = arg_230_1:FormatText(arg_230_1:GetWordFromCfg(325531057).content)

				arg_230_1.text_.text = var_233_3

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_5 = 2 <= 0 and var_233_2 or var_233_2 * (utf8.len(var_233_3) / 2)

				if (2 <= 0 and var_233_2 or var_233_2 * (utf8.len(var_233_3) / 2)) > 0 and var_233_2 < var_233_5 then
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
	Play325531058 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 325531058
		arg_234_1.duration_ = 5

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play325531059(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = 1.425

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, false)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_1 = arg_234_1:FormatText(arg_234_1:GetWordFromCfg(325531058).content)

				arg_234_1.text_.text = var_237_1

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_3 = 57 <= 0 and var_237_0 or var_237_0 * (utf8.len(var_237_1) / 57)

				if (57 <= 0 and var_237_0 or var_237_0 * (utf8.len(var_237_1) / 57)) > 0 and var_237_0 < var_237_3 then
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
	Play325531059 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 325531059
		arg_238_1.duration_ = 1.43

		local var_238_0 = {
			zh = 1.3,
			ja = 1.433
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
				arg_238_0:Play325531060(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(arg_238_1.actors_["10170ui_story"]) and arg_238_1.var_.characterEffect10170ui_story == nil then
				arg_238_1.var_.characterEffect10170ui_story = arg_238_1.actors_["10170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_0 = 0.200000002980232

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_0 and not isNil(arg_238_1.actors_["10170ui_story"]) then
				if arg_238_1.var_.characterEffect10170ui_story and not isNil(arg_238_1.actors_["10170ui_story"]) then
					arg_238_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_238_1.time_ >= 0 + var_241_0 and arg_238_1.time_ < 0 + var_241_0 + arg_241_0 and not isNil(arg_238_1.actors_["10170ui_story"]) and arg_238_1.var_.characterEffect10170ui_story then
				arg_238_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_241_2 = 0
			local var_241_3 = 0.125

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_2 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_4 = arg_238_1:GetWordFromCfg(325531059)
				local var_241_5 = arg_238_1:FormatText(var_241_4.content)

				arg_238_1.text_.text = var_241_5

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_7 = 5 <= 0 and var_241_3 or var_241_3 * (utf8.len(var_241_5) / 5)

				if (5 <= 0 and var_241_3 or var_241_3 * (utf8.len(var_241_5) / 5)) > 0 and var_241_3 < var_241_7 then
					arg_238_1.talkMaxDuration = var_241_7

					if var_241_7 + var_241_2 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_7 + var_241_2
					end
				end

				arg_238_1.text_.text = var_241_5
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325531", "325531059", "story_v_out_325531.awb") ~= 0 then
					local var_241_8 = manager.audio:GetVoiceLength("story_v_out_325531", "325531059", "story_v_out_325531.awb") / 1000

					if var_241_8 + var_241_2 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_8 + var_241_2
					end

					if var_241_4.prefab_name ~= "" and arg_238_1.actors_[var_241_4.prefab_name] ~= nil then
						local var_241_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_4.prefab_name].transform, "story_v_out_325531", "325531059", "story_v_out_325531.awb")

						arg_238_1:RecordAudio("325531059", var_241_9)
						arg_238_1:RecordAudio("325531059", var_241_9)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_325531", "325531059", "story_v_out_325531.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_325531", "325531059", "story_v_out_325531.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_10 = math.max(var_241_3, arg_238_1.talkMaxDuration)

			if var_241_2 <= arg_238_1.time_ and arg_238_1.time_ < var_241_2 + var_241_10 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_2) / var_241_10

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_2 + var_241_10 and arg_238_1.time_ < var_241_2 + var_241_10 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play325531060 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 325531060
		arg_242_1.duration_ = 5

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play325531061(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(arg_242_1.actors_["10170ui_story"]) and arg_242_1.var_.characterEffect10170ui_story == nil then
				arg_242_1.var_.characterEffect10170ui_story = arg_242_1.actors_["10170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_0 = 0.200000002980232

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_0 and not isNil(arg_242_1.actors_["10170ui_story"]) then
				if arg_242_1.var_.characterEffect10170ui_story and not isNil(arg_242_1.actors_["10170ui_story"]) then
					arg_242_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_242_1.var_.characterEffect10170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_242_1.time_ - 0) / var_245_0)
				end
			end

			if arg_242_1.time_ >= 0 + var_245_0 and arg_242_1.time_ < 0 + var_245_0 + arg_245_0 and not isNil(arg_242_1.actors_["10170ui_story"]) and arg_242_1.var_.characterEffect10170ui_story then
				arg_242_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_242_1.var_.characterEffect10170ui_story.fillRatio = 0.5
			end

			local var_245_1 = 0
			local var_245_2 = 0.75

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, true)
				arg_242_1.iconController_:SetSelectedState("hero")

				arg_242_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_242_1.callingController_:SetSelectedState("normal")

				arg_242_1.keyicon_.color = Color.New(1, 1, 1)
				arg_242_1.icon_.color = Color.New(1, 1, 1)

				local var_245_3 = arg_242_1:FormatText(arg_242_1:GetWordFromCfg(325531060).content)

				arg_242_1.text_.text = var_245_3

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_5 = 30 <= 0 and var_245_2 or var_245_2 * (utf8.len(var_245_3) / 30)

				if (30 <= 0 and var_245_2 or var_245_2 * (utf8.len(var_245_3) / 30)) > 0 and var_245_2 < var_245_5 then
					arg_242_1.talkMaxDuration = var_245_5

					if var_245_5 + var_245_1 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_5 + var_245_1
					end
				end

				arg_242_1.text_.text = var_245_3
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_6 = math.max(var_245_2, arg_242_1.talkMaxDuration)

			if var_245_1 <= arg_242_1.time_ and arg_242_1.time_ < var_245_1 + var_245_6 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_1) / var_245_6

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_1 + var_245_6 and arg_242_1.time_ < var_245_1 + var_245_6 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play325531061 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 325531061
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play325531062(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 0.5

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, true)
				arg_246_1.iconController_:SetSelectedState("hero")

				arg_246_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_246_1.callingController_:SetSelectedState("normal")

				arg_246_1.keyicon_.color = Color.New(1, 1, 1)
				arg_246_1.icon_.color = Color.New(1, 1, 1)

				local var_249_1 = arg_246_1:FormatText(arg_246_1:GetWordFromCfg(325531061).content)

				arg_246_1.text_.text = var_249_1

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_3 = 20 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_1) / 20)

				if (20 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_1) / 20)) > 0 and var_249_0 < var_249_3 then
					arg_246_1.talkMaxDuration = var_249_3

					if var_249_3 + 0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_3 + 0
					end
				end

				arg_246_1.text_.text = var_249_1
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_4 = math.max(var_249_0, arg_246_1.talkMaxDuration)

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_4 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - 0) / var_249_4

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= 0 + var_249_4 and arg_246_1.time_ < 0 + var_249_4 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play325531062 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 325531062
		arg_250_1.duration_ = 2

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play325531063(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 and not isNil(arg_250_1.actors_["10170ui_story"]) and arg_250_1.var_.characterEffect10170ui_story == nil then
				arg_250_1.var_.characterEffect10170ui_story = arg_250_1.actors_["10170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_0 = 0.200000002980232

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_0 and not isNil(arg_250_1.actors_["10170ui_story"]) then
				if arg_250_1.var_.characterEffect10170ui_story and not isNil(arg_250_1.actors_["10170ui_story"]) then
					arg_250_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_250_1.time_ >= 0 + var_253_0 and arg_250_1.time_ < 0 + var_253_0 + arg_253_0 and not isNil(arg_250_1.actors_["10170ui_story"]) and arg_250_1.var_.characterEffect10170ui_story then
				arg_250_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action2_2")
			end

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_253_2 = 0
			local var_253_3 = 0.1

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_2 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_4 = arg_250_1:GetWordFromCfg(325531062)
				local var_253_5 = arg_250_1:FormatText(var_253_4.content)

				arg_250_1.text_.text = var_253_5

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_7 = 4 <= 0 and var_253_3 or var_253_3 * (utf8.len(var_253_5) / 4)

				if (4 <= 0 and var_253_3 or var_253_3 * (utf8.len(var_253_5) / 4)) > 0 and var_253_3 < var_253_7 then
					arg_250_1.talkMaxDuration = var_253_7

					if var_253_7 + var_253_2 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_7 + var_253_2
					end
				end

				arg_250_1.text_.text = var_253_5
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325531", "325531062", "story_v_out_325531.awb") ~= 0 then
					local var_253_8 = manager.audio:GetVoiceLength("story_v_out_325531", "325531062", "story_v_out_325531.awb") / 1000

					if var_253_8 + var_253_2 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_8 + var_253_2
					end

					if var_253_4.prefab_name ~= "" and arg_250_1.actors_[var_253_4.prefab_name] ~= nil then
						local var_253_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_4.prefab_name].transform, "story_v_out_325531", "325531062", "story_v_out_325531.awb")

						arg_250_1:RecordAudio("325531062", var_253_9)
						arg_250_1:RecordAudio("325531062", var_253_9)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_325531", "325531062", "story_v_out_325531.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_325531", "325531062", "story_v_out_325531.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_10 = math.max(var_253_3, arg_250_1.talkMaxDuration)

			if var_253_2 <= arg_250_1.time_ and arg_250_1.time_ < var_253_2 + var_253_10 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_2) / var_253_10

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_2 + var_253_10 and arg_250_1.time_ < var_253_2 + var_253_10 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play325531063 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 325531063
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play325531064(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.var_.moveOldPos10170ui_story = arg_254_1.actors_["10170ui_story"].transform.localPosition

				local var_257_0 = GameObjectTools.GetOrAddComponent(arg_254_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_257_0 then
					var_257_0:EnableDynamicBone(false)
				end
			end

			local var_257_1 = 0.001

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_1 then
				arg_254_1.actors_["10170ui_story"].transform.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos10170ui_story, Vector3.New(0, 100, 0), (arg_254_1.time_ - 0) / var_257_1)
				arg_254_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_254_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["10170ui_story"].transform.position).z)
				arg_254_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_254_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_254_1.actors_["10170ui_story"].transform.localEulerAngles = arg_254_1.actors_["10170ui_story"].transform.localEulerAngles
			end

			if arg_254_1.time_ >= 0 + var_257_1 and arg_254_1.time_ < 0 + var_257_1 + arg_257_0 then
				arg_254_1.actors_["10170ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_254_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_254_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["10170ui_story"].transform.position).z)
				arg_254_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_254_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_254_1.actors_["10170ui_story"].transform.localEulerAngles = arg_254_1.actors_["10170ui_story"].transform.localEulerAngles

				local var_257_2 = GameObjectTools.GetOrAddComponent(arg_254_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_257_2 then
					var_257_2:EnableDynamicBone(true)
				end
			end

			local var_257_3 = arg_254_1.actors_["10170ui_story"]

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(var_257_3) and arg_254_1.var_.characterEffect10170ui_story == nil then
				arg_254_1.var_.characterEffect10170ui_story = var_257_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_4 = 0.200000002980232

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_4 and not isNil(var_257_3) then
				if arg_254_1.var_.characterEffect10170ui_story and not isNil(var_257_3) then
					arg_254_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_254_1.var_.characterEffect10170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_254_1.time_ - 0) / var_257_4)
				end
			end

			if arg_254_1.time_ >= 0 + var_257_4 and arg_254_1.time_ < 0 + var_257_4 + arg_257_0 and not isNil(var_257_3) and arg_254_1.var_.characterEffect10170ui_story then
				arg_254_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_254_1.var_.characterEffect10170ui_story.fillRatio = 0.5
			end

			local var_257_5 = 0
			local var_257_6 = 0.725

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_5 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, false)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_7 = arg_254_1:FormatText(arg_254_1:GetWordFromCfg(325531063).content)

				arg_254_1.text_.text = var_257_7

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_9 = 29 <= 0 and var_257_6 or var_257_6 * (utf8.len(var_257_7) / 29)

				if (29 <= 0 and var_257_6 or var_257_6 * (utf8.len(var_257_7) / 29)) > 0 and var_257_6 < var_257_9 then
					arg_254_1.talkMaxDuration = var_257_9

					if var_257_9 + var_257_5 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_9 + var_257_5
					end
				end

				arg_254_1.text_.text = var_257_7
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_10 = math.max(var_257_6, arg_254_1.talkMaxDuration)

			if var_257_5 <= arg_254_1.time_ and arg_254_1.time_ < var_257_5 + var_257_10 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_5) / var_257_10

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_5 + var_257_10 and arg_254_1.time_ < var_257_5 + var_257_10 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_254_1:InitPlayNodeList()
	end,
	Play325531064 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 325531064
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
			arg_258_1.auto_ = false
		end

		function arg_258_1.playNext_(arg_260_0)
			arg_258_1.onStoryFinished_()
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_261_1 = 0
			local var_261_2 = 1.2

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, false)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_3 = arg_258_1:FormatText(arg_258_1:GetWordFromCfg(325531064).content)

				arg_258_1.text_.text = var_261_3

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_5 = 48 <= 0 and var_261_2 or var_261_2 * (utf8.len(var_261_3) / 48)

				if (48 <= 0 and var_261_2 or var_261_2 * (utf8.len(var_261_3) / 48)) > 0 and var_261_2 < var_261_5 then
					arg_258_1.talkMaxDuration = var_261_5

					if var_261_5 + var_261_1 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_5 + var_261_1
					end
				end

				arg_258_1.text_.text = var_261_3
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_6 = math.max(var_261_2, arg_258_1.talkMaxDuration)

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_6 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_1) / var_261_6

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_1 + var_261_6 and arg_258_1.time_ < var_261_1 + var_261_6 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J25f"
	},
	voices = {
		"story_v_out_325531.awb"
	}
}
