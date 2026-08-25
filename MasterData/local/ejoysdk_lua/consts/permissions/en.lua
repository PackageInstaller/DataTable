return {
  android = {
    ["android.permission.WRITE_EXTERNAL_STORAGE"] = {
      "Album Permissions",
      "The app needs your consent to get permission to access albums"
    },
    ["android.permission.READ_EXTERNAL_STORAGE"] = {
      "Storage Permission",
      ""
    },
    ["android.permission.CAMERA"] = {
      "Camera Permission",
      "Granting access to your camera for the game's QR code scanning feature"
    },
    ["android.permission.RECORD_AUDIO"] = {
      "Microphone Permission",
      "Voice Chat"
    },
    ["android.permission.READ_PHONE_STATE"] = {
      "Phone Permission",
      ""
    },
    ["android.permission.ACCESS_COARSE_LOCATION"] = {
      "Location Permission",
      "Region related gameplay"
    },
    ["android.permission.WRITE_CALENDAR"] = {
      "Calendar Write Permission",
      "Used to create calendar reminders"
    },
    ["android.permission.READ_CALENDAR"] = {
      "Calendar Read Permission",
      "Used to view existing calendar reminders"
    }
  },
  ios = {
    NSCameraUsageDescription = {
      "Camera",
      "Granting access to your camera for the game's QR code scanning feature"
    },
    NSPhotoLibraryUsageDescription = {
      "Access to the album",
      "Save shared photos"
    },
    NSPhotoLibraryAddUsageDescription = {
      "Access to the album",
      "Save shared photos"
    },
    NSMicrophoneUsageDescription = {"Microphone", "Voice Chat"},
    NSUserTrackingUsageDescription = {
      "IDFA",
      "Allow access to IDFA"
    },
    NSLocationWhenInUseUsageDescription = {
      "Location Permission",
      "Region related gameplay"
    },
    NSCalendarsUsageDescription = {
      "Read and write calendar permissions",
      "For advance notice"
    },
    NSCalendarsWriteOnlyAccessUsageDescription = {
      "Calendar Write Permission",
      "Used to create calendar reminders"
    },
    NSCalendarsFullAccessUsageDescription = {
      "Read and write calendar permissions",
      "For advance notice"
    }
  },
  harmonyos = {
    ["ohos.permission.CAMERA"] = {
      "Camera Permission",
      "Granting access to your camera for the game's QR code scanning feature"
    },
    ["ohos.permission.APPROXIMATELY_LOCATION"] = {
      "Location Permission",
      "Region related gameplay"
    },
    ["ohos.permission.WRITE_CALENDAR"] = {
      "Calendar Write Permission",
      "Used to create calendar reminders"
    },
    ["ohos.permission.READ_CALENDAR"] = {
      "Calendar Read Permission",
      "Used to view existing calendar reminders"
    },
    ["ohos.permission.MICROPHONE"] = {
      "Microphone permission",
      "Voice Chat"
    }
  },
  windows = {}
}
